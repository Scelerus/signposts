# signposts

@Martin Kellogg, March-April 2015

This repository contains a program that generates data from a corpus of latin texts with regards to signposting, reporting the relative frequencies of several common signposts when applied to a text.

This program is written in Objective CAML and Python. You will need an OCaml compiler (ocaml.org); this was written using version 3.12.1. You will also need to be able to run Python scripts (this was developed using Python 2.7.3).

In order to build the program, run "make". This will create lsp, which is an executable. Run this program, passing the text you wish to analyze as an argument on the command line. It will output on stdout.

If you pipe the result into the file "results," the python script "summarizer.py" will output a summary of which signposts appear, and how often they do, to stdout. summarizer.py only read files named "results".

If you have any questions, please contact me at mjk6zt at virginia dot edu.

Martin Kellogg