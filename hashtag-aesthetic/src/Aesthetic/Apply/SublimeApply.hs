{-# LANGUAGE OverloadedStrings #-}
-- | Copy sublime files- stored in the pretty/<aesthetic> directory - to their proper place

module SublimeApply where

import Turtle
import qualified Data.Text as T
import qualified System.Directory as S

import SublimeTypes

{- Defining this function here so that the main importConfigs function does not get impossibly cluttered- this is the thing that copies file from point A (within a /pretty/ folder) to point B within a sublime-config folder -}
cpConfig :: String -> String -> IO()
cpConfig aesFile filename = do

    -- get current user's home directory
    homedir <- S.getHomeDirectory

    cp (Turtle.fromText $ T.pack $ aesFile ++ "/" ++ filename) 
       (Turtle.fromText $ T.pack $ homedir ++ "/.config/sublime-text/Packages/User/" ++ filename)
     
{- This is the "import configs" function that's actually just 4 copy statements in a row. Hopefully it changes to an actual import-and-merge-the-config-jsons function sometime -}
importConfigs :: String -> SublimeAesthetic -> IO () 
importConfigs aesFile (SublimeAesthetic upref kbinds ppref oprefList) = do
        
        mapM (cpConfig aesFile) oprefList
        cpConfig aesFile upref
        cpConfig aesFile kbinds
        cpConfig aesFile ppref
        