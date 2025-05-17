; Tiny Toon 2: Montana's Movie Madness (USA/Europe) Restoration
; by Marc Robledo @marc_robledo 2024-2025
;
; BANK 7
; The free space in this bank will be used to store the passwords themselves
; and the subroutines needed to get the current stage password (game over
; screen) and to check the password input by the player (title screen).
; There is enough space to store the password icon squares and its map.

SECTION "Bank 7 - Free space", ROMX[$7ef0], BANK[7]
_passwords:
	DB 4, 0, 1, 2 ;Western (Normal)
	DB 2, 4, 1, 4 ;Samurai (Normal)
	DB 1, 3, 0, 4 ;Future (Normal)
	DB 3, 4, 2, 0 ;Monster (Normal)
	DB 2, 0, 3, 2 ;Studio (Normal)
	DB 3, 4, 4, 3 ;Western (Hard)
	DB 0, 3, 1, 3 ;Samurai (Hard)
	DB 2, 1, 0, 4 ;Future (Hard)
	DB 4, 0, 0, 1 ;Monster (Hard)
	DB 1, 2, 4, 3 ;Studio (Hard)

;Gets the current stage password offset.
;
;@return hl current stage password offset
get_current_stage_password:
	ld		a, [_hard_mode]
	and		a
	ld		a, [_current_stage]
	jr		z, .get_source_offset
	add		5 ;hard mode passwords are stored after the first 5 normal passwords

.get_source_offset:
	sla		a
	sla		a
	ld		c, a
	ld		b, $00
	ld		hl, _passwords
	add		hl, bc

	ld		de, _menu_variables.password_digit0
	ld		c, 4
	jp		mem_copy

; Checks if the password input by player is valid.
;
; The original japanese subroutine was too big and didn't fit, so a new heavily
; optimized equivalent subroutine had to be written
check_password:
	xor		a

.loop:
	ld		b, a
	sla		a
	sla		a
	ld		de, _menu_variables.password_digit0
	ld		hl, _passwords
	rst		hl_plus_a

	ld		c, 4
.loop_check_digits:
	ld		a, [de]
	cp		[hl]
	jr		nz, .incorrect
	inc		e
	inc		hl
	dec		c
	jr		nz, .loop_check_digits

	jr		.ok

.incorrect:
	ld		a, b
	inc		a
	cp		10
	jr		nz, .loop ;keep looking for a match

.end:
	ld		a, $33
	jp		$03f0 ;japanese $03e9


.ok:
	ld		a, b
	ld		c, 0 ;normal
	cp		a, 5
	jr		c, .ok_normal
.ok_hard:
	sub		a, 5
	inc		c ;hard
.ok_normal:
	ld		[_current_stage], a
	ld		a, c
	ld		[_hard_mode], a
	;set initial data (this is set only after continuing or after the stage 1 cutscene, which won't play if we are starting at stage 2 or higher, so we force the initial data here)
	xor		a
	ld		hl, _score
	ld		[hli], a
	ld		[hli], a
	ld		[hl], a
	ld		[$dd50], a
	ld		a, 2
	ldh		[_extra_life_digit], a
	ld		[_lives], a

	ld		[_menu_variables.current_option], a ;setting bit1=1, forces to play the next stage cutscene
	jp		increase_menu_temp_variable1





load_password_tileset_squares_and_draw_map:
	ld		hl, _tileset_password_squares
	ld		de, $8850
	ld		bc, 16 * 4
	call	mem_copy_safe
	;ld		hl, _compressed_map_password_squares ;can be skipped since tiles and map are stored sequentially
	ld		de, $9c00
	;ld		bc, $00c0
	ld		c, $c0 ;optimization, since it's guaranteed b will always be 0 at this point
	jp		compressed_mem_copy_safe




_tileset_password_squares:
	INCBIN "password_tiles.bin", 4*16, 4*16

_compressed_map_password_squares:
	;borrowed from japanese game
	DB $cd, $00, $de, $7f, $88, $88, $ff, $6b, $df, $6c, $85, $00, $63, $00, $86, $20, $09, $10, $1f, $df, $6c, $87, $87, $5f, $0b, $00, $70, $1f, $7c, $08, $ff