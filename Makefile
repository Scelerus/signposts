
all:
	ocamlopt -o lsp str.cmxa *.ml

clean:
	rm lsp
	rm *.cmi
	rm *.cmx
	rm *.o
	rm *~

pdf:
	pdflatex main.tex
	bibtex main.aux
	pdflatex main.tex
	pdflatex main.tex