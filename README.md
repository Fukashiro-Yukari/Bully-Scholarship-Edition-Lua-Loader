# Bully Scholarship Edition Lua Loader (Beta)

This loader is made for coexistence of multiple lua mods

## installation

You need any tool that can open img files

### [Imgtool](https://www.gamefront.com/games/grand-theft-auto-san-andreas/file/img-tool)

Then you also need a lua compiler

### [Lua Compiler](http://www.bully-board.com/index.php?action=downloads;sa=view;down=60)

You also need Visual Studio 2008 to run the lua compiler

### [Visual Studio 2008](https://download.microsoft.com/download/d/c/3/dc3439e7-5533-4f4c-9ba0-8577685b6e7e/vcsetup.exe)

Then compile all files as lur files

You just need to compile the STimeCycle.lua and qtglib.lua files

Then replace the files in Scripts.img

## Add mod

You need to change the name of the written lua file to mod (num) .lua. This loader allows 100 files to be loaded together.

The mod loaded by the loader catches all errors, so that the game does not crash directly, but some errors still behave as crashes

### Example

mod1.lua mod5.lua mod100.lua

No other mods are currently supported, but you can follow the example mod to write a new mod

## File introduction

* mod1.lua - God mode
* mod2.lua - test mod
* mod3.lua - Spawning vehicle system
