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

wallpaperCheck :: GTKAesthetic -> IO String
wallpaperCheck (GTKAesthetic wpaper _ _ _) = do 
    homedir <- S.getHomeDirectory
    exists <- S.doesFileExist $ homedir ++ "/autognomy/pretty/pictures/" ++ wpaper
    case exists of 
        True -> return $ homedir ++ "/autognomy/pretty/pictures/" ++ wpaper
        False -> return $ homedir ++ "/autognomy/pretty/pictures/" ++ wpaper ++ "   false"


changeWallpaper :: String -> Shell Line
changeWallpaper wpaper =
    inshell (T.pack $ "gsettings set org.gnome.desktop.background picture-uri " ++ wpaper) empty


changeGTKTheme :: GTKAesthetic -> Shell Line
changeGTKTheme (GTKAesthetic _ theme _ _) =
    inshell (T.pack $ "gsettings set org.gnome.desktop.interface gtk-theme " ++ theme) empty


changeShellTheme :: GTKAesthetic -> Shell Line
changeShellTheme (GTKAesthetic _ _ shTheme _) =
    inshell (T.pack $ "gsettings set org.gnome.shell.extensions.user-theme name " ++ shTheme) empty


changeIconTheme :: GTKAesthetic -> Shell Line  
changeIconTheme (GTKAesthetic _ _ _ icnTheme) =
    inshell (T.pack $ "gsettings set org.gnome.desktop.interface icon-theme " ++ icnTheme) empty
