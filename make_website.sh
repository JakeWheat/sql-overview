#! /usr/bin/env bash

set -e

cabal v1-sandbox init
cabal v1-install regex-compat

mkdir -p build

asciidoctor index.asciidoc -o -| runhaskell AddLinks.lhs > build/index.html

gta="runhaskell -package-db=.cabal-sandbox/x86_64-linux-ghc-8.6.5-packages.conf.d/ ./GrammarToAsciidoc.lhs"

for i in sql-92-grammar sql-1999-grammar sql-2003-foundation-grammar sql-2008-foundation-grammar sql-2011-foundation-grammar sql-2011-psm-grammar sql-2016-foundation-grammar; do
    echo $i
    perl fix_lines.pl < $i.txt | $gta | asciidoctor - | runhaskell AddLinks.lhs > build/$i.html
done
