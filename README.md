# Sprite-Parade
ZX SPECTRUM NEXT Display 64 Animated Hardware Sprites

Compile with SJASM plus

sjasmplus  --zxnext=cspect src/main.asm

Run in CSPECT
CSpect.exe -zxnext -r -brk -s28 -tv -vsync -60 -map=bin/map exe/sprite_parade.nex

MacOS ~ run CSCPECT via Mono
mono /Users/user/Documents/ZX\ Spectrum\ Next/bin/CSpect/CSpect.exe -zxnext -r -brk -s28 -tv -vsync -60 -map=bin/map exe/sprite_parade.nex
