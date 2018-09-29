
> module Data.Ant.Parser.Symbol
>   ( openS
>   , closeS
>   , annexS
>   , escapeS
>   , uscoreS
>   , tickS
>   , open
>   , close
>   , annex
>   , escape
>   , uscore
>   , tick
>   )
>   where

> import Text.ParserCombinators.Parsec

> openS :: Char
> openS = '{'

> closeS :: Char
> closeS = '}'

> annexS :: Char
> annexS = '$'

> escapeS :: Char
> escapeS = '\\'

> uscoreS :: Char
> uscoreS = '_'

> tickS :: Char
> tickS = '\''

> open :: Parser Char
> open = char openS

> close :: Parser Char
> close = char closeS

> annex :: Parser Char
> annex = char annexS

> escape :: Parser Char
> escape = char escapeS

> uscore :: Parser Char
> uscore = char uscoreS

> tick :: Parser Char
> tick = char tickS
