
> module Data.Ant.Render (render) where

> {-# NOINLINE render #-}
> {-# RULES
>   "render/String" render = id
>   #-}
> render :: Show a => a -> String
> render = show
