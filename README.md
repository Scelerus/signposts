# signposts

@Martin Kellogg, March-April 2015

This repository contains a program that generates data from a corpus of latin texts with regards to signposting, reporting the relative frequencies of several common signposts when applied to a text. This program was used to produce the paper whose latex source is also found here. The latex can be compiled by running "make pdf". This requires pdflatex and bibtex.

The program is written in Objective CAML and Python. You will need an OCaml compiler (ocaml.org); this was written using version 3.12.1. You will also need to be able to run Python scripts (this was developed using Python 2.7.3).

In order to build the program, run "make". This will create lsp, which is an executable. Run this program, passing the text you wish to analyze as an argument on the command line. It will output on stdout.

If you pipe the result into the file "results," the python script "summarizer.py" will output a summary of which signposts appear, and how often they do, to stdout. summarizer.py only read files named "results".

If you have any questions, please contact me at mjk6zt at virginia dot edu.

Martin Kellogg

### This file is part of signposts.

    signposts is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Foobar is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with signposts.  If not, see <http://www.gnu.org/licenses/>.

###