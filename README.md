# data-ant
[![Build Status](https://travis-ci.com/Kove-W-O-Salter/data-ant.svg?branch=master)](https://travis-ci.com/Kove-W-O-Salter/data-ant)
## Description
`data-ant` is a simple, yet powerful, library for `String` interpolation in `Haskell`.

## Installation
* **With stack**
  To use `data-ant` in a project add the following to the `extra-deps` field in your `package.yaml`:
   ```yaml
   - git: https://github.com/Kove-W-O-Salter/data-ant.git
     commit: <commmit-id>
   ```
   where `<commit-id>` is the id of the latest commit.
   Now add `data-ant` to any dependency sections in your `package.yaml`.
* **With cabal**
  To install `data-ant` using cabal run the following:
  ```bash
  git clone https://github.com/Kove-W-O-Salter/data-ant && cd data-ant
                                                        && cabal test
														&& cabal install
  ```

## Example
```haskell
{-# LANGUAGE QuasiQuotes #-}

module Main (main) where

import Data.Ant
import Data.Char

main :: IO ()
main =
  do putStrLn "What is your name?"
     name <- getLine
     putStrLn [aq|Pleased to meet you $name.|]
     putStrLn [aq|Your name backwards is ${reverse name}|]
     putStrLn [aq|Your name in upper-case is ${map toUpper name}|]
     putStrLn [aq|Your name in lower-case is ${map toLower name}|]
     putStrLn [aq|Well... that was fun but I've got to go now. Godbye $name|]

```
