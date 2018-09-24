
> module Data.Ant.Parser (parseAnt) where

> import Prelude hiding (error)
> import Data.Ant.Ast
> import Data.Ant.Error
> import Language.Haskell.TH
> import Language.Haskell.Meta
> import Text.ParserCombinators.Parsec

> parseAnt :: String -> Either String Ast
> parseAnt source =
>   case parse ant "(unknown)" source of
>     Left message -> Left $ show message
>     Right ast -> Right ast

> ant :: Parser Ast
> ant = pure MkAst
>    <*> nodes

> nodes :: Parser [Node]
> nodes = many node

> node :: Parser Node
> node = choice [esc, expN, chrN]

> esc :: Parser Node
> esc =
>   do char '\\'
>      c <- lookAhead $ anyChar
>      if c == '$' then
>        do anyChar
>           return $ ChrN c
>      else
>        return $ ChrN '\\'

> expN :: Parser Node
> expN =
>   do string "$"
>      exp <- (try expNVar <|> expNExp)
>      return $ ExpN exp

> chrN :: Parser Node
> chrN = pure ChrN
>     <*> noneOf "\\$"

> expNVar :: Parser Exp
> expNVar = choice [hsVar, hsCon]
>   where
>     hsVar = hsId VarE lower
>     hsCon = hsId ConE upper 
>     hsId node initial =
>       do x <- initial <|> char '_'
>          xs <- idBody
>          return $ node $ mkName (x:xs)
>     idBody = many $ choice
>       [ letter
>       , char '_'
>       , digit
>       , char '\''
>       ]

> expNExp :: Parser Exp
> expNExp =
>   do string "{|"
>      raw <- manyTill anyChar (string "|}")
>      case parseExp raw of
>        Left message -> error message
>        Right exp -> return exp
