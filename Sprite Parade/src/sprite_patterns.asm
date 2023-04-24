
 	MMU 6 7,40	; slot to load Sprite Data, 16K file wraps over into next bank         
	ORG $C000	; start to write data

SpriteBinaryFileStart:
	INCBIN "src/MM.spr" ; Includes Sprite Patterns File - editable and viewable if imported into Remy's ZX Graphics Tools website, for example.
SpriteBinaryFileEnd:
