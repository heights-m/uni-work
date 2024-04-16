(*-------------------------------------
  Board and Mark
-------------------------------------*)

(*TODO: Implement BoardImpl module.
    BoardImpl implements the signature Iboard.IBoard*)

    (*constants*)
    let mark_n = 0. 
    let mark_o = 1. 
    let mark_x = 2. 

    (*get the i-th mark of the board*)
    let get_mark board i =
        (*TODO: implement this method
        get_mark [mark_o; mark_n; mark_x; mark_o; ...] 2 should be mark_x*)


    (*the board whose i-th mark is switched to m*)
    let chg_mark board i m =
        (*TODO: implement this method
        chg_mark [mark_o; mark_n; mark_x; mark_o; ...] 2 mark_n
        should be [mark_o; mark_n; mark_n; mark_o; ...]*)


    (*print the board for the debugging*)
    let print_board board = 
        let str m = if      m = mark_o then "o"
                    else if m = mark_x then "x"
                    else                    " " in
        let pm = fun i -> str (get_mark board i) in
        Printf.printf "%s. %s. %s.\n"   (pm 0) (pm 1) (pm 2);
        Printf.printf "%s. %s. %s.\n"   (pm 3) (pm 4) (pm 5);
        Printf.printf "%s. %s. %s.\n\n" (pm 6) (pm 7) (pm 8)

    (*TODO: refactor: move winner from game to here*)
    (*winner of the board if any; otherwise mark_n*)
    let winner board = 
        (*whether a = b = c*)
        let equ3 a b c = (a = b && b = c && a <> mark_n) in
        (*get_mark with board param provided*)
        let gm = get_mark board in
        (*cache for the 9 positions*)
        let (b00, b01, b02) = (gm 0, gm 1, gm 2) in
        let (b10, b11, b12) = (gm 3, gm 4, gm 5) in
        let (b20, b21, b22) = (gm 6, gm 7, gm 8) in
        
        (*return the winner if there is one; otherwise mark_n*)
        if      equ3 b00 b01 b02 then b00
        else if equ3 b10 b11 b12 then b10
        else if equ3 b20 b21 b22 then b20
        
        else if equ3 b00 b10 b20 then b00  
        else if equ3 b01 b11 b21 then b01  
        else if equ3 b02 b12 b22 then b02 
        
        else if equ3 b00 b11 b22 then b00  
        else if equ3 b02 b11 b20 then b02
        else mark_n

    (*find the first empty position*)
    (*TODO: implement this method
        find the index of the first empty position, or 9 if it doesn't exist
        e.g. empty_pos [mark_o; mark_x; mark_n; mark_o; ...] should be 2*)
    let empty_pos board =



    (*is the game over?*)
    let game_over board =
        winner board <> mark_n || empty_pos board = 9        

