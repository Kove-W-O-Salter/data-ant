
> module Data.Ant.Error (error) where

> import qualified Prelude as Prelude

> error :: Prelude.String -> a
> error message =
>   Prelude.error (Prelude.concat
>     [ "Ant: Error: "
>     , message
>     , "."
>     ])
