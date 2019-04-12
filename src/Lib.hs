{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( helloWorld
    ) where

import qualified Turtle as T
import qualified Data.ByteString.Lazy as B
import Data.Aeson

import Types
import Aesthetic

jsonFile :: FilePath
jsonFile = "pretty/pure.json"

getData :: IO B.ByteString
getData = B.readFile jsonFile

helloWorld :: IO ()
helloWorld = do
    d <- getData
    gtk  <- readAesthetic d
    subl <- readAesthetic d
    case gtk of
        Left err -> putStrLn err
        Right dat -> print dat
    case subl of
        Left err -> putStrLn err
        Right dat -> print dat


