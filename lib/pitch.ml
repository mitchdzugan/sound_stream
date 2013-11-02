type octave_ = int
type pitch = A__ | B__ | C__ | D__ | E__ | F__ | G__ |
             A_  | B_  | C_  | D_  | E_  | F_  | G_  | 
             A   | B   | C   | D   | E   | F   | G   | 
             A'  | B'  | C'  | D'  | E'  | F'  | G'  | 
             A'' | B'' | C'' | D'' | E'' | F'' | G''

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

