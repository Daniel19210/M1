EXECUTABLES=newton newtonx

all: $(EXECUTABLES)


################# pour compiler sans optimisation 
newton: tp5_code.ml
	ocamlfind ocamlc -o newton graphics.cma tp5_code.ml


################# pour compiler avec optimisation 
newtonx: tp5_code.ml
	ocamlfind ocamlopt -o newtonx graphics.cmxa tp5_code.ml


################# clean up
clean:
	rm -f $(EXECUTABLES)
	rm -f *.cm[iox] *.o *.cma *.cmxa *.a