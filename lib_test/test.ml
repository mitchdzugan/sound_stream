open Sdlmixer
open Unix
open Types
open Sound

let sound_c_dim = sounds_of_pitches_in_order_const_vol
                    [D;F;G';C_] 3 1.0
let sound_c_res = sounds_of_pitches_in_order_const_vol
                    [C;F_;F'';B'] 3 1.0

let () =
    open_audio ~freq:44100 ~format:AUDIO_FORMAT_S16SYS ~chunksize:2048 ~channels:MONO ();
    play_sound (sound_list_to_chunk sound_c_dim);
    sleep 1;
    play_sound (sound_list_to_chunk sound_c_res);
    sleep 1;
    close_audio ()
