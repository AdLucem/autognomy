{-# LANGUAGE OverloadedStrings #-}

module AestheticAPI
    ( loadAesthetic
    ) where

-- library imports
import qualified Turtle as T
import qualified Data.ByteString.Lazy as B
import Data.Aeson

-- local imports
import Types
import Aesthetic
import GTKApply
import DataLoader


-- | reads in an Aesthetic and applies it to the system 
loadAesthetic :: FilePath -> IO ()
loadAesthetic aesFile = do
    d <- getData aesFile
    let gtk = (parseAesthetic d) :: Either String GTKAesthetic
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


