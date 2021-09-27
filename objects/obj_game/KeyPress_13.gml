/// @description Bring up the menu

if (obj_player.state != player_state_menu
and obj_player.state != player_state_transition
and obj_player.state != player_state_locked
and obj_player.state != player_state_battle
and obj_player.x % TILE_SIZE == 0
and obj_player.y % TILE_SIZE == 0) {
	instance_create_layer(0, 0, "Instances", obj_menu);
}