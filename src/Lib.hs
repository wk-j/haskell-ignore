module Lib
    ( ignore 
    ) where

import System.Directory (getCurrentDirectory, doesFileExist)
import System.FilePath.Posix (joinPath)

ignore :: IO()
ignore = do
    dir <- getCurrentDirectory
    let ignoreFile = joinPath [dir, ".gitignore"]
    exist <- doesFileExist ignoreFile

    if not exist then do
        let ignoreList = 
                [ "dist"
                , ".DS_Store"
                , "pacakges"
                , "node_modules"
                , "**/*.js.map"
                , ".stack-work"
                , "bin"
                , "obj"]

        let ignoreLines = map (\x -> x ++ "\n") ignoreList
        mapM (appendFile ignoreFile) ignoreLines
        putStrLn "-- ok"
    else
        putStrLn "-- .gitignore already exist."



