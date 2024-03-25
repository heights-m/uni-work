(*-------------------------------------
  Basis
-------------------------------------*)

(*basis scale: scale basis by s (float)*)
let b_scale s (o, x, y, z) =
    (*TODO*)

(*basis translation: translate basis by t (vector)*)
let b_translate t (o, x, y, z) =
    (*TODO*)

(*basis rotation*)
let b_rot ang vrot (o, x, y, z) =
    (o, vrot ang x, vrot ang y, vrot ang z) 

let b_rotx ang basis = b_rot ang v_rotx basis 

let b_roty ang basis = b_rot ang v_roty basis 

let b_rotz ang basis = b_rot ang v_rotz basis 

(*convert v (vector) in basis coordinate to the global coordinate*)
let v2g_basis v  basis =
    let (a, b, c) = v in
    let (o, x, y, z) = basis in
    (*TODO*)

(*convert b (basis) in basis coordinate to the global coordinate*)
let b2g_basis b basis = 
    let (o, x, y, z) = b in
    let (bo, bx, by, bz) = basis in
    let basis' = (gv_o, bx, by, bz) in (*for axes, origin is gv_o *)
    ( (v2g_basis o basis),
      (v2g_basis x basis'),
      (v2g_basis y basis'),
      (v2g_basis z basis') ) 

(*unit test*)
let test_basis () =
    Printf.printf("----------------------------------------\n");
    Printf.printf("test basis...\n");
    let (o, x, y, z) = b_scale 2. gb_basis in
    assert(o = (0., 0., 0.));
    assert(x = (2., 0., 0.));
    assert(y = (0., 2., 0.));
    assert(z = (0., 0., 2.));
    let (o, x, y, z) = b_translate (1., 2., 3.) gb_basis in
    assert(o = (1., 2., 3.));
    assert(x = (1., 0., 0.));
    assert(y = (0., 1., 0.));
    assert(z = (0., 0., 1.));
    let v = v2g_basis (1., 1., 1.) (o, x, y, z) in
    assert(v = (2., 3., 4.));
    Printf.printf("test basis done\n")
let _ = test_basis ()
