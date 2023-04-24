
 	MMU 0,44	;        
	ORG $0000	; start to write data

SpriteAttributesTable:
;--------------------------------------------------------------------------------------------

	; data structure to hold sprite attributes, which are inserted dynamically by the program
	; Note: this demo does not use all of the attributes seen below, which are actually used for another program.
	; 0 - 63 Sprite Attributes
	; Data Structure Examples 
; ;--------------------------------------------------------------------------------------------
; Sprite 1 
; ;--------------------------------------------------------------------------------------------

; 	db 5		; (ix+0)  : SPRITE_ID			; note  id is deliberately set to 5, ghost will be drawn on top of player sprite during collision
; 	db 0		; (ix+1)  : SPRITE_Y
; 	dw 0		; (ix+2)  : SPRITE_X LSB
; 		   	; (ix+3)  : SPRITE_X MSB
; 	db MIRROR_H	; (ix+4)  : SPRITE_MIRROR
; 	db VISIBLE     	; (ix+5)  : SPRITE_VISIBLE
; 	db 0	        ; (ix+6)  : SPRITE_DIRECTION
; 	db 0	    	; (ix+7)  : SPRITE_START_Y 
; 	dw 0            ; (ix+8)  : SPRITE_START_X 
;      	    	     	; (ix+9)
; 	db 0		; (ix+10) : SPRITE_FRAME_COUNTER
; 	db 4           	; (ix+11) : SPRITE_ANIMATION_FRAMES
; 	db 3		; (ix+12) : SPRITE_ANIMATION_DELAY
; 	db 0		; (ix+13) : SPRITE_ANIMATION_DELAY_COUNTER
; 	db 0	        ; (ix+14) : SPRITE_CURRENT_PATTERN_NUMBER
; 	db 0		; (ix+15) : SPRITE_TEMP_PATTERN_HOLDER
; 	db 0		; (ix+16) : SPRITE_START_PATTERN
; 	db LEFT		; (ix+17) : SPRITE_START_DIRECTION
; 	db 0		; (ix+18) : UNUSED PADDING
; 	db 0		; (ix+19) : UNUSED PADDING	
; 	db 0		; (ix+20) : UNUSED PADDING

; ;--------------------------------------------------------------------------------------------
; Sprite 2
; ;--------------------------------------------------------------------------------------------

;      	db 1		; (ix+0)  : SPRITE_ID
;      	db 0  	   	; (ix+1)  : SPRITE_Y
;      	dw 0 	   	; (ix+2)  : SPRITE_X LSB
;      			; (ix+3)  : SPRITE_X MSB
;      	db 0	 	; (ix+4)  : SPRITE_MIRROR
;      	db 0     	; (ix+5)  : SPRITE_VISIBLE
;      	db 0      	; (ix+6)  : SPRITE_DIRECTION
;      	db 0	     	; (ix+7)  : SPRITE_START_Y
;      	dw 0 	     	; (ix+8)  : SPRITE_START_X
;      		  	; (ix+9)
; 	db 0           	; (ix+10) : SPRITE_FRAME_COUNTER
; 	db 1           	; (ix+11) : SPRITE_ANIMATION_FRAMES		; frames to animate 0..1 (2)
;      	db 3          	; (ix+12) : SPRITE_ANIMATION_DELAY
; 	db 0		; (ix+13) : SPRITE_ANIMATION_DELAY_COUNTER
;      	db 05 	 	; (ix+14) : SPRITE_CURRENT_PATTERN_NUMBER 	; init same as sprite start pattern
;      	db 05          	; (ix+15) : SPRITE_TEMP_PATTERN_HOLDER
;      	db 0          	; (ix+16) : SPRITE_START_PATTERN
;      	db 0       	; (ix+17) : SPRITE_START_DIRECTION
;      	db 0	 	; (ix+18) : UNUSED PADDING
;      	db 0	 	; (ix+19) : UNUSED PADDING
; 	db 0		; (ix+20) : UNUSED PADDING


SpriteAttributesTableEnd:
