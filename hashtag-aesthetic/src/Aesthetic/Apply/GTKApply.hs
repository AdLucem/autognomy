{-# LANGUAGE OverloadedStrings #-}
-- | Apply GTK aesthetic changes

module GTKApply where

import Turtle
import qualified Data.Text as T
import qualified System.Directory as S

import GTKTypes

--toLine :: String -> Shell Line
--toLine s = case (textToLine $ T.pack s) of
--  Nothing -> unsafeTextToLine $ T.pack "Error"
--  Just x  -> x

gDownload :: String -> String -> String 
gDownload fileid filename = 
    "wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=" ++ fileid ++ "' -O " 
    ++ filename ++ ".tar.gz"


wallpaperCheck :: GTKAesthetic -> IO String
wallpaperCheck (GTKAesthetic wpaper _ _ _ _ _ _) = do 
    homedir <- S.getHomeDirectory
    exists <- S.doesFileExist $ homedir ++ "/autognomy/pretty/pictures/" ++ wpaper
    case exists of 
        True -> return $ homedir ++ "/autognomy/pretty/pictures/" ++ wpaper
        False -> return $ homedir ++ "/autognomy/pretty/pictures/" ++ wpaper ++ "   false"


changeWallpaper :: String -> IO ExitCode
changeWallpaper wpaper = do
    shell (T.pack $ "gsettings set org.gnome.desktop.background picture-uri " ++ wpaper) empty


changeGTKTheme :: GTKAesthetic -> IO ExitCode
changeGTKTheme (GTKAesthetic _ theme themeId _ _ _ _) = do
    homedir <- S.getHomeDirectory

    -- cd ~/.themes
    cd $ fromText $ T.pack $ homedir ++ "/.themes"
    -- download theme zip file from my google drive
    shell (T.pack $ gDownload themeId theme) empty
    -- unzip file
    shell (T.pack $ "tar xvzf " ++ theme ++ ".tar.gz") empty
    shell (T.pack $ "gsettings set org.gnome.desktop.interface gtk-theme " ++ theme) empty


changeShellTheme :: GTKAesthetic -> IO ExitCode
changeShellTheme (GTKAesthetic _ _ _ shTheme shThemeId _ _) = do
    homedir <- S.getHomeDirectory

    -- cd ~/.themes
    cd $ fromText $ T.pack $ homedir ++ "/.themes"
    -- download theme zip file from my google drive
    shell (T.pack $ gDownload shThemeId shTheme) empty
    -- unzip file
    shell (T.pack $ "tar xvzf " ++ shTheme ++ ".tar.gz") empty
    -- set the theme
    shell (T.pack $ "gsettings set org.gnome.shell.extensions.user-theme name " ++ shTheme) empty


changeIconTheme :: GTKAesthetic -> IO ExitCode  
changeIconTheme (GTKAesthetic _ _ _ _ _ icnTheme icnThemeId) = do
    homedir <- S.getHomeDirectory

    -- cd ~/.icons
    cd $ fromText $ T.pack $ homedir ++ "/.icons"
    -- download icons zip file from my google drive
    shell (T.pack $ gDownload icnThemeId icnTheme) empty
    -- unzip file
    shell (T.pack $ "tar xvzf " ++ icnTheme ++ ".tar.gz") empty
    -- set the icon theme
    shell (T.pack $ "gsettings set org.gnome.desktop.interface icon-theme " ++ icnTheme) empty
