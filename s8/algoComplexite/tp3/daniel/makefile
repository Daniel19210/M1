SRC = tp3_code

.PHONY: all format clean
	
all:
	ocamlc -o main $(SRC).ml
	./main

format:
	ocp-indent -i $(SRC).ml

clean:
	rm main *.cmi *.cmo

dune:
	@ dune build $(SRC).exe
	@ dune exec ./$(SRC).exe

