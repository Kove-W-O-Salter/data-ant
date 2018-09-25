> {-# LANGUAGE QuasiQuotes #-}

> module Main (main) where

> import Data.Ant
> import Test.Hspec
> import Test.QuickCheck

> main =
>  hspec $
>    describe "Data.Ant.aq" $ do
>      it "Should interpolate a variable that is an instance of 'Show'" $
>        property $ \x -> [aq|x is $x|] == "x is " ++ show (x :: String)
>
>      it "Should interpolate a value that is an instance of 'Show'" $
>        property $ \x -> [aq|x is ${|x|}|] == "x is " ++ show (x :: String)
>
>      it "Should support escaping '$' with '\\'" $
>        [aq|x is \$x|] `shouldBe` "x is $x"
