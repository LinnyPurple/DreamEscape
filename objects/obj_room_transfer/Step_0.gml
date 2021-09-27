/// @description Cause a room transition

var _dir_pos_check;
if (obj_player.dir == 180) {
	_dir_pos_check = position_meeting(obj_player.x + TILE_SIZE - 1, obj_player.y, id);
} else if (obj_player.dir == 90) {
	_dir_pos_check = position_meeting(obj_player.x, obj_player.y + TILE_SIZE - 1, id);
} else {
	_dir_pos_check = position_meeting(obj_player.x, obj_player.y, id);
}

if (instance_exists(obj_player) and _dir_pos_check) {
	global.target_room = target_room;
	global.target_x = target_x;
	global.target_y = target_y;
	obj_player.direction = obj_player.dir;
	global.target_direction = obj_player.direction;
	with (obj_player) state = player_state_transition;
	room_transition(transition_type.rm, target_room);
	instance_destroy();
}