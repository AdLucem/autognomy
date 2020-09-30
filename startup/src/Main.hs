{-# LANGUAGE OverloadedStrings #-}

import System.Environment
import qualified Data.Text as T
import System.IO
import Control.Monad
import Turtle

checkIfInstalled :: Turtle.FilePath -> IO Bool
checkIfInstalled program = do
    ifExists <- which program
    case ifExists of
        Nothing -> return False
        Just x -> return True

-- | Install program if it does not already exist
install :: String -> IO ()
install program = do
    ifInstalled <- checkIfInstalled $ decodeString program
    case ifInstalled of
        True -> putStrLn $ program ++ " is already installed"
        False -> do
            putStrLn $ "Installing " ++ program ++ "..."
            shell (T.pack $ "sudo apt install " ++ program) "Y"
            putStrLn "Installed"

-- | Is given line a program or not
isProgram :: String -> Bool
isProgram ('#':xs) = False
isProgram "" = False
isProgram (' ':xs) = isProgram xs
isProgram s = True

{-
data Args = Args {
    configDir :: Maybe String,
    installs :: Bool, 
    sublimeText :: Bool
} deriving (Show)


parseArgs :: [String] -> Args -> Args
parseArgs [] args = args 
parseArgs ("--install":rest) (Args con ins sub) = parseArgs rest (Args con True sub)
parseArgs ("--sublime":rest) (Args con ins sub) = parseArgs rest (Args con ins True)
parseArgs ["--config"] (Args con ins sub) = error $ "Arguments:\n" ++
                            "setup --config <config_dir> [--install] [--sublime]"
parseArgs ("--config":rest) (Args con ins sub) = parseArgs (tail rest) 
                                                           (Args (Just (head rest)) ins sub)
parseArgs xs args = error $ "Arguments:\n" ++
                            "setup --config <config_dir> [--install] [--sublime]"

execInstalls :: String -> IO ()
execInstalls configDir = putStrLn "installling files..."

execArgs :: Args -> IO ()
execArgs (Args conf inst subl) = do
    if inst then (execInstalls conf) else (print "")
-}

main = do
    argLine <- getArgs
    print argLine
--    let xs = parseArgs argLine (Args Nothing False False)
--    execArgs xs
    let configDir = (head $ argLine)
    
    handle <- openFile (configDir ++ "installs.txt") ReadMode
    contents <- hGetContents handle
    let programs = filter isProgram $ lines contents
    mapM install programs
    -- install "sshfs"
    -- install "lolcat"
    -- print configDir
