(** Stream *******************************************************
*)
type 'a stream = Nil | Cons of 'a * (unit -> 'a stream)

let cons = fun h thunk ->
    Cons (h, thunk)

(*TODO: implement car
*)
let car = function
	| Cons (h, _) -> h
	| _ -> assert false

(*TODO: implement cdr
*)
let cdr = function
	| Cons (_, thunk) -> thunk ()
	| _ -> assert false

(*TODO: implement map
*)
let rec map f strm =
	cons (f (car s)) (fun () -> map f (cdr s))

(*TODO: implement index (n-th element of strm)
*)
let rec index n strm =
	if n <= 0 then car strm
	else index (n-1) (cdr strm)
    
(*print the first n elements of strm*)
let print n strm = 
    strm    |>  map (fun x -> Printf.printf "%6.3f, " x)
            |>  index n;
    Printf.printf "\n"

(*TODO: implement const
    - const c returns a stream of c
*)
let rec const c =
	cons c (fun () -> const c)

let zeros       = const 0. 
let ones        = const 1. 

let _ = zeros |> print 5
let _ = ones  |> print 5
(*  0.000,  0.000,  0.000,  0.000,  0.000,  0.000, 
    1.000,  1.000,  1.000,  1.000,  1.000,  1.000,
*)

(** Fibonacci stream  *******************************************************
*)
(*TODO: implement sum
    - sum a_strm b_strm returns a stream of the sum of a_strm and b_strm
    - a_strm and b_strm are streams of float
    - e.g. sum [1; 3; 1; 2; ...] [0; 1; 2; 3; ...] = [1; 4; 3; 5; ...]
*)
let rec sum a_strm b_strm =
	cons (car a_strm +. car b_strm) (fun () -> sum (cdr a_strm) (cdr b_strm))
    
let _ = sum ones ones |> print 5
(* 2.000,  2.000,  2.000,  2.000,  2.000,  2.000,*)

(*TODO: implement fibs using sum
    - fibs retuns a stream of fibonacci numbers
    - fib(t) = fib(t-1) + fib(t-2)

      fib(0, 1, 2, ...): 0, 1, 1, 2, 3, 5, ...
    + fib(1, 2, 3, ...): 1, 1, 2, 3, 5, ...
    = fib(2, 3, 4, ...): 1, 2, 3, 5, 8, ...
*)
let rec fibs () =
	cons 0. ( fun () ->
	cons 1. (fun () ->
	sum (fibs ()) (cdr (fibs ()))
	))

let _ = fibs () |> print 8
(* 0.000,  1.000,  1.000,  2.000,  3.000,  5.000,  8.000, 13.000, 21.000,*)


(** pi stream *******************************************************
*)
(* TODO: implement rand_stream
   - return a stream of random numbers in between 0. and 1.
*)
let rec rand_stream seed =
    let rand_max = 0x7fffffff in
    let rand_update x = (x * 16807) mod rand_max in    
	cons (randupdate seex) (

(*TODO: implement inside stream
    - take two random numbers for x and y and test if they are inside a unit circule
*)
let rec inside_stream r_strm = (*count inside, count total, rand stream*)
    let inside x y =
        x *. x +. y *. y < 1. in


(*TODO: implement monte carlo stream
    - returns a stream of estimates for the success probability of an experiment
*)
let rec monte_carlo nr_passed nr_trials experiment =

(*TODO: implement pi stream
    - a stream of estimations for pi
    - pipeline rand_sream 1, inside_stream, monte_carlo 0 0 and map with (fun x -> 4. *. x)
*)
let rec pi_stream =


let _ =
    pi_stream
    |> index 1000000
    |> Printf.printf "pi ~ %f\n"

(*pi ~ 3.142285*)


(* Skip ARMA
(** ARMA model *******************************************************
    y(t) = a1*y(t-1) + a2*y(t-2) + a3*y(t-3) + ...
         + b0*u(t)   + b1*u(t-1) + b2*u(t-2) + b3*u(t-3) + ...
    assume that y(t) = 0 for t < 0 and u(t) = 0 for t < 0
*)
   
(*TODO: implement fibs using ARMA model
    - y(t) = y(t-1) + y(t-2)
*)
let rec fibs () =
    let rec iter y1 y2 =    (*y1, y2: y(t-1), y(t-2)*)
        let y0 = y1 +. y2 in
        cons y0 (fun () -> iter y0 y1) in
    iter 0. 1.

let _ = fibs () |> print 8
(* 1.000,  1.000,  2.000,  3.000,  5.000,  8.000, 13.000, 21.000, 34.000,*)


(*TODO: implement psum
    - psum strm returns a stream of partial sum of strm
    - strm is a stream of float
    - e.g. psum [1; 3; 1; 2; ...] = [1; 4; 5; 7; ...]
*)
let psum strm =
    let rec iter acc strm =
        let sum = acc +. (car strm) in
        cons sum (fun () -> iter sum (cdr strm)) in
    iter 0. strm

let _ = psum ones |> print 5
(* 1.000,  2.000,  3.000,  4.000,  5.000,  6.000,*)

(*TODO: implement psum in ARMA model
    - y(t) = y(t-1) + u(t)
*)
let psum strm =
    let rec iter y1 strm =
        let y0 = y1 +. (car strm) in
        cons y0 (fun () -> iter y0 (cdr strm)) in
    iter 0. strm

let _ = psum ones |> print 5
(* 1.000,  2.000,  3.000,  4.000,  5.000,  6.000,*)


(*TODO: implement diff
    - diff strm returns a stream of difference between the elements of strm
    - strm is a stream of float
    - e.g. diff [1; 3; 1; 2; ...] = [1; -2; 2; -1; ...]
*)
let diff strm =
    let rec iter prev strm =
        let curr = (car strm) in
        cons (curr -. prev) (fun () -> iter curr (cdr strm)) in
    iter 0. strm (*the first element is the difference from 0*)

let _ = ones |> diff |> print 5
(* 1.000,  0.000,  0.000,  0.000,  0.000,  0.000,*)

(*TODO: implement diff in ARMA model
    - y(t) = u(t) - u(t-1)
*)
let diff strm =
    let rec iter u1 strm =
        let u0 = (car strm) in
        cons (u0 -. u1) (fun () -> iter u0 (cdr strm)) in
    iter 0. strm

let _ = ones |> diff |> print 5
(* 1.000,  0.000,  0.000,  0.000,  0.000,  0.000,*)


(*TODO: implement sys
    - sys strm returns a stream of output of the ARMA model of
    - y(t) = 0.9*y(t-1) - 0.1*y(t-2) + 0.5*u(t) - 0.3*u(t-1) + 0.1*u(t-2)
*)
let sys strm =
    let rec iter y1 y2 u1 u2 u =
        let u0 = (car u) in
        let y0 = 0.9*.y1 -. 0.1*.y2 +. 0.5*.u0 -. 0.3*.u1 +. 0.1*.u2 in
        cons y0 (fun () -> iter y0 y1 u0 u1 (cdr u)) in
    iter 0. 0. 0. 0. strm 

let _ = ones |> sys |> print 10
(*0.500,  0.650,  0.835,  0.986,  1.104,  1.195,  1.265,  1.319,  1.361,  1.393,  1.417,*)
Skip ARMA*)
