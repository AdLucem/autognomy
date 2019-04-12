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

getData :: FilePath -> IO B.ByteString
getData jsonFile = B.readFile jsonFile

parseAesthetic :: Aesthetic a => B.ByteString -> Either String a
parseAesthetic d = eitherDecode d

readAesthetic :: Aesthetic a => IO [a]
parseAesthetic aesFile = do
        d <- getData aesFile
    let gtk = (readAesthetic d) :: Either String GTKAesthetic
    let subl = (readAesthetic d) :: Either String SublimeAesthetic
    case gtk of
        Left err -> putStrLn err
        Right dat -> print dat
    case subl of
        Left err -> putStrLn err
        Right dat -> print dat


