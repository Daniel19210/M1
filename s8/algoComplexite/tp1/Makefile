.PHONY: all format clean

all:
	ocamlc -o code tp1_code.ml
	./code

format:
	ocp-indent -i tp1_code.ml

clean:
	rm code *.cmi *.cmo
