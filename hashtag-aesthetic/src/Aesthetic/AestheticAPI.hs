{-# LANGUAGE OverloadedStrings #-}

module AestheticAPI
    ( loadAesthetic,
      makeover
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

fromEither :: Aesthetic a => Either String a -> a
fromEither eitherAesthetic = case eitherAesthetic of 
    Left errorMessage -> error errorMessage
    Right aesthetic -> aesthetic

-- | applies a set of aesthetics to a system
makeover :: FilePath -> (GTKAesthetic, SublimeAesthetic) -> IO ()
makeover aesFile (gtkAesthetic, sublimeAesthetic) = 
    let 

        gtkMakeover dat = do 
            -- get current user's home directory
            homedir <- getHomeDirectory
            -- check if wallpaper exists, then change wallpaper
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

        sublimeMakeover sdat = do 
            -- get current user's home directory
            homedir <- getHomeDirectory
            importConfigs (homedir ++ "/autognomy/pretty/" ++ aesFile) sdat
            print "Imported sublime text configs!"

    in  
        do 
            gtkMakeover gtkAesthetic
            sublimeMakeover sublimeAesthetic

-- | reads in an Aesthetic and parses it
-- | throws error if aesthetic is not able to be parsed
loadAesthetic :: FilePath -> IO ()
loadAesthetic aesFile = do
    -- get current user's home directory
    homedir <- getHomeDirectory

    -- get GTK aesthetic json
    d <- getData (homedir ++ "/autognomy/pretty/" ++ aesFile ++ "/" ++ aesFile ++ ".json")
    -- get Sublime aesthetic json
    s <- getData (homedir ++ "/autognomy/pretty/" ++ aesFile ++ "/sublime.json")

    -- parse both the JSONs
    let gtk = (parseAesthetic d) :: Either String GTKAesthetic
    let sublime = (parseAesthetic s) :: Either String SublimeAesthetic

    case gtk of
        Left g_err -> error g_err 
        Right g_wall -> do 
            wpaper <- wallpaperCheck g_wall
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
    case gtk of 
        Left g_err -> error g_err
        Right g_dat -> do
            changeGTKTheme g_dat 
            changeShellTheme g_dat 
            changeIconTheme g_dat
    print $ "Changed stuff"

    -- parse and execute sublime text aesthetic
    case sublime of
        Left s_err -> error s_err
        Right s_dat -> do
            importConfigs (homedir ++ "/autognomy/pretty/" ++ aesFile) s_dat
            print "Imported sublime text configs!"

