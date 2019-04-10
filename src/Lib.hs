{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( helloWorld
    ) where

import qualified Turtle as T
import qualified Data.ByteString.Lazy as B 
import Data.Aeson

import Types


jsonFile :: FilePath
jsonFile = "pretty/pure.json"

getData :: IO B.ByteString
getData = B.readFile jsonFile
 
helloWorld :: IO ()
helloWorld = do
    gtk  <- (eitherDecode <$> getData) :: IO (Either String GTKAesthetic)
    subl <- (eitherDecode <$> getData) :: IO (Either String SublimeAesthetic)
    case gtk of
        Left err -> putStrLn err
        Right dat -> print dat
    case subl of
        Left err -> putStrLn err
        Right dat -> print dat


