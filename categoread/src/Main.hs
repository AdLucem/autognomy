module Main where

import System.Directory
import Control.Monad
import Data.List
import Data.List.Split
import System.IO
import Text.Printf

joinPath :: FilePath -> FilePath -> FilePath
joinPath root filename = root ++ "/" ++ filename

tabs :: Int -> String
tabs 0 = "\t"
tabs n = '\t' : (tabs (n - 1))

showAsTree :: Int -> String -> String
showAsTree depth fname =
    join $ zipWith showCell (tabs depth) fname
    where
      showCell x y = printf "%s %s\n" x y

isDir :: FilePath -> IO (Bool)
isDir path = doesDirectoryExist path

{-
getCats :: Int -> Int -> FilePath -> IO ([FilePath])
getCats maxdepth depth root = do
    let depthExceeded = depth >= maxdepth
    case depthExceeded of
        -- if either recursion depth is exceeded, or file is a repo
        -- then stop recursing
        True -> return [root]
        -- else recurse
        False -> do
            -- get the subdirectories of the directory
            -- that are not dotfile directories
            dirContents  <- listDirectory root
            maybeSubdirs <- filterM
                            doesDirectoryExist
                            (map (joinPath root) dirContents)
            let subdirs = filter isNotDotFile maybeSubdirs 
            case subdirs of
                -- if no subdirectories, then stop recursing
                [] -> return []
                -- else if there are subdirectories
                otherwise -> do
                    -- get the subdirectories within it, adding one recursion level
                    recSubdirs <- mapM (listAllRepos maxdepth (depth + 1)) subdirs
                    return $ [] ++ (concat recSubdirs)
-}

main :: IO ()
main = putStrLn "hello"
