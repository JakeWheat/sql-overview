#! /usr/bin/env bash

# instructions: have a recent version of cabal-install and ghc in your path
# and perl, asciidoctor
# run this file and it will generate the html to the build dir
# tested with cabal-install 3.0.0.0 and ghc 8.10.1
# should work with earlier versions of both (and later)
# last ran with asciidoctor 1.5.8

set -e

mkdir -p build

asciidoctor index.asciidoc -o -| cabal run -v0 AddLinks > build/index.html

for i in sql-92-grammar sql-1999-grammar sql-2003-foundation-grammar sql-2008-foundation-grammar sql-2011-foundation-grammar sql-2011-psm-grammar sql-2016-foundation-grammar; do
    echo $i
    perl fix_lines.pl < $i.txt | cabal run -v0 GrammarToAsciidoc | asciidoctor - | cabal run -v0 AddLinks > build/$i.html
done

