; Tiny Toon 2: Montana's Movie Madness (USA/Europe) Restoration
; by Marc Robledo @marc_robledo 2024-2025
;
; Code replacements for:
; - set extra life requirements from 3000 to 2000
; - earn an extra life instead of a continue after winning a minigame

;EXTRA LIFE REQUIREMENTS DECREASE (from 3000 points to 2000)
SECTION "Set initial extra life digit (title screen)", ROMX[$40ef], BANK[5]
ld		a, 3 - 1
ldh		[_extra_life_digit], a
SECTION "Set initial extra life digit (after first cutscene)", ROMX[$6e2c], BANK[2]
ld		a, 3 - 1
ldh		[_extra_life_digit], a
SECTION "Increase extra life digit (after reaching minimum score)", ROM0[$05a1]
ld		a, 3 - 1
SECTION "Reset extra life digit (after continuing)", ROMX[$4ae7], BANK[5]
ld		a, 3 - 1
ldh		[_extra_life_digit], a



;EARN AN EXTRA LIFE INSTEAD OF CONTINUE AFTER WINNING MINIGAME
SECTION "Increase continue after winning minigame", ROM0[$3de6]
/*earn_continue:
	ld		a, [_continues]
	inc		a
	cp		a, 9
	jr		c, .store
	ld		a, 9
.store:
	ld		[_continues], a
*/
earn_extra_life:
	ld		a, [_lives]
	add		a, 1
	daa
	jr		nc, .store
	ld		a, $99
.store:
	ld		[_lives], a

SECTION "Extra continue dialogue after winning minigame", ROMX[$7677], BANK[2]
DB "WELL DONE! YOU'VE", $fe
;DB "EARNED 1 CONTINUE!", $ff
DB "EARNED 1 LIFE!", $ff
REPT 4
	nop
ENDR
SECTION "Extra continue dialogue after winning minigame (END)", ROMX[$769c], BANK[2]
DB $c2