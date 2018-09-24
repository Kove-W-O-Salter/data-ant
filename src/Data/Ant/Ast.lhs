
> module Data.Ant.Ast
>   ( Ast (..)
>   , Node (..)
>   )
>   where

> import Language.Haskell.TH

> data Ast = MkAst { astNodes :: [Node] }
>          deriving Show

> data Node = StrN { nodeStr :: String }
>           | ExpN { nodeExp :: Exp }
>           deriving Show
