
> module Data.Ant.Parser (parseAnt) where

> import Prelude hiding error
> import Data.Ant.Ast
> import Data.Ant.Error
> import Lanuage.Haskell.Meta
> import Text.ParserCombinators.Parsec

> parseAnt :: String -> Either String Ast
> parseAnt source =
>   case parse ant "(unknown)" source of
>     Left message -> Left $ show error
>     Right ast -> Right ast

> ant :: Parser Ast
> ant = pure MkAst
>    <*> nodes

> nodes :: Parser [Node]
> nodes = many node

> node :: Parser Node
> node =  choice [esc, expN, strN]

> esc :: Parser Node
> esc =
>   do string "\\$"
>      return $ StrN "$"

> expN :: Parser Node
> expN =
>   do string "$"
>      exp <- (try expNVar <|> expNExp)
>      return $ ExpN exp
>
> expNVar :: Parser Exp
> expNVar =  pure (VarE . mkName)
>        <*> hsId

> expNExp :: Parser Exp
> expNExp =
>   do raw <- between (string "{|")
>                     (string "|}")
>                     (some anyChar)
>      case parseExp raw of
>        Left message -> error message
>        Right exp -> return exp

> hsId :: Parser String
> hsId =
>   do x <- idHead
>      xs <- idBody
>      return (x:xs)
>   where
>     idHead = choice
>       [ letter
>       , char '_'
>       ]
>     idBody = choice
>       [ letter
>       , char '_'
>       , digit
>       , char '\''
>       ]

>
