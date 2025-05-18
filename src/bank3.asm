; Tiny Toon 2: Montana's Movie Madness (USA/Europe) Restoration
; by Marc Robledo @marc_robledo 2024-2025
;
; BANK 3
; This bank contains the Game Over map that is only shown when losing all
; continues or after finishing game and covers the CONTINUE and END words

SECTION "Bank 3 - Game Over (after finishing game)", ROMX[$4c85], BANK[3]
DW $98a5
;DB "GAME  OVER   ", $fe
DB "             ", $fe
;DW $9845
DW $9865 ;cover CONTINUE
DB $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $fe
DW $98e6 ;cover END
DB $00, $00, $00, $00, $ff