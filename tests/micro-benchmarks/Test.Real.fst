module Test.Real

open FStar.Real

#push-options "--smtencoding.elim_box true --smtencoding.l_arith_repr native --smtencoding.nl_arith_repr native"
let n_over_n2 (n:real{n =!= 0.0R /\ n*.n =!= 0.0R}) = assert (n /. (n *. n) == 1.0R /. n)
#pop-options

let test = assert (two >. one)
let test1 = assert (one == 1.0R)

let test_lt1 = assert (1.0R <. 2.0R)
let test_lt2 = assert (~ (1.0R <. 1.0R))
let test_lt3 = assert (~ (2.0R <. 1.0R))

let test_le1 = assert (1.0R <=. 2.0R)
let test_le2 = assert (1.0R <=. 1.0R)
let test_le3 = assert (~ (2.0R <=. 1.0R))

let test_gt1 = assert (~ (1.0R >. 2.0R))
let test_gt2 = assert (~ (1.0R >. 1.0R))
let test_gt3 = assert (2.0R >. 1.0R)

let test_ge1 = assert (~ (1.0R >=. 2.0R))
let test_ge2 = assert (1.0R >=. 1.0R)
let test_ge3 = assert (2.0R >=. 1.0R)

let test_add_eq = assert (1.0R +. 1.0R == 2.0R)
let test_add_eq' = assert (1.0R +. 3.0R == 4.0R)
let test_add_lt = assert (1.0R +. 1.0R <. 3.0R)

let test_mul_eq = assert (2.0R *. 2.0R == 4.0R)
let test_mul_lt = assert (2.0R *. 2.0R <. 5.0R)

let test_div_eq = assert (8.0R /. 2.0R == 4.0R)
let test_div_lt = assert (8.0R /. 2.0R <. 5.0R)

let test_sqrt_2_mul = assert (sqrt_2 *. sqrt_2 == 2.0R)

let test_sqrt_2_add = assert (sqrt_2 >. 1.0R)

let test_sqrt_2_add_explicit =
  (* A bit of SMT wrestling can prove it *)
  let mlem (x y : (r:real{r >=. 0.0R})) : Lemma (requires x*.x >. y*.y) (ensures x >. y) =
    ()
  in
  mlem sqrt_2 1.0R;
  assert (sqrt_2 >. 1.0R)

#push-options "--smtencoding.elim_box true --smtencoding.l_arith_repr native --smtencoding.nl_arith_repr native"
let test_sqrt_2_scale = assert (1.0R /. sqrt_2 == sqrt_2 /. 2.0R)
#pop-options

// Common identities
let add_id_l = assert (forall n. 0.0R +. n == n)
let add_id_r = assert (forall n. n +. 0.0R == n)

let mul_nil_l = assert (forall n. 0.0R *. n == 0.0R)
let mul_nil_r = assert (forall n. n *. 0.0R == 0.0R)

let mul_id_l = assert (forall n. 1.0R *. n == n)
let mul_id_r = assert (forall n. n *. 1.0R == n)

let add_comm = assert (forall x y. x +. y == y +.x)
let add_assoc = assert (forall x y z. ((x +. y) +.z) == (x +. (y +. z)))

let mul_comm = assert (forall x y. x *. y == y *.x)
#push-options "--smtencoding.elim_box true --smtencoding.l_arith_repr native --smtencoding.nl_arith_repr native"
let mul_assoc = assert (forall x y z. ((x *. y) *.z) == (x *. (y *. z)))
let mul_dist = assert (forall x y z. x *. (y +. z) == (x *. y) +. (x *.z))
#pop-options

(* Testing some simplification rules *)
#push-options "--no_smt"
let _ = assert (0.0R <. 1.0R)
let _ = assert (1.0R >. 0.0R)
let _ = assert (1.0R >=. 0.0R)
let _ = assert (0.0R <=. 1.0R)
let _ = assert (0.0R >=. 0.0R)
let _ = assert (0.0R <=. 0.0R)
let _ = assert (1.0R >=. 1.0R)
let _ = assert (1.0R <=. 1.0R)
let _ = assert (1.0R <=. 2.0R)
let _ = assert (1.R <=. 1.R)
let _ = assert (1.R <=. 2.R)
let _ = assert (1.0R <. 2.0R)
let _ = assert (1001.0R <. 1002.00R)
#pop-options

[@@expect_failure] let _ = assert (1.0R <. 0.0R)
[@@expect_failure] let _ = assert (0.0R >. 1.0R)
[@@expect_failure] let _ = assert (0.0R >=. 1.0R)
[@@expect_failure] let _ = assert (1.0R <=. 0.0R)

#push-options "--no_smt"
let test_ref1 = Some #(r:real{r >. 0.0R}) 1.0R
let test_ref2 = Some #(r:real{r >. of_int 0}) 1.0R
#pop-options

// This one does not work witout SMT as zero is not unfolded!
let test_ref3 = Some #(r:real{r >. zero}) 1.0R
