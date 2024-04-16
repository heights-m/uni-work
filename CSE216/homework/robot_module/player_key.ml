(*-------------------------------------
  Player_Keyboard
-------------------------------------*)
open Globals

(*TODO: Implement PlayerKey module.
    PlayerKey takes a module Board of Iboard.IBoard type
    and implements the signature Iplayer.IPlayer*)


    (*read a keyboard input*)
    let rec get_key () =    
        try
            let event = Graphics.wait_next_event [Graphics.Key_pressed] in
            if event.Graphics.keypressed then
                event.Graphics.key
            else get_key ()
        with
            _ -> 'q'

    (*play by human*)
    let rec play mrk board =
        let k = get_key () in
        if '1' <= k && k <= '9' then
            let i = (Char.code k) - (Char.code '1') in
            if Board.get_mark board i = Board.mark_n (*if not occupied*)
            then i 
            else play mrk board
        else if k = 'q' then 9
        else play mrk board
