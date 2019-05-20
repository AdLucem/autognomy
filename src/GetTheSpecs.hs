
module GetTheSpecs 
    (readSpecs,
     parseSpecs
     ) where

import qualified Data.ByteString.Lazy as B
import qualified Data.Text as T
import Data.Aeson
import Turtle


class FromJSON a => Specs a where
	validateSpecs :: a -> a 
	filterSpec :: a -> String -> String
	applyPartialSpec :: a -> String -> Shell Line


-- | reads in a string from given file
readSpecs :: FilePath -> IO B.ByteString
readSpecs jsonFile = B.readFile jsonFile


-- | parses the raw string into either a type of specification
-- | or an error string
parseSpecs :: Specs a => B.ByteString -> Either String a
parseSpecs d = eitherDecode d


-- | Executes a shell command with arguments, input as a list
-- | (Here because Turtle's command-executor gives weird errors)
exec :: [String] -> Shell Line
exec cmd = 
	inshell (T.pack cmdString) empty
	where
		join a b = a ++ b
		cmdString = foldl join (head cmd) (tail cmd)