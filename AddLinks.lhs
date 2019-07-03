
Little hack to add links to the navigation bars

> main :: IO ()
> main = interact addLinks


> addLinks :: String -> String
> addLinks [] = error "not found"
> addLinks ('<':'/':'u':'l':'>':'\n':'<':'/':'d':'i':'v':'>':xs) =
>     "</ul>" ++ linkSection ++ "\n</div>" ++ xs
> addLinks (x:xs) = x : addLinks xs

> linkSection :: String
> linkSection =
>   "<hr />\n\
>   \<ul class=\"sectlevel1\">\n\
>   \<div id=\"toctitle\">Links</div>\n\
>   \<li><a href=\"index.html\">Index</a></li>\n\
>   \<li><a href='sql-92-grammar.html'>SQL-92</li>\n\
>   \<li><a href='sql-1999-grammar.html'>SQL:1999</li>\n\
>   \<li><a href='sql-2003-foundation-grammar.html'>SQL:2003</li>\n\
>   \<li><a href='sql-2008-foundation-grammar.html'>SQL:2008</li>\n\
>   \<li><a href='sql-2011-foundation-grammar.html'>SQL:2011</li>\n\
>   \<li><a href='sql-2011-psm-grammar.html'>SQL:2011 SQL/PSM</li>\n\
>   \<li><a href='sql-2016-foundation-grammar.html'>SQL:2016</li>\n\
>   \</ul>\n\
>   \<br />\n\
>   \<ul class=\"sectlevel1\">\n\
>   \<li><a href=\"http://jakewheat.github.io/sql-overview\" class=\"bare\">Homepage</a></li>\n\
>   \<li><a href=\"https://github.com/JakeWheat/sql-overview\" class=\"bare\">Repository</a></li>\n\
>   \<li><a href=\"https://github.com/JakeWheat/sql-overview/issues\" class=\"bare\">Bug tracker</a></li>\n\
>   \<li><a href=\"http://jakewheat.github.io/\" class=\"bare\">Parent project</a>\n\
>   \</li><li>jakewheatmail@gmail.com</li>\n\
>   \</ul>\n"
