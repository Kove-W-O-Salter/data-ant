
> module Data.Ant.Parser.Hsid (var, con) where

> import Prelude hiding (id)
> import Data.Ant.Parser.Symbol
> import Language.Haskell.TH
> import Text.ParserCombinators.Parsec

> var :: Parser Exp
> var = id VarE lower

> con :: Parser Exp
> con = id ConE upper

> id :: (Name -> Exp) -> Parser Char -> Parser Exp
> id node initial =
>   do c <- choice [initial, uscore]
>      cs <- many (choice [letter, digit, uscore, tick])
>      return $ node $ mkName (c:cs)
