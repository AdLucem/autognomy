
{-# LANGUAGE OverloadedStrings #-}

module Main where

import AestheticAPI

main = do
        putStrLn "Enter name of aesthetic file"
	fname <- getLine
	loadAesthetic fname
