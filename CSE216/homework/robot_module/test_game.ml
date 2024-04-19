(*-------------------------------------
  Unit Test for Game
-------------------------------------*)
open Globals

module TestGame = struct
    module Board = Board.BoardImpl 

    (*TODO: build MockDrawer of IDrawer type that simply returns unit from all of its functions*)
    module MockDrawer: Idrawer.IDrawer = struct
        let open_graph u = ()
        let close_graph u = ()
        let delay u = ()
        let draw b p bo = ()
    end

    module MockCommand: Icommand.ICommand = struct
        let mark basis (pose, board) mrk i = 
            Board.chg_mark board i mrk |> fun b ->
                Board.print_board b;
                (pose, b)
    end

    (*TODO: build a module for a computer player*)
    module Player = Player_com.PlayerCom (Board)
    
    (*TODO: build Game using GameImpl, Board, MockDrawer, MockCommand,
        and two Players: it is a game between two computer players*)    
    module Game   = Game.GameImpl (Board) (MockDrawer) (MockCommand) (Player) (Player)

    (*unit test*)
    let test () =
        let open Board in
        let board = [   mark_n; mark_n; mark_n;
                        mark_n; mark_n; mark_n;
                        mark_n; mark_n; mark_n;
                        mark_o (*9*); mark_x (*10*)] in
        let ipose = (0., 0., 0., 0., mark_n) in                      
        Printf.printf("----------------------------------------\n");
        Printf.printf("test game...\n");
        (ipose, board)
            |> Game.game gb_basis
            |> fun w -> assert(w = Board.mark_o);
        Printf.printf("test game done\n")
end

let _ = TestGame.test ()
