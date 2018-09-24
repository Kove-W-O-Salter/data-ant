> {-# LANGUAGE LambdaCase #-}

> module Data.Ant
>   ( aq
>   , antq
>   )
>   where

> import Prelude hiding (error)
> import Data.Ant.Ast
> import Data.Ant.AntQ
> import Data.Ant.Error
> import Data.Ant.Parser
> import Language.Haskell.TH

> aq :: AntQ
> aq = antq

> antq :: AntQ
> antq = mkAntQ antQExp

> antQExp :: AntQExp
> antQExp source =
>   case parseAnt source of
>     Left message -> error message
>     Right ast ->
>       return $ AppE (VarE $ mkName "concat") (ListE $ eNodes ast)
>   where
>     eNodes ast =
>       map (\case
>         ChrN str -> LitE $ StringL [str]
>         ExpN exp -> AppE (VarE $ mkName "show") exp) (astNodes ast)
