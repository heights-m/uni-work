#use "parser.ml"

(*print expr*)
let print expr =
    (*TODO: implement to_str in CPS*)
    let rec to_str e k =
	let open Printf in
	match e with
	| NUM n -> k (sprintf "NUM(%d)" n)
	| BOOL b -> if b then k "BOOL(true)" else k "BOOL(false)"
	| VAR v -> k (sprintf "VAR(%s)" v)
	| ADD (a, b) -> to_str a (fun sa ->
			to_str b (fun sb ->
			k (sprintf "ADD(%s, %s)" sa sb))) 
	| SUB (a, b) -> to_str a (fun sa ->
			to_str b (fun sb ->
			k (sprintf "SUB(%s, %s)" sa sb))) 
	| EQ  (a, b) -> to_str a (fun sa ->
			to_str b (fun sb ->
			k (sprintf "EQ(%s, %s)" sa sb))) 
	| GE  (a, b) -> to_str a (fun sa ->
			to_str b (fun sb ->
			k (sprintf "GE(%s, %s)" sa sb))) 
	| AND (a, b) -> to_str a (fun sa ->
			to_str b (fun sb ->
			k (sprintf "AND(%s, %s)" sa sb))) 
	| OR  (a, b) -> to_str a (fun sa ->
			to_str b (fun sb ->
			k (sprintf "OR(%s, %s)" sa sb))) 
	| NOT a	    -> to_str a (fun sa -> k (sprintf "NOT(%s)" sa))
	| IF (c, t, f) -> to_str c (fun sc ->
			  to_str t (fun st ->
			  to_str f (fun sf ->
				k (sprintf "IF(%s, %s, %s)" sc st sf))))
	| FUN (v, e) -> to_str e (fun se ->
			k (sprintf "FUN(%s, %s)" v se))
	| CLO (v, e, ev) -> to_str e (fun se ->
			    k (sprintf "CLO(%s, %s, env)" v se))
   	| APP (a,b ) -> to_str a (fun sa ->
			to_str b (fun sb ->
			k (sprintf "APP(%s, %s)" sa sb))) in
    to_str expr (Printf.printf "%s\n")
 

(*evaluate expr in env*)
(*TODO: implement eval in CPS*)
let rec eval expr env k =
    let dropNUM  = function NUM  n -> n | e -> print e; assert false in
    let dropBOOL = function BOOL b -> b | e -> print e; assert false in
    let dropCLO  = function CLO (v, e, ev) -> (v, e, ev) | e -> print e; assert false in

    (*look up the value of a variable from an environment*)
    let rec lookup name env =
        match env with
        | [] -> print (VAR name); assert false
        | (n, e)::rest -> if name = n
                        then e
                        else lookup name rest in

    match expr with
	| BOOL b -> k (BOOL b)
	| NUM  n -> k (NUM  n)
	| VAR  v -> lookup v env
	| ADD (a, b)	-> eval a env (fun x ->
			   eval b env (fun y ->
			   k (NUM (dropNUM x + dropNUM y)))) 
	| SUB (a, b)	-> eval a env (fun x ->
			   eval b env (fun y ->
			   k (NUM (dropNUM x - dropNUM y)))) 
	| EQ (a, b)	-> eval a env (fun x ->
			   eval b env (fun y ->
			   k (BOOL (dropNUM x = dropNUM y)))) 
	| GE (a, b)	-> eval a env (fun x ->
			   eval b env (fun y ->
			   k (BOOL (dropNUM x >= dropNUM y)))) 
	| AND (a, b)	-> eval a env (fun x ->
			   eval b env (fun y ->
			   k (BOOL (dropBOOL x && dropBOOL y)))) 
	| OR (a, b)	-> eval a env (fun x ->
			   eval b env (fun y ->
			   k (BOOL (dropBOOL x || dropBOOL y)))) 
	| NOT a		-> eval a env ( fun x ->
			   k (BOOL (not (dropBOOL x))))
	| IF (c, t, f)  -> eval c env (fun x ->
			   if dropBOOL x then eval t env k
					 else eval f env k)
	| FUN (v, e)    -> k (CLO (v, e, env))
	| APP (f, a)    -> eval f env (fun clo ->
			   eval a env (fun x ->
			   dropCLO clo |> fun (v, e, ev) ->
			   eval e ((v, x)::ev) k))
	| _ -> assert false