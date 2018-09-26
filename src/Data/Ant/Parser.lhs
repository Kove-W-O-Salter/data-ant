
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
> node = choice [esc, expN, strN]

> esc :: Parser Node
> esc =
>   do char '\\'
>      c <- oneOf "\\$"
>      return $ StrN [c]

> expN :: Parser Node
> expN =
>   do string "$"
>      exp <- (try expNVar <|> expNExp)
>      return $ ExpN exp

> strN :: Parser Node
> strN =
>   do str <- many1 strChar
>      return $ StrN str
>   where
>     strChar = noneOf "\\$"

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
>   do char '{'
>      raw <- closed 0
>      case parseExp raw of
>        Left message -> error message
>        Right exp -> return exp      
>   where
>     closed :: Int -> Parser String
>     closed nesting =
>       do c <- anyChar
>          if c == '}' && nesting == 0 then
>            return []
>          else if c == '\\' then
>            do c' <- oneOf "\\{}" <?> "escape character"
>               cs <- closed nesting
>               return (c':cs)
>          else
>            do cs <- closed $
>                 case c of
>                   '{' -> nesting + 1
>                   '}' -> nesting - 1
>                   _ -> nesting
>               return (c:cs)
