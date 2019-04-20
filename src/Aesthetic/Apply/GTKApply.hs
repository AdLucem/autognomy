{-# LANGUAGE OverloadedStrings #-}
-- | Apply GTK aesthetic changes

module GTKApply where

import Turtle
import qualified Data.Text as T

import GTKTypes

--toLine :: String -> Shell Line
--toLine s = case (textToLine $ T.pack s) of
--	Nothing -> unsafeTextToLine $ T.pack "Error"
--	Just x  -> x

changeWallpaper :: GTKAesthetic -> Shell Line
changeWallpaper (GTKAesthetic wpaper _ _ _) = 
	inshell (T.pack $ "gsettings set org.gnome.desktop.background picture-uri " ++ wpaper) empty


changeGTKTheme :: GTKAesthetic -> Shell Line
changeGTKTheme (GTKAesthetic _ theme _ _) =
	inshell "gsettings set org.gnome.desktop.interface gtk-theme" $ fromString theme


changeShellTheme :: GTKAesthetic -> Shell Line
changeShellTheme (GTKAesthetic _ _ shTheme _) =
	inshell "gsettings set org.gnome.shell.extensions.user-theme name" $ fromString shTheme


changeIconTheme :: GTKAesthetic -> Shell Line  
changeIconTheme (GTKAesthetic _ _ _ icnTheme) =
	inshell "gsettings set org.gnome.desktop.interface icon-theme" $ fromString icnTheme