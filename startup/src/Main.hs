{-# LANGUAGE OverloadedStrings #-}

import System.Environment
import qualified Data.Text as T
import System.IO
import Control.Monad
import Turtle

{- Some utility functions -}

-- execute a bash command using Turtle, and print the exitcode returned
execLine line = do
    exitcode <- shell (T.pack line) empty
    print exitcode

execLineWithArgs line args = do
    exitcode <- shell (T.pack line) (return (unsafeTextToLine (T.pack args)))
    print exitcode


checkIfInstalled :: Turtle.FilePath -> IO Bool
checkIfInstalled program = do
    ifExists <- which program
    case ifExists of
        Nothing -> return False
        Just x -> return True

-- | Install program if it does not already exist
install program = do
    ifInstalled <- checkIfInstalled $ decodeString program
    case ifInstalled of
        True -> putStrLn $ program ++ " is already installed"
        False -> do
            putStrLn $ "Installing " ++ program ++ "..."
            shell (T.pack $ "sudo apt install " ++ program) "Y"
            putStrLn "Installed"


-- | Execute file in configdir if it exists
execIfExist configDir (filename, False) =
    putStrLn $ "File " ++ filename ++ "does not exist!"
execIfExist configDir (filename, True) = do
    putStrLn $ "Executing " ++ filename
    execLine $ "bash " ++ configDir ++ "/" ++ filename


helpString :: String
helpString = "Format:\n stack run startup <config_filepath>" 


{- Execute startup commands, which consist of the following:

- get name of config file
    - if config file does not exist, raise error
- Checking-else-Installing programs listed in `installs.txt`
- Installing gnome shell extensions using `extensions.sh`
- Executing any other bash files specified in `run_custom.txt`, in the 
  order that the files are listed. The bash files must also be in 
  config directory
-}

execInstallsIf False filename =
    putStrLn $ "File " ++ filename ++ " does not exist!"
execInstallsIf True filename = do
    putStrLn $ "Installing programs from file " ++ filename
    -- read in installs.txt file
    content <- readFile filename
    -- remove comments and whitespace/empty lines
    let programs = filter (\x -> (x /= "") && 
                                 ((head x) /= '#') && 
                                 (any (/= ' ') x)) 
                          (lines content)
    mapM install programs
    return ()


execExtensionsIf False filename = 
    putStrLn $ "File " ++ filename ++ " does not exist!"
execExtensionsIf True filename = do
    putStrLn $ "Running extensions installer " ++ filename
    execLine $ "bash " ++ filename


execCustomIf configDir False filename =
    putStrLn $ "File " ++ filename ++ " does not exist!"
execCustomIf configDir True filename = do 
    putStrLn $ "Running custom bash files from: " ++ filename
    -- read in contents of file
    content <- readFile filename
    -- remove whitespace, empty lines and comments
    -- remove comments and whitespace/empty lines
    let bashfiles = filter (\x -> (x /= "") && 
                                  ((head x) /= '#') && 
                                  (any (/= ' ') x)) 
                            (lines content)
    -- check if all bash files specified exist
    bashExist <- mapM 
                    (\x -> testfile $ fromString $ configDir ++ "/" ++ x)
                    bashfiles
    -- execute files if they exist
    mapM (execIfExist configDir) $ zip bashfiles bashExist 
    return ()


execStartup configDir = do
    putStrLn "to be implemented..."
    -- check if installs file exists
    installsExists <- testfile $ fromString $ configDir ++ "/installs.txt"
    putStrLn $ "Installs file exists: " ++ (show installsExists)
    execInstallsIf installsExists (configDir ++ "/installs.txt")
    -- install chrome-gnome-shell for extensions
    install "chrome-gnome-shell"
    -- check if extensions.sh exists
    extExists <- testfile $ fromString $ configDir ++ "/extensions.sh"
    putStrLn $ "Extensions installer exists: " ++ (show extExists)
    execExtensionsIf extExists (configDir ++ "/extensions.sh")
    -- check if `run_custom.txt` exists
    customExists <- testfile $ fromString $ configDir ++ "/run_custom.txt"
    putStrLn $ "run_custom.txt exists: " ++ (show customExists)
    execCustomIf configDir customExists (configDir ++ "/run_custom.txt")


{------------ MAIN -------------}


main = do
    args <- getArgs
    -- is format correct
    case (length args) of
        1 -> execStartup $ head args
        _ -> error helpString
