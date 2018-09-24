
> module Data.Ant.Ast
>   ( Ast (..)
>   , Node (..)
>   )
>   where

> import Language.Haskell.TH

> data Ast = MkAst { astNodes :: [Node] }
>          deriving Show

> data Node = ChrN { nodeChr :: Char }
>           | ExpN { nodeExp :: Exp }
>           deriving Show
