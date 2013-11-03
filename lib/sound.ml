open Sdlmixer
open Core.Std
open Types
open Tone

let _AMPLITUDE = 31000.0
let _FREQUENCY = 44100.0
let _PI = 4.0 *. atan(1.0)

let rec range i j = if i > j then [] else i :: (range (i+1) j)
let nums = range 0 44100

let sounds_of_tones_const_vol tones vol =
    List.map tones (fun t -> Sound (freq_of_tone t, vol))

let sounds_of_pitches_in_order_const_vol pitches base_octave vol =
    sounds_of_tones_const_vol (tones_of_pitches_in_order pitches base_octave) vol

(* val chars_of_short : int -> (char, char) *)
let chars_of_short i = 
    (char_of_int (i land 255), 
     char_of_int ((i lsr 8) land 255))

(* val map_explode_condense : 'a list -> ('a -> ('b, 'b)) -> 'b list *)
let rec map_explode_condense l f = match l with
    | [] -> []
    | x::xs ->
            let (a, b) = f x in 
            a::b::(map_explode_condense xs f)

(* val eval_sound : sound list -> float -> i -> float *)
let eval_sound sound_list total_vol i =
    let calc_immediate freq i =
        sin(freq *. (float i) *. 2.0 *. _PI /. _FREQUENCY) in
    let normalize_vol imm vol =
        _AMPLITUDE *. imm *. vol /. total_vol in
    let sound_contrib freq vol i =
        normalize_vol (calc_immediate freq i) vol in
    List.fold_left sound_list ~init:0.0 ~f:(fun sum (Sound(freq, vol)) -> sum +. (sound_contrib freq vol i))

(* val marshall_sound : float -> (char, char) *)
let marshall_sound s =
    chars_of_short (Float.to_int (s))

(* val sound_list_to_chunk : sound list -> chunk *)
let sound_list_to_chunk sound_list =
    let total_vol = float (List.length sound_list) in
    let raw_string = String.of_char_list (map_explode_condense nums (fun i -> (marshall_sound (eval_sound sound_list total_vol i)))) in
    load_string_raw raw_string
