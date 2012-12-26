type token =
  | LSYM of (string)
  | USYM of (string)
  | INPUT_CLAUSE
  | AXIOM
  | HYPOTHESIS
  | CONJECTURE
  | EQUAL
  | LPAREN
  | RPAREN
  | LBRACKET
  | RBRACKET
  | PLUSPLUS
  | MINUSMINUS
  | COMMA
  | DOT
  | EOF

val start :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Tptp.clause_t list
