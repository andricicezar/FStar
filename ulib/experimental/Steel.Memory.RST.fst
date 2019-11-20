module Steel.Memory.RST

open Steel.Memory

let rst_pre (pre:hprop) = interp pre
let rst_post (a:Type) (post:a -> hprop) = x:a -> m:mem -> interp (post x) (heap_of_mem m)


new_effect GST = STATE_h mem

let gst_pre = st_pre_h mem
let gst_post' (a:Type) (pre:Type) = st_post_h' mem a pre
let gst_post (a:Type) = st_post_h mem a
let gst_wp (a:Type) = st_wp_h mem a

unfold let lift_div_gst (a:Type) (wp:pure_wp a) (p:gst_post a) (h:mem) = wp (fun a -> p a h)
sub_effect DIV ~> GST = lift_div_gst



effect ST (a:Type) (pre:gst_pre) (post: (m0:mem -> Tot (gst_post' a (pre m0)))) =
  GST a
    (fun (p:gst_post a) (h:mem) -> pre h /\ (forall a h1. (pre h /\ post h a h1) ==> p a h1))


effect Steel
  (a: Type)
  (res0: hprop)
  (res1: a -> hprop)
  (pre: mem -> prop)
  (post: mem -> a -> mem -> prop)
= ST
  a
  (fun h0 ->
    interp res0 (heap_of_mem h0) /\
    pre h0)
  (fun h0 x h1 ->
    interp res0 (heap_of_mem h0) /\
    pre h0 /\
    interp (res1 x) (heap_of_mem h1) /\
    post h0 x h1
  )

assume val get (#r:hprop) (_:unit)
  :Steel mem (r) (fun _ -> r)
             (requires (fun m -> True))
             (ensures (fun m0 x m1 -> m0 == x /\ m1 == m0))

val perm_to_ptr (#a:Type) (#p:perm) (r:ref a) : Steel unit
  (ptr_perm r p)
  (fun _ -> ptr r)
  (fun _ -> True)
  (fun h0 _ h1 -> h0 == h1)

let perm_to_ptr #a #p r =
 let h = get #(ptr_perm r p) () in
 assert (interp (ptr_perm r p) (heap_of_mem h));
 let lem (v:a) (h:heap) : Lemma
   (requires interp (pts_to r p v) h)
   (ensures interp (ptr r) h)
   = intro_exists v (pts_to r p) h;
     intro_exists p (ptr_perm r) h
 in Classical.forall_intro (Classical.move_requires (fun v -> lem v (heap_of_mem h)));
 elim_exists (pts_to r p) (ptr r) (heap_of_mem h)

val ptr_read (#a:Type) (r:ref a) : Steel a
  (ptr_perm r 1.0R)
  (fun v -> pts_to r 1.0R v)
  (fun _ -> True)
  (fun _ _ _ -> True)

let ptr_read #a r =
 perm_to_ptr #a #1.0R r;
 let h = get #(ptr r) () in
 let v = sel r (heap_of_mem h) in
 sel_lemma r 1.0R (heap_of_mem h);
 v