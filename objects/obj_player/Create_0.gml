state = player_state_free;
last_state = state;

collision_map = layer_tilemap_get_id(layer_get_id("TS_Layer_Collision"));

image_speed = 0;
speed_x = 0;
speed_y = 0;
speed_walk = 1;
moving = false;
sprite_idle = spr_player_m;
sprite_walk = spr_player_m_walk;
steps = 0;
dir = global.target_direction;
collision = false;
mod_four_hit = false;

if (global.target_x != -1) {
	x = global.target_x;
	y = global.target_y;
	dir = global.target_direction;
	if (dir == 0) obj_player.image_index = 0;
	else if (dir == 90) obj_player.image_index = 1;
	else if (dir == 180) obj_player.image_index = 2;
	else obj_player.image_index = 3;
}