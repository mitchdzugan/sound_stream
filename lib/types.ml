type octave_ = int
type pitch = A__ | B__ | C__ | D__ | E__ | F__ | G__ |
             A_  | B_  | C_  | D_  | E_  | F_  | G_  | 
             A   | B   | C   | D   | E   | F   | G   | 
             A'  | B'  | C'  | D'  | E'  | F'  | G'  | 
             A'' | B'' | C'' | D'' | E'' | F'' | G''

type tone = Tone of pitch * octave_

type frequency_ = float
type volume_ = float
type sound = Sound of volume_ * frequency_
