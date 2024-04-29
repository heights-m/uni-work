(** Stream ****************************
*)
module type IStream = sig
    type 'a stream = Nil | Cons of 'a * (unit -> 'a stream)

    val cons: 'a -> (unit -> 'a stream) -> 'a stream
    val nil: unit -> 'a stream
    val car: 'a stream -> 'a
    val cdr: 'a stream -> 'a stream
    val index: 'a stream -> int -> 'a
end

(* TODO: impelemnt Stream module
*)
module Stream: IStream = struct
    type 'a stream = Nil | Cons of 'a * (unit -> 'a stream)

    let cons h t = Cons (h, t)

    let nil () = (*what*)

    let car = function

    let cdr = function

    let rec index s n =     (*return the n-th element of stream s*)

end

module TestStream = struct
    open Stream

    let test () =
        let s = cons 1 (fun () -> cons 2 (fun () -> Nil)) in
        assert (Nil = nil ());
        assert (1   = (s |> car));
        assert (2   = (s |> cdr |> car));
        assert (Nil = (s |> cdr |> cdr));
        Printf.printf "Success!\n"
end

let _ = TestStream.test()


(** Wire ****************************
*)
module type IWire = sig
    include IStream
    type wire = int stream

    val w_zero: wire
    val w_one: wire
    val probe: wire list -> int -> unit
end

module Wire: IWire = struct
    include Stream
    type wire = int stream

    (* TODO: implement constant
       constant c returns the infinite stream of c
    *)
    let rec constant c =


    let w_zero = constant 0
    let w_one  = constant 1

    let rec map f = function
        | [] -> []
        | h::t -> f h |> fun fh -> fh::map f t

    let rec probe wires n =
        if n = 0
        then Printf.printf "\n"
        else begin
            let rest = map (fun w -> Printf.printf "%d " (car w); cdr w) wires in
            Printf.printf "\n";
            probe rest (n-1)
        end
end

module TestWire = struct
    open Wire

    let test () =
        assert (0 = (w_zero |> car));
        assert (1 = (w_one  |> car));
        assert (1 = (w_one  |> cdr |> car));
        Printf.printf "Success!\n"
end

let _ = TestWire.test()


(** Gate ****************************
*)
module type IGateParam = sig
    val delay_not: int
    val delay_and: int
    val delay_or:  int
end

module type IGate = sig
    open Wire

    val g_not: wire -> wire
    val g_and: wire -> wire -> wire
    val g_or:  wire -> wire -> wire
end

module GateBuilder (P: IGateParam): IGate = struct
    open Wire

    (* delay d stream adds d 0's to the front of stream
        e.g. delay 3 stream => [0; 0; 0; stream]
    *)
    let rec delay d stream =
        if d = 0 
        then stream
        else cons 0 (fun () -> delay (d-1) stream)

    (*not-gate: returns the negated stream of w_a
        e.g. g_not [1; 1; 0; 0; ...] => [0; 0; 1; 1; ...]
    *)
    let g_not w_a = 
        let rec iter wa =
            let a = car wa in
            let o = if a = 0 then 1 else 0 in
            cons o (fun () -> iter (cdr wa)) in
        iter w_a |> delay P.delay_not

    (*TODO: impement g_and, the and-gate
        - g_and returns the stream of the conjunction of w_a and w_b
        e.g. g_and [1; 1; 0; 0; ...] [1; 0; 1; 0; ...] => [1; 0; 0; 0; ...]
    *)
    let g_and w_a w_b = 


    (*TODO: impement g_or, the or-gate
        - g_or returns the stream of the disjunction of w_a and w_b
        e.g. g_and [1; 1; 0; 0; ...] [1; 0; 1; 0; ...] => [1; 1; 1; 0; ...]
    *)
    let g_or w_a w_b = 


end

module TestGate = struct
    module Gate = GateBuilder (struct let delay_not=1 let delay_and=1 let delay_or=1 end)
    open Gate
    open Wire

    let test () =
        let w_not = g_not w_zero in
        let w_and = g_and w_one  w_not in
        let w_or  = g_or  w_zero w_not in
        assert (0 = (w_not |> car));
        assert (1 = (w_not |> cdr |> car));
        assert (0 = (w_and |> car));
        assert (0 = (w_and |> cdr |> car));
        assert (1 = (w_and |> cdr |> cdr |> car));
        assert (0 = (w_or  |> car));
        assert (0 = (w_or  |> cdr |> car));
        assert (1 = (w_or  |> cdr |> cdr |> car));
        Printf.printf "Success!\n"
end

let _ = TestGate.test()


(** Adder ****************************
*)
module type IAdder = sig
    open Wire

    val half_adder: wire -> wire -> (wire * wire)
    val full_adder: wire -> wire -> wire -> (wire * wire)
    val adder:      wire list -> wire list -> wire list
end

module AdderBuilder (G:IGate) : IAdder = struct
    open Wire
    open G

    (*TODO: impement half_adder, a half-adder
        - half_adder returns the tuple of the sum and the carry streams of
          w_a and w_b
        e.g. half_adder [1; 1; 0; 0; ...]
                        [1; 0; 1; 0; ...]
                    => ([0; 1; 1; 0; ...], [1; 0; 0; 0; ...])
    *)
    let half_adder w_a w_b =



    (*TODO: impement full_adder, a full-adder
        - full_adder returns the tuple of the sum and the carry streams of
          w_a, w_b, and w_c
        e.g. half_adder [1; 1; 0; 0; ...]
                        [1; 0; 1; 0; ...]
                        [1; 1; 0; 0; ...]
                    => ([1; 0; 1; 0; ...], [1; 1; 0; 0; ...])
    *)
    let full_adder w_a w_b w_c = 



    (*TODO: impement adder, an n-bit adder
        - wl_a, wl_b: list of wires of the form [LSB wire; ... ; MSB wire]
        - adder returns the sum of wl_a, wl_b with carry in the form
          [LSB wire; ... ; MSB wire; carry wire]
        e.g. adder [  [1; 0; 1; 1; ...];
                      [1; 1; 1; 0; ...]  ]
                   [  [1; 1; 1; 0; ...];
                      [0; 1; 1; 1; ...]  ]
            =>     [  [0; 1; 0; 1; ...];
                      [0; 0; 1; 1; ...];
                      [1; 1; 1; 0; ...]  ]
           i.e. adder [3; 2; 3; 1; ...]
                      [1; 3; 3; 2; ...]
                   => [(0, 1); (1, 1); (2, 1); (3, 0); ...]
    *)
    let adder wl_a wl_b =
        let rec iter wl_a wl_b w_c =



        iter wl_a wl_b w_zero
end

module TestAdder = struct
    module Gate  = GateBuilder (struct let delay_not = 1 let delay_and = 2 let delay_or = 3 end)
    module Adder = AdderBuilder (Gate)
    open Wire
    open Gate
    open Adder

    let test () = 
        let wl_a = [w_one; w_zero; w_one;  w_zero] in
        let wl_b = [w_one; w_one;  w_zero; w_zero] in
        let wl_s = adder wl_a wl_b in
        let rec compare wl_s expected =
            let list2tuple = function a::b::c::d::e::t -> (a, b, c, d, e) | _  -> assert false in
            let (a, b, c, d, e) = list2tuple wl_s in
            let rec iter i expected = 
                match expected with
                | [] -> ()
                | h::t ->
                    if h = (index a i, index b i, index c i, index d i, index e i) 
                    then iter (i+1) t
                    else begin
                        probe wl_s 40;
                        Printf.printf "failed in step %d\n" i;
                        assert false
                    end  in
            iter 0 expected in
        let expected = [
            0, 0, 0, 0, 0;
            0, 0, 0, 0, 0;
            0, 0, 0, 0, 0;
            0, 0, 0, 0, 0;
            0, 0, 0, 0, 0;
            1, 0, 1, 0, 0;
            1, 0, 1, 0, 0;
            1, 0, 1, 0, 0;
            1, 0, 1, 0, 0;
            1, 0, 1, 0, 0;
            0, 1, 1, 0, 0;
            0, 1, 1, 0, 0;
            0, 1, 1, 0, 0;
            0, 1, 1, 0, 0;
            0, 1, 1, 0, 0;
            0, 1, 1, 0, 0;
            0, 1, 1, 0, 0;
            0, 1, 1, 0, 0;
            0, 1, 1, 0, 0;
            0, 1, 1, 0, 0;
            0, 0, 1, 0, 0;
            0, 0, 1, 0, 0;
            0, 0, 1, 0, 0;
            0, 0, 1, 0, 0;
            0, 0, 1, 0, 0;
            0, 0, 0, 0, 0;
            0, 0, 0, 0, 0;
            0, 0, 0, 0, 0;
            0, 0, 0, 0, 0;
            0, 0, 0, 0, 0;
            0, 0, 0, 0, 0;
            0, 0, 0, 0, 0;
            0, 0, 0, 0, 0;
            0, 0, 0, 0, 0;
            0, 0, 0, 0, 0;
            0, 0, 0, 1, 0;
            0, 0, 0, 1, 0;
            0, 0, 0, 1, 0;
            0, 0, 0, 1, 0;
            0, 0, 0, 1, 0            
        ] in
        compare wl_s expected;
        Printf.printf "Success!\n"
end

let _ = TestAdder.test()
