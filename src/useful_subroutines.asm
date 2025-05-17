; Tiny Toon 2: Montana's Movie Madness (USA/Europe) Restoration
; by Marc Robledo @marc_robledo 2024-2025
;
; Common subroutines used in the original game and the new code as well.

SECTION "Get array word", ROM0[$0008]
get_array_word:
SECTION "bc+a", ROM0[$0018]
bc_plus_a:
SECTION "de+a", ROM0[$0020]
de_plus_a:
SECTION "Get array byte", ROM0[$0028]
hl_plus_a:
;SECTION "rst30", ROM0[$0030]
;rst30:
;SECTION "rst38", ROM0[$0038]
;rst38:
SECTION "Bank 0 - Bank switching", ROM0[$0364]
switch_bank_1:
	ld		a, 1
	ld		[$2180], a
	ret
switch_bank_2:
	ld		a, 2
	ld		[$2180], a
	ret
switch_bank_3:
	ld		a, 3
	ld		[$2180], a
	ret
switch_bank_4:
	ld		a, 4
	ld		[$2180], a
	ret
switch_bank_5:
	ld		a, 5
	ld		[$2180], a
	ret
switch_bank_6:
	ld		a, 6
	ld		[$2180], a
	ret
switch_bank_7:
	ld		a, 7
	ld		[$2180], a
	ret
bank_pop:
	pop		af
	ld		[$2180], a
	ret
SECTION "Update pressed keys", ROM0[$0212]
update_pressed_keys:
SECTION "Draw map", ROM0[$0616]
draw_map:
	ld		e, $ff ;mask
	jr		draw_map_blank.loop
draw_map_blank: ;for menu blinking purposes
	ld		e, $00 ;mask
.loop:
	;...
SECTION "Bank 0 - mem_fill_d", ROM0[$0356]
mem_fill:
SECTION "Bank 0 - mem_fill_small", ROM0[$035f]
mem_fill_small:
SECTION "Bank 0 - mem_copy", ROM0[$0499]
mem_copy:
SECTION "Bank 0 - mem_copy_safe", ROM0[$04a2]
mem_copy_safe:
SECTION "Bank 0 - compressed_mem_copy_safe", ROM0[$0265]
compressed_mem_copy_safe:
SECTION "Bank 0 - mem_copy_safe_1byte", ROM0[$0ff9]
mem_copy_safe_1byte:
SECTION "Bank 0 - mem_copy2", ROM0[$04f6]
mem_copy2:
	;seems to be an exact copy of mem_copy?



SECTION "Bank 0 - VRAM empty", ROM0[$05d1]
vram_empty_all:
	call	vram_empty_tiles
	call	$0486
	call	vram_empty_window
vram_empty_map:
	ld		hl, _SCRN0
.set_size:
	ld		bc, $0400
.loop:
	ldh		a, [rSTAT]
	bit		1, a
	jr		nz, vram_empty_map.loop
	xor		a
	ld		[hli], a
	dec		bc
	ld		a, b
	or		c
	jr		nz, vram_empty_map.loop
	ret  
vram_empty_window:
	ld		hl, _SCRN1
	jr		vram_empty_map.set_size
vram_empty_tiles:
	ld		hl, _VRAM8000
	ld		bc, $1800
	jr		vram_empty_map.loop



SECTION "Bank 0 - Add metasprite", ROM0[$3e0f]
metasprite_add:




SECTION "Bank 0 - set_menu_option", ROM0[$0fe9]
increase_menu_option:
	ld		hl, _menu_variables.current_option
	inc		[hl]
	ret
increase_menu_temp_variable1:
	ld		hl, _menu_variables.secondary_option
	inc		[hl]
	ret
set_menu_option0:
	xor		a
set_menu_option:
	ld		hl, _menu_variables.current_option
	ld		[hl], a
	ret

