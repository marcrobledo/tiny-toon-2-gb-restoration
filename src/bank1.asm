; Tiny Toon 2: Montana's Movie Madness (USA/Europe) Restoration
; by Marc Robledo @marc_robledo 2024-2025
;
; BANK 1
; The free space in this bank will be used to store part of the new tileset.

SECTION "Bank 1 - Free space", ROMX[$7fab], BANK[1]
load_password_tileset_selector:
	ld		hl, _tileset_password_selector
	ld		de, $8010
	ld		bc, 3*16
	jp		mem_copy_safe

_tileset_password_selector:
	INCBIN "password_tiles.bin", 1*16, 3*16
