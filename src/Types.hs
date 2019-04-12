{-# LANGUAGE OverloadedStrings #-}

module Types (
    GTKAesthetic,
    SublimeAesthetic
    ) where

import Data.Aeson
import qualified GTKTypes
import qualified SublimeTypes

type GTKAesthetic = GTKTypes.GTKAesthetic

--instance Aesthetic GTKAesthetic where
--    readAesthetic aes = eitherDecode aes

type SublimeAesthetic = SublimeTypes.SublimeAesthetic

--instance Aesthetic SublimeAesthetic where
--    readAesthetic aes = eitherDecode aes
