
module Aesthetic where

import qualified Data.ByteString.Lazy as B
import Data.Aeson

class FromJSON a => Aesthetic a where
    isCorrect :: a -> Bool
