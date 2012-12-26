%{
(* tptp parser *)

open Terms
open Tptp

%}
%token <string> LSYM
%token <string> USYM
%token INPUT_CLAUSE
%token AXIOM
%token HYPOTHESIS
%token CONJECTURE
%token EQUAL
%token LPAREN
%token RPAREN
%token LBRACKET
%token RBRACKET
%token PLUSPLUS
%token MINUSMINUS
%token COMMA
%token DOT
%token EOF

%start start
%type <Tptp.clause_t list> start

%%
start: 
clauses EOF { $1 }

clauses:
one_clause clauses { $1 :: $2 }
| one_clause { [$1] }

one_clause:
INPUT_CLAUSE LPAREN LSYM COMMA clause_status COMMA LBRACKET formulas RBRACKET RPAREN DOT
{ InputClause($3, $5, $8) }

clause_status:
AXIOM {Axiom}
| HYPOTHESIS {Hypothesis}
| CONJECTURE {Conjecture}

formulas: 
one_formula COMMA formulas { $1 :: $3 }
| one_formula {[$1]}

one_formula:
PLUSPLUS EQUAL LPAREN term COMMA term RPAREN { Equal($4, $6) }
| MINUSMINUS EQUAL LPAREN term COMMA term RPAREN { DisEqual($4, $6) }

terms:
LSYM LPAREN terms RPAREN COMMA terms { (T($1, $3)) :: $6  }
| LSYM LPAREN terms RPAREN { [T($1, $3)]  }
| LSYM COMMA terms { T($1,[]) :: $3 }
| USYM COMMA terms { V($1,0) :: $3  }
| LSYM { [T ($1,[])] }
| USYM { [V ($1,0)] } 

term:
| LSYM LPAREN terms RPAREN { T($1, $3)  }
| LSYM { T ($1,[]) }
| USYM { V ($1,0) } 




