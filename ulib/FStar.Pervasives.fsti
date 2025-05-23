(*
   Copyright 2008-2018 Microsoft Research

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*)
[@@"no_prelude"]
module FStar.Pervasives

(* This is a file from the core library, dependencies must be explicit *)
open Prims
open FStar.Pervasives.Native

/// This module is implicitly opened in the scope of all other
/// modules.
///
/// It provides several basic definitions in F* that are common to
/// most programs. Broadly, these include:
///
/// - Utility types and functions, like [id], [either], dependent
///   tuples, etc.
///
/// - Utility effect definitions, including [DIV] for divergence,
///   [EXN] of exceptions, [STATE_h] a template for state, and (the
///   poorly named) [ALL_h] which combines them all.
///
/// - Some utilities to control proofs, e.g., inversion of inductive
///   type definitions.
///
/// - Built-in attributes that can be used to decorate definitions and
///   trigger various kinds of special treatments for those
///   definitions.

(** [remove_unused_type_parameters]

    This attribute is used to decorate signatures in interfaces for
    type abbreviations, indicating that the 0-based positional
    parameters are unused in the definition and should be eliminated
    for extraction.

    This is important particularly for use with F# extraction, since
    F# does not accept type abbreviations with unused type parameters.

    See tests/bug-reports/RemoveUnusedTyparsIFace.A.fsti
 *)
val remove_unused_type_parameters : list int -> Tot unit

(** Values of type [pattern] are used to tag [Lemma]s with SMT
    quantifier triggers *)
type pattern : Type0 = unit

(** The concrete syntax [SMTPat] desugars to [smt_pat] *)
val smt_pat (#a: Type) (x: a) : Tot pattern

(** The concrete syntax [SMTPatOr] desugars to [smt_pat_or]. This is
    used to represent a disjunction of conjunctions of patterns.

    Note, the typing discipline and syntax of patterns is laxer than
    it should be. Patterns like [SMTPatOr [SMTPatOr [...]]] are
    expressible, but unsupported by F*

    TODO: We should tighten this up, perhaps just reusing the
    attribute mechanism for patterns.
*)
val smt_pat_or (x: list (list pattern)) : Tot pattern

(** eqtype is defined in prims at universe 0

    Although, usually, only universe 0 types have decidable equality,
    sometimes it is possible to define a type in a higher universe also
    with decidable equality (e.g., type t : Type u#1 = | Unit)

    Further, sometimes, as in Lemma below, we need to use a
    universe-polymorphic equality type (although it is only ever
    instantiated with `unit`)
*)
type eqtype_u = a:Type{hasEq a}

(** [Lemma] is a very widely used effect abbreviation.

    It stands for a unit-returning [Ghost] computation, whose main
    value is its logical payload in proving an implication between its
    pre- and postcondition.

    [Lemma] is desugared specially. The valid forms are:

     Lemma (ensures post)
     Lemma post [SMTPat ...]
     Lemma (ensures post) [SMTPat ...]
     Lemma (ensures post) (decreases d)
     Lemma (ensures post) (decreases d) [SMTPat ...]
     Lemma (requires pre) (ensures post) (decreases d)
     Lemma (requires pre) (ensures post) [SMTPat ...]
     Lemma (requires pre) (ensures post) (decreases d) [SMTPat ...]

   and

     Lemma post    (== Lemma (ensures post))

   the squash argument on the postcondition allows to assume the
   precondition for the *well-formedness* of the postcondition.
*)
effect Lemma (a: eqtype_u) (pre: Type) (post: (squash pre -> Type)) (pats: list pattern) =
  Pure a pre (fun r -> post ())

(** IN the default mode of operation, all proofs in a verification
    condition are bundled into a single SMT query. Sub-terms marked
    with the [spinoff] below are the exception: each of them is
    spawned off into a separate SMT query *)
val spinoff (p: Type0) : Type0

val spinoff_eq (p:Type0) : Lemma (spinoff p == p)

val spinoff_equiv (p:Type0) : Lemma (p <==> spinoff p) [SMTPat (spinoff p)]

(** Logically equivalent to assert, but spins off separate query *)
val assert_spinoff (p: Type) : Pure unit (requires (spinoff (squash p))) (ensures (fun x -> p))

(** The polymorphic identity function *)
unfold
let id (#a: Type) (x: a) : a = x

(** Trivial postconditions for the [PURE] effect *)
unfold
let trivial_pure_post (a: Type) : pure_post a = fun _ -> True

(** Sometimes it is convenient to explicit introduce nullary symbols
    into the ambient context, so that SMT can appeal to their definitions
    even when they are no mentioned explicitly in the program, e.g., when
    needed for triggers.

    Use [intro_ambient t] for that.
    See, e.g., LowStar.Monotonic.Buffer.fst and its usage there for loc_none *)
[@@ remove_unused_type_parameters [0; 1;]]
val ambient (#a: Type) (x: a) : Type0

(** cf. [ambient], above *)
val intro_ambient (#a: Type) (x: a) : Tot (squash (ambient x))

open FStar.NormSteps

///  Controlling normalization

(** In any invocation of the F* normalizer, every occurrence of
    [normalize_term e] is reduced to the full normal for of [e]. *)
noextract
val normalize_term (#a: Type) (x: a) : Tot a

(** In any invocation of the F* normalizer, every occurrence of
    [normalize e] is reduced to the full normal for of [e]. *)
noextract
val normalize (a: Type0) : Type0

(** [norm s e] requests normalization of [e] with the reduction steps
    [s]. *)
noextract
val norm (s: list norm_step) (#a: Type) (x: a) : Tot a

(** [assert_norm p] reduces [p] as much as possible and then asks the
    SMT solver to prove the reduct, concluding [p] *)
val assert_norm (p: Type) : Pure unit (requires (normalize p)) (ensures (fun _ -> p))

(** Sometimes it is convenient to introduce an equation between a term
    and its normal form in the context. *)
val normalize_term_spec (#a: Type) (x: a) : Lemma (normalize_term #a x == x)

(** Like [normalize_term_spec], but specialized to [Type0] *)
val normalize_spec (a: Type0) : Lemma (normalize a == a)

(** Like [normalize_term_spec], but with specific normalization steps *)
val norm_spec (s: list norm_step) (#a: Type) (x: a) : Lemma (norm s #a x == x)

(** Use the following to expose an ["opaque_to_smt"] definition to the
    solver as: [reveal_opaque (`%defn) defn]. *)
let reveal_opaque (s: string) = norm_spec [delta_once [s]]

(** Wrappers over pure wp combinators that return a pure_wp type
    (with monotonicity refinement) *)

unfold
let pure_return (a:Type) (x:a) : pure_wp a =
  reveal_opaque (`%pure_wp_monotonic) pure_wp_monotonic;
  pure_return0 a x

unfold
let pure_bind_wp (a b:Type) (wp1:pure_wp a) (wp2:(a -> Tot (pure_wp b))) : Tot (pure_wp b) =
  reveal_opaque (`%pure_wp_monotonic) pure_wp_monotonic;
  pure_bind_wp0 a b wp1 wp2

unfold
let pure_if_then_else (a p:Type) (wp_then wp_else:pure_wp a) : Tot (pure_wp a) =
  reveal_opaque (`%pure_wp_monotonic) pure_wp_monotonic;
  pure_if_then_else0 a p wp_then wp_else

unfold
let pure_ite_wp (a:Type) (wp:pure_wp a) : Tot (pure_wp a) =
  reveal_opaque (`%pure_wp_monotonic) pure_wp_monotonic;
  pure_ite_wp0 a wp

unfold
let pure_close_wp (a b:Type) (wp:b -> Tot (pure_wp a)) : Tot (pure_wp a) =
  reveal_opaque (`%pure_wp_monotonic) pure_wp_monotonic;
  pure_close_wp0 a b wp

unfold
let pure_null_wp (a:Type) : Tot (pure_wp a) =
  reveal_opaque (`%pure_wp_monotonic) pure_wp_monotonic;
  pure_null_wp0 a

[@@ "opaque_to_smt"]
unfold
let pure_assert_wp (p:Type) : Tot (pure_wp unit) =
  reveal_opaque (`%pure_wp_monotonic) pure_wp_monotonic;
  pure_assert_wp0 p

[@@ "opaque_to_smt"]
unfold
let pure_assume_wp (p:Type) : Tot (pure_wp unit) =
  reveal_opaque (`%pure_wp_monotonic) pure_wp_monotonic;
  pure_assume_wp0 p

/// The [DIV] effect for divergent computations
///
/// The wp-calculus for [DIV] is same as that of [PURE]


(** The effect of divergence: from a specificational perspective it is
    identical to PURE, however the specs are given a partial
    correctness interpretation. Computations with the [DIV] effect may
    not terminate. *)
new_effect {
  DIV : a:Type -> wp:pure_wp a -> Effect
  with
    return_wp = pure_return
  ; bind_wp = pure_bind_wp
  ; if_then_else = pure_if_then_else
  ; ite_wp = pure_ite_wp
  ; stronger = pure_stronger
  ; close_wp = pure_close_wp
  ; trivial = pure_trivial
}

(** [PURE] computations can be silently promoted for use in a [DIV] context *)
sub_effect PURE ~> DIV { lift_wp = purewp_id }


(** [Div] is the Hoare-style counterpart of the wp-indexed [DIV] *)
unfold
let div_hoare_to_wp (#a:Type) (#pre:pure_pre) (post:pure_post' a pre) : Tot (pure_wp a) =
  reveal_opaque (`%pure_wp_monotonic) pure_wp_monotonic;
  fun (p:pure_post a) -> pre /\ (forall a. post a ==> p a)

effect Div (a: Type) (pre: pure_pre) (post: pure_post' a pre) =
  DIV a (div_hoare_to_wp post)


(** [Dv] is the instance of [DIV] with trivial pre- and postconditions *)
effect Dv (a: Type) = DIV a (pure_null_wp a)


(** We use the [EXT] effect to underspecify external system calls
    as being impure but having no observable effect on the state *)
effect EXT (a: Type) = Dv a

/// The [EXN] effect for computations that may raise exceptions or
/// fatal errors
///
/// Weakest preconditions for stateful computations transform
/// [ex_post] postconditions (predicates on [result]s) to [ex_pre]
/// precondition propositions.

(** Normal results are represented using [V x].
    Handleable exceptions are represented [E e].
    Fatal errors are [Err msg]. *)
noeq
type result (a: Type) =
  | V : v: a -> result a
  | E : e: exn -> result a
  | Err : msg: string -> result a

(** Exceptional preconditions are just propositions *)
let ex_pre = Type0

(** Postconditions on results refined by a precondition *)
let ex_post' (a pre: Type) = _: result a {pre} -> GTot Type0

(** Postconditions on results *)
let ex_post (a: Type) = ex_post' a True

(** Exceptions WP-predicate transformers *)
let ex_wp (a: Type) = ex_post a -> GTot ex_pre

(** Returning a value [x] normally promotes it to the [V x] result *)
unfold
let ex_return (a: Type) (x: a) (p: ex_post a) : GTot Type0 = p (V x)

(** Sequential composition of exception-raising code requires case analysing
    the result of the first computation before "running" the second one *)
unfold
let ex_bind_wp (a b: Type) (wp1: ex_wp a) (wp2: (a -> GTot (ex_wp b))) (p: ex_post b)
    : GTot Type0 =
  forall (k: ex_post b).
    (forall (rb: result b). {:pattern (guard_free (k rb))} p rb ==> k rb) ==>
    (wp1 (function
          | V ra1 -> wp2 ra1 k
          | E e -> k (E e)
          | Err m -> k (Err m)))

(** As for other effects, branching in [ex_wp] appears in two forms.
    First, a simple case analysis on [p] *)
unfold
let ex_if_then_else (a p: Type) (wp_then wp_else: ex_wp a) (post: ex_post a) =
  wp_then post /\ (~p ==> wp_else post)

(** Naming continuations for use with branching *)
unfold
let ex_ite_wp (a: Type) (wp: ex_wp a) (post: ex_post a) =
  forall (k: ex_post a).
    (forall (rb: result a). {:pattern (guard_free (k rb))} post rb ==> k rb) ==> wp k

(** Subsumption for exceptional WPs *)
unfold
let ex_stronger (a: Type) (wp1 wp2: ex_wp a) = (forall (p: ex_post a). wp1 p ==> wp2 p)

(** Closing the scope of a binder for exceptional WPs *)
unfold
let ex_close_wp (a b: Type) (wp: (b -> GTot (ex_wp a))) (p: ex_post a) = (forall (b: b). wp b p)

(** Applying a computation with a trivial postcondition *)
unfold
let ex_trivial (a: Type) (wp: ex_wp a) = wp (fun r -> True)

(** Introduce a new effect for [EXN] *)
new_effect {
  EXN : result: Type -> wp: ex_wp result -> Effect
  with
    return_wp = ex_return
  ; bind_wp = ex_bind_wp
  ; if_then_else = ex_if_then_else
  ; ite_wp = ex_ite_wp
  ; stronger = ex_stronger
  ; close_wp = ex_close_wp
  ; trivial = ex_trivial
}

(** A Hoare-style abbreviation for EXN *)
effect Exn (a: Type) (pre: ex_pre) (post: ex_post' a pre) =
  EXN a (fun (p: ex_post a) -> pre /\ (forall (r: result a). post r ==> p r))

(** We include divergence in exceptions.

    NOTE: BE WARNED, CODE IN THE [EXN] EFFECT IS ONLY CHECKED FOR
    PARTIAL CORRECTNESS *)
unfold
let lift_div_exn (a: Type) (wp: pure_wp a) (p: ex_post a) = wp (fun a -> p (V a))
sub_effect DIV ~> EXN { lift_wp = lift_div_exn }

(** A variant of [Exn] with trivial pre- and postconditions *)
effect Ex (a: Type) = Exn a True (fun v -> True)

/// The [ALL_h] effect template for computations that may diverge,
/// raise exceptions or fatal errors, and uses a generic state.
///
/// Note, this effect is poorly named, particularly as F* has since
/// gained many more user-defined effect. We no longer have an effect
/// that includes all others.
///
/// We might rename this in the future to something like [StExnDiv_h].
///
/// We layer state on top of exceptions, meaning that raising an
/// exception does not discard the state.
///
/// As with [STATE_h], [ALL_h] is not a computation type, though its
/// instantiation with a specific type of [heap] (in FStar.All) is.

(** [all_pre_h] is a predicate on the initial state *)
let all_pre_h (h: Type) = h -> GTot Type0

(** Postconditions relate [result]s to final [heap]s refined by a precondition *)
let all_post_h' (h a pre: Type) = result a -> _: h{pre} -> GTot Type0

(** A variant of [all_post_h'] without the precondition refinement *)
let all_post_h (h a: Type) = all_post_h' h a True

(** WP predicate transformers for the [All_h] effect template *)
let all_wp_h (h a: Type) = all_post_h h a -> Tot (all_pre_h h)

(** Returning a value [x] normally promotes it to the [V x] result
    without touching the [heap] *)
unfold
let all_return (heap a: Type) (x: a) (p: all_post_h heap a) = p (V x)

(** Sequential composition for [ALL_h] is like [EXN]: case analysis of
    the exceptional result before "running" the continuation *)
unfold
let all_bind_wp
      (heap: Type)
      (a b: Type)
      (wp1: all_wp_h heap a)
      (wp2: (a -> GTot (all_wp_h heap b)))
      (p: all_post_h heap b)
      (h0: heap)
    : GTot Type0 =
  wp1 (fun ra h1 ->
        (match ra with
          | V v -> wp2 v p h1
          | E e -> p (E e) h1
          | Err msg -> p (Err msg) h1))
    h0

(** Case analysis in [ALL_h] *)
unfold
let all_if_then_else
      (heap a p: Type)
      (wp_then wp_else: all_wp_h heap a)
      (post: all_post_h heap a)
      (h0: heap)
     = wp_then post h0 /\ (~p ==> wp_else post h0)

(** Naming postcondition for better sharing in [ALL_h] *)
unfold
let all_ite_wp (heap a: Type) (wp: all_wp_h heap a) (post: all_post_h heap a) (h0: heap) =
  forall (k: all_post_h heap a).
    (forall (x: result a) (h: heap). {:pattern (guard_free (k x h))} post x h ==> k x h) ==> wp k h0

(** Subsumption in [ALL_h] *)
unfold
let all_stronger (heap a: Type) (wp1 wp2: all_wp_h heap a) =
  (forall (p: all_post_h heap a) (h: heap). wp1 p h ==> wp2 p h)

(** Closing a binder in the scope of an [ALL_h] wp *)
unfold
let all_close_wp
      (heap a b: Type)
      (wp: (b -> GTot (all_wp_h heap a)))
      (p: all_post_h heap a)
      (h: heap)
     = (forall (b: b). wp b p h)

(** Applying an [ALL_h] wp to a trivial postcondition *)
unfold
let all_trivial (heap a: Type) (wp: all_wp_h heap a) = (forall (h0: heap). wp (fun r h1 -> True) h0)

(** Introducing the [ALL_h] effect template *)
new_effect {
  ALL_h (heap: Type) : a: Type -> wp: all_wp_h heap a -> Effect
  with
    return_wp = all_return heap
  ; bind_wp = all_bind_wp heap
  ; if_then_else = all_if_then_else heap
  ; ite_wp = all_ite_wp heap
  ; stronger = all_stronger heap
  ; close_wp = all_close_wp heap
  ; trivial = all_trivial heap
}

(**
 Controlling inversions of inductive type

 Given a value of an inductive type [v:t], where [t = A | B], the SMT
 solver can only prove that [v=A \/ v=B] by _inverting_ [t]. This
 inversion is controlled by the [ifuel] setting, which usually limits
 the recursion depth of the number of such inversions that the solver
 can perform.

 The [inversion] predicate below is a way to circumvent the
 [ifuel]-based restrictions on inversion depth. In particular, if the
 [inversion t] is available in the SMT solver's context, it is free to
 invert [t] infinitely, regardless of the [ifuel] setting.

 Be careful using this, since it explicitly subverts the [ifuel]
 setting. If used unwisely, this can lead to very poor SMT solver
 performance.  *)
[@@ remove_unused_type_parameters [0]]
val inversion (a: Type) : Type0

(** To introduce [inversion t] in the SMT solver's context, call
    [allow_inversion t]. *)
val allow_inversion (a: Type) : Pure unit (requires True) (ensures (fun x -> inversion a))

(** Since the [option] type is so common, we always allow inverting
    options, regardless of [ifuel] *)
val invertOption (a: Type)
    : Lemma (requires True) (ensures (forall (x: option a). None? x \/ Some? x)) [SMTPat (option a)]

(** Values of type [a] or type [b] *)
type either a b =
  | Inl : v: a -> either a b
  | Inr : v: b -> either a b

(** Projections for the components of a dependent pair *)
let dfst (#a: Type) (#b: a -> GTot Type) (t: dtuple2 a b)
    : Tot a
  = Mkdtuple2?._1 t

let dsnd (#a: Type) (#b: a -> GTot Type) (t: dtuple2 a b)
    : Tot (b  (Mkdtuple2?._1 t))
  = Mkdtuple2?._2 t

(** Dependent triples, with sugar [x:a & y:b x & c x y] *)
unopteq
type dtuple3 (a: Type) (b: (a -> GTot Type)) (c: (x: a -> b x -> GTot Type)) =
  | Mkdtuple3 : _1: a -> _2: b _1 -> _3: c _1 _2 -> dtuple3 a b c

(** Dependent quadruples, with sugar [x:a & y:b x & z:c x y & d x y z] *)
unopteq
type dtuple4
  (a: Type) (b: (x: a -> GTot Type)) (c: (x: a -> b x -> GTot Type))
  (d: (x: a -> y: b x -> z: c x y -> GTot Type))
  = | Mkdtuple4 : _1: a -> _2: b _1 -> _3: c _1 _2 -> _4: d _1 _2 _3 -> dtuple4 a b c d

(** Dependent quadruples, with sugar [x:a & y:b x & z:c x y & d x y z] *)
unopteq
type dtuple5
  (a: Type) (b: (x: a -> GTot Type)) (c: (x: a -> b x -> GTot Type))
  (d: (x: a -> y: b x -> z: c x y -> GTot Type))
  (e: (x: a -> y: b x -> z: c x y -> w: d x y z -> GTot Type))
  = | Mkdtuple5 : _1: a -> _2: b _1 -> _3: c _1 _2 -> _4: d _1 _2 _3 -> _5: e _1 _2 _3 _4 -> dtuple5 a b c d e

(** Explicitly discarding a value *)
let ignore (#a: Type) (x: a) : Tot unit = ()

(** In a context where [false] is provable, you can prove that any
    type [a] is inhabited.

    There are many proofs of this fact in F*. Here, in the implementation, we build an
    infinitely looping function, since the termination check succeeds
    in a [False] context. *)
val false_elim (#a: Type) (u: unit{False}) : Tot a
(** Pure and ghost inner let bindings are now always inlined during
    the wp computation, if: the return type is not unit and the head
    symbol is not marked irreducible.

    To circumvent this behavior, singleton can be used.
    See the example usage in ulib/FStar.Algebra.Monoid.fst. *)
val singleton (#a: Type) (x: a) : Tot (y: a{y == x})

(** A weakening coercion from eqtype to Type.

    One of its uses is in types of layered effect combinators that
    are subjected to stricter typing discipline (no subtyping) *)
unfold let eqtype_as_type (a:eqtype) : Type = a

(** A coercion of the [x] from [a] to [b], when [a] is provably equal
    to [b]. In most cases, F* will silently coerce from [a] to [b]
    along a provable equality (as in the body of this
    function). Occasionally, you may need to apply this explicitly *)
let coerce_eq (#a:Type) (#b:Type) (_:squash (a == b)) (x:a) : b = x

(** This attribute decorates a let binding, e.g.,

    [@@normalize_for_extraction steps]
    let f = e

    The effect is that prior to extraction, F* will first reduce [e]
    using the normalization [steps], and then proceed to extract it as
    usual.

    Almost the same behavior can be achieved by using a
    [postprocess_for_extraction_with t] attribute, which runs tactic
    [t] on the goal [e == ?u] and extracts the solution to [?u] in
    place of [e]. However, using a tactic to postprocess a term is
    more general than needed for some cases.

    In particular, if we intend to only normalize [e] before
    extraction (rather than applying some other form of equational
    reasoning), then using [normalize_for_extraction] can be more
    efficient, for the following reason:

    Since we are reducing [e] just before extraction, F* can enable an
    otherwise non-user-facing normalization feature that allows all
    arguments marked [@@@erasable] to be erased to [()]---these terms
    will anyway be extracted to [()] so erasing them during
    normalization is a useful optimization.
  *)
val normalize_for_extraction (steps:list norm_step) : Tot unit

(* When using [normalize_for_extraction] this flag indicates that the type
 * of the definition should also be normalized. *)
val normalize_for_extraction_type : unit
