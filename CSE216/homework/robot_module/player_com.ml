(*-------------------------------------
  Player_Computer
-------------------------------------*)
open Globals

(*TODO: Implement PlayerCom module.
    PlayerCom takes a module Board of Iboard.IBoard type
    and implements the signature Iplayer.IPlayer*)
module PlayerCom (Board: Iboard.IBoard): Iplayer.IPlayer =  struct

    (*play by the computer*)
    let play mrk board = 
        let other m =
            if m = Board.mark_o then Board.mark_x else Board.mark_o in

        (*TODO: refactor iter:
            iter i m: for each poisition i in [0..8], check if i is mark_n
                    and if putting m at i will make m the winner
        e.g.)
            Suppose that your board is as below
                | O | O |   |
                | X |   |   |
                | X |   |   | 
            - if m is O, then iter should return 2 as putting O
              at position 2 will make O the winner.
            - if m is X, then iter should return 9 as there are
              no winning position for X.
        *)    
        let rec iter m i =
            if i < 9 then
                if Board.get_mark board i <> Board.mark_n 
                then iter m (i+1)
                else 
                    if Board.winner (Board.chg_mark board i m) <> Board.mark_n
                    then i
                    else iter m (i+1)
            else 9 in 
        


        iter mrk 0 |> fun i -> (*this player*)
            if i <> 9 then i
            else
        iter (other mrk) 0 |> fun i -> (*other player*)
            if i <> 9 then i
            else
        Board.empty_pos board
end
