module Export where

import Turtle
import Data.Text as T


export :: FilePath -> IO ()
export fpath = do
	current <- pwd 
	cp fpath (current ++ "../configs/")