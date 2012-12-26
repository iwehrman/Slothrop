type debug_level_t = 
    ERROR | INFO | WARN | DEBUG | TRACE;;

let debug_level = ref INFO;;

let parse_debug_level = function
    "error" | "0" -> ERROR
  | "info" | "1" -> INFO
  | "warn" | "2" -> WARN
  | "debug" | "3" | "" -> DEBUG
  | "trace" | "4" -> TRACE
  | x -> failwith ("Unable to parse debug level: " ^ x)
;;

let set_debug_level s = 
  debug_level := (parse_debug_level s)
;;

let should_display msg_level = 
  match msg_level,(!debug_level) with 
      ERROR,_ -> true
    | INFO,_ -> true
    | WARN,ERROR | WARN,INFO -> false
    | WARN,_ -> true
    | DEBUG,ERROR | DEBUG,INFO -> false
    | DEBUG,_ -> true
    | TRACE,TRACE -> true
    | TRACE,_ -> false
;;

let display_fun level = 
  match level with 
      INFO -> print_endline
    | _ -> prerr_endline
;;

let debug_checker = ref (false);;
let debug_rewriting = ref (false);;

let maybe_debug level msg = 
  if should_display level then
    let print = display_fun level in
      print msg
;;
  
let debug_if level b msg = 
  if b then maybe_debug level msg
;;

let debug_l level f = 
  if should_display level then 
    let print = display_fun level in
      print (Lazy.force f)
;;

let debug_if_l level b f = 
  if b then debug_l level f
;;

let error msg = maybe_debug ERROR msg;; 
let info msg = maybe_debug INFO msg;; 
let warn msg = maybe_debug WARN msg;; 
let debug msg = maybe_debug DEBUG msg;; 
let trace msg = maybe_debug TRACE msg;; 

