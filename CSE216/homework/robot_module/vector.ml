(*-------------------------------------
  Vector 3D
-------------------------------------*)
open Globals

(*TODO: Implement VectImpl module.
        VectImpl implements the signature Ivector.IVect*)

module VectImpl: Ivector.IVect = struct

    (*vector addition*)
    let add (x, y, z) (u, v, w) =
        (*TODO*)

    (*vector subtraction*)
    let sub (x, y, z) (u, v, w) =
        (*TODO*)

    (*scalar multiplication*)
    let smul s (x, y, z)  =
        (*TODO*)

    (*inner product*)
    let prod (x, y, z) (u, v, w) =
        (*TODO*)

    (*length of a vector*)
    let len v =
        (*TODO*)

    (*vector rotation*)
    let rot2d ang (x, y) = 
        let r = deg2rad ang in (*a in deg to r in radian*)
        ( (cos r) *. x -. (sin r) *. y,
          (sin r) *. x +. (cos r) *. y ) 

    let rotx ang (x, y, z) =
        rot2d ang (y, z) |> fun (u, v) -> (x, u, v)

    let roty ang (x, y, z) =
        rot2d ang (z, x) |> fun (u, v) -> (v, y, u)

    let rotz ang (x, y, z) =
        rot2d ang (x, y) |> fun (u, v) -> (u, v, z)
