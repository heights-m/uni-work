(*-------------------------------------
   Robot pose
-------------------------------------*)

(*the position of the mark at index i*)   
let mark_pos i =
    match i with
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
	if tag = joint then ang +. delta
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

(*unit test*)
let test_robot_pose () =
    let pose = (90., 30., 60., 0., mark_n) in 
    let equ_pose pose (b, a1, a2, f, m) =
        assert (equ b  (get_pose pose "base"));  
        assert (equ a1 (get_pose pose "arm1"));  
        assert (equ a2 (get_pose pose "arm2"));  
        assert (equ f  (get_pose pose "finger"));  
        assert (equ m  (get_pose pose "mark")) in

    Printf.printf("----------------------------------------\n");
    Printf.printf("test robot pose...\n");
    equ_pose pose (90., 30., 60., 0., mark_n);        

    equ_pose (chg_pose pose "base" 5.)     (95., 30., 60., 0., mark_n);  
    equ_pose (chg_pose pose "arm1" 5.)     (90., 35., 60., 0., mark_n);  
    equ_pose (chg_pose pose "arm2" 5.)     (90., 30., 65., 0., mark_n);  
    equ_pose (chg_pose pose "finger" 5.)   (90., 30., 60., 5., mark_n);  
    equ_pose (chg_pose pose "mark" mark_o) (90., 30., 60., 0., mark_o);  

    let p = (find_pose (mark_pos 0)) 3. mark_o in
    let a = (75.963756532073532, 49.548507296007486, 76.595860623084960, 3., mark_o) in
    equ_pose p a;
    Printf.printf("test robot pose\n")

let _ = test_robot_pose ()
