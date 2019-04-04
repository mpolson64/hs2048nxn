module Main where

import Data.List
import System.Random

type Board = [[Int]]
data Gamestate = Gamestate Board StdGen
data Direction = North | South | East | West

mkBoard :: Int -> Board
mkBoard n = replicate n $ replicate n 0

-- Prettyprint helper functions
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

prettyPrint :: Board -> String
prettyPrint board = intercalate "\n" (formatLines board)

getBoard :: Gamestate -> Board
getBoard (Gamestate board _) = board

getStdGen :: Gamestate -> StdGen
getStdGen (Gamestate _ stdGen) = stdGen

reduce :: Board -> Board
reduce = map rowReduce
    where rowReduce [] = []
          rowReduce [x] = [x]
          rowReduce (x:y:zs)
              | x == 0 = rowReduce (y : zs) ++ [0]
              | y == 0 = rowReduce (x : zs) ++ [0]
              | x == y = (x + y) : rowReduce zs ++ [0]
              | otherwise = x : rowReduce (y : zs)

slide :: Direction -> Board -> Board
slide North = transpose . reduce . transpose
slide South = transpose . map reverse . reduce . map reverse . transpose
slide East  = map reverse . reduce . map reverse
slide West  = reduce

main :: IO ()
main = putStrLn "Hello, Haskell!"
