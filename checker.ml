open Debug
open Tptp
open Terms
open Print
open Unix
open Status
open Learning

module type External_checker = 
sig
  val name : string
  val default_cmd : string
  val get_handle : string -> in_channel * out_channel
  val tell : in_channel * out_channel -> string -> unit
  val ask : in_channel * out_channel -> checker_status
  val shutdown : unit -> unit
end
;;  

(* FIXME : I have no idea how modules work *)

module AProVE = ( Aprove : External_checker );;
module TPA = ( Tpa : External_checker );;



type checker_t = APROVE | TPA;;

let string_of_checker = function
    APROVE -> AProVE.name
  | TPA -> TPA.name
;;

let checker = ref APROVE;;
let checker_cmd = ref "aprove";;

let use_aprove() = checker_cmd := AProVE.default_cmd; checker := APROVE;;
let use_tpa() = checker_cmd := TPA.default_cmd; checker := TPA;;

let checker_name() = string_of_checker !checker;;

let get_handle cmd =
  match !checker with 
      APROVE -> AProVE.get_handle cmd
    | TPA -> TPA.get_handle cmd
;;

let tell handle msg = 
  match !checker with 
      APROVE -> AProVE.tell handle msg
    | TPA -> TPA.tell handle msg
;;

let ask handle = 
  match !checker with 
      APROVE -> AProVE.ask handle
    | TPA -> TPA.ask handle
;;

let shutdown () = 
  match !checker with 
      APROVE -> AProVE.shutdown ()
    | TPA -> TPA.shutdown ()
;;




let call_count = ref 0;;
let call_time = ref 0.;;
let max_call_time = ref 0.;;
let min_call_time = ref max_float;;
let total_yes_time = ref 0.;;
let max_yes_time = ref 0.;;
let yes_count = ref 0;;
let no_count = ref 0;;
let maybe_count = ref 0;;
let orientations = ref 0;;
let duplicates = ref 0;;

let is_terminating all_rules vars =
  match all_rules with 
      r::rs -> 
        let vars_msg = string_of_vars_tpdb vars in
        let rules_msg = string_of_trs_tpdb all_rules in
        let handle = get_handle !checker_cmd in
          incr call_count;
          debug_if_l TRACE (!debug_checker) 
            (lazy ("tell: " ^ (string_of_int !call_count)));
          List.iter (tell handle) [vars_msg;rules_msg];
          let start_t = gettimeofday() in
          let status = ask handle in
          let stop_t = gettimeofday() in
          let this_call_time = stop_t -. start_t in
            call_time := !call_time +. this_call_time;
            if (compare this_call_time !max_call_time) > 0 then 
              max_call_time := this_call_time;
            if (compare this_call_time !min_call_time) < 0 then 
              min_call_time := this_call_time;
            debug_if_l TRACE (!debug_checker) 
              (lazy ("ask: " ^ (string_of_int !call_count) ^ " " ^
                       (string_of_checker_status status) ^ " " ^
                       (string_of_float this_call_time)));
            begin
              match status with
                  TERM_YES -> 
                    incr yes_count; 
                    total_yes_time := !total_yes_time +. this_call_time;
                    if this_call_time > !max_yes_time then 
                      max_yes_time := this_call_time;
                    register_terminating_trs all_rules;
                    true
                | TERM_NO -> 
                    incr no_count;
                    register_nonterminating_trs all_rules;
                    false
                | TERM_UNKNOWN -> 
                    incr maybe_count;
                    false
            end
    | [] -> failwith "Testing empty TRS for termination"
;;


(* always shutdown checker on exit *)
at_exit (fun () -> shutdown ());;

