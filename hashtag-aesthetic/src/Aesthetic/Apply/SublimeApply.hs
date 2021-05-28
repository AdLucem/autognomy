{-# LANGUAGE OverloadedStrings #-}
-- | Copy sublime files- stored in the pretty/<aesthetic> directory - to their proper place

module SublimeApply where

import Turtle
import qualified Data.Text as T

import SublimeTypes

importConfigs :: SublimeAesthetic -> io () 
importConfigs (SublimeAesthetic upref kbinds ppref) = do
	mv upref "~/.config/sublime-text/Packages/User/"
	mv kbinds "~/.config/sublime-text/Packages/User/"
	mv ppref "~/.config/sublime-text/Packages/User/"