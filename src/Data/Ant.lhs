> {-# LANGUAGE LambdaCase #-}
> {-# LANGUAGE TemplateHaskell #-}
> {-# LANGUAGE QuasiQuotes #-}

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
>       return $ AppE (VarE 'concat)
>                     (ListE $ eNodes)
>       where
>         eNodes =
>           map (\case
>             ChrN str -> LitE $ StringL [str]
>             ExpN exp -> AppE (VarE 'show) exp) (astNodes ast)
