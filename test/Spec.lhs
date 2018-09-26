> {-# LANGUAGE QuasiQuotes #-}

> module Main (main) where

> import Data.Ant
> import Test.Hspec
> import Test.QuickCheck

> main :: IO ()
> main =
>  hspec $
>    describe "Data.Ant.aq" $ do
>      it "Should interpolate any serialisable variable" $
>        property $ \x -> [aq|x == $x|] == "x == " ++ show (x :: Char)
>
>      it "Should insert Strings" $
>        property $ \name -> [aq|Hi, my name is $name|] == "Hi, my name is " ++ name
>
>      it "Should interpolate any serialisable expression" $
>        property $ \name age -> [aq|${(name,age)}|] == show (name :: String, age :: Int)
>
>      it "Should support interpolation escaping" $
>        [aq|\$string|] `shouldBe` "$string"
>
>      it "Should support escape escaping" $
>        [aq|\\|] `shouldBe` "\\"
>
>      it "Should support escaped braces in interpolation blocks" $
>        [aq|${"\{\}"}|] `shouldBe` "{}"
>
>      it "Should support escaped escapes in interpolation blocks" $
>        [aq|${(\\x -> x) "Hello"}|] `shouldBe` "Hello"
