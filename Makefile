SOURCES := heap.ml debug.ml terms.ml tptp.ml print.ml parser.mly lexer.mll \
	rewriting.ml status.ml aprove.ml tpa.ml learning.ml \
	checker.ml orient.ml cp.ml conjectures.ml huet.ml main.ml 

LIBS=unix

RESULT=slothrop

# write parser.output with info about the generated parser
YFLAGS = -v

# disable warnings about cases not covered in matches
OCAMLFLAGS := 

all: nc


include OCamlMakefile
