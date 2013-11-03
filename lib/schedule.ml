open Core.Std
open Async.Std
open Types

module type MusicEnvironment =
    sig
        val bpm : int
        val time_signature : rational
    end

(*module type Scheduler =
    sig
    end*)

module Make(Env: MusicEnvironment) = struct
    let bpm = Env.bpm
    let spb = 60.0 /. (Float.of_int bpm)
    let time_signature = Env.time_signature
    let init_time = Unix.gettimeofday ()

    let convert_duration duration = 
        match time_signature with
        Rational(_ , d2) -> 
            spb *. (Rational.to_float duration) *. (Float.of_int d2)

end
