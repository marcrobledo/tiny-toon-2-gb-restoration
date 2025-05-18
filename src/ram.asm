SECTION "RAM - Menu temp variables", WRAMX[$ded8], BANK[1]
_menu_variables:
.current_option: DB
.secondary_option: DB ;used in title screen 0=off, 1=password entering, 2=correct password entered
.correct_password: DB
.password_digit0: DB
.password_digit1: DB
.password_digit2: DB
.password_digit3: DB
.password_digit_selector: DB

SECTION "RAM - Health", WRAMX[$dd54], BANK[1]
_health:
SECTION "RAM - Boss health", WRAM0[$c106]
_health_boss:

SECTION "RAM - Hard mode", WRAMX[$dd59], BANK[1]
_hard_mode:
SECTION "RAM - Continues", WRAMX[$dd5e], BANK[1]
_continues:
SECTION "RAM - Lives", WRAMX[$dd62], BANK[1]
_lives:
SECTION "RAM - Score", WRAMX[$dd64], BANK[1]
_score: DS 3
SECTION "RAM - Current stage", WRAMX[$ddc2], BANK[1]
_current_stage: DB
_current_stage_room: DB

SECTION "RAM - Minigame menu option", WRAMX[$dec0], BANK[1]
_menu_option:

SECTION "HRAM - Max OAM sprites", HRAM[$ffa9]
_max_oam_sprites:
SECTION "HRAM - Extra life digit", HRAM[$ffb3]
_extra_life_digit:


SECTION "HRAM - Next loop", HRAM[$ff80]
_next_loop:
SECTION "HRAM - Frame counter", HRAM[$ff83]
_frame_counter:
SECTION "HRAM - Pressed buttons", HRAM[$ff88]
_held_buttons: DB
_pressed_buttons: DB




SECTION "HRAM - Video register values", HRAM[$ff90]
_reg_lcdc: DB
_reg_scroll_y: DB
_reg_scroll_x: DB
_reg_win_y: DB
_reg_win_x: DB
_reg_pal_bg: DB
_reg_pal_obj0: DB
_reg_pal_obj1: DB
_reg_lyc: DB
SECTION "HRAM - Hblank action", HRAM[$ffa0]
_hblank_action_current: DB
_hblank_action_next: DB
