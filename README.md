# ruby-chess

Final project for Ruby section of TOP

# Status

This game meets all the described functionality except for 'checkmate' detection.  
I didn't plan out the game sufficiently before I started writing code, and implementing checkmate now
would either require hacking in fake player input and creating fake board objects, or a significant
refactor of code.

I've decided to park this for now and continue with Odin Project, with intent to return later and
refactor/rebuild the game, potentially adding a front end.

Lessons learned:

* put common functions into modules
* plan design out first - you’ve got capture/move logic split across game/pieces, now it’s a nightmare to build a checkmate function
    * each piece should store list of valid moves/captures, recalculated each turn
    * store location, previous location, captured pieces -> you can undo moves
    * keep request, validate + move logic seperate
* use a library of error messages, then set an @error_msg variable during command and print on failure

## Classes

### Chess Game
Contains main game logic and instantiates all other classes.

### Chess Board
Tracks 8x8 board state.

### Chess Piece
Objects stored within ChessBoard, track piece color and type.
Child classes for each type of piece.

### Player
Prompts player and processes input.

## Modules

### SaveLoad

Implements save/load functionality.





