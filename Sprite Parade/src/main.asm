		/* ~ Sprite Parade Demo 2024 ~ */

;------------------------------------------------------------------------------------------------------------------------------------------------
; Page Map
;------------------------------------------------------------------------------------------------------------------------------------------------

; Page:

; 40 ~ sprite patterns
; 41 ~ sprite patterns
; 44 ~ sprite data table

;------------------------------------------------------------------------------------------------------------------------------------------------
; ~~ Sprite Engine Run Time MMU Memory Map ~~
;------------------------------------------------------------------------------------------------------------------------------------------------
; SLOT 0 $0000 - $1FFF ~ Sprite Attributes Data Table	
; SLOT 1 $2000 - $3FFF ~ 
; SLOT 2 $4000 - $5FFF ~ ULA / ATTR 
; SLOT 3 $6000 - $7FFF 
; SLOT 4 $8000 - $9FFF ~ Program Code
; SLOT 5 $A000 - $BFFF ~ 
; SLOT 6 $C000 - $DFFF ~ 
; SLOT 7 $E000 - $FFFF ~ 
;------------------------------------------------------------------------------------------------------------------------------------------------

	DEVICE ZXSPECTRUMNEXT
	opt --zxnext=cspect
	SLDOPT COMMENT WPMEM, LOGPOINT, ASSERTION			; dezog debugger stuff for Microsoft VSCODE editor
	

 MACRO SPRITES_ON
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
	ld a,%01000011				; SPRITE SYSTEM ON, with sprites over border on          
	nextreg SPRITE_SPRITE_AND_LAYERS,a
	ENDM
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 MACRO SPRITES_OFF
	ld a,%01000000				; SPRITE SYSTEM OFF         
	nextreg SPRITE_SPRITE_AND_LAYERS,a
	ENDM

	ORG $8000

	INCLUDE "src/defines.asm"

CODE_START

	DI								; Disable Interrupts, iy register can be safely used, halt instruction will no longer function on Next hardware. 'WaitForScanlineUnderULA' used instead.

MAIN:

Init:
	call 	ClearULAScreen
	NEXTREG MMU_SLOT_6,40						; $C000 ~ $DFFF load 16K Sprite Pattern Data residing in banks 40,41, loaded at assembly time
	NEXTREG MMU_SLOT_7,41						; $E000 ~ $FFFF sprite data is contained over 2 * 8 kb banks. Once this data is used by the sprite uploading routines to hardware, the memory is free to be used.				
	call	LoadSpritePatterns					; copy Sprite Patterns to hardware
	call 	SetSpritePalette					; ~ Sprite Init ~			
	NEXTREG MMU_SLOT_0,44						; $0000 ~ $2000 Sprite Data Table is loaded here ~ ditch ROM by swapping in bank 44 to memory slot 0
									
	call	WipeAllAttrsFromSpriteTable				; clear memory
	call	CreateAttrDataForSpriteTable				; fill memory with data
	
	ld a,%01000011							; SPRITE SYSTEM ON, with sprites over border on          
	nextreg SPRITE_SPRITE_AND_LAYERS,a

MainLoop:
;------------------------------------------------------------------------------------------------------------------------------------------------
	
	ld b,16*5							; number of draw cycles

.demoLoop
	push bc
	call DrawAllSprites						; all sprites are updated and drawn 1 frame at a time, 16 times	
	call WaitForScanlineUnderUla
	pop bc
	djnz .demoLoop							; loop x number of cycles prior to changing sprite pattern
	jp MainLoop	

	INCLUDE "src/palette.asm"
	INCLUDE "src/sprite_routines.asm" 
	INCLUDE "src/subroutines.asm"
	INCLUDE "src/sprite_attributes_table.asm"	
	INCLUDE "src/variables.asm"
	INCLUDE "src/sprite_patterns.asm"	

;--------------------------------------------------------------------------------------------------------------------------------------------------------
; CSPECT/SJASM plus compiler stuff
;--------------------------------------------------------------------------------------------------------------------------------------------------------- 

	CSPECTMAP "bin/map"
	DISPLAY "Compiling exe/sprite_parade.nex......"
	SAVENEX OPEN "exe/sprite_parade.nex",MAIN,$BFFF			; This sets the name of the project, the start address, and the initial stack pointer.
	SAVENEX AUTO
	SAVENEX CLOSE		
;--------------------------------------------------------------------------------------------------------------------------------------------------------