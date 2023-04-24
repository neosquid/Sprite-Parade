;---------------------------------------------------------------------------------------
SetSpritePalette:
;---------------------------------------------------------------------------------------
	nextreg $40,%00000000		; palette index 0, auto increment
	nextreg $43,%00100000 		; sprites - auto increments?

	ld hl,ulaPalette8bit 
	ld b,16
.loop
	ld a,(hl)			; read color value
	nextreg $41,a			; write value
	inc hl
	djnz .loop
	
	ld a,8				; set index of transparent byte for sprites, points to value c0
	nextreg $4B,a			; write value
	
	ret

;---------------------------------------------------------------------------------------
SetTileMapPalette:
;---------------------------------------------------------------------------------------
	nextreg $40,%00000000		; palette index 0
	nextreg $43,%00110000 		; tilemap

	ld hl,ulaPalette8bit 
	ld b,16
.loop
	ld a,(hl)
	nextreg $41,a
	inc hl
	djnz .loop
	ret

ulaPalette8bit:
;---------------------------------------------------------------------------------------
; ULA 8 bit palette created with Remy's tools 
; Check ports and regs wiki section / tomaz guide on how to write to ports, as seen above
;---------------------------------------------------------------------------------------
	; Value ~index ~ color
	db $0  ; 0 	black	 
	db $2  ; 1	blue	
	db $a0 ; 2	red	
	db $a2 ; 3	magenta	
	db $14 ; 4	green	
	db $16 ; 5	cyan	
	db $b4 ; 6	yellow	
	db $a0 ; 7	white	
	db $c0 ; 8	transparent
	db $03 ; 9	blue	~ bright
	db $e0 ; 10 $0A	red 	~ bright
	db $e7 ; 11 $0B	magenta ~ bright
	db $1c ; 12 $0C	green 	~ bright
	db $1f ; 13 $0D	cyan 	~ bright
	db $fc ; 14 $0E	yellow 	~ bright
	db $ff ; 15 $0F	white 	~ bright


	