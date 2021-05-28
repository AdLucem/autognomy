
{-# LANGUAGE OverloadedStrings #-}

module Main where

import AestheticAPI

main = do
        putStrLn "Enter name of aesthetic"
	fname <- getLine
	loadAesthetic fname
