{-# LANGUAGE OverloadedStrings #-}

module SublimeTypes where

import Data.Aeson

import Aesthetic


data SublimeAesthetic =
    SublimeAesthetic
    {
        userPref :: String,
        keybinds :: String,
        packagePref :: String
    }  deriving (Show, Read)


instance FromJSON SublimeAesthetic where
    parseJSON = withObject "SublimeAesthetic" $ \ v ->
            SublimeAesthetic <$> v .: "user-pref"
                             <*> v .: "keybinds"
                             <*> v .: "package-pref"


instance Aesthetic SublimeAesthetic where
    isCorrect aes = True
