{-# LANGUAGE OverloadedStrings #-}

module SublimeTypes where

import Data.Aeson

data CustomPair =
    CustomPair
    {
        key :: String,
        value :: String
    } deriving (Show, Read)


instance FromJSON CustomPair where
    parseJSON = withObject "CustomPair" $ \ v ->
            CustomPair <$> v .: "key"
                       <*> v .: "value"


data SublimeAesthetic =
    SublimeAesthetic 
    {
        sublTheme :: String,
        colorScheme :: String,
        customPairs :: [CustomPair]
    }  deriving (Show, Read)


instance FromJSON SublimeAesthetic where
    parseJSON = withObject "SublimeAesthetic" $ \ v ->
            SublimeAesthetic <$> v .: "sublime-theme"
                             <*> v .: "color-scheme"
                             <*> v .: "custom-pairs"