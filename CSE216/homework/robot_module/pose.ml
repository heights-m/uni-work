(*-------------------------------------
   Robot pose
-------------------------------------*)
open Globals
open Ivector
open Ibasis
open Iboard
open Ipose

(*TODO: Implement PoseImpl module.
    PoseImpl takes modules
        Vect of IVect type, Basis of IBasis type, Board of IBoard type in this order
    and implements the signature IPose*)

module PoseImpl (Vect: IVect) (Basis: IBasis) (Board: IBoard): IPose = struct
    (*the position of the mark at index i*)   
    let mark_pos = function
        | 0 -> ( 0.2, 0.8, 0.)
        | 1 -> (  0., 0.8, 0.)
        | 2 -> (-0.2, 0.8, 0.)
        | 3 -> ( 0.2, 0.6, 0.)
        | 4 -> (  0., 0.6, 0.)
        | 5 -> (-0.2, 0.6, 0.)
        | 6 -> ( 0.2, 0.4, 0.)
        | 7 -> (  0., 0.4, 0.)
        | 8 -> (-0.2, 0.4, 0.)
        | 9 -> ( 0.5, 0.4, 0.)
        | 10-> ( 0.5, 0.6, 0.)
        | _ -> assert false 

    (*the specified angle of the pose*)
    let get_pose (b, a1, a2, f, m) =
        function x ->
            if x = "base" then b
	         else if x = "arm1" then a1
	         else if x = "arm2" then a2
	         else if x = "finger" then f
	         else if x = "mark" then m
	         else assert false
        (*TODO: return b, a1, a2, f, and m for the parameters
                "base", "arm1", "arm2", "finger", and "mark"
            e.g. get_pose (0., 1., 2., 3., 1.) "arm2"
            should return 2. *)


    (*the pose whose joint is changed by delta*)
    let chg_pose (b, a1, a2, f, m) joint delta = 
          let checker tag ang =
               if tag = joint then 
		            if tag = "mark" then delta
		            else ang +. delta
	            else ang in
          (checker "base" b, checker "arm1" a1, checker "arm2" a2, checker "finger" f, checker "mark" m)
        (*TODO: return the pose whose angles are switched to
                b+delta, a1+delta, a2+delta, f+delta, or delta
                depending on the joint parameters of
                "base", "arm1", "arm2", "finger", and "mark"
            e.g.  chg_pose (0., 1., 2., 3., 1.) "arm2" 1.
            should return (0., 1., 3., 3., 1.)*)


    (*find the angle joints to get to x y z*)
    let find_pose (x, y, z) = 
        fun f m ->
            let d1 = 0.5 in  (*length of arm1*)
            let d2 = 0.55 in (*length of arm2 + length of finger*)
            let b = rad2deg (atan2 y x) in
         	let d = sqrt (x *. x +. y *. y +. z *. z) in
         	let a2 = acos ( (d *. d -. d1 *. d1 -. d2 *. d2) /. (2. *. d1 *. d2)) in
         	let a2d = rad2deg a2 in
         	let a1 = 90. -. rad2deg (asin (z /. d) +. asin (d2 *. (sin a2) /. d)) in
         	(b, a1, a2d, f, m)
            (*TODO: find b, a1, and a2 and return the pose (b, a1, a2, f, m)
                    b: angle (deg) of base measured from x axis (use atan2),
                    a1: angle (deg) of arm1 measured from z axis
                    a2: angle (deg) of arm2 measured from arm1
                e.g. find_pose (0.1, 0.1, 0.1) 1. 2. should return 
                (45.000, -27.800, 161.805, 1., 2.)
                Please see the lecture slide for more information*)


    (*the pose between movements*)
    let lift_pose pose = 
        let b = get_pose pose "base"   in
        let f = get_pose pose "finger" in
        let m = get_pose pose "mark"   in
        (b, 10., 70., f, m)
end
