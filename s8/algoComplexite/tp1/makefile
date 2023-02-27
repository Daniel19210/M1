SRC = tp1_code

.PHONY: all format clean
	
all: tp1_code.ml
	ocamlc -o main $(SRC).ml
	./main

format:
	ocp-indent -i $(SRC).ml

clean:
	rm main *.cmi *.cmo

dune:
	@ dune build $(SRC).exe
	@ dune exec ./$(SRC).exe

