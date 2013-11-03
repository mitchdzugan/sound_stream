type rational = Rational of int * int

type pitch = A__ | B__ | C__ | D__ | E__ | F__ | G__ |
             A_  | B_  | C_  | D_  | E_  | F_  | G_  | 
             A   | B   | C   | D   | E   | F   | G   | 
             A'  | B'  | C'  | D'  | E'  | F'  | G'  | 
             A'' | B'' | C'' | D'' | E'' | F'' | G''
type octave_ = int
type tone = Tone of pitch * octave_

type frequency_ = float
type volume_ = float
type sound = Sound of frequency_ * volume_

type duration_ = rational
type note = Note of tone * volume_ * duration_

type frame_count_ = int
type stream_segment = StreamSegment of sound list * frame_count_
