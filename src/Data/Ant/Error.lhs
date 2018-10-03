
> module Data.Ant.Error (error) where

> import Prelude hiding (error)

> error :: Monad m => String -> m a
> error message =
>   fail $ concat ["ant: ", message, "."]
