
> module Data.Ant.AntQ
>   ( AntQ
>   , AntQExp
>   , mkAntQ
>   )
>   where

> import Prelude hiding (error)
> import Data.Ant.Error
> import Language.Haskell.TH
> import Language.Haskell.TH.Quote

> type AntQ = QuasiQuoter

> type AntQExp = (String -> Q Exp)

> mkAntQ :: AntQExp -> AntQ
> mkAntQ antQExp =
>   QuasiQuoter
>     { quoteExp = antQExp
>     , quotePat = unusable "pattern"
>     , quoteType = unusable "type"
>     , quoteDec = unusable "declaration"
>     }
>   where
>     unusable construct =
>       error $ concat
>         [ "An Ant may not be used as an '"
>         , construct
>         , "'."
>         ]
>
