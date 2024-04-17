(*-------------------------------------
  Basis
-------------------------------------*)
open Globals

(*TODO: Implement BasisImpl module.
    BasisImpl takes a module Vect of Ivector.IVect type and 
    implements the signature Ibasis.IBasis
*)
module BasisImpl (Vect: Ivector.IVect): Ibasis.IBasis = struct

    (*basis scale: scale basis by s (float)*)
    let scale s (o, x, y, z) = (o, Vect.mul s x, Vect.mul s y, Vect.mul s z)
        (*TODO*) 

    (*basis translation: translate basis by t (vector)*)
    let translate t (o, x, y, z) = (Vect.add t o, x, y, z)
        (*TODO*) 

    (*basis rotation*)
    let rot ang vrot (o, x, y, z) =
        (vrot ang o, vrot ang x, vrot ang y, vrot ang z) 

    let rotx ang basis =
        rot ang Vect.rotx basis 

    let roty ang basis =
        rot ang Vect.roty basis 

    let rotz ang basis =
        rot ang Vect.rotz basis 

    (*convert v (vector) in basis coordinate to the global coordinate*)
    let v2g_basis v  basis =
        let (a, b, c) = v in
        let (o, x, y, z) = basis in
        Vect.add o (Vect.add (Vect.mul a x) (Vect.add (Vect.mul b y) (Vect.mul c z)))
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
end
