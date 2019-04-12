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
        shellTheme :: String,
        iconTheme :: String
    } deriving (Show, Read)


instance FromJSON GTKAesthetic where
    parseJSON = withObject "GTKAesthetic" $ \ v ->
            GTKAesthetic <$> v .: "wallpaper"
                         <*> v .: "gtk-theme"
                         <*> v .: "shell-theme"
                         <*> v .: "icon-theme"


instance Aesthetic GTKAesthetic where
    isCorrect aes = True
