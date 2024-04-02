(*-------------------------------------
  Robot commands
-------------------------------------*)

(*move from pose to target_pose*)
let moveto_pose b_camera (pose, board) target_pose =    
    let db  = (get_pose target_pose "base")   -. (get_pose pose "base") in
    let da1 = (get_pose target_pose "arm1")   -. (get_pose pose "arm1") in
    let da2 = (get_pose target_pose "arm2")   -. (get_pose pose "arm2") in
    let df  = (get_pose target_pose "finger") -. (get_pose pose "finger") in
    
    (*move the joint <ang> angle in <step> steps
      e.g. rotate arm1 30 deg in 5 steps
           => rotate arm1 5 times 6 deg each
    *)
    let rot_joint pose joint ang step =
      let ang_seg = ang /. step in
      let draw_frame chpose =
        Thread.delay 0.05;
        draw b_camera chpose board in
      let rec draw_frames step_cnt chpose =
        if step_cnt = 0
        then chpose
        else 
        
        (*TODO: implement this method
            - on each step, draw the robot and the board
            - wait for 50ms by calling Thread.delay 0.05
            - after rotating step times, return the final pose
        *)


    (*move the joints in base, arm1, arm2, and finger order*)
    let p   = pose
            |> fun p -> rot_joint p "base" db  5
            |> fun p -> rot_joint p "arm1" da1 5
            |> fun p -> rot_joint p "arm2" da2 5
            |> fun p -> rot_joint p "finger" df 3 in
    (p, board)

(*pick mark at index i*)
let pick (pose, board) i =
    let f = get_pose pose "finger" in
    let m = get_mark board i in
    (*TODO: return (p, b), where p is the pose whose
            mark and finger are switched to m and 0. respectively
            and b is the board whose mark at i is set to mark_n.
        e.g.     pick ((1.,1.,1.,10.,mark_n), [mark_x;mark_o;...]) 1
        should return ((1.,1.,1.,0., mark_o), [mark_x;mark_n;...])
    *)

(*dropt mark at index i*)
let drop (pose, board) i =
    let f = get_pose pose "finger" in
    let m = get_pose pose "mark" in
    let j = if m = mark_o then 9 else 10 in
    (*TODO: return (p, b),
            where b is the board whose i-th and j-th marks are m
            and p is the pose whose mark and finger are set 
            to mark_n and 10. (= change 10 - f) respectively
        e.g.     drop ((1.,1.,1.,0., mark_o), [mark_x;mark_n;...]) 1
        should return ((1.,1.,1.,10.,mark_n), [mark_x;mark_o;...])
    *)


(*put mark at dst*)
let mark b_camera (pose, board) mrk dst =
    let src = if mrk = mark_o then 9 else 10 in
    let f = get_pose pose "finger" in
    let m = get_pose pose "mark" in

    (*TODO: 1) find b, a1, and a2 for dst_pose and src_pose
               using find_pose, mark_pos then
            2) pass two params for the fun returned by find_pose
    *)            
    let dst_pose = in (*robot's pose for the dst-th mark with finger is f, mark is mrk*)
    let src_pose = in (*robot's pose for the src-th mark with finger is 0, mark is m*)

    (*moveto_pose with the first param applied*)
    let mvp = moveto_pose b_camera in
    
    (*TODO: 1. move to pose src_pose (use mvp)
            2. pick the mark at src  (use pick)
            3. lift                  (use mvp and lift_pose)
            4. move to pose dst_pose (use mvp)
            5. drop the mark at dst  (use drop)
            6. lift                  (use mvp and lift_pose)
            7. return the resulting pose and the board*)

