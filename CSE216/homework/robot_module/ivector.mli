(*-------------------------------------
  Vector 3D
-------------------------------------*)
open Globals

module type Ivect = sig

val add: vector -> vector -> vector
val sub: vector -> vector -> vector
val smul: float -> vector -> vector
val prod: vector -> vector -> float
val len: vector -> float
val rotx: float -> vector -> vector
val roty: float -> vector -> vector
val rotz: float -> vector -> vector
end
(*TODO: Add a module signature IVect.
  It should expose functions: add, sub, smul, prod, len, rotx, roty, rotz
  hint: use vector type of globals.ml
*)
