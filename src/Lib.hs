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
                , "packages"
                , "tools"
                , "node_modules"
                , "**/*.js.map"
                , ".stack-work"
                , "bin"
                , "obj"]

        let ignoreLines = map (++ "\n") ignoreList
        mapM_ (appendFile ignoreFile) ignoreLines
        putStrLn "-- ok"
    else
        putStrLn "-- .gitignore already exist."
