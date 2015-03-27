all:
	ocamlopt -o lsp *.ml

clean:
	rm lsp
	rm *.cmi
	rm *.cmx
	rm *.o
	rm *~