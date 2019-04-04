module Main where

import Data.List
import System.Random

data Board = Board [[Int]]
data Gamestate = Gamestate Board StdGen
data Direction = Up | Down | Left | Right

mkBoard :: Int -> Board
mkBoard n = Board $ replicate n $ replicate n 0

showNoZero :: Int -> String
showNoZero 0 = " "
showNoZero n = show n

pad :: Int -> String -> String
pad n str
    | length str < n = ' ' : pad (n - 1) str
    | otherwise = str

formatLine :: Int -> [Int] -> String
formatLine padLength xs = "[" ++ (unwords $ map (pad padLength) (map showNoZero xs)) ++ "]"

formatLines :: [[Int]] -> [String]
formatLines board = map (formatLine (length $ show $ maximum $ map maximum board)) board 

instance Show Board where
    show (Board board) = intercalate "\n" (formatLines board)

getBoard :: Gamestate -> Board
getBoard (Gamestate board _) = board

getStdGen :: Gamestate -> StdGen
getStdGen (Gamestate _ stdGen) = stdGen

main :: IO ()
main = putStrLn "Hello, Haskell!"
