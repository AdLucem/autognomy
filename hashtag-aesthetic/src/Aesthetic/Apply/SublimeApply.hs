{-# LANGUAGE OverloadedStrings #-}
-- | Copy sublime files- stored in the pretty/<aesthetic> directory - to their proper place

module SublimeApply where

import Turtle
import qualified Data.Text as T
import qualified System.Directory as S

import SublimeTypes

importConfigs :: String -> SublimeAesthetic -> IO () 
importConfigs aesFile (SublimeAesthetic upref kbinds ppref) = do
	-- get current user's home directory
	homedir <- S.getHomeDirectory

	cp (Turtle.fromText $ T.pack $ aesFile ++ "/" ++ upref) 
	   (Turtle.fromText $ T.pack $ homedir ++ "/.config/sublime-text/Packages/User/" ++ upref)
	cp (Turtle.fromText $ T.pack $ aesFile ++ "/" ++ kbinds) 
	   (Turtle.fromText $ T.pack $ homedir ++ "/.config/sublime-text/Packages/User/" ++ kbinds)
	cp (Turtle.fromText $ T.pack $ aesFile ++ "/" ++ ppref) 
	   (Turtle.fromText $ T.pack $ homedir ++ "/.config/sublime-text/Packages/User/" ++ ppref)