(*   reci_lazy.ml
*)

#use "globals.ml"
#use "eval.ml"

(*--Helpers----------------------*)
(*eval_str: evaluates string expression in env*)
let eval_str str_expr env =
    parse str_expr
    |> fun expr -> eval expr env 

(*define: extends env with the value of string expression
*)
let define name str_expr env =
    eval_str str_expr env
    |> fun v -> (name, v)::env

(* extend env with basic functions
*)
let str_rec =  
    "(lambda (f)\
        (f f))"
let str_cons = 
    "(lambda (x y z)\
        (if z x y))"
let str_car =  
    "(lambda (x)\
        (x true))"
let str_cdr =  
    "(lambda (x)\
        (x false))"

let env = []
        |> define "rec"  str_rec
        |> define "cons" str_cons
        |> define "car"  str_car       
        |> define "cdr"  str_cdr        

(*TODO: implement max function*)
let str_max =
	"(lambda (x y)
		(if (>= x y) x y))"

let _ = env 
        |> define "max" str_max
        |> eval_str "(max 1 2)"
        |> print


(*TODO: implement gcd function
    hint: use rec
*)
let str_gcd =
	"(rec (lambda (gcd x y)
		(if (= x y)
			x
			(if (>= x y)
				(rec gcd (- x y) y)
				(rec gcd (- y x ) x)))))"
				
let _ = env 
        |> define "gcd" str_gcd
        |> eval_str "(gcd 30 42)"
        |> print

(*TODO: implement index function
    it takes a stream and a number and returns 
    the number-th element of the stream
*)
let str_index =
	"(rec (lambda (index strm n)
		(if ( = n 0)
			(car strm)
			(rec index (cdr strm) (- n 1)))))"

(*TODO: implement the stream of natural numbers
*)
let str_nat = 


let _ = env 
        |> define "index" str_index
        |> define "nat"   str_nat
        |> eval_str "(index nat 10)"
        |> print

