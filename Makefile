
all:
	ocamlopt -o lsp str.cmxa *.ml

clean:
	rm lsp
	rm *.cmi
	rm *.cmx
	rm *.o
	rm *~

pdf:
	pdflatex plinysignposts.tex
	bibtex plinysignposts.aux
	pdflatex plinysignposts.tex
	pdflatex plinysignposts.tex