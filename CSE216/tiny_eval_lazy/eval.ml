#use "parser.ml"

(*print expr*)
let print expr =
    (*let rec to_str e =
        let open Printf in
        match e with
        | NUM n -> sprintf "%d" n
        | BOOL b -> if b then "T" else "F"
        | VAR v -> v
        | ADD (a, b) -> sprintf "%s + %s"  (to_str a) (to_str b)
        | SUB (a, b) -> sprintf "%s - %s"  (to_str a) (to_str b)
        | EQ  (a, b) -> sprintf "%s = %s"  (to_str a) (to_str b)
        | GE  (a, b) -> sprintf "%s >= %s" (to_str a) (to_str b)
        | AND (a, b) -> sprintf "%s && %s" (to_str a) (to_str b)
        | OR  (a, b) -> sprintf "%s || %s" (to_str a) (to_str b)
        | NOT a      -> sprintf "! %s" (to_str a)
        | IF  (c, t, f) -> sprintf "(if %s then %s else %s)" (to_str c) (to_str t) (to_str f)
        | FUN (v, e) -> sprintf "fun %s -> (%s)" v (to_str e)
        | CLO (v, e, ev) -> sprintf "clo %s -> (%s)" v (to_str e)
        | APP (a, b) -> sprintf "%s %s" (to_str a) (to_str b)
        (*| _ -> assert false*) in*)

    let rec to_str e =
        let open Printf in
        match e with
        | NUM n -> sprintf "NUM(%d)" n
        | BOOL b -> if b then "BOOL(true)" else "BOOL(false)"
        | VAR v -> sprintf "VAR(%s)" v
        | ADD (a, b) -> sprintf "ADD(%s, %s)" (to_str a) (to_str b)
        | SUB (a, b) -> sprintf "SUB(%s, %s)" (to_str a) (to_str b)
        | EQ  (a, b) -> sprintf "EQ(%s, %s)"  (to_str a) (to_str b)
        | GE  (a, b) -> sprintf "GE(%s, %s)"  (to_str a) (to_str b)
        | AND (a, b) -> sprintf "AND(%s, %s)" (to_str a) (to_str b)
        | OR  (a, b) -> sprintf "OR(%s, %s)"  (to_str a) (to_str b)
        | NOT a      -> sprintf "NOT(%s)"     (to_str a)
        | IF  (c, t, f) -> sprintf "IF(%s, %s, %s)" (to_str c) (to_str t) (to_str f)
        | FUN (v, e) -> sprintf "FUN(%s, %s)"  v (to_str e)
        | CLO (v, e, ev) -> sprintf "CLO(%s, %s, env)" v (to_str e)
        | APP (a, b) -> sprintf "APP(%s, %s)" (to_str a) (to_str b) in

     to_str expr |> (Printf.printf "%s\n")


(*evaluate expr in env*)
let rec eval expr env =
    let dropNUM  = function NUM  n -> n | e -> print e; assert false in
    let dropBOOL = function BOOL b -> b | e -> print e; assert false in
    let dropCLO  = function CLO (v, e, ev) -> (v, e, ev) | e -> print e; assert false in

	let force = function
		| TNK (e, ev) -> eval e ev
		| x -> x in

    (*look up the value of a variable from an environment*)
    let rec lookup name env =
        match env with
        | [] -> print (VAR name); assert false
        | (n, e)::rest -> if name = n
                        then e
                        else lookup name rest in

    match expr with
    | BOOL b -> BOOL b
    | NUM n  -> NUM n
    | VAR v  -> lookup v env |> force
    | ADD (a, b)   -> eval a env |> fun x ->
                      eval b env |> fun y ->
                      NUM (dropNUM x + dropNUM y)
    | SUB (a, b)   -> eval a env |> fun x ->
                      eval b env |> fun y ->
                      NUM (dropNUM x - dropNUM y)
    | EQ (a, b)    -> eval a env |> fun x ->
                      eval b env |> fun y ->
                      BOOL (dropNUM x = dropNUM y)
    | GE (a, b)    -> eval a env |> fun x ->
                      eval b env |> fun y ->
                      BOOL (dropNUM x >= dropNUM y)
    | AND (a, b)   -> eval a env |> fun x ->
                      eval b env |> fun y ->
                      BOOL (dropBOOL x && dropBOOL y)
    | OR (a, b)    -> eval a env |> fun x ->
                      eval b env |> fun y ->
                      BOOL (dropBOOL x || dropBOOL y)
    | NOT a        -> eval a env |> fun x ->
                      BOOL (not (dropBOOL x))
    | IF (c, t, f) -> eval c env |> fun x ->
                      if dropBOOL x then eval t env
                                   else eval f env
    | FUN (v, e)   -> CLO (v, e, env)
    | APP (f, a)   -> eval f env  |> fun clo ->
                      dropCLO clo |> fun (v, e, ev) ->
                      eval e ((v, TNK (a, env))::ev)
    | _ -> assert false

