/// @description Sort items

sort_items();
if (instance_exists(obj_battle)) {
	if (obj_battle.enemy_y2 == GAME_Y) {
		obj_battle.enemy_y1 = 0;
		obj_battle.enemy_y2 = TILE_SIZE * 1.5;
	} else {
		obj_battle.enemy_y1 = GAME_Y - TILE_SIZE * 1.5;
		obj_battle.enemy_y2 = GAME_Y;
	}
}
// global.scale = 10;
// window_set_size(GAME_X * global.scale, GAME_Y * global.scale);