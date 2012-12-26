open Debug
open Tptp
open Terms
open Print
open Unix
open Status

let name = "TPA";;

let default_cmd = "tpa";;

let _handle = ref None;;

let start cmd = 
  let ic,oc = Unix.open_process cmd in
    set_binary_mode_in ic false ; 
    set_binary_mode_out oc false ;
    (ic,oc)
;;

let stop (ic,oc) = 
  close_in ic;
  ignore (Unix.close_process(ic,oc));
  _handle := None
;;

let read_answer (ic,oc) = 
  output_string oc "\n";
  flush oc;
  close_out oc;
  input_line ic
;;

let tell (ic,oc) msg =
  debug_if TRACE (!debug_checker) msg;
  output_string oc msg;
  output_char oc '\n'
;;

let ask (ic,oc) = 
  let status = 
    match read_answer (ic,oc) with 
        "YES" -> TERM_YES
      | "NO" -> TERM_NO
      | "MAYBE" -> TERM_UNKNOWN
      | "TIMEOUT" -> TERM_UNKNOWN
      | x -> failwith ("Error communicating with " ^ name ^ 
                         ": responded with " ^ x)
  in
    stop (ic,oc);
    status
;;


let get_handle cmd = 
  debug_if_l TRACE (!debug_checker) 
    (lazy ("Starting TPA (" ^ cmd ^ ") ..."));
  let h = start cmd in
    _handle := Some(h); 
    h
;;


let shutdown () = 
  match !_handle with 
      Some(h) -> stop h
    | None -> ()
;;
