module Main where

import System.Directory
import Control.Monad
import Data.List
import Data.List.Split
import System.IO
import Text.Printf


isGitRepo :: FilePath -> IO Bool
isGitRepo dir = do
    dirContents <- listDirectory dir
    return $ ".git" `elem` dirContents


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


main :: IO ()
main = do
    home <- getHomeDirectory
    dirs <- listAllRepos home
    repos <- mapM findRepoName dirs
    users <- mapM findUserName dirs
    serv <- mapM findServiceName dirs
    putStrLn $ showAsTable repos serv users
    -- putStrLn $ showAsTable repo ser user
