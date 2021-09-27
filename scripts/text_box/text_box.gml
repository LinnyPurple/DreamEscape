/// @desc Textbox
/// @param message
/// @param background
/// @param responses
function text_box() {

	var _obj;

	if (instance_exists(obj_textbox)) _obj = obj_textqueue; else _obj = obj_textbox;
	// _obj = obj_textbox;
	with (instance_create_layer(0, 0, "Instances", _obj)) {
		message = argument[0];
		if (instance_exists(other)) origin_instance = other.id; else origin_instance = noone;
		if (argument_count > 1) textbox_background = argument[1]; else textbox_background = 0;
		if (argument_count > 2) {
			// Trim markers from responses
			responses = argument[2];
			obj_textbox.r_x1 = GAME_X - TILE_SIZE * (array_max_length(responses) / 2 + 3 / 2);
			obj_textbox.r_y1 = GAME_Y - TILE_SIZE * (array_length(responses) - 2 + 6.5);
			for (var _i = 0; _i < array_length(responses); _i++) {
				var _marker_position = string_pos(":", responses[_i]);
				response_scripts[_i] = string_copy(responses[_i], 1, _marker_position - 1);
				response_scripts[_i] = response_scripts[_i];
				responses[_i] = string_delete(responses[_i], 1, _marker_position);
			}
		} else {
			responses = [-1];
			response_scripts = [-1];
		}
	}
	with (obj_player) {
		if (state != player_state_locked
		and state != player_state_item
		and state != player_state_equip) {
			last_state = state;
			state = player_state_locked;
		}
	}


}
