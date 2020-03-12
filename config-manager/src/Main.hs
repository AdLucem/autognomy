module Main where

import Import 
import Export 


data Config = Config {
	system :: String,
	filepath :: String
}

instance FromJSON Config where
    parseJSON = withObject "Config" $ \ v ->
            Config <$> v .: "system"
                   <*> v .: "filepath"
                  
-- | reads in a string from given file
getData :: FilePath -> IO B.ByteString
getData jsonFile = B.readFile jsonFile

-- | parses the raw string into either [Config] or an error string
parseConfig :: B.ByteString -> Either String [Config]
parseConfig s = eitherDecode s


main :: IO ()
main = putStrLn "TODO"
