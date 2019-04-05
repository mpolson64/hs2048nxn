module Main where

import Data.List
import System.Random

type Board = [[Int]]
data Gamestate = Gamestate Board StdGen
data Direction = North | South | East | West

-- Board builder
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

-- Coalesce adjacent squares of matching value and slide West
reduce :: Board -> Board
reduce = map rowReduce
    where rowReduce [] = []
          rowReduce [x] = [x]
          rowReduce (x:y:zs)
              | x == 0 = rowReduce (y : zs) ++ [0]
              | y == 0 = rowReduce (x : zs) ++ [0]
              | x == y = (x + y) : rowReduce zs ++ [0]
              | otherwise = x : rowReduce (y : zs)

-- Coalesce directionally
slide :: Direction -> Board -> Board
slide North = transpose . reduce . transpose
slide South = transpose . map reverse . reduce . map reverse . transpose
slide East  = map reverse . reduce . map reverse
slide West  = reduce

-- Check if any moves on the board are legal
isLocked :: Board -> Bool
isLocked board = all (\board' -> board' == board) $ map (\dir -> slide dir board) [North, South, East, West]

-- Returns indices of empty tiles on board
emptyTiles :: Board -> [(Int, Int)]
emptyTiles board = 
    let indicies = [0..(length board) - 1]
        indexed = concatMap (\x -> map (\y -> (fst y, (snd x, snd y))) (fst x)) (map (\x -> (zip (fst x) indicies, snd x)) (zip board indicies))
     in map snd (filter (\x -> fst x == 0) indexed)

-- Sets the value of the tile at a specific coordinate
setTile :: (Int, Int) -> Int -> Board -> Board
setTile (i, j) n board = setNth i (setNth j n (board !! i)) board
    where setNth _ _ [] = []
          setNth i n (x:xs)
            | i == 0 = n:xs
            | otherwise = x:setNth (i - 1) n xs          

main :: IO ()
main = putStrLn "Hello, Haskell!"
