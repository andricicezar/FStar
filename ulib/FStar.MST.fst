module FStar.MST

/// The [STATE_h] effect template for stateful computations, generic
/// in the type of the state.
///
/// Note, [STATE_h] is itself not a computation type in F*, since it
/// is parameterized by the type of heap. However, instantiations of
/// [STATE_h] with specific types of the heap are computation
/// types. See, e.g., [FStar.ST] for such instantiations.

open FStar.Tactics
open FStar.Calc
open FStar.Preorder

module W = FStar.Monotonic.Witnessed

(**
  File structured as follows:
  1. Spec monad
  2. Free monad
  3. Define theta and proofs that is a lax morphism
  4. Define Dijkstra Monad
**)

(** ** START Section 1: specification monad **)

/// Weakest preconditions for stateful computations transform
/// [st_post_h] postconditions to [st_pre_h] preconditions. Both are
/// parametric in the type of the state, here denoted by the
/// [heap:Type] variable.


(** Preconditions are predicates on the [heap] *)
let st_pre_h (heap: Type) = heap -> GTot Type0

(** Postconditions relate [a]-typed results to the final [heap], here
    refined by some pure proposition [pre], typically instantiated to
    the precondition applied to the initial [heap] *)
let st_post_h' (heap a pre: Type) = a -> _: heap{pre} -> GTot Type0

(** Postconditions without refinements *)
let st_post_h (heap a: Type) = st_post_h' heap a True

(** The type of the main WP-transformer for stateful computations *)
let st_wp_h_no_mon (heap a: Type) = st_post_h heap a -> Tot (st_pre_h heap)

unfold
let st_post_ord (#heap:Type) (p1 p2:st_post_h heap 'a) =
  forall r h. p1 r h ==> p2 r h

unfold
let st_wp_monotonic (heap:Type) (wp:st_wp_h_no_mon heap 'a) =
  forall p1 p2. (p1 `st_post_ord` p2) ==> (forall h. wp p1 h ==> wp p2 h)

let st_wp_h (heap a: Type) = wp:(st_wp_h_no_mon heap a){st_wp_monotonic heap wp}

(** Returning a value does not transform the state *)
unfold
let st_return (heap a: Type) (x: a) (p: st_post_h heap a) = p x

(** Sequential composition of stateful WPs *)
unfold
let st_bind_wp
      (heap: Type)
      (a b: Type)
      (wp1: st_wp_h heap a)
      (wp2: (a -> GTot (st_wp_h heap b)))
      (p: st_post_h heap b)
      (h0: heap)
     = wp1 (fun a h1 -> wp2 a p h1) h0

(** Branching for stateful WPs *)
unfold
let st_if_then_else
      (heap a p: Type)
      (wp_then wp_else: st_wp_h heap a)
      (post: st_post_h heap a)
      (h0: heap)
     = wp_then post h0 /\ (~p ==> wp_else post h0)

(** As with [PURE] the [wp] combinator names the postcondition as
    [k] to avoid duplicating it. *)
unfold
let st_ite_wp (heap a: Type) (wp: st_wp_h heap a) (post: st_post_h heap a) (h0: heap) =
  forall (k: st_post_h heap a).
    (forall (x: a) (h: heap). {:pattern (guard_free (k x h))} post x h ==> k x h) ==> wp k h0

(** Subsumption for stateful WPs *)
unfold
let st_stronger (heap a: Type) (wp1 wp2: st_wp_h heap a) =
  (forall (p: st_post_h heap a) (h: heap). wp1 p h ==> wp2 p h)

(** Closing the scope of a binder within a stateful WP *)
unfold
let st_close_wp (heap a b: Type) (wp: (b -> GTot (st_wp_h heap a))) (p: st_post_h heap a) (h: heap) =
  (forall (b: b). wp b p h)

(** Applying a stateful WP to a trivial postcondition *)
unfold
let st_trivial (heap a: Type) (wp: st_wp_h heap a) = (forall h0. wp (fun r h1 -> True) h0)

unfold
let (⊑) #heap #a wp1 wp2 = st_stronger heap a wp2 wp1

(** ** END Section 1: specification monad **)


(** ** START Section 2: free monad **)
noeq type tstate = {
  t: Type u#a;
  rel: preorder t;
}

noeq
type free (state:tstate u#s) (a:Type u#a) : Type u#(max 1 a s) =
| Get : cont:(state.t -> free state a) -> free state a
| Put : state.t -> cont:(unit -> free state a) -> free state a
| Witness : p:(state.t -> Type0) -> cont:(unit -> free state a) -> free state a
| Recall : p:(state.t -> Type0) -> cont:(unit -> free state a) -> free state a
| PartialCall : (pre:pure_pre) -> cont:((squash pre) -> free state a) -> free state a
| Return : a -> free state a

let free_return (state:tstate u#s) (a:Type u#b) (x:a) : free state a =
  Return x

let rec free_bind
  (#state:tstate u#s)
  (#a:Type u#a)
  (#b:Type u#b)
  (l : free state a)
  (k : a -> free state b) :
  free state b =
  match l with
  | Return x -> k x
  | Get cont -> Get (fun x -> free_bind (cont x) k)
  | Put h cont -> Put h (fun _ -> free_bind (cont ()) k)
  | Witness pred cont -> Witness pred (fun _ -> free_bind (cont ()) k)
  | Recall pred cont -> Recall pred (fun _ -> free_bind (cont ()) k)
  | PartialCall pre fnc ->
      PartialCall pre (fun _ ->
        free_bind (fnc ()) k)
(** ** END Section 2: free monad **)

(** ** START Section 3: theta **)
unfold
let partial_call_wp (#state:tstate) (pre:pure_pre) : st_wp_h state.t (squash pre) =
  let wp' : st_wp_h_no_mon state.t (squash pre) = fun p h0 -> pre /\ p () h0 in
  assert (st_wp_monotonic state.t wp');
  wp'

unfold
let get_wp (#state:tstate) : st_wp_h state.t state.t =
  fun p h0 -> p h0 h0

unfold
let put_wp (#state:tstate) (h1:state.t) : st_wp_h state.t unit =
  fun p h0 -> (h0 `state.rel` h1) /\ p () h1

unfold
let witness_wp (#state:tstate) (pred:state.t -> Type0) : st_wp_h state.t unit =
  fun p h -> pred h /\ stable pred state.rel /\ (W.witnessed state.rel pred ==> p () h)

unfold
let recall_wp (#state:tstate) (pred:state.t -> Type0) : st_wp_h state.t unit =
  fun p h -> W.witnessed state.rel pred /\ (pred h ==> p () h)

val theta : #a:Type u#a -> #state:tstate u#s -> free state a -> st_wp_h state.t a
let rec theta #a #state m =
  match m with
  | Return x -> st_return state.t _ x
  | PartialCall pre k ->
      st_bind_wp state.t _ _ (partial_call_wp pre) (fun r -> theta (k r))
  | Get k ->
      st_bind_wp state.t state.t a get_wp (fun r -> theta (k r))
  | Put h1 k ->
      st_bind_wp state.t _ _ (put_wp h1) (fun r -> theta (k r))
  | Witness pred k ->
      st_bind_wp state.t _ _ (witness_wp pred) (fun r -> theta (k r))
  | Recall pred k ->
      st_bind_wp state.t _ _ (recall_wp pred) (fun r -> theta (k r))

let lemma_theta_is_monad_morphism_ret (#state:tstate) (v:'a) :
  Lemma (theta (free_return state 'a v) == st_return state.t 'a v) by (compute ()) = ()


#push-options "--split_queries always"
let rec lemma_theta_is_lax_morphism_bind
  (#a:Type u#a) (#b:Type u#b) (#state:tstate u#s) (m:free state a) (f:a -> free state b) :
  Lemma
    (theta (free_bind m f) ⊑ st_bind_wp state.t a b (theta m) (fun x -> theta (f x))) =
  match m with
  | Return x -> ()
  | Get k -> begin
    calc (⊑) {
      theta (free_bind (Get k) f);
      ⊑ {}
      st_bind_wp state.t state.t b get_wp (fun (h:state.t) -> theta (free_bind (k h) f));
      ⊑ {
          let lhs = fun r -> theta (free_bind (k r) f) in
          let rhs = fun r -> st_bind_wp state.t a b (theta (k r)) (fun x -> theta (f x)) in
          introduce forall r. lhs r ⊑ rhs r with begin
            lemma_theta_is_lax_morphism_bind #a #b #state (k r) f
          end
          }
      st_bind_wp state.t state.t b get_wp (fun (h:state.t) -> st_bind_wp state.t a b (theta (k h)) (fun x -> theta (f x)));
      ⊑ {}
      st_bind_wp state.t a b (theta (Get k)) (fun x -> theta (f x));
    }
  end
  | Put h1 k -> begin
    calc (⊑) {
      theta (free_bind (Put h1 k) f);
      ⊑ {}
      st_bind_wp state.t unit b (put_wp h1) (fun r -> theta (free_bind (k r) f));
      ⊑ {
          let lhs = fun r -> theta (free_bind (k r) f) in
          let rhs = fun r -> st_bind_wp state.t a b (theta (k r)) (fun x -> theta (f x)) in
          introduce forall r. lhs r ⊑ rhs r with begin
            lemma_theta_is_lax_morphism_bind #a #b #state (k r) f
          end
          }
      st_bind_wp state.t unit b (put_wp h1) (fun r -> st_bind_wp state.t a b (theta (k r)) (fun x -> theta (f x)));
      ⊑ {}
      st_bind_wp state.t a b (theta (Put h1 k)) (fun x -> theta (f x));
    }
  end
  | Witness pred k -> begin
    calc (⊑) {
      theta (free_bind (Witness pred k) f);
      ⊑ {}
      st_bind_wp state.t unit b (witness_wp pred) (fun r -> theta (free_bind (k r) f));
      ⊑ {
          let lhs = fun r -> theta (free_bind (k r) f) in
          let rhs = fun r -> st_bind_wp state.t a b (theta (k r)) (fun x -> theta (f x)) in
          introduce forall r. lhs r ⊑ rhs r with begin
            lemma_theta_is_lax_morphism_bind #a #b #state (k r) f
          end
          }
      st_bind_wp state.t unit b (witness_wp pred) (fun r -> st_bind_wp state.t a b (theta (k r)) (fun x -> theta (f x)));
      ⊑ {}
      st_bind_wp state.t a b (theta (Witness pred k)) (fun x -> theta (f x));
    }
  end
  | Recall pred k -> begin
    calc (⊑) {
      theta (free_bind (Recall pred k) f);
      ⊑ {}
      st_bind_wp state.t unit b (recall_wp pred) (fun r -> theta (free_bind (k r) f));
      ⊑ {
          let lhs = fun r -> theta (free_bind (k r) f) in
          let rhs = fun r -> st_bind_wp state.t a b (theta (k r)) (fun x -> theta (f x)) in
          introduce forall r. lhs r ⊑ rhs r with begin
            lemma_theta_is_lax_morphism_bind #a #b #state (k r) f
          end
          }
      st_bind_wp state.t unit b (recall_wp pred) (fun r -> st_bind_wp state.t a b (theta (k r)) (fun x -> theta (f x)));
      ⊑ {}
      st_bind_wp state.t a b (theta (Recall pred k)) (fun x -> theta (f x));
    }
  end
  | PartialCall pre k -> begin
    calc (⊑) {
      theta (free_bind (PartialCall pre k) f);
      ⊑ {}
      st_bind_wp state.t (squash pre) b (partial_call_wp pre) (fun r -> theta (free_bind (k r) f));
      ⊑ {
          let lhs = fun r -> theta (free_bind (k r) f) in
          let rhs = fun r -> st_bind_wp state.t a b (theta (k r)) (fun x -> theta (f x)) in
          introduce forall (r:squash pre). lhs r ⊑ rhs r with begin
            lemma_theta_is_lax_morphism_bind #a #b #state (k r) f
          end
          }
      st_bind_wp state.t (squash pre) b (partial_call_wp pre) (fun r -> st_bind_wp state.t a b (theta (k r)) (fun x -> theta (f x)));
      ⊑ {}
      st_bind_wp state.t a b (theta (PartialCall pre k)) (fun x -> theta (f x));
    }
  end
#pop-options
(** ** END Section 3: theta **)

(** ** START Section 4: Dijkstra Monad **)
let total_mst (a:Type u#a) (state:tstate u#1) (wp:st_wp_h state.t a)=
  m:(free state a){theta m ⊑ wp}

let total_mst_return (a:Type u#a) (x:a) (state:tstate u#1) : total_mst a state (st_return state.t a x) =
  free_return state a x

let total_mst_bind
  (a : Type u#a)
  (b : Type u#b)
  (state:tstate u#1)
  (wp_v : st_wp_h state.t a)
  (wp_f: a -> st_wp_h state.t b)
  (v : total_mst a state wp_v)
  (f : (x:a -> total_mst b state (wp_f x))) :
  Tot (total_mst b state (st_bind_wp state.t a b wp_v wp_f)) =
  lemma_theta_is_lax_morphism_bind v f;
  free_bind v f

let total_mst_subcomp
  (a : Type u#a)
  (state:tstate u#1)
  (wp1 : st_wp_h state.t a)
  (wp2 : st_wp_h state.t a)
  (v : total_mst a state wp1)
  : Pure (total_mst a state wp2) (requires (wp1 ⊑ wp2)) (ensures (fun _ -> True)) =
  v

let total_mst_if_then_else
  (a : Type u#a)
  (state:tstate u#1)
  (wp1 : st_wp_h state.t a)
  (wp2 : st_wp_h state.t a)
  (f : total_mst a state wp1) (g : total_mst a state wp2) (b : bool) : Type =
  total_mst a state (st_if_then_else state.t a b wp1 wp2)
(** ** END Section 4: Dijkstra Monad **)

[@@ top_level_effect; primitive_extraction]
// reifiable -- this could be now turned on
total
reflectable
effect {
  TotalMSTwp (a:Type) ([@@@ effect_param] state:tstate u#1) (wp : st_wp_h state.t a)
  with {
    repr         = total_mst;
    return       = total_mst_return ;
    bind         = total_mst_bind ;
    subcomp      = total_mst_subcomp ;
    if_then_else = total_mst_if_then_else
  }
}

unfold
let wp_lift_pure_st (w : pure_wp 'a) (state:tstate) : st_wp_h state.t 'a =
  FStar.Monotonic.Pure.elim_pure_wp_monotonicity_forall ();
  fun p h -> w (fun r -> p r h)

let partial_return state (pre:pure_pre) : total_mst (squash pre) state (partial_call_wp pre) =
  PartialCall pre (Return)

val lift_pure_mst :
  a: Type u#a ->
  state:tstate u#1 ->
  w: pure_wp a ->
  f: (eqtype_as_type unit -> PURE a w) ->
  Tot (total_mst a state (wp_lift_pure_st w state))
let lift_pure_mst a state w f =
  FStar.Monotonic.Pure.elim_pure_wp_monotonicity_forall ();
  let lhs = partial_return state (as_requires w) in
  let rhs = (fun (pre:(squash (as_requires w))) -> total_mst_return a (f pre) state) in
  let m = total_mst_bind _ _ state _ _ lhs rhs in
  total_mst_subcomp _ state _ _ m

sub_effect PURE ~> TotalMSTwp = lift_pure_mst

let total_mst_get state () : TotalMSTwp state.t state get_wp =
  TotalMSTwp?.reflect (Get Return)

let total_mst_put state (h1:state.t) : TotalMSTwp unit state (put_wp h1) =
  TotalMSTwp?.reflect (Put h1 Return)

let total_mst_witness state (pred:state.t -> Type0) : TotalMSTwp unit state (witness_wp pred) =
  TotalMSTwp?.reflect (Witness pred Return)

let total_mst_recall state (pred:state.t -> Type0) : TotalMSTwp unit state (recall_wp pred) =
  TotalMSTwp?.reflect (Recall pred Return)

let mst (a:Type u#a) (state:tstate u#1) (wp:st_wp_h state.t a)=
  unit -> Dv (total_mst a state wp)

let mst_return (a:Type u#a) (x:a) (state:tstate u#1) : mst a state (st_return state.t a x) =
  fun () -> total_mst_return a x state

let rec dv_free_bind
  (#state:tstate u#s)
  (#a:Type u#a)
  (#b:Type u#b)
  (l : free state a)
  (k : a -> Dv (free state b)) :
  Dv (free state b) =
  match l with
  | Return x -> k x
  | Get cont -> Get (fun x -> dv_free_bind (cont x) k) // <-- the bind is Dv, but a Pure lambda is expected based on the sig of Get
  | Put h cont -> Put h (fun _ -> dv_free_bind (cont ()) k)
  | Witness pred cont -> Witness pred (fun _ -> dv_free_bind (cont ()) k)
  | Recall pred cont -> Recall pred (fun _ -> dv_free_bind (cont ()) k)
  | PartialCall pre fnc ->
      PartialCall pre (fun _ ->
        dv_free_bind (fnc ()) k)

let mst_bind
  (a : Type u#a)
  (b : Type u#b)
  (state:tstate u#1)
  (wp_v : st_wp_h state.t a)
  (wp_f: a -> st_wp_h state.t b)
  (v : mst a state wp_v)
  (f : (x:a -> mst b state (wp_f x))) :
  Tot (mst b state (st_bind_wp state.t a b wp_v wp_f)) =
  fun () ->
    total_mst_bind a b state wp_v wp_f (v ()) (fun x -> f x ()) // <-- f is Dv, but the lambda has to be Pure

(**
let mst_subcomp
  (a : Type u#a)
  (state:tstate u#1)
  (wp1 : st_wp_h state.t a)
  (wp2 : st_wp_h state.t a)
  (v : mst a state wp1)
  : Pure (mst a state wp2) (requires (wp1 ⊑ wp2)) (ensures (fun _ -> True)) =
  v

let mst_if_then_else
  (a : Type u#a)
  (state:tstate u#1)
  (wp1 : st_wp_h state.t a)
  (wp2 : st_wp_h state.t a)
  (f : mst a state wp1) (g : mst a state wp2) (b : bool) : Type =
  mst a state (st_if_then_else state.t a b wp1 wp2)
**)
