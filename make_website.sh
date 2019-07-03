#! /usr/bin/env bash

set -e

cabal sandbox init
cabal install regex-compat

mkdir -p build

asciidoctor index.asciidoc -o -| runhaskell AddLinks.lhs > build/index.html

gta="runhaskell -package-db=.cabal-sandbox/x86_64-linux-ghc-7.10.2-packages.conf.d/ ./GrammarToAsciidoc.lhs"

cat sql-92-grammar.txt | $gta | asciidoctor - | runhaskell AddLinks.lhs > build/sql-92-grammar.html
cat sql-1999-grammar.txt | $gta | asciidoctor - | runhaskell AddLinks.lhs > build/sql-1999-grammar.html
cat sql-2003-foundation-grammar.txt | $gta | asciidoctor - | runhaskell AddLinks.lhs > build/sql-2003-foundation-grammar.html
cat sql-2008-foundation-grammar.txt | $gta | asciidoctor - | runhaskell AddLinks.lhs > build/sql-2008-foundation-grammar.html
cat sql-2011-foundation-grammar.txt | $gta | asciidoctor - | runhaskell AddLinks.lhs > build/sql-2011-foundation-grammar.html
cat sql-2011-psm-grammar.txt | $gta | asciidoctor - | runhaskell AddLinks.lhs > build/sql-2011-psm-grammar.html
cat sql-2016-foundation-grammar.txt | $gta | asciidoctor - | runhaskell AddLinks.lhs > build/sql-2016-foundation-grammar.html
