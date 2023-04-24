;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
LoadSpritePatterns:
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
	; Loads sprite patterns into sprite hardware
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	ld hl,SpriteBinaryFileStart			; start as indicated in the .spr file, follow SpriteAddress for incbin statement
	ld b,MAX_SPRITES				; number of sprite patterns to load
.loop
	push bc
	ld bc,SPRITE_PATTERN_PORT 
	otir						; copy data command - after sending 256 bytes, the target pattern slot is auto-incremented
	pop bc            
	djnz .loop                                                                       
	ret

;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
DrawAllSprites:
;-----------------------------------------------------------------------------------------------------------------------------------------------
; Loop to draw each sprite
;-----------------------------------------------------------------------------------------------------------------------------------------------
	ld ix,SpriteAttributesTable
	ld a,(createdSprites) 
	ld b,a
.loop 
	push bc

	call MoveSpriteRight

	call PrepToDrawSprite
	call DrawSprite
	ld de,SPRITE_DATA_BLOCK_SIZE 
	add ix,de 			; add to ix = point to next sprite
	
	pop bc
	
	djnz .loop
	ret

;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
PrepToDrawSprite:
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
	Animation Flow Summary:

	0. Check a counter to see how many cycles of animation before pattern changes
	1. If counter = sprite delay, then pattern changes
	2. Decide if max pattern sprite animation has been reached
		  a. if not increase pattern
		  b. if max, reset pattern to start pattern    
	3. Return and Draw
*/
;-----------------------------------------------------------------------------------------------------------------------------------------------
	ld 	a,(ix+SPRITE_FRAME_COUNT)		; Sprite pattern will not change every frame, this is too fast and will prevent animation illusion	
	cp 	(ix+SPRITE_ANIMATION_DELAY)		; is it time to change the pattern?
	jr 	nz,.doNotIncreasePattern		; do not increase sprite pattern unless the number of frames drawn = numer of frames to change pattern, e.g. draw, draw, draw, update pattern...						  
	xor	a					; a = 0
	ld 	(ix+SPRITE_FRAME_COUNT),a		; time to change pattern and therefore reset frame counter to 0
							
	ld 	a,(ix+SPRITE_START_PATTERN)		; get the start pattern index, which is different for each sprite  			                   
	add 	(ix+SPRITE_ANIMATION_FRAMES)		; a = max animation frames	
	cp 	(ix+SPRITE_CURRENT_PATTERN)		; current pattern = max frames?
	jr 	nz,.notMaxPattern			; increase pattern as it's not max pattern
							; else max pattern is reached
.resetPattern    					; reset
	ld 	a,(ix+SPRITE_START_PATTERN)		; get start pattern
	ld 	(ix+SPRITE_CURRENT_PATTERN),a		; current pattern = start
	ret
.notMaxPattern						; pattern limit not reached so return and draw as normal, but increase pattern number
	inc 	(ix+SPRITE_CURRENT_PATTERN)		
	ret
.doNotIncreasePattern					               
	inc 	(ix+SPRITE_FRAME_COUNT)			; increase frame count
	ret						; return and draw sprite with no pattern change

;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
DrawSprite:
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

; Fetch Attributes from Sprite Data Table

	ld a,(ix+SPRITE_ID)				; get sprite id from spriteData
	ld hl,(ix+SPRITE_X)
	ld d,(ix+SPRITE_Y)
	ld e,(ix+SPRITE_CURRENT_PATTERN)		; Set Pattern Number
	ld c,(ix+SPRITE_MIRROR)				; set rom above code, as it varies depending on sprite movement ?							
	ld b,(ix+SPRITE_VISIBLE)
	
; WriteUpDateSpriteAttributes:

	NEXTREG $34,a            	; select sprite      
	ld a,l                		; X coord, 8 bit
	NEXTREG SPRITE_ATTR0,a		; Write ATTR_0  -  HL is 9 bit, value over 2 bytes, see attr 2??
	ld a,d                		; Y coord, 8 bit
	NEXTREG SPRITE_ATTR1,a		; Write ATTR_1
	ld a,h				; 9th bit of X 16 bit coordinate
	and %00000001			; mask off bits 7-1, keeping bit 0, the x MSB coord bit of 9 bytes
	or c				; XXXX'0000 Palette Offset - or MIRROR_H/MIRROR_V
	NEXTREG SPRITE_ATTR2,a		; load attr 2 with data
	xor a                     
	or b 				; visibility
	or e				
	NEXTREG SPRITE_ATTR3,a		; Pattern Number    
	ret

;--------------------------------------------------------------------------------------------------
CalculateSpriteAttrTableInsertionPoint:
;--------------------------------------------------------------------------------------------------
; EXIT
; ix = insertion point for new sprite data
; insertion point in memory = createdSprites * SPRITE_DATA_BLOCK_SIZE
;--------------------------------------------------------------------------------------------------
        ld ix,SpriteAttributesTable             ; calculate data table insertion point
        ld a,(createdSprites)                   ; = sprite amount * SPRITE_DATA_BLOCK_SIZE, e.g. 0 * 21 = 0                     
        ld d,a
        ld e,SPRITE_DATA_BLOCK_SIZE
        mul d,e
        add ix,de                               ; ix = insertion point
        ret

createdSprites db 63
;--------------------------------------------------------------------------------------------------
WriteIntoSpriteAttrDataTable:
;--------------------------------------------------------------------------------------------------

; Calculates correct memory address to inserts sprite attributes one after another into our attribute data area

; A = Sprite Number/ ID
; B = x
; C = y
; H = start pattern
; L = animation frames
; D = VISBILITY
;--------------------------------------------------------------------------------------------------
        push af,de                                     ; save registers containing start parameters that will be lost on calling next function
        call CalculateSpriteAttrTableInsertionPoint    ; returns IX
        pop de,af

        ld a,(createdSprites)
        nextreg $34,a
        inc a
        ld (createdSprites),a
      
        ld (ix+SPRITE_ID),a
        ld (ix+SPRITE_X),b
        ld (ix+SPRITE_Y),c
        ld (ix+SPRITE_CURRENT_PATTERN),h
	ld (ix+SPRITE_START_PATTERN),h
        ld (ix+SPRITE_ANIMATION_FRAMES),l
        ld (ix+SPRITE_VISIBLE),d
        ld (ix+SPRITE_ANIMATION_DELAY),3

        ret

;--------------------------------------------------------------------------------------------------
WipeAllAttrsFromSpriteTable
;--------------------------------------------------------------------------------------------------
; Clear All Sprite Attrs
;--------------------------------------------------------------------------------------------------
	ld ix,SpriteAttributesTable
        ld hl,64*SPRITE_DATA_BLOCK_SIZE
        
        ld a,h
        or l
        ret z  

.loop
        xor a			; 0
        ld (ix),a			
        inc ix
        dec hl			; 16 bit count down
        ld a,h
        or l			; 0 ?
        jr nz, .loop		; if not, loop
        ret			; else exit
		
;--------------------------------------------------------------------------------------------------
MoveSpriteRight:
;--------------------------------------------------------------------------------------------------
; Move Sprite Right by increasing attr SPRITE_X, called for each sprite during loop
;--------------------------------------------------------------------------------------------------
	ld hl,(ix+SPRITE_X)			; move, not = 0, so dec hl. (moving left)
	inc hl				
	ld a,h                          
	and %00000001				; strips bits 7-1, leaving bit 0 as 1, representing number above 256 - lsb still counting 
	ld h,a                          
	ld (ix+SPRITE_X),hl  

	ld de,320 				; right screen limit in pixels
	or a					; 16 bit comparison...
	sbc hl,de				 ; ..
	add hl,de 				 ; .
	ret nz					; greater than? no keep going
	ld hl,0					
	ld (ix+SPRITE_X),hl			; else reset x coord ...
	ret	
