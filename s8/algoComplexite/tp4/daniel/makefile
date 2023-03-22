SRC = main

.PHONY: all format clean
	
all:
	ocamlc -o main bin/$(SRC).ml
	./main

format:
	ocp-indent -i bin/$(SRC).ml

clean:
	rm main *.cmi *.cmo

dune:
	@ dune build bin/$(SRC).exe
	@ dune exec ./$(SRC).exe

