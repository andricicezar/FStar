module ResolveImplicitsHook
open FStar.Tactics.V2
module T = FStar.Tactics.V2
irreducible
let marker : unit = ()

assume
val resource : Type u#1

assume
val emp : resource

assume
val ptr (a:Type0) : Type0

assume
val ptr_resource (x:ptr 'a) : resource

assume
val ( ** ) (r1 r2:resource) : resource

assume
val emp_unit (r1 :resource)
  : Lemma (r1 ** emp == r1)

assume
val commutative (r1 r2:resource)
  : Lemma (r1 ** r2 == r2 ** r1)

assume
val associative (r1 r2 r3:resource)
  : Lemma (r1 ** (r2 ** r3) == (r1 ** r2) ** r3)

[@unifier_hint_injective]
assume
val cmd (r1:resource) (r2:resource) : Type

assume
val ( >> ) (#p #q #r : resource) (f:cmd p q) (g:cmd q r)
  : cmd p r

assume
val frame (#frame #p #q : resource) (f:cmd p q)
  : cmd (frame ** p) (frame ** q)

assume
val frame_delta (pre p post q : resource) : Type

assume
val frame2
    (#[@@@defer_to marker]pre
     #[@@@defer_to marker]post
     #[@@@defer_to marker]p
     #[@@@defer_to marker]q : resource)
    (#[@@@defer_to marker]delta:frame_delta pre p post q)
    (f:cmd p q)
  : cmd pre post


assume
val frame_delta_refl (pre p q : resource) : frame_delta pre p pre q

////////////////////////////////////////////////////////////////////////////////

assume val r1 : resource
assume val r2 : resource
assume val r3 : resource
assume val r4 : resource
assume val r5 : resource

assume val f1: cmd r1 r1
assume val f2: cmd r2 r2
assume val f3: cmd r3 r3
assume val f4: cmd r4 r4
assume val f5: cmd r5 r5


let test0 : cmd (r1 ** r2) (r1 ** r2) =
  frame f2 >>
  frame f2

// let test1 : cmd (r1 ** r2) (r1 ** r2) =
//   frame f1 >>
//   frame f2

[@@resolve_implicits; marker]
let resolve_tac () : Tac unit =
  T.dump "Start!";
  if T.ngoals() = 45 then T.fail "Got 45 goals as expected; failing intentionally"
  else T.admit_all()

[@@expect_failure [228]]
let test1 (b:bool)
  : cmd (r1 ** r2 ** r3 ** r4 ** r5)
        (r1 ** r2 ** r3 ** r4 ** r5)
  =
  frame2 f1 >>
  frame2 f2 >>
  frame2 f3 >>
  frame2 f4 >>
  frame2 f5

assume
val frame3
    (#pre #post #p #q : resource)
    (#[T.apply (`frame_delta_refl)] delta:frame_delta pre p post q)
    (f:cmd p q)
  : cmd pre post

(*
GM 2023-12-03: This example now fails since we don't run meta args
in contexts/types that have uvars in them. But the only thing forcing
the resolution of pre and post is the tactic
*)
[@@expect_failure [66]]
let test2
  : cmd (r1 ** r2) (r1 ** r2)
  =
  frame3 f1 >>
  frame3 f2 >>
  frame3 f3 >>
  frame3 f4 >>
  frame3 f5


[@@resolve_implicits;
   marker]
let resolve_tac_alt () : Tac unit =
  T.dump "Start!";
  if T.ngoals() = 45 then T.fail "Got 45 goals as expected; failing intentionally"
  else T.admit_all()
#push-options "--warn_error @348"

// Raises 348 for ambiguity in resolve_implicits
[@@expect_failure [348]]
let test3 (b:bool)
  : cmd (r1 ** r2 ** r3 ** r4 ** r5)
        (r1 ** r2 ** r3 ** r4 ** r5)
  =
  frame2 f1 >>
  frame2 f2 >>
  frame2 f3 >>
  frame2 f4 >>
  frame2 f5

[@@resolve_implicits;
   marker;
   override_resolve_implicits_handler marker [`%resolve_tac; `%resolve_tac_alt]]
let resolve_tac_alt_alt () : Tac unit =
  T.dump "Start!";
  if T.ngoals() = 45 then T.fail "Got 45 goals as expected; failing intentionally"
  else T.admit_all()

[@@expect_failure [228]] //intentional failure in resolve_tac_alt_alt
let test4 (b:bool)
  : cmd (r1 ** r2 ** r3 ** r4 ** r5)
        (r1 ** r2 ** r3 ** r4 ** r5)
  =
  frame2 f1 >>
  frame2 f2 >>
  frame2 f3 >>
  frame2 f4 >>
  frame2 f5

#pop-options
