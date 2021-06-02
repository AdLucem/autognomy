{-# LANGUAGE OverloadedStrings #-}

module AestheticAPI
    ( loadAesthetic
    ) where

-- library imports
import qualified Turtle as T
import qualified Data.Text as Text
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
            changeWallpaper wpaper
            -- if themes dir does not exist
            themesExists <- S.doesDirectoryExist $ homedir ++ "/.themes"
            case themesExists of 
                True -> print "Themes file exists"
                False -> T.mkdir $ T.fromText $ Text.pack $ homedir ++ "/.themes"
            -- if icons dir does not exist
            iconsExists <- S.doesDirectoryExist $ homedir ++ "/.icons"
            case iconsExists of 
                True -> print "Icons file exists"
                False -> T.mkdir $ T.fromText $ Text.pack $ homedir ++ "/.icons"
            changeGTKTheme dat
            changeShellTheme dat
            changeIconTheme dat
            print $ "Changed wallpaper to " ++ wpaper

    -- parse and execute sublime text aesthetic
    let sublime = (parseAesthetic s) :: Either String SublimeAesthetic
    case sublime of
        Left s_err -> putStrLn s_err
        Right s_dat -> do
            importConfigs (homedir ++ "/autognomy/pretty/" ++ aesFile) s_dat
            print "Imported sublime text configs!"


