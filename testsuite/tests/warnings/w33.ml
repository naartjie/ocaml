(* TEST

flags = "-w A"

* setup-ocamlc.byte-build-env
** ocamlc.byte
compile_only = "true"
*** check-ocamlc.byte-output

*)

(** Test unused opens, in particular in presence of
     pattern open *)

module M = struct end
module N = struct type t = A | B end
module R = struct type r = {x: int} end

let f M.(x) = x (* useless open *)
let g N.(A|B) = () (* used open *)
let h R.{x} = R.{x}

open N (* used open *)
let i (A|B) = B

open! M (* useless open! *)
open M (* useless open *)
