# nxn2048hs
Terminal 2048 implementation for n by n game boards written (for great good) in Haskell.

## How to play
Clone the repository, build with cabal, then run the executable with (optional) command line arguments for board dimensionality and random number generator seed. Use WASD (or hjkl) <ENTER> to slide the board. The game ends with the board becomes locked, or use <ctrl-c> to quit immediately.

```bash
git clone https://github.com/mpolson64/nxn2048hs.git
cd nxn2048/
cabal build
./dist/build/nxn2048hs/nxn2048hs 4 0
```
