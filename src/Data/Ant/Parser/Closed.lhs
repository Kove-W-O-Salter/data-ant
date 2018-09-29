> module Data.Ant.Parser.Closed (closed) where

> import Text.ParserCombinators.Parsec

> closed :: (Char, Char) -> Char -> Parser String
> closed = closedHelper 0

> closedHelper :: Int -> (Char, Char) -> Char -> Parser String
> closedHelper nesting (open, close) esc =
>   choice [ if nesting == 1 then
>              pure (:[]) <*> char close
>            else
>              do c <- char close
>                 cs <- next (nesting - 1)
>                 return (c:cs)
>          , do char esc
>               c <- oneOf [open, close, esc]
>               cs <- next nesting
>               return (c:cs)
>          , do c <- anyChar
>               let nesting' | c == open = nesting + 1
>                            | otherwise = nesting
>               cs <- next nesting'
>               return (c:cs)
>          ] <?> concat ["text denoted with ", show open, " and ", show close, " optionally containing many other denoted sub-sections"]
>   where
>     next nesting' = closedHelper nesting' (open, close) esc
