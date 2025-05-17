; Tiny Toon 2: Montana's Movie Madness (USA/Europe) Restoration
; by Marc Robledo @marc_robledo 2024-2025
;
; BANK 5
; This bank contains all the logic for both title and game over screens.
; The free space in this bank will be used to store part of the new tileset.

SECTION "Bank 5 - Restore PUSH START text (after NORMAL/HARD MODE)", ROMX[$471c], BANK[5]
ld		hl, $479c ;PUSH START string
;call	draw_map
nop
nop
nop
SECTION "Bank 5 - Restore PUSH START text (after MINIGAMES CHEAT)", ROMX[$4738], BANK[5]
ld		hl, $479c ;PUSH START string
;call	draw_map
nop
nop
nop





SECTION "Bank 5 - Game over/continue menu", ROMX[$4a56], BANK[5]
game_over_menu_loop:
	;the original subroutine here handled the game over menu
	;since there are no continues, we can reuse space here for our new menu that includes passwords

	call	$4af3 ;calamity coyote and little beeper animation?

	ld		hl, _menu_variables.current_option
	ldh		a, [_pressed_buttons]
	bit		2, a
	jr		nz, .up_pressed
	bit		3, a
	jr		nz, .down_pressed
	jr		.no_direction_pressed

.up_pressed:
	ld   	a, [hl]
	dec		a
	cp		$ff
	jr		nz, .refresh_carrot_selector
	ld		a, 2
	jr		.refresh_carrot_selector

.down_pressed:
	ld   	a, [hl]
	inc		a
	cp		3
	jr		nz, .refresh_carrot_selector
	xor		a


.refresh_carrot_selector:
	ld		[hl], a

	ld		b, $ff
	ld		de, $9864
	call	menu_draw_undraw_carrot
	ld		de, $98a4
	call	menu_draw_undraw_carrot
	ld		de, $98e4
	call	menu_draw_undraw_carrot
.toggle_password_window:
	ld		a, [_menu_variables.current_option]
	cp		1
	ld		a, $c7 ;window disabled
	jr		nz, .skip
	set		5, a ;enable window
.skip:
	ldh		[_reg_lcdc], a


	;original code
	ld		a, $0c
	call	$03f0


.no_direction_pressed:
	ldh		a, [_pressed_buttons]
	and		a, $b0
	ret		z

	;pressed START/A/B
	ld		a, [_menu_variables.current_option]
	cp		2
	jp		z, $0b73 ;nz=END

	and 	a
	ret		nz ;nz=PASSWORD

	;CONTINUE
.continue:
	ld		a, $0c
	ld		[$c0cc], a

	call	$0fe3 ;set next loop
	ld		a, 9
	jp		$03f0

REPT 5
	nop
ENDR
SECTION "Bank 5 - Game over/continue menu (END)", ROMX[$4ac1], BANK[5]
continue:
	ld		a, [_menu_variables.current_option]
	;bit		0, a
	bit		1, a
	jp		nz, $0fe3 ;end game
	;...










SECTION "Bank 5 - Game Over static screen - Put initial cursor position", ROMX[$4a2d], BANK[5]
	ld		de, $98a4 - $0040 ;CONTINUE word is now placed higher
	ld		a, $f3
	call	mem_copy_safe_1byte

SECTION "Bank 5 - Game Over static screen map", ROMX[$4bc7], BANK[5]
_uncompressed_game_over_static_screen_map:
	;originally, this map was compressed, we will store it uncompressed since we don't know the compression algorithm
	DW $9823
	DB $ee, " GAME  OVER ", $ee, $fe
	DW $9866
	DB "CONTINUE", $fe
	DW $98a6
	DB "PASSWORD", $fe
	DW $98e6
	DB "END", $fe
	DW $9921
	DB "YOUR SCORE", $fe
	DW $9961
	DB "HIGH SCORE", $ff
REPT 12
	nop
ENDR
SECTION "Bank 5 - Game Over static screen map (END)", ROMX[$4c1a], BANK[5]
;to-do: check the real ending byte
DB $00

SECTION "Bank 5 - Title screen loop", ROMX[$475a], BANK[5]
	jp		title_screen_loop_hook
title_screen_loop_original:
	ldh		[_reg_lcdc], a

	ldh		a, [_pressed_buttons]
	bit		7, a
	jr		nz, start_pressed ;start pressed

	ldh		a, [_frame_counter]
	and		a, $3f
	jr		nz, title_screen_wait

	ld		hl, $dee8 ;decrease wait timer every 64 frames
	dec		[hl]
	jr		nz, title_screen_wait

	;wait timer is over, start demo
	ld		a, $03
	jp		$0fda

title_screen_wait:
	ldh		a, [_pressed_buttons]
	and		%00001100 ;up or down
	ret		z

	call	increase_menu_option
	jp		title_screen_update_carrot

start_pressed:
	ld		a, [_menu_variables.current_option]
	bit		0, a
	jp		nz, increase_menu_temp_variable1

title_screen_start_game:
	ldh		a, [_held_buttons]
	bit		5, a
	jr		nz, .start_minigame_cheat
	ld		b, $00
	bit		4, a
	jr		z, .set_difficulty_and_start
	inc		b
.set_difficulty_and_start:
	ld		a, b
	ld		[_hard_mode],a
	jp		$0fe3
.start_minigame_cheat:
	call	$0fe3
	jp		$0fe3

REPT 6
	nop
ENDR
/*
SECTION "Bank 5 - Title screen loop (END)", ROMX[$479c], BANK[5]
	;could be removed if needed
	DW $99e6
	DB "GAME START", $ff
*/
SECTION "Bank 5 - Title screen loop (END)", ROMX[$47a9], BANK[5]
DB $e7







SECTION "Bank 5 - Free space", ROMX[$7f2b], BANK[5]
menu_draw_undraw_carrot_binary:
	ld		a, [_menu_variables.current_option]
	and		%00000001
	jr		menu_draw_undraw_carrot.compare
menu_draw_undraw_carrot:
	ld		a, [_menu_variables.current_option]
.compare:
	inc		b
	cp		b
.check:
	jr		z, .draw
.undraw:
	xor		a
	jr		.draw + 2
.draw:
	ld		a, $f3
	jp		mem_copy_safe_1byte

title_screen_update_carrot:
	ld		b, $ff
	ld		de, $99e4
	call	menu_draw_undraw_carrot_binary
	ld		de, $9a24
	jp		menu_draw_undraw_carrot_binary



title_screen_loop_hook:
	ld		a, [_menu_variables.secondary_option]
	bit		1, a ;a correct password has been entered
	jp		nz, continue
	bit		0, a
	ld		a, $c7
	jp		z, title_screen_loop_original

title_screen_loop_password:
	ld		h, $c0 ;shadow OAM high byte
	ld		bc, $2178 ;initial YX
	ld		de, $8b01
	ld		a, [_menu_variables.password_digit_selector]
	sla		a
	swap	a
	add		b
	ld		b, a
	call	metasprite_add
	ld		a, $e7
	ldh		[_reg_lcdc], a
	ld		hl, _pressed_buttons
.check_left_or_right:
	ld		a, %00000011 ;left or right
	and		[hl] ;right
	jr		nz, .pressed_left_right
.check_up_or_down:
	ld		a, %00001100 ;left or right
	and		[hl] ;right
	jr		nz, .pressed_up_down
.check_b:
	bit		5, [hl]
	jr		nz, .cancel
.check_start:
	bit		7, [hl]
	jp		nz, check_password_from_bank5
	ret

.cancel:
	xor		a
	ld		[_menu_variables.secondary_option], a
	ld		[$c007], a ;metasprite engine
	ld		[$dee8], a ;timer
	ret
.pressed_left_right:
	bit		1, a ;b0=right, b1=left
	ld		hl, _menu_variables.password_digit_selector
	ld		b, 4 ;maximum value
	jp		change_and_fix_option_value

.pressed_up_down:
	bit		3, a ;b2=up, b3=down
	push	af

	ld		hl, _menu_variables.password_digit_selector
	ld		a, [hl]
	add		LOW(_menu_variables.password_digit0)
	ld		l, a

	pop		af
	ld		b, 5 ;maximum value
	call	change_and_fix_option_value
	jp		redraw_password




change_and_fix_option_value:
	ld		a, [hl]
	jr		nz, .decrease
.increase:
	inc		a
	cp		b
	jr		c, .store
	xor		a
	jr		.store
.decrease:
	dec		a
	bit		7, a
	jr		z, .store
	ld		a, b
	dec		a
.store:
	ld		[hl], a
	ret









draw_game_over_ground:
	ld		a, $e7
	ld		bc, 31
mem_fill_safe:
	call	mem_copy_safe_1byte
	ld		h, d
	ld		l, e
	inc		de
	jp		mem_copy_safe























