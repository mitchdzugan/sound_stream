open Core.Std
open Types

let to_float (Rational(n, d)) = 
    (Float.of_int n) /. (Float.of_int d)

let to_int (Rational(n, d)) = 
    n / d

let rec greatest_common_factor a b =
    if (b = 0)
        then a
        else greatest_common_factor b (a mod b)

let reduce (Rational(n, d)) =
    let gcf = greatest_common_factor n d in
    Rational(n/gcf, d/gcf)

let ( *// ) (Rational(n1, d1)) (Rational(n2, d2)) =
    Rational(n1*n2, d1*d2)

let ( /// ) (Rational(n1, d1)) (Rational(n2, d2)) =
    Rational(n1*d2, d1*n2)

let ( +// ) (Rational(n1, d1)) (Rational(n2, d2)) =
    Rational (n1*d1*d2 + n2*d1*d2, d1*d2)

let ( -// ) (Rational(n1, d1)) (Rational(n2, d2)) =
    Rational (n1*d1*d2 - n2*d1*d2, d1*d2)
