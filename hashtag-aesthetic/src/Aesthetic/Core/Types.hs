{-# LANGUAGE OverloadedStrings #-}

module Types (
    GTKAesthetic,
    SublimeAesthetic
    ) where

import Data.Aeson
import qualified GTKTypes
import qualified SublimeTypes
import Aesthetic

type GTKAesthetic = GTKTypes.GTKAesthetic

type SublimeAesthetic = SublimeTypes.SublimeAesthetic
