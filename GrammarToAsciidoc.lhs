
This file converts the text grammar files into asciidoc

creates asciidoc headings from the text headings (==, ===)
changes 'Function' and 'Format' into local headings (.Function)
adds anchors to the start of each grammar def
adds anchor links in the grammar def bodies
adds blocks around the grammar defs

TODO:

add backreferences from grammer def names to usage sites (in
side bar?)

get links working e.g. from psm to foundation doc

> import Data.Char
> --import System.Environment
> --import Data.List
> import Text.Regex

> --import Debug.Trace

> main :: IO ()
> main = do
>   str <- getContents
>   let ls = lines str
>       ls' = addBlocks False ls
>   putStrLn ":toc: right\n\n= Document\n"
>   putStrLn $ unlines ls'


start a pre block:
add the anchor and start the block

> addBlocks :: Bool -> [String] -> [String]
> addBlocks False (x@('<':t):xs) = --trace (show ("g",x)) $
>     let t' = hyphenize $ takeWhile (/='>') t
>     in ("[[" ++ t' ++ "]]")
>        :"[subs=\"specialcharacters,macros\"]"
>        :"----":x:addBlocks True xs
>   where
>     hyphenize = map $ \c -> case c of
>         ' ' -> '-'
>         _ -> c

inside a pre block, check if this is the end of the block

special case for the keywords which have empty lines inside the
grammar defs

> addBlocks True (x:y:xs) | trim x == ""
>                           && startsWithPipe (trim y)
>      = x:addBlocks True (y:xs)
>   where
>     startsWithPipe ('|':_) = True
>     startsWithPipe _ = False

regular end of grammar def - an empty line

> addBlocks True (x:xs) | trim x == "" = "----":x:addBlocks False xs


inside a pre block, change a grammar reference into an anchorlink
line with grammar defs, add links

(<([^>]*)>) ->  <<replace-space-with-hyphen \2, \1 >

example:
<SQL language character>
->
<<SQL-language-character, <SQL language character> >>

> {-addBlocks True (x@(' ':_):xs)
>   | trace (show (grammarLine x, x)) False = undefined
>   where
>     grammarLine y = case dropWhile isSpace y of
>         '<':_ -> True
>         _ -> False-}

> addBlocks True (x@(' ':_):xs) =
>     fixLinks (
>       subRegex (mkRegex "(<([^>]*)>)") x "<<\\2, \\1 >>")
>     : addBlocks True xs
>   where
>     {-grammarLine y = case dropWhile isSpace y of
>         '<':_ -> True
>         _ -> False-}
>     fixLinks ('<':'<':ts) = '<':'<': hyph ts
>     fixLinks (t:ts) = t : fixLinks ts
>     fixLinks [] = []
>     hyph (',':ts) = ',':fixLinks ts
>     hyph (' ':ts) = '-' : hyph ts
>     hyph (t:ts) = t : hyph ts
>     hyph [] = []


> addBlocks True (x:xs) = x:addBlocks True xs

add a newline after function,format headers so they render nicely

> addBlocks False (x:xs) | trim x `elem` headers =
>     ('.':x):"":addBlocks False xs
>   where headers = ["Function","Format"]

section titles

> addBlocks False (x@(c1:_):xs) | isDigit c1 =
>     (case dropWhile isDigit x of
>          '.':_ -> "=== " ++ x
>          _ -> "== " ++ x)
>     : addBlocks False xs


any other line: todo, check for anchor links

> addBlocks False (x:xs) = x:addBlocks False xs

finished the document

> addBlocks True [] = ["----"]
> addBlocks False [] = []



> trim :: String -> String
> trim = f . f
>    where f = reverse . dropWhile isSpace
