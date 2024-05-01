(* Exercise modular abstractions
*)

(* IBoolNand: signature for nand operator
    - nand is a universal operator
*)
module type IBoolNand= sig
    type t
    val _true:  t
    val _false: t
    val _nand:  t -> t -> t
    val to_str: t -> string
end

(* IBool: signature for boolean operators
    TODO: - include IBoolNand
          - add operators _not, _and, _or, _nor, _imply, _equiv
*)
module type IBool = sig
    include IBoolNand
    val _not: t -> t
    val _and: t -> t -> t
    val _or: t -> t -> t
    val _nor: t -> t -> t
    val _imply: t -> t -> t
    val _equiv: t -> t -> t
end


(* BoolBuilder: functor for boolean operators
    TODO: - copy _true, _false, _nand, and to_str from module B
          - implement operators _not, _and, _or, _nor, _imply, _equiv
          - _imply: x -> y == !x \/ y, _equiv: x <-> y == (x -> y) /\ (y -> x)
*)
module BoolBuilder (B: IBoolNand): IBool = struct
    type t = B.t
    let _true = B._true
    let _false = B._false
    let _nand = B._nand
    let to_str = B.to_str
    let _not a = _nand a a
    let _and a b = _not (_nand a b)
    let _or a b = _nand (_not a) (_not b)
    let _nor a b = _not (_or a b)
    let _imply a b = _or (_not a) b
    let _equiv a b = _and (_imply a b) (_imply b a)

end

(* Bool1: first implementation of IBool
    TODO: - implement _nand
*)
module Bool1 = BoolBuilder (struct
    type t = bool
    let _true     = true
    let _false    = false
    let _nand x y = not (x && y) 
    let to_str x  = if x then "true" else "false"
end)

(* BoolTest: functor for test IBool
*)
module BoolTest (B: IBool) = struct
    let test () =
        let open B in
        let t = _true  in
        let f = _false in
        assert ("true"  = (t          |> to_str));
        assert ("false" = (f          |> to_str));
        assert ("false" = (_nand t t  |> to_str));
        assert ("true"  = (_nand t f  |> to_str));
        assert ("true"  = (_and t t   |> to_str));
        assert ("false" = (_and t f   |> to_str));
        assert ("true"  = (_not f     |> to_str));
        assert ("false" = (_not t     |> to_str));
        assert ("true"  = (_or t t    |> to_str));
        assert ("true"  = (_or t f    |> to_str));
        assert ("false" = (_or f f    |> to_str));
        assert ("false" = (_nor t f   |> to_str));
        assert ("true"  = (_nor f f   |> to_str));
        assert ("true"  = (_imply t t |> to_str));
        assert ("true"  = (_imply f t |> to_str));
        assert ("false" = (_imply t f |> to_str));
        assert ("true"  = (_equiv t t |> to_str));
        assert ("true"  = (_equiv f f |> to_str));
        assert ("false" = (_equiv t f |> to_str));
        Printf.printf "Success!\n"
end

(* BT1: first implementation of IBool tester
    TODO: using BoolTest, build a tester for Bool1 and run the test
*)
module BT1 = BoolTest (Bool1) 
let _ = BT1.test ()

(* Bool2: second implementation of IBool
    TODO: - implement _nand
*)
module Bool2 = BoolBuilder (struct
    type t = B of (t -> t -> t) | S of string
    let dropB = function B x -> x | _ -> assert false
    let dropS = function S x -> x | _ -> assert false

    let _true     = B (fun x y -> x)
    let _false    = B (fun x y -> y)
    let _nand x y = (dropB x) ((dropB y) _false _true) _true 
    let to_str x  = (dropB x) (S "true") (S "false") |> dropS
end)

(* BT2: second implementation of IBool tester
    TODO: using BoolTest, build a tester for Bool2 and run the test
*)
module BT2 = 
let _ = BT2.
