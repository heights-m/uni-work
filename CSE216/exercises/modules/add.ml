module type IAdd = sig
	val add: int -> int -> int
end

module Add: IAdd = struct
	let add x y = x + y
end

let _ = Add.add 1 2

(*functor*)
module type IInc = sig
	val inc: int -> int
end

module FInc (A: IAdd): IInc = struct
	let inc x = A.add 1 x
end

module Inc = FInc (Add)

let _ = Inc.inc 2
