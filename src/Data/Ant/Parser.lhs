
> {-# LANGUAGE MultiWayIf #-}

> module Data.Ant.Parser (parseAnt) where

> import Prelude hiding (error)
> import Data.Ant.Ast
> import Data.Ant.Parser.Hsid
> import Data.Ant.Parser.Symbol
> import Data.Ant.Parser.Closed
> import Language.Haskell.TH
> import Language.Haskell.Meta
> import Text.ParserCombinators.Parsec

> parseAnt :: String -> Either String Ast
> parseAnt source =
>   case parse ast "(unknown)" source of
>     Left message -> Left "parse error"
>     Right ast' -> Right ast'

> ast :: Parser Ast
> ast = pure MkAst <*> many (choice [escN, expN, strN])

> escN :: Parser Node
> escN =
>   do escape
>      c <- oneOf [escapeS, annexS]
>      return $ StrN [c]

> expN :: Parser Node
> expN =
>   do annex
>      exp <- choice [expNVar, expNExp]
>      return $ ExpN exp

> strN :: Parser Node
> strN = pure StrN <*> many1 (noneOf [escapeS, annexS])

> expNVar :: Parser Exp
> expNVar = choice [var, con]

> expNExp :: Parser Exp
> expNExp =
>   do raw <- closed (openS, closeS) escapeS
>      case parseExp (crux raw) of
>        Left message -> fail message
>        Right exp -> return exp
>   where crux = tail . init
