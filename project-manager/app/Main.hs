module Main where

import System.Directory
import Control.Monad
import Data.List
import Data.List.Split
import System.IO
import Text.Printf


joinPath :: FilePath -> FilePath -> FilePath
joinPath root filename = root ++ "/" ++ filename


isGitRepo :: FilePath -> IO Bool
isGitRepo dir = do
    dirContents <- listDirectory dir
    return $ ".git" `elem` dirContents


isNotDotFile :: FilePath -> Bool
isNotDotFile filename = not ('.' `elem` filename)

{-
listAllRepos :: FilePath -> IO ([FilePath])
listAllRepos root = do
    isItAGitRepo <- isGitRepo root
    case isItAGitRepo of
        True -> return [root]
        False -> do
            dirContents <- listDirectory root
            subdirs <- filterM
                         doesDirectoryExist
                         (map (\x -> root ++ "/" ++ x) dirContents)
            case subdirs of
                [] -> return []
                otherwise -> do
                    rec <- mapM listAllRepos subdirs
                    return $ [] ++ (concat rec)
-}

listAllRepos :: Int -> Int -> FilePath -> IO ([FilePath])
listAllRepos maxdepth depth root = do
    let depthExceeded = depth >= maxdepth
    isRepo <- isGitRepo root
    case (depthExceeded || isRepo) of
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


getService :: String -> String
getService url = head service_parts
    where
        service_url = (splitOn "/" url) !! 2
        service_parts = splitOn "." service_url


getUsername :: String -> String
getUsername url = url_split !! 3
    where
        url_split = splitOn "/" url


getRepoName :: String -> String
getRepoName url = head $ splitOn "." repogitURL
    where
        url_split = splitOn "/" url
        repogitURL = url_split !! 4

getConfigs :: FilePath -> IO (String)
getConfigs reponame =
    let
        filename = reponame ++ "/.git/config"
    in
      do
        contents <- readFile filename
        return contents

getURL :: String -> String
getURL content = head $ filter (isSubsequenceOf "url =") cleanLines
    where
      cleanLines = map (coerceMaybe . stripPrefix "\t") (lines content)


coerceMaybe :: Maybe String -> String
coerceMaybe value = case value of
    Nothing -> ""
    Just x  -> x


findServiceName :: FilePath -> IO String
findServiceName repo = do
    configs <- getConfigs repo
    return $ getService $ getURL configs


findUserName :: FilePath -> IO String
findUserName repo = do
    configs <- getConfigs repo
    return $ getUsername $ getURL configs


findRepoName :: FilePath -> IO String
findRepoName repo = do
    configs <- getConfigs repo
    return $ getRepoName $ getURL configs


showAsTable :: [String] -> [String] -> [String] -> String
showAsTable repos services usernames =
    join $ zipWith3 showCell repos services usernames
    where
      showCell x y z = printf "%-50s %-9s %s\n" x y z


showProjects :: IO ()
showProjects = do
    home <- getHomeDirectory
    dirs <- listAllRepos 10 0 home
    repos <- mapM findRepoName dirs
    users <- mapM findUserName dirs
    serv <- mapM findServiceName dirs
    putStrLn $ showAsTable repos serv users


main = do
    putStrLn "Enter command "
    cmd <- getLine
    case cmd of
        "show" -> showProjects
        otherwise -> putStrLn "Command not found."