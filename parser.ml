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

open Parsing;;
# 2 "parser.mly"
(* tptp parser *)

open Terms
open Tptp

# 27 "parser.ml"
let yytransl_const = [|
  259 (* INPUT_CLAUSE *);
  260 (* AXIOM *);
  261 (* HYPOTHESIS *);
  262 (* CONJECTURE *);
  263 (* EQUAL *);
  264 (* LPAREN *);
  265 (* RPAREN *);
  266 (* LBRACKET *);
  267 (* RBRACKET *);
  268 (* PLUSPLUS *);
  269 (* MINUSMINUS *);
  270 (* COMMA *);
  271 (* DOT *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  257 (* LSYM *);
  258 (* USYM *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\003\000\004\000\004\000\004\000\005\000\
\005\000\006\000\006\000\008\000\008\000\008\000\008\000\008\000\
\008\000\007\000\007\000\007\000\000\000"

let yylen = "\002\000\
\002\000\002\000\001\000\011\000\001\000\001\000\001\000\003\000\
\001\000\007\000\007\000\006\000\004\000\003\000\003\000\001\000\
\001\000\004\000\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\021\000\000\000\000\000\000\000\001\000\
\002\000\000\000\000\000\005\000\006\000\007\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\008\000\000\000\020\000\000\000\
\000\000\004\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\018\000\010\000\011\000\
\000\000\014\000\015\000\000\000\000\000\012\000"

let yydgoto = "\002\000\
\004\000\005\000\006\000\015\000\020\000\021\000\032\000\040\000"

let yysindex = "\013\000\
\019\255\000\000\013\255\000\000\023\000\019\255\023\255\000\000\
\000\000\011\255\002\255\000\000\000\000\000\000\012\255\017\255\
\003\255\021\255\022\255\020\255\024\255\025\255\026\255\027\255\
\003\255\016\255\016\255\015\255\000\000\029\255\000\000\028\255\
\030\255\000\000\018\255\016\255\016\255\253\254\031\255\032\255\
\034\255\037\255\018\255\018\255\018\255\000\000\000\000\000\000\
\038\255\000\000\000\000\035\255\018\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\032\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\039\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\251\254\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\042\255\043\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\044\255\000\000\000\000"

let yygindex = "\000\000\
\000\000\029\000\000\000\000\000\014\000\000\000\232\255\213\255"

let yytablesize = 53
let yytable = "\049\000\
\050\000\051\000\033\000\019\000\043\000\012\000\013\000\014\000\
\019\000\054\000\044\000\041\000\042\000\001\000\018\000\019\000\
\030\000\031\000\038\000\039\000\007\000\003\000\008\000\010\000\
\011\000\016\000\017\000\022\000\023\000\034\000\024\000\003\000\
\026\000\027\000\009\000\028\000\035\000\025\000\029\000\000\000\
\046\000\036\000\047\000\037\000\045\000\048\000\052\000\000\000\
\053\000\009\000\016\000\017\000\013\000"

let yycheck = "\043\000\
\044\000\045\000\027\000\009\001\008\001\004\001\005\001\006\001\
\014\001\053\000\014\001\036\000\037\000\001\000\012\001\013\001\
\001\001\002\001\001\001\002\001\008\001\003\001\000\000\001\001\
\014\001\014\001\010\001\007\001\007\001\015\001\011\001\000\000\
\008\001\008\001\006\000\009\001\008\001\014\001\025\000\255\255\
\009\001\014\001\009\001\014\001\014\001\009\001\009\001\255\255\
\014\001\011\001\009\001\009\001\009\001"

let yynames_const = "\
  INPUT_CLAUSE\000\
  AXIOM\000\
  HYPOTHESIS\000\
  CONJECTURE\000\
  EQUAL\000\
  LPAREN\000\
  RPAREN\000\
  LBRACKET\000\
  RBRACKET\000\
  PLUSPLUS\000\
  MINUSMINUS\000\
  COMMA\000\
  DOT\000\
  EOF\000\
  "

let yynames_block = "\
  LSYM\000\
  USYM\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun parser_env ->
    let _1 = (peek_val parser_env 1 : 'clauses) in
    Obj.repr(
# 30 "parser.mly"
            ( _1 )
# 141 "parser.ml"
               : Tptp.clause_t list))
; (fun parser_env ->
    let _1 = (peek_val parser_env 1 : 'one_clause) in
    let _2 = (peek_val parser_env 0 : 'clauses) in
    Obj.repr(
# 33 "parser.mly"
                   ( _1 :: _2 )
# 149 "parser.ml"
               : 'clauses))
; (fun parser_env ->
    let _1 = (peek_val parser_env 0 : 'one_clause) in
    Obj.repr(
# 34 "parser.mly"
             ( [_1] )
# 156 "parser.ml"
               : 'clauses))
; (fun parser_env ->
    let _3 = (peek_val parser_env 8 : string) in
    let _5 = (peek_val parser_env 6 : 'clause_status) in
    let _8 = (peek_val parser_env 3 : 'formulas) in
    Obj.repr(
# 38 "parser.mly"
( InputClause(_3, _5, _8) )
# 165 "parser.ml"
               : 'one_clause))
; (fun parser_env ->
    Obj.repr(
# 41 "parser.mly"
      (Axiom)
# 171 "parser.ml"
               : 'clause_status))
; (fun parser_env ->
    Obj.repr(
# 42 "parser.mly"
             (Hypothesis)
# 177 "parser.ml"
               : 'clause_status))
; (fun parser_env ->
    Obj.repr(
# 43 "parser.mly"
             (Conjecture)
# 183 "parser.ml"
               : 'clause_status))
; (fun parser_env ->
    let _1 = (peek_val parser_env 2 : 'one_formula) in
    let _3 = (peek_val parser_env 0 : 'formulas) in
    Obj.repr(
# 46 "parser.mly"
                           ( _1 :: _3 )
# 191 "parser.ml"
               : 'formulas))
; (fun parser_env ->
    let _1 = (peek_val parser_env 0 : 'one_formula) in
    Obj.repr(
# 47 "parser.mly"
              ([_1])
# 198 "parser.ml"
               : 'formulas))
; (fun parser_env ->
    let _4 = (peek_val parser_env 3 : 'term) in
    let _6 = (peek_val parser_env 1 : 'term) in
    Obj.repr(
# 50 "parser.mly"
                                             ( Equal(_4, _6) )
# 206 "parser.ml"
               : 'one_formula))
; (fun parser_env ->
    let _4 = (peek_val parser_env 3 : 'term) in
    let _6 = (peek_val parser_env 1 : 'term) in
    Obj.repr(
# 51 "parser.mly"
                                                 ( DisEqual(_4, _6) )
# 214 "parser.ml"
               : 'one_formula))
; (fun parser_env ->
    let _1 = (peek_val parser_env 5 : string) in
    let _3 = (peek_val parser_env 3 : 'terms) in
    let _6 = (peek_val parser_env 0 : 'terms) in
    Obj.repr(
# 54 "parser.mly"
                                     ( (T(_1, _3)) :: _6  )
# 223 "parser.ml"
               : 'terms))
; (fun parser_env ->
    let _1 = (peek_val parser_env 3 : string) in
    let _3 = (peek_val parser_env 1 : 'terms) in
    Obj.repr(
# 55 "parser.mly"
                           ( [T(_1, _3)]  )
# 231 "parser.ml"
               : 'terms))
; (fun parser_env ->
    let _1 = (peek_val parser_env 2 : string) in
    let _3 = (peek_val parser_env 0 : 'terms) in
    Obj.repr(
# 56 "parser.mly"
                   ( T(_1,[]) :: _3 )
# 239 "parser.ml"
               : 'terms))
; (fun parser_env ->
    let _1 = (peek_val parser_env 2 : string) in
    let _3 = (peek_val parser_env 0 : 'terms) in
    Obj.repr(
# 57 "parser.mly"
                   ( V(_1,0) :: _3  )
# 247 "parser.ml"
               : 'terms))
; (fun parser_env ->
    let _1 = (peek_val parser_env 0 : string) in
    Obj.repr(
# 58 "parser.mly"
       ( [T (_1,[])] )
# 254 "parser.ml"
               : 'terms))
; (fun parser_env ->
    let _1 = (peek_val parser_env 0 : string) in
    Obj.repr(
# 59 "parser.mly"
       ( [V (_1,0)] )
# 261 "parser.ml"
               : 'terms))
; (fun parser_env ->
    let _1 = (peek_val parser_env 3 : string) in
    let _3 = (peek_val parser_env 1 : 'terms) in
    Obj.repr(
# 62 "parser.mly"
                           ( T(_1, _3)  )
# 269 "parser.ml"
               : 'term))
; (fun parser_env ->
    let _1 = (peek_val parser_env 0 : string) in
    Obj.repr(
# 63 "parser.mly"
       ( T (_1,[]) )
# 276 "parser.ml"
               : 'term))
; (fun parser_env ->
    let _1 = (peek_val parser_env 0 : string) in
    Obj.repr(
# 64 "parser.mly"
       ( V (_1,0) )
# 283 "parser.ml"
               : 'term))
(* Entry start *)
; (fun parser_env -> raise (YYexit (peek_val parser_env 0)))
|]
let yytables =
  { actions=yyact;
    transl_const=yytransl_const;
    transl_block=yytransl_block;
    lhs=yylhs;
    len=yylen;
    defred=yydefred;
    dgoto=yydgoto;
    sindex=yysindex;
    rindex=yyrindex;
    gindex=yygindex;
    tablesize=yytablesize;
    table=yytable;
    check=yycheck;
    error_function=parse_error;
    names_const=yynames_const;
    names_block=yynames_block }
let start (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (yyparse yytables 1 lexfun lexbuf : Tptp.clause_t list)
