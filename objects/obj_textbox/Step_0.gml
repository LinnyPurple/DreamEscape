/// @description Update the textbox

text_progress += global.text_speed;

// Cycle through responses
k_up = keyboard_check_pressed(vk_up);
k_down = keyboard_check_pressed(vk_down);
response_selected += (k_down - k_up);
var _min = 0;
var _max = array_length(responses) - 1;
if (response_selected > _max) response_selected = _min;
if (response_selected < _min) response_selected = _max;

if (keyboard_check_pressed(ord("Z"))) {
	var _message_length = string_length(message);
	if (text_progress >= _message_length) {
		if (responses[0] != -1) {
			with (origin_instance) {
				if (obj_player.state == player_state_equip) {
					menu_events(other.response_scripts[other.response_selected]);
				} else response_events(other.response_scripts[other.response_selected]);
			}
		}
		instance_destroy();
		if (instance_exists(obj_textqueue)) {
			with (obj_textqueue) ticket--;
		} else {
			with (obj_player) state = last_state;
			global.in_text = false;
		}
	} else {
		if (text_progress > 2) {
			text_progress = _message_length;
		}
	}
}