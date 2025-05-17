; Tiny Toon 2: Montana's Movie Madness (USA/Europe) Restoration
; by Marc Robledo @marc_robledo 2024-2025


; IMPORTS
INCLUDE "./hardware.inc" ;https://github.com/gbdev/hardware.inc/blob/master/hardware.inc
INCLUDE "./charmap.asm"
INCLUDE "./ram.asm"
INCLUDE "./useful_subroutines.asm"
INCLUDE "./bank1.asm"
INCLUDE "./bank2.asm"
INCLUDE "./bank4.asm"
INCLUDE "./bank5.asm"
INCLUDE "./bank6.asm"
INCLUDE "./bank7.asm"
INCLUDE "./balancing.asm"



SECTION "Bank 0 - Title screen - Prepare", ROM0[$068b]
title_screen_prepare:
	call	load_password_tileset

	;original code
	call	switch_bank_6
	;tileset
	ld		hl, $6021
	ld		de, $9010
	ld		bc, $0790
	call	compressed_mem_copy_safe
	;map
	ld		hl, _title_screen_uncompressed_map
	call	draw_map


	;additional title screen setup
	call	title_screen_prepare_hook

	jp		switch_bank_5
	REPT 0
		nop
	ENDR
SECTION "Bank 0 - Title screen - Prepare (END)", ROM0[$06a9]
	call	switch_bank_2
	;...


;GAME START BLINK
SECTION "Bank 0 - Stage start animation - Stage 0 (blink PUSH START, NORMAL MODE)", ROM0[$075a]
;ld		hl, $479c ;PUSH START string
ret
nop
nop









SECTION "Bank 0 - Initialize Game Over", ROM0[$0acc]
initialize_game_over_map:
	;some game over static screen initialization
	;most of the original code has changed due to password addition and continues removal, so we recode everything

	;the original static screen map was compressed (offset 5:4bc7, 85 bytes)
	;adding the PASSWORD word to the menu would increase its size
	;the only reason to compress that screen was for the repeated ground tile at the bottom
	;and the 000000 score fillers (which can be removed safely because it is later replaced with the actual score)
	;we will be storing our new map as uncompressed map at its original offset, but with the ground removed
	;the ground will be restored later below
	call	switch_bank_5

	ld		hl, _uncompressed_game_over_static_screen_map
	call	draw_map

	;load password tileset and map
	call	load_password_tileset
	;restore ground
	ld		de, $9a20 ;map
	call	draw_game_over_ground
	ld		de, $9d20 ;window
	call	draw_game_over_ground


	;set window Y position to show password
	ld		a, $40
	ldh		[_reg_win_y], a

	;draw password
	call	switch_bank_7
	call	get_current_stage_password
	call	switch_bank_2
	call	draw_game_over_password
	call	switch_bank_5

	REPT 8
		nop ;disable game over function, always infinite continues
	ENDR
SECTION "Bank 0 - Initialize Game Over (END)", ROM0[$0aff]
	call	$0376 ;$0aff
SECTION "Bank 0 - Initialize Game Over (END OK!!!)", ROM0[$0b35]
	DB $0d;, ...







































SECTION "Bank 0 - Free space (top)", ROM0[$004b]
load_password_tileset: ;important: should always be ran from bank 5
	call	switch_bank_1
	call	load_password_tileset_selector
	call	switch_bank_4
	call	load_password_tileset_icons
	call	switch_bank_7
	call	load_password_tileset_squares_and_draw_map
	jp		switch_bank_5
REPT 6
	nop
ENDR
SECTION "Bank 0 - Free space (top) (END)", ROM0[$0066]
	ld		bc, $f300

SECTION "Bank 0 - Free space (middle)", ROM0[$00ea]
redraw_password:
	call	switch_bank_2
	ld		a, [_menu_variables.password_digit_selector]
	call	draw_password_icon
	jp		switch_bank_5
check_password_from_bank5:
	call	switch_bank_7
	call	check_password
	jp		switch_bank_5
REPT 1
	nop
ENDR
SECTION "Bank 0 - Free space (middle) (END)", ROM0[$0100]
entry_point:
	nop
	jp		$0150

SECTION "Bank 0 - Free space (bottom)", ROM0[$3fe9]
