#!/bin/bash

f='journal'

# build
latexmk -pdf -lualatex $f.tex
makeglossaries $f
rm $f.pdf # trick remove to rebuild
latexmk -pdf -lualatex $f.tex


# clean
arg=${1:-.}
exts="acn aux bbl bcf blg blx.bib brf fdb_latexmk fls idx ilg ind ist lof log lol lot nav out run.xml snm toc synctex.gz acr alg glg glo gls glsdefs loa maf mtc mtc0 spl"

if [ -d $arg ]; then
    for ext in $exts; do
         rm -f $arg/*.$ext
	 rm -f $arg/*-$ext
    done
else
    for ext in $exts; do
         rm -f $arg.$ext
    done
fi

# rename
mv $f.pdf $f.pdf_
mv $f.pdf_ $f\_\_$(date +%Y%m%d).pdf
