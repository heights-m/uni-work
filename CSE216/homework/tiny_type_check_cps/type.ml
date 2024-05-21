#use "parser.ml"

(*print kind*)
let print_kind knd =
    (*TODO: implement to_str in CPS*)
    let rec to_str knd k =
        match knd with
        | Boolean -> k "bool"
        | Number  -> k "num"
        | Function (knd1, knd2) ->
			to_str knd1 (fun x ->
			to_str knd2 (fun y ->
				k (Printf.sprintf "(%s -> %s)" x y)))
        | Error   -> k "error" in

    to_str knd (Printf.printf "%s\n")

(*kind of expr in env*)
(*TODO: implement kind in CPS*)
let rec kind expr env k =
    (*look up the kind of a variable from an environment*)
    let rec lookup name env =
        match env with
        | [] -> Error
        | (n, knd)::rest -> if name = n
                        then knd
                        else lookup name rest in
    match expr with
        | BOOL b -> k Boolean
        | NUM n  -> k Number
        | VAR v  -> k (lookup v env)
        | ADD (a, b) | SUB (a, b)  ->
            kind a env ( fun ka ->
            kind b env ( fun kb ->
            if ka = Number && kb = Number
            then k Number
            else k Error))
        | EQ (a, b) | GE (a, b) ->
            kind a env ( fun ka ->
            kind b env ( fun kb ->
            if ka = Number && kb = Number
            then k Boolean
            else k Error))
        | AND (a, b) | OR (a, b) ->
            kind a env ( fun ka ->
            kind b env ( fun kb ->
            if ka = Boolean && kb = Boolean
            then k Boolean
            else k Error))
        | NOT a ->
            kind a env ( fun ka ->
            if ka = Boolean
            then k Boolean
            else k Error)

        | IF (cond, t_exp, f_exp) ->
            kind cond env  ( fun kc ->
            kind t_exp env ( fun kt ->
            kind f_exp env ( fun kf ->
            (*kind of t_exp and f_exp must match*)
            if kc = Boolean && kt = kf
            then k kt
            else k Error)))

        | FUN ((param, k_param), body) ->
            (*find the kind of body in the extended env*)
            kind body ((param, k_param)::env) ( fun k_body ->
            if k_body != Error 
            then k (Function (k_param, k_body))
            else k Error)

        | APP (f, a) ->
            kind f env ( fun kf ->
            kind a env ( fun ka ->
            (match kf with
            | Function (kf_param, kf_ret) ->
                (*parameter kind of f and kind of a must match*)
                if kf_param = ka && ka != Error
                then k kf_ret 
                else k Error
            | _ -> k Error)))
