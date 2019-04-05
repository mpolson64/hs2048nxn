# nxn2048hs
Terminal 2048 implementation for n by n game boards written (for great good) in Haskell.

## How to play
Clone the repository, build with cabal, then run the executable with (optional) command line arguments for board dimensionality and random number generator seed.
Use WASD (or hjkl) <ENTER> to slide the board.
The game ends with the board becomes locked, or use <ctrl-c> to quit immediately.

```bash
git clone https://github.com/mpolson64/nxn2048hs.git
cd nxn2048/
cabal build
./dist/build/nxn2048hs/nxn2048hs 4 0
```
[![asciicast](https://asciinema.org/a/FsYeOHg3bWWFExsl8Gs77SXMl.svg)](https://asciinema.org/a/FsYeOHg3bWWFExsl8Gs77SXMl)

## Why this game exists
I made this game as an exersise in learning the Haskell programming language while reading the deservedly often praised [Learn you a Haskell for Great Good](http://learnyouahaskell.com/).
While I don't use Haskell to any meaningful extent in either my academic or professional work as of date, I try and implement functional principles in everything I write. This project has been a quick and fun learning experience in both a new language and a light intro into monadic structures.
