open Types

let int_of_pitch = function
    | C__             -> 0
    | C_              -> 1
    | C   | D__       -> 2
    | C'  | D_        -> 3
    | D   | E__ | C'' -> 4
    | D'  | E_  | F__ -> 5
    | E   | F_  | D'' -> 6
    | F   | G__ | E'  -> 7
    | F'  | G_  | E'' -> 8
    | G   | A__ | F'' -> 9
    | G'  | A_        -> 10
    | A   | B__ | G'' -> 11
    | A'  | B_        -> 12
    | B   | A''       -> 13
    | B'              -> 14
    | B''             -> 15

let pitch_compare p1 p2 =
    (int_of_pitch p1) - (int_of_pitch p2)

let tone_compare (Tone(p1, o1)) (Tone(p2, o2)) =
    let oc = o2 - o1 in
    if (oc = 0)
        then pitch_compare p1 p2
        else oc

let tones_of_pitches_in_order pitches base_octave =
    let rec helper_fun prev_pitch octave = function
        | [] -> []
        | p::ps -> 
        let octave' = if (pitch_compare p prev_pitch) >= 0 then octave else octave + 1 in
        (Tone(p, octave'))::(helper_fun p octave' ps) in
    match pitches with
        | [] -> []
        | p::ps -> (Tone(p, base_octave))::(helper_fun p base_octave ps)

let freq_of_tone = function
    Tone(p, o) -> 
        let o = match p with
            | B'  | B'' -> o + 1
            | C_  | C__ -> o - 1
            | _         -> o in
        (* The base frequencies are the corresponding
         * frequencies for each note in the first octave *)
        let base_freq = match p with
            | C   | D__ | B'  -> 32.70
            | C'  | D_  | B'' -> 34.65
            | D   | E__ | C'' -> 36.71
            | D'  | E_  | F__ -> 38.89
            | E   | F_  | D'' -> 41.20
            | F   | G__ | E'  -> 43.65
            | F'  | G_  | E'' -> 46.25
            | G   | A__ | F'' -> 49.00
            | G'  | A_        -> 51.91
            | A   | B__ | G'' -> 55.00
            | A'  | B_  | C__ -> 58.27
            | B   | C_  | A'' -> 61.74 in
        (* Every octave increase causes a doubling of the frequency
         * and therefore an octave decrease halves the frequency *)
        let scale_fun = 
            if (o < 1) 
                then (fun freq -> freq /. (float (2 lsl (1 - o))))
                else (fun freq -> freq *. (float (2 lsl (o - 1)))) in
        scale_fun base_freq

