
{-# LANGUAGE OverloadedStrings #-}

module Main where

import AestheticAPI

main = do
	fname <- getLine
	loadAesthetic fname
