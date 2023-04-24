#!/bin/sh
echo attempting to compile file...
echo
/Users/steve/Documents/ZX\ Spectrum\ Next/bin/CSpect/sjasmplus  --zxnext=cspect src/main.asm
echo
echo launching Cspect ...
echo
#sound off
#mono /Users/steve/Documents/ZX\ Spectrum\ Next/bin/CSpect/CSpect.exe -zxnext -r -brk -s28 -tv -vsync -sound -60 -map=bin/map exe/gnk.nex

#sound on
mono /Users/steve/Documents/ZX\ Spectrum\ Next/bin/CSpect/CSpect.exe -zxnext -r -brk -s28 -tv -vsync -60 -map=bin/map exe/sprite_parade.nex
