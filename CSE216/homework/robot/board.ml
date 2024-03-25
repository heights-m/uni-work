(*-------------------------------------
  Board and Mark
-------------------------------------*)

(* mark -------------------------------
*)   
(*the marks are floats to match with other pose elements*)
let mark_n = 0. 
let mark_o = 1. 
let mark_x = 2.         

(* board ------------------------------
*)   
(*get the i-th mark of the board*)
let get_mark board i = List.nth board i
    (*TODO: implement this method
      get_mark [mark_o; mark_n; mark_x; mark_o; ...] 2 should be mark_x*)


(*the board whose i-th mark is switched to m*)
let chg_mark board i m =
    (*TODO: create new board list??? implement this method
      chg_mark [mark_o; mark_n; mark_x; mark_o; ...] 2 mark_n
      should be [mark_o; mark_n; mark_n; mark_o; ...]*)


(*print the board for the debugging*)
let print_board board = 
    let str m = if      m = mark_o then "o"
                else if m = mark_x then "x"
                else                    " " in
    let pm = fun i -> str (get_mark board i) in
    Printf.printf "%s, %s, %s\n"   (pm 0) (pm 1) (pm 2);
    Printf.printf "%s, %s, %s\n"   (pm 3) (pm 4) (pm 5);
    Printf.printf "%s, %s, %s\n\n" (pm 6) (pm 7) (pm 8)

(*unit test*)
let test_board () =
    let board = [ mark_n; mark_n; mark_n;
                  mark_n; mark_n; mark_n;
                  mark_n; mark_n; mark_n;
                  mark_o (*9*); mark_x (*10*)] in
    Printf.printf("----------------------------------------\n");
    Printf.printf("test board...\n");
    assert(mark_x = get_mark board 10);
    assert(mark_n = get_mark board 5);
    assert(mark_o = (board |> fun b -> chg_mark b 5 mark_o
                           |> fun b -> get_mark b 5));
    Printf.printf("test board done\n")
let _ = test_board ()
