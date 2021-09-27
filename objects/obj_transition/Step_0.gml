/// @description Progress transition

with (obj_player) state = player_state_transition;

if (type == transition_type.rm) {
	obj_transition.sprite_index = spr_transition_2;
}

obj_transition.x = camera_get_view_x(view_camera[0]);
obj_transition.y = camera_get_view_y(view_camera[0]);
obj_transition.image_xscale = 8;
obj_transition.image_yscale = 8;
sub_sprites = obj_transition.image_number;

if (leading == OUT) {
	if (obj_transition.image_index == sub_sprites - 1) {
		leading = IN;
		room_goto(target);
	}
} else { // leading == IN
	obj_transition.image_speed = -1;
	if (room != r_battle) {
		obj_player.x = global.target_x;
		obj_player.y = global.target_y;
		obj_player.dir = global.target_direction;
	}
	if (obj_transition.image_index == 0) {
		with (obj_player) state = player_state_free;
		obj_transition.sprite_index = -1;
		if (room == r_battle) {
			instance_create_depth(0, 0, -9999, obj_battle);
			with (obj_player) state = player_state_battle;
		}
		instance_destroy();
	}
}