
module DataLoader 
    (getData,
     parseAesthetic
     ) where

import qualified Data.ByteString.Lazy as B
import Data.Aeson

import Types
import Aesthetic 

-- | reads in a string from given file
getData :: FilePath -> IO B.ByteString
getData jsonFile = B.readFile jsonFile

-- | parses the raw string into either an aesthetic or an error string
parseAesthetic :: Aesthetic a => B.ByteString -> Either String a
parseAesthetic d = eitherDecode d
