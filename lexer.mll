{
  (* tptp lexer*)
  open Parser
}
rule token = parse 
  | "input_clause" {INPUT_CLAUSE} 
  | "axiom" {AXIOM} 
  | "hypothesis" {HYPOTHESIS}
  | "conjecture" {CONJECTURE}
  | "equal" {EQUAL} 
  | ['a' - 'z']['a'-'z' 'A' - 'Z' '1'-'9' '_']* {LSYM(Lexing.lexeme lexbuf)}
  | ['A' - 'Z']['a'-'z' 'A' - 'Z' '1'-'9' '_']* {USYM(Lexing.lexeme lexbuf)}
  | "++" {PLUSPLUS}
  | "--" {MINUSMINUS}
  | '(' {LPAREN}
  | ')' {RPAREN}
  | '[' {LBRACKET}
  | ']' {RBRACKET}
  | '.' {DOT}
  | ',' {COMMA}
  | '#' [^'\n']* "\n" {token lexbuf}  (* comment *)
  | '%' [^'\n']* "\n" {token lexbuf}  (* comment *)
  | [' ' '\t' '\n' '\r'] {token lexbuf}
  | eof   {EOF}
  | _ {token lexbuf}
