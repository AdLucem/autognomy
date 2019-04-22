{-# LANGUAGE OverloadedStrings #-}

module AestheticAPI
    ( loadAesthetic
    ) where

import qualified Turtle as T
import qualified Data.ByteString.Lazy as B
import Data.Aeson

import Types
import Aesthetic
import GTKApply

getData :: FilePath -> IO B.ByteString
getData jsonFile = B.readFile jsonFile

parseAesthetic :: Aesthetic a => B.ByteString -> Either String a
parseAesthetic d = eitherDecode d

loadAesthetic :: FilePath -> IO ()
loadAesthetic aesFile = do
    d <- getData aesFile
    let gtk = (parseAesthetic d) :: Either String GTKAesthetic
--    let subl = (parseAesthetic d) :: Either String SublimeAesthetic
    case gtk of
        Left err -> putStrLn err
        Right dat -> do
            let resWall = changeWallpaper dat
            putStrLn "Wallpaper changing..."
            T.stdout resWall
            let resTheme = changeGTKTheme dat
            putStrLn "GTK theme changing..."
            T.stdout resTheme
            let resShell = changeShellTheme dat
            putStrLn "Shell theme changing..."
            T.stdout resShell 
            let resIcon = changeIconTheme dat
            putStrLn "Icon theme changing..." 
            T.stdout resIcon


