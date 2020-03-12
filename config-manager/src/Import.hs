module Import where

import Turtle
import Data.Text as T 


import :: FilePath -> IO ()
import fpath = do
	current <- pwd 
	cp fpath (current ++ "../configs/")