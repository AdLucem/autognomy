
module Aesthetic where

import qualified Data.ByteString.Lazy as T
import Data.Aeson

class FromJSON a => Aesthetic a where
    readAesthetic :: T.ByteString -> Either String a
    readAesthetic s = eitherDecode s
