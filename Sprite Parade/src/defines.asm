; MMU
;----------------------------------------------------------------------------------------
MMU_SLOT_0 EQU $50
MMU_SLOT_1 EQU $51
MMU_SLOT_2 EQU $52
MMU_SLOT_3 EQU $53
MMU_SLOT_4 EQU $54
MMU_SLOT_5 EQU $55
MMU_SLOT_6 EQU $56
MMU_SLOT_7 EQU $57	

; ULA
;----------------------------------------------------------------------------------------
ULA_SCREENMEMORY_START				EQU $4000
ULA_ATTR_START					EQU $5800
ULA_ATTRIBUTES_LENGTH  				EQU ULA_SCREEN_WIDTH_CHARS * ULA_SCREEN_HEIGHT_CHARS
ULA_SCREEN_LENGTH				EQU ULA_ATTR_START - ULA_SCREENMEMORY_START
ULA_SCREEN_WIDTH_CHARS: 			EQU 32
ULA_SCREEN_HEIGHT_CHARS:			EQU 24
SCREEN_WIDTH_PIXELS:				EQU 256
SCREEN_HEIGHT_PIXELS				EQU 192

; Sprite I/O ports
;----------------------------------------------------------------------------------------
SPRITE_REGISTER_PORT    			EQU $243B
SPRITE_VALUE_PORT       			EQU $253B
SPRITE_INDEX_PORT       			EQU $303B
SPRITE_PALETTE_PORT     			EQU $53
SPRITE_SPRITE_PORT      			EQU $57
SPRITE_PATTERN_PORT     			EQU $5B
SPRITE_SPRITE_AND_LAYERS			EQU $15

; Sprite ID and Attributes ports
;----------------------------------------------------------------------------------------
SPRITE_ATTR0					EQU $35	; Next Reg $35
SPRITE_ATTR1					EQU $36	; Next Reg $36
SPRITE_ATTR2					EQU $37	; Next Reg $37
SPRITE_ATTR3					EQU $38	; Next Reg $38
SPRITE_ATTR4					EQU $39	; Next Reg $39

VISIBLE						EQU 128

; Number of Sprites
;---------------------------------------------------------------------------------------
MAX_SPRITES					EQU 63								; plus x 3 HUD sprites

; Sprite Data Offsets
;-----------------------------------------------------------------------------------------------------
SPRITE_DATA_BLOCK_SIZE				EQU 21			; Total Number of ix + Data Items in sprite_data, including the LSB's of 16 bit values

; IX Offsets for sprite data buffer e.g. (ix + SPRITE_ID)
;-----------------------------------------------------------------------------------------------------
SPRITE_ID					EQU 00
SPRITE_Y					EQU 01
SPRITE_X					EQU 02			; points to a 16 bit value 
						;   03			; position of 2nd byte of 16 bit value
SPRITE_MIRROR					EQU 04
SPRITE_VISIBLE					EQU 05
SPRITE_DIRECTION				EQU 06
SPRITE_START_Y		                        EQU 07	
SPRITE_START_X					EQU 08			; points to 16 bit value, as above
						;   09			; position of 2nd byte of 16 bit value
SPRITE_FRAME_COUNTER				EQU 10			; counts the number of movements made in a 16 pixel movement cycle
SPRITE_ANIMATION_FRAMES				EQU 11
SPRITE_ANIMATION_DELAY				EQU 12
SPRITE_FRAME_COUNT			EQU 13
SPRITE_CURRENT_PATTERN				EQU 14
SPRITE_TEMP_PATTERN_HOLDER			EQU 15
SPRITE_START_PATTERN				EQU 16
SPRITE_START_DIRECTION				EQU 17
SPARE_1						EQU 18
SPARE_2						EQU 19
SPARE_3						EQU 20

; Sprite
;-----------------------------------------------------------------------------------------------------
MANIC_MINER_ANIMATION_FRAMES			EQU 3

; Pattern Start Indexes, each sprites takes a pattern for 4 frames of animation, e.g. 0,1,2,3, 4,5,6,7
;-----------------------------------------------------------------------------------------------------
WILLY 			EQU 0
ROO			EQU 4
CLOCKWORK		EQU 8
TOILET 			EQU 12
PENGUIN			EQU 16
SEAL			EQU 20
OSTRICH			EQU 24
BARREL			EQU 28
TELEPHONE		EQU 32
WALKER			EQU 36
BEAR			EQU 40

; Movement Directions
;----------------------------------------------------------------------------------------
RIGHT	EQU 1	; %XXXX'0001
LEFT 	EQU 2	; %XXXX'0010
DOWN 	EQU 4	; %XXXX'0100
UP   	EQU 8	; %XXXX'1000

