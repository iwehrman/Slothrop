open Debug
open Tptp
open Terms
open Print
open Unix
open Status

let name = "AProVE";;

let default_cmd = "aprove";;

let read_answer (ic,oc) = 
  output_string oc ".\n";
  flush oc;
  let ans = input_line ic in
    ignore (input_line ic); 
    ignore (input_line ic); 
    ans
;;

let tell (ic,oc) msg =
  debug_if TRACE (!debug_checker) msg;
  output_string oc msg;
  output_char oc '\n'
;;

let ask (ic,oc) = 
  match read_answer (ic,oc) with 
      "true" -> TERM_YES
    | "false" -> TERM_NO
    | "maybe" -> TERM_UNKNOWN
    | "timed out" -> TERM_UNKNOWN
    | x -> failwith ("Error communicating with " ^ name ^ 
                       ": responded with " ^ x)
;;

let start cmd = 
  let ic,oc = Unix.open_process cmd in
    set_binary_mode_in ic false ; 
    set_binary_mode_out oc false ;
    (ic,oc)
;;

let stop (ic,oc) = 
  close_in ic;
  ignore (Unix.close_process(ic,oc))
;;

let _handle = ref None;;

let set_handle cmd h =
  _handle := Some(cmd,h); h
;;

let get_handle cmd = 
  match !_handle with 
      None -> 
        debug_if_l TRACE (!debug_checker) 
          (lazy ("Starting AProVE (" ^ cmd ^ ") ..."));
        let h = start cmd in
          set_handle cmd h
    | Some(s,h) when s = cmd -> h
    | Some(s,h) -> 
        debug_if_l TRACE (!debug_checker) 
          (lazy ("Restarting AProVE (" ^ cmd ^ ") ..."));
        stop h;
        let h' = start cmd in
          set_handle cmd h'
;;


let shutdown () = 
  match !_handle with 
      Some(cmd,h) -> 
        stop h
    | None -> ()
;;
