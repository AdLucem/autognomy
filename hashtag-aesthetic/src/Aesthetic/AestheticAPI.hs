{-# LANGUAGE OverloadedStrings #-}

module AestheticAPI
    ( loadAesthetic
    ) where

-- library imports
import qualified Turtle as T
import qualified Data.ByteString.Lazy as B
import Data.Aeson
import System.Directory as S

-- local imports
import Types
import Aesthetic
import GTKApply
import SublimeApply
import DataLoader


-- | reads in an Aesthetic and applies it to the system 
loadAesthetic :: FilePath -> IO ()
loadAesthetic aesFile = do
    -- get current user's home directory
    homedir <- getHomeDirectory

    -- get GTK aesthetic json
    d <- getData (homedir ++ "/autognomy/pretty/" ++ aesFile ++ "/" ++ aesFile ++ ".json")
    -- get Sublime aesthetic json
    s <- getData (homedir ++ "/autognomy/pretty/" ++ aesFile ++ "/sublime.json")

    -- parse and execute GTK aesthetic
    let gtk = (parseAesthetic d) :: Either String GTKAesthetic
    case gtk of
        Left err -> putStrLn err
        Right dat -> do
            wpaper <- wallpaperCheck dat
            let resWall = changeWallpaper wpaper
            let resTh = changeGTKTheme dat
            let resSh = changeShellTheme dat
            let resIcn = changeIconTheme dat
            print wpaper

    -- parse and execute sublime text aesthetic
    let sublime = (parseAesthetic s) :: Either String SublimeAesthetic
    case sublime of
        Left s_err -> putStrLn s_err
        Right s_dat -> do
            importConfigs (homedir ++ "/autognomy/pretty/" ++ aesFile) s_dat
            print "Imported sublime text configs!"


