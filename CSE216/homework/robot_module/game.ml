(*-------------------------------------
  Game
-------------------------------------*)
open Globals
open Iboard
open Idrawer
open Icommand
open Igame
open Iplayer

(*TODO: Implement GameImpl module.
    GameImpl takes modules
        Board of IBoard type, Drawer of IDrawer type, Command of ICommand type,
        PlayerO of IPlayer type PlayerX of IPlayer type in this order
    and implements the signature IGame*)

    (*run the game*)
    let rec game b_camera (pose, board) =
        let open Command in
        Drawer.delay 0.05; (*to make drawer get correct window sizes*)
        Drawer.draw b_camera pose board;
        PlayerO.play Board.mark_o board |> fun i ->
            if i = 9 then Board.mark_n
            else
        mark b_camera (pose, board) Board.mark_o i |> fun (p, b) ->
            if Board.game_over b then Board.winner b
            else 
        PlayerX.play Board.mark_x  b |> fun i ->
            if i = 9 then Board.mark_n
            else
        mark b_camera (p, b) Board.mark_x i |> fun (p, b) ->
            if Board.game_over b then Board.winner b
            else 
        game b_camera (p, b)


    (*print the game result*)
    let print_result m =
        if      m = Board.mark_o then Printf.printf "O win! :)\n"
        else if m = Board.mark_x then Printf.printf "X win! :)\n"
        else                          Printf.printf "No winner\n" 
