open Debug
open Terms
open Tptp
open Print
open Lexer
open Parser
open Rewriting
open Huet
open Orient
open Conjectures

let equation_of_clause allow_neg = function
    InputClause(n,st,Equal(s,t)::[]) -> true,(s,t)
  | InputClause(n,st,DisEqual(s,t)::[]) when allow_neg -> false,(s,t)
  | x -> failwith "Positive unit clauses only"
;;

let find_all = ref false;;

let separate clauses = 
  let rec sep_h ax hp cj = function
      ((InputClause(s,Axiom,tl)) as a)::cs -> 
        sep_h (a::ax) hp cj cs
    | ((InputClause(s,Hypothesis,tl)) as h)::cs -> 
        sep_h ax (h::hp) cj cs
    | ((InputClause(s,Conjecture,tl)) as c)::cs -> 
        sep_h ax hp (c::cj) cs
    | [] -> (ax,hp,cj)
  in
    sep_h [] [] [] clauses
;;
      



let go filename = 
  let in_ch = open_in filename in
  let lexbuf = Lexing.from_channel in_ch in
  let clauses = Parser.start Lexer.token lexbuf in
  let axioms,hypotheses,conjectures = separate clauses in
  let ax_eq = snd (List.split 
                     (List.map (equation_of_clause false) axioms)) in
  let hyp_eq = snd (List.split 
                      (List.map (equation_of_clause false) hypotheses)) in
  let conj_eq = List.map (equation_of_clause true) conjectures in
  let identities = ax_eq@hyp_eq in
    debug "Input clauses: ";
    List.iter (fun c -> debug (string_of_clause c)) clauses;
    debug "Axioms: ";
    List.iter (fun c -> debug (string_of_rule c)) ax_eq;
    debug "Hypothesis: ";
    List.iter (fun c -> debug (string_of_equation c)) hyp_eq;
    debug "Conjectures: ";
    List.iter (fun (b,c) -> 
                 debug 
                   ((if b then string_of_equation else 
                       string_of_disequation) c)) conj_eq;
    if !trust_input then List.iter add_axiom ax_eq;
    begin
      try
        let dp,unsolved = grind identities conj_eq !find_all in 
          if unsolved != [] then
            (info "Deciding remaining conjectures...";
             List.iter (decide_conjecture dp) unsolved)
      with
          CONJECTURES_SOLVED -> ()
    end;
    info "All conjectures solved."
;;


let opt_specs =
  [ "--debug", 
    Arg.String set_debug_level, 
    "Turn on debugging";
    
    "--debug-checker", 
    Arg.Set debug_checker, 
    "Show communication with the termination checker";

    "--debug-learning", 
    Arg.Set Learning.dbg_learning, 
    "Debug learning";

    "--debug-rewriting", 
    Arg.Set debug_rewriting, 
    "Show normalization steps in detail";

    "--timeout", 
    Arg.Set_int Huet.timeout, 
    "Timeout in seconds";

    "-t", 
    Arg.Set_int Huet.timeout, 
    "Timeout in seconds";

    "--complete", 
    Arg.Set Huet.completion_mode, 
    "Search for a convergent completion";

    "--find-all", 
    Arg.Set find_all, 
    "Find all completions";

    "--trust-input",
    Arg.Set trust_input,
    "Always orient axioms as given in the input";

    "--aprove",
    Arg.Unit Checker.use_aprove,
    "Use the AProVE termination checker (default)";

    "--tpa",
    Arg.Unit Checker.use_tpa,
    "Use the TPA termination checker";

    "--cmd",
    Arg.Set_string Checker.checker_cmd,
    "Command used to run AProVE";

  ];;


let main() = 
  try
    Arg.parse opt_specs go 
      ("Usage: " ^ Sys.argv.(0) ^ " <file1.tptp> <file2.tptp> ...");
    exit 0
  with 
      Arg.Bad msg ->
	prerr_string (Sys.argv.(0) ^ ": " ^ msg ^ "\n");
	exit 1
;;

main();;


