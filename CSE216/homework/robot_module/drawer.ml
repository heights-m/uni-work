(*-------------------------------------
  Drawer: box
-------------------------------------*)
open Globals
open Ivector
open Ibasis
open Iboard
open Ipose
open Idrawer

(*TODO: Implement DrawerImpl module.
    DrawerImpl takes modules
        Vect of IVect type, Basis of IBasis type, Board of IBoard type, Pose of IPose type in this order
    and implements the signature IDrawer*)

    (*open a graphics window*)
    let open_graph () =
        Graphics.open_graph " 800x800";
        Graphics.auto_synchronize false

    (*close the graphics window*)
    let close_graph () = 
        Graphics.close_graph ()

    (*delay*)
    let delay sec =
        Thread.delay sec

    let draw_box w d h clr = 
        let scr_coord (x, y, z) =
            let s = 600. in
            let p = (2. +. z) /. 3. in (*perspective*)
            ( truncate (s *. x *. p) + 500,
              truncate (s *. y *. p) + 400 ) in 
        let p0 = (-.w /.2., -.d /.2., 0.) in
        let p1 = (  w /.2., -.d /.2., 0.) in
        let p2 = (  w /.2.,   d /.2., 0.) in
        let p3 = (-.w /.2.,   d /.2., 0.) in
        let p4 = (-.w /.2., -.d /.2., h ) in
        let p5 = (  w /.2., -.d /.2., h ) in
        let p6 = (  w /.2.,   d /.2., h ) in
        let p7 = (-.w /.2.,   d /.2., h ) in

        let draw_axes basis =
            let open Graphics in
            let s = 2. *. min w (min d h) in
            let (xo, yo) = scr_coord (Basis.v2g_basis (0., 0., 0.) basis) in
            let (xx, yx) = scr_coord (Basis.v2g_basis (s,  0., 0.) basis) in
            let (xy, yy) = scr_coord (Basis.v2g_basis (0., s,  0.) basis) in
            let (xz, yz) = scr_coord (Basis.v2g_basis (0., 0., s ) basis) in
            set_color red;
            moveto xo yo; lineto xx yx;
            set_color green;
            moveto xo yo; lineto xy yy;
            set_color blue;
            moveto xo yo; lineto xz yz in

        fun basis ->
            let open Graphics in
            let (x0, y0) = scr_coord (Basis.v2g_basis p0 basis) in
            let (x1, y1) = scr_coord (Basis.v2g_basis p1 basis) in
            let (x2, y2) = scr_coord (Basis.v2g_basis p2 basis) in
            let (x3, y3) = scr_coord (Basis.v2g_basis p3 basis) in
            let (x4, y4) = scr_coord (Basis.v2g_basis p4 basis) in
            let (x5, y5) = scr_coord (Basis.v2g_basis p5 basis) in
            let (x6, y6) = scr_coord (Basis.v2g_basis p6 basis) in
            let (x7, y7) = scr_coord (Basis.v2g_basis p7 basis) in

            set_color clr;
            moveto x3 y3; lineto x0 y0; lineto x1 y1; lineto x2 y2; lineto x3 y3;
            moveto x7 y7; lineto x4 y4; lineto x5 y5; lineto x6 y6; lineto x7 y7;
            moveto x0 y0; lineto x4 y4;
            moveto x1 y1; lineto x5 y5;
            moveto x2 y2; lineto x6 y6;
            moveto x3 y3; lineto x7 y7
            (*;draw_axes basis*)

    (*mark to color map*)
    let mark_clr m = 
        if      m = Board.mark_n then Graphics.black
        else if m = Board.mark_o then Graphics.red
        else if m = Board.mark_x then Graphics.blue
        else assert false 

    (*draw board*) 
    let draw_board board = 
        let draw_mark  = draw_box 0.05 0.05 0.05 in
        let draw_plate = draw_box 0.18 0.18 0.05 in
        let v_tmk      = (0.0, 0.0, 0.05) in (*height of plates*)
        fun basis -> 
            (*draw mark i and plate i in basis coord*)
            let rec iter i =
                let b_mk    =  gb_basis     (*b_mk: basis for mark i*)
                            (*TODO: translate gb_basis by mark_pos i*)
                            (*TODO: translate the result by v_tmk*)
                            (*TODO: convert the result in basis coord to global coord*)

                let b_pl    =  gb_basis     (*b_pl: basis for plate i*)
                            (*TODO: translate gb_basis by mark_pos i*)
                            (*TODO: convert the result in basis coord to global coord*)

                let m = Board.get_mark board i in (*m: mark i*)

                (*draw nothing if m is mark_n;
                  otherwise draw mark in mark_clr m color and in b_mk basis coord*)
                if m = Board.mark_n
                then    ()                           (*draw nothing for mark_n*)
                else    draw_mark (mark_clr m) b_mk; (*draw mark in mark_clr m color and in b_mk basis coord*)

                (*draw plate in Graphics.black onn b_pl basis*)
                draw_plate Graphics.black b_pl;

                if i < 10 then iter (i+1) else () in
            iter 0 

    let draw_mark pose =
        let s = 0.9 *. 0.5 *. 0.1 in
        fun basis -> 
            let m = Pose.get_pose pose "mark" in
            if m = Board.mark_n
            then    ()
            else    draw_box (0.05/.s) (0.05/.s) (0.05/.s) (mark_clr m) basis

    let draw_finger pose =
        let s = 0.9 *. 0.5 *. 0.2 in
        fun basis -> 
            draw_box (0.02/.s) (0.02/.s) (0.1/.s) Graphics.black basis

    let draw_arm2 pose =
        let s     = 0.9 *. 0.5 in
        let v_tf1 = (0.0, -0.08, 0.5/.s)    in
        let v_tf2 = (0.0,  0.08, 0.5/.s)    in
        let v_tmk = (0.0,0.0,0.5/.s +. 0.1) in
        fun basis ->
            let b_f1    = gb_basis  (*b_f1: basis for finger 1*)
                        (*TODO: rotate gb_basis by the finger angle of pose around x axis*)
                        (*TODO: scale the result by 0.2*)
                        (*TODO: translate the result by v_tf1*)
                        (*TODO: convert the result in basis coord to global coord*)

            let b_f2    = gb_basis  (*b_f2: basis for finger 2*)
                        (*TODO: rotate gb_basis by - finger angle of pose around x axis*)
                        (*TODO: scale the result by 0.2*)
                        (*TODO: translate the result by v_tf2*)
                        (*TODO: convert the result in basis coord to global coord*)

            let b_mk    = gb_basis  (*b_mk: basis for mark*)
                        (*TODO: scale bb_basis by 0.1*)
                        (*TODO: translate the result by v_tmk*)
                        (*TODO: convert the result in basis coord to global coord*)

            (*draw mark, finger 1, finger 2 in b_mk basis*)
            draw_mark   pose b_mk;
            draw_finger pose b_f1;
            draw_finger pose b_f2;

            (*draw arm2*)
            draw_box (0.1/.s) (0.1/.s) (0.5/.s) Graphics.black basis

    let draw_arm1 pose =
        let s     = 0.9 in
        let v_ta2 = (0.0,0.0,0.56) in
        fun basis ->
            let b_a2    = gb_basis  (*b_a2: basis for arm 2*)
                        (*TODO: rotate gb_basis by arm2 angle of pose around y axis*)
                        (*TODO: scale the result by 0.5*)
                        (*TODO: translate the result by v_ta2*)
                        (*TODO: convert the result in basis coord to global coord*)

            (*draw arm2 in b_a2 basis*)
            draw_arm2 pose b_a2;

            (*draw arm1*)
            draw_box (0.12/.s) (0.12/.s) (0.5/.s) Graphics.black basis

    let draw_base pose =
        let v_ta1 = (0.0,0.0,0.1) in
        fun basis ->
            let b_a1    = gb_basis   (*b_a1: basis for arm 1*)
                        (*TODO: rotate gb_basis by arm1 angle of pose around y axis*)
                        (*TODO: scale the result by 0.9*)
                        (*TODO: translate the result by v_ta1*)
                        (*TODO: convert the result in basis coord to global coord*)

            (*draw arm1 in b_a1 basis*)
            draw_arm1 pose b_a1;

            (*draw base*)
            draw_box 0.3 0.3 0.1 Graphics.black basis

    let draw_robot pose =
        fun basis ->
            let b_bs    = gb_basis  (*b_bs: basis for base*)
                        (*TODO: rotate gb_basis by base angle of pose around z axis*)
                        (*TODO: convert the result in basis coord to global coord*)

            (*draw base in b_bs basis*)
            draw_base pose b_bs

    (*draw robot and board*)
    let draw b_camera pose board =
        Graphics.clear_graph ();
        draw_robot pose  b_camera;
        draw_board board b_camera; 
        Graphics.synchronize ()
