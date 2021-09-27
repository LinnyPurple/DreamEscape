// Get Player Movement
k_right = keyboard_check(vk_right);
k_up = keyboard_check(vk_up);
k_left = keyboard_check(vk_left);
k_down = keyboard_check(vk_down);
k_a = keyboard_check_pressed(ord("Z"));
k_b = keyboard_check_pressed(ord("X"));
k_start = keyboard_check_pressed(vk_enter);
k_select = keyboard_check_pressed(vk_rshift);

if (not global.game_paused) script_execute(state);