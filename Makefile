all:
	ocamlopt -o lsp str.cmxa *.ml

clean:
	rm lsp
	rm *.cmi
	rm *.cmx
	rm *.o
	rm *~