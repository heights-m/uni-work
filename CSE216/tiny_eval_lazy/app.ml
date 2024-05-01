(*   app.ml
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


let str_max = 
    "(  (lambda (x y)
            (if (>= x y) x y))
        1 2)"

let str_sum = 
    "(  (lambda (f) (f f))
        (lambda (self x)
            (if (= x 0)
                0
                (+  x
                    (self self (- x 1)))))
        10)"
                
let str_gcd = 
    "(  (lambda (f) (f f))
        (lambda (self x y)
            (if (= x y)
                x
                (if (>= x y)
                    (self self (- x y) y)
                    (self self (- y x) x))))
        14 21)"

let str_lst = 
    "(  (lambda (cons car cdr)
            (car (cdr (cdr
                (cons 1 (cons 2 (cons 3 false)))))))
        (lambda (x y z) (if z x y))
        (lambda (x) (x true))
        (lambda (x) (x false)))"

let _ = 
    eval_str str_max [] |> print;
    eval_str str_sum [] |> print;
    eval_str str_gcd [] |> print;
    eval_str str_lst [] |> print