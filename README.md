# Sprite-Parade
ZX SPECTRUM NEXT Display 64 Animated Hardware Sprites

Compile with SjASMPlus

sjasmplus  --zxnext=cspect src/main.asm

Run in CSPECT
CSpect.exe -zxnext -r -brk -s28 -tv -vsync -60 -map=bin/map exe/sprite_parade.nex

MacOS ~ run CSCPECT via Mono
mono /Users/user/Documents/ZX\ Spectrum\ Next/bin/CSpect/CSpect.exe -zxnext -r -brk -s28 -tv -vsync -60 -map=bin/map exe/sprite_parade.nex

![sprite_parade](https://user-images.githubusercontent.com/3781546/233520283-9033dfa5-1b0d-4c99-8426-a1b17206699f.png)
