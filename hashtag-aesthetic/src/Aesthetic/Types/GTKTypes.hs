{-# LANGUAGE OverloadedStrings #-}

module GTKTypes where

import Data.Aeson
import qualified Data.ByteString.Lazy as T

import Aesthetic


data GTKAesthetic =
    GTKAesthetic
    {
        wallpaper :: String,
        gtkTheme :: String,
        gtkThemeId :: String,
        shellTheme :: String,
        shellThemeId :: String,
        iconTheme :: String,
        iconThemeId :: String
    } deriving (Show, Read)


instance FromJSON GTKAesthetic where
    parseJSON = withObject "GTKAesthetic" $ \ v ->
            GTKAesthetic <$> v .: "wallpaper"
                         <*> v .: "gtk-theme"
                         <*> v .: "gtk-theme-id"
                         <*> v .: "shell-theme"
                         <*> v .: "shell-theme-id"
                         <*> v .: "icon-theme"
                         <*> v .: "icon-theme-id"


instance Aesthetic GTKAesthetic where
    isCorrect aes = True
