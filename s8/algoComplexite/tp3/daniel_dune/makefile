SRC = main

.PHONY: all format clean
	
all: dune

ocamlc:
	ocamlc -o main $(SRC).ml
	./main

format:
	ocp-indent -i bin/$(SRC).ml

clean:
	rm main *.cmi *.cmo

dune:
	#@ dune build $(SRC).exe
	#@ dune exec ./$(SRC).exe
	@ dune exec daniel_dune

