; Tiny Toon 2: Montana's Movie Madness (USA/Europe) Restoration
; by Marc Robledo @marc_robledo 2024-2025
;
; BANK 4
; The free space in this bank will be used to store part of the new tileset.

SECTION "Bank 4 - Free space", ROMX[$7ef0], BANK[4]
load_password_tileset_icons:
	ld		hl, _tileset_password_icons
	ld		de, $88b0
	ld		bc, 16*16
	jp		mem_copy_safe

_tileset_password_icons:
	INCBIN "password_tiles.bin", 8*16
