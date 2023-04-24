;-----------------------------------------------------------------------------------------------------------------------------------------------
ClearULAScreen: 
;-----------------------------------------------------------------------------------------------------------------------------------------------

	ld hl,ULA_SCREENMEMORY_START
	ld de,ULA_SCREENMEMORY_START+1
	ld bc,ULA_SCREEN_LENGTH-1
	ld (hl),$00; 
	ldir
	
	ld hl,ULA_ATTR_START
	ld de,ULA_ATTR_START+1
	ld bc,ULA_ATTRIBUTES_LENGTH-1
	ld (hl),%0'0'000'111 		; flash off, bright off, paper black, ink white

	ldir
	ret


TotalFrames:		dd 0	; Use for counting frames
WaitForScanLine:        db 192	; Scanline to wait for
;-------------------------------------------------------------------------------------
WaitForScanlineUnderUla:
;-------------------------------------------------------------------------------------
; From 'Dougie Do' ; ref: https://github.com/robgmoran/DougieDoSource
;-------------------------------------------------------------------------------------

.UpdateTotalFrames:
        ld hl,(TotalFrames)
        inc hl
        ld (TotalFrames),hl
        ld a,h
        or l
        jr nz,.totalFramesUpdated
        ld hl,(TotalFrames+2)
        inc hl
        ld (TotalFrames+2),hl
.totalFramesUpdated:
        ld bc,$243B        
        ld a,$1F          
        out (c),a          
        inc b              
.cantStartAtScanLine:
        ld a,(WaitForScanLine)
        ld d,a
        in a,(c)       
        cp d
        jr z,.cantStartAtScanLine
.waitLoop:
        in a,(c)       
        cp d
        jr nz,.waitLoop
        ret 

pattern 		db WILLY
y_coord 		db 0
;--------------------------------------------------------------------------------------------
CreateAttrDataForSpriteTable:
;--------------------------------------------------------------------------------------------

	ld c,0					; row column
	ld b,8					; number of rows of sprites
.outerLoop
	push bc

	ld e,0					; 
	ld b,8					; number of sprites to display per row 8 * 8 = 64
.loop
	push bc		

	ld a,(pattern)				; init pattern
	ld h,a					; pattern number  

	add 4
	ld (pattern),a
	cp BEAR+4
	jr nz, .cont
	; else, reset
	ld a,WILLY
	ld (pattern),a
.cont

	ld b,e					; x
	ld a,(y_coord)		      		
	ld c,a					; y  
	ld l,MANIC_MINER_ANIMATION_FRAMES	; animation frames
	ld d,VISIBLE				; sprite is visible

	push af,bc,de
	call WriteIntoSpriteAttrDataTable
	pop de,bc,af

	ld a,e
	add 32					; spacing between sprite, multiple of 16
	ld e,a

	pop bc
	djnz .loop

	ld a,(y_coord)
	add 32					; spacing between sprite, multiple of 16
	ld (y_coord),a

	pop bc
	djnz .outerLoop
	
	ret