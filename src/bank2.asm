; Tiny Toon 2: Montana's Movie Madness (USA/Europe) Restoration
; by Marc Robledo @marc_robledo 2024-2025
;
; BANK 2
; The free space in this bank will be used to store the password drawing
; subroutine. The subroutine itself was borrowed from the japanese version,
; though a few optimizations were required to fit in the bank.

SECTION "Bank 2 - Free space", ROMX[$7f90], BANK[2]
draw_game_over_password:
	xor		a
	call	draw_password_icon
	ld		a, 1
	call	draw_password_icon
	ld		a, 2
	call	draw_password_icon
	ld		a, 3
	jp		draw_password_icon

draw_password_icon:
	;optimization from original japanese game
	ld		[_menu_variables.password_digit_selector], a
	ld		hl, _menu_variables.password_digit0
	add		l
	ld		l, a

	push	hl
	ld		a, [_menu_variables.password_digit_selector]
	ld		hl, _password_icons_coordinates
	rst		get_array_word
	ld		d, h
	ld		e, l
	pop		hl
	ld		a, [hl]
	sla		a
	sla		a
	ld		bc, _password_icons
	rst		bc_plus_a
	ld		a, [bc]
	call	mem_copy_safe_1byte
	call	.last_row_byte
	inc		bc
	ld		a, 32 - 1
	rst		de_plus_a
	ld		a, [bc]
	call	mem_copy_safe_1byte
.last_row_byte:
	inc		bc
	inc		de
	ld		a, [bc]
	jp		mem_copy_safe_1byte

_password_icons_coordinates:
	DW $9c43 ;slot 0
	DW $9c47 ;slot 1
	DW $9c4b ;slot 2
	DW $9c4f ;slot 3

_password_icons:
	DB $00, $00, $00, $00 ;0=blank
	DB $8b, $8d, $8c, $8e ;1=carrot
	DB $8f, $91, $90, $92 ;2=dodo
	DB $93, $95, $94, $96 ;3=buster
	DB $97, $99, $98, $9a ;4=soccer ball
