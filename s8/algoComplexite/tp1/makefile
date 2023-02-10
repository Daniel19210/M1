.PHONY: all format clean

all: tp1_code.ml
	ocamlc -o main tp1_code.ml
	./main

format:
	ocp-indent -i tp1_code.ml

clean:
	rm main *.cmi *.cmo
