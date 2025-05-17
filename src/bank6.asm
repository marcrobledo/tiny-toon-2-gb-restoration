; Tiny Toon 2: Montana's Movie Madness (USA/Europe) Restoration
; by Marc Robledo @marc_robledo 2024-2025
;
; BANK 6
; This bank contains the title screen map
; The free space in this bank will be used for additional initialization code.

SECTION "Bank 6 - Title screen - Map", ROMX[$64e7], BANK[6]
; Title screen map (uncompressed)
;
; This map was compressed originally, but our new map (that includes the PASSWORD word) fits uncompressed
_title_screen_uncompressed_map:
DW $9822
DB $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $00, $0c, $07, $fe
DW $9842
DB $0d, $0e, $0f, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1a, $63, $64, $fe
DW $9862
DB $1b, $1c, $1d, $1e, $1f, $20, $21, $22, $23, $24, $25, $26, $27, $28, $65, $66, $fe
DW $9883
DB $29, $2a, $2b, $2c, $2d, $2e, $2f, $30, $31, $32, $33, $34, $35, $67, $68, $fe
DW $98a3
DB $36, $37, $38, $00, $39, $00, $00, $00, $3a, $3b, $00, $00, $00, $69, $6a, $fe
DW $98c4
DB $3c, $3d, $3e, $3f, $40, $41, $42, $43, $44, $45, $00, $00, $6b, $fe
DW $98e3
DB $46, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f, $50, $51, $52, $6c, $fe
DW $9903
DB $53, $54, $55, $56, $57, $58, $59, $5a, $5b, $5c, $5d, $5e, $5f, $6d, $6e, $fe
DW $9926
DB $60, $fe
DW $992e
DB $61, $62, $fe
DW $9946
DB $6f, $70, $71, $72, $73, $71, $73, $74, $75, $fe
DW $9964
DB $6f, $70, $76, $77, $78, $00, $6f, $73, $79, $71, $78, $75, $75, $fe
DW $99a4
DB $df, "1993 KONAMI", $fe
DW $99e6
DB "GAME START", $fe
DW $9a26
DB "PASSWORD", $ff

REPT 0
	nop
ENDR
SECTION "Bank 6 - Title screen - Map (END)", ROMX[$65c1], BANK[6]
DB $dc;, ...





SECTION "Bank 6 - Free space", ROMX[$7fd8], BANK[6]
; Additional code for the new title screen
title_screen_prepare_hook:
	;window registers
	ld		a, $60
	ldh		[_reg_win_y], a
	ld		a, $08
	ldh		[_reg_win_x], a
	;set default carrot position
	call	set_menu_option0
	ld		a, $f3
	ld		de, $99e4
	jp		mem_copy_safe_1byte
