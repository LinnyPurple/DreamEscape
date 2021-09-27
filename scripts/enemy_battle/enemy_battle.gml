// Enemy scripts in battle
function enemy_in_battle() {
	// @desc Generate the number of enemies in the battle
	var _num_enemy = irandom_range(0, 9);
	if (_num_enemy >= 0 and _num_enemy <= 3) return 1;		// 40% to spawn 1 enemy
	else if (_num_enemy >= 4 and _num_enemy <= 6) return 2;	// 30% to spawn 2 enemies
	else if (_num_enemy >= 7 and _num_enemy <= 9) return 3;	// 20% to spawn 3 enemies
}

function enemy_list(_eib) {
	// @desc Create a list for the enemies
	// @param number_of_enemies
	switch (_eib) {
		case 1:
			global.enemies = [-1];
			break;
		case 2:
			global.enemies = [-1, -1];
			break;
		case 3:
			global.enemies = [-1, -1, -1];
			break;
		default:
			show_debug_message("SOMETHING WENT WRONG WITH THE ENEMY LIST GENERATOR");
			break;
	}
}

function get_enemy(_id) {
	// @desc Get enemy for battle
	// @param enemy_kind
	switch (_id) {
		case enemy_kind.e_dream_cell:
			return new enemy_dream_cell();
			break;
		case enemy_kind.e_dream_cell_2:
			return new enemy_dream_cell_2();
			break
		default:
			break;
	}
}

function generate_enemy_group(_rm) {
	// @desc Generate the enemies for the battle
	// @param room_id
	var _enemy = enemy_in_battle();
	enemy_list(_enemy);
	switch (_rm) {
		case r_town:
			for (var _i = 0; _i < array_length(global.enemies); _i++) {
				var _random = irandom_range(0, 1);
				if (_random == 0) global.enemies[_i] = get_enemy(enemy_kind.e_dream_cell);
				else if (_random == 1) global.enemies[_i] = get_enemy(enemy_kind.e_dream_cell_2);
				instance_create_depth(0, 0, -999, obj_enemy);
			}
			break;
		default:
			break;
	}
}

function enemy_total_width() {
	// @desc Get the width of all the enemies in global.enemies (for placement)
	var _total_width = 0;
	for (var _i = 0; _i < array_length(global.enemies); _i++) {
		_total_width += sprite_get_width(global.enemies[_i].enemy_sprite);
	}
	return _total_width;
}

function enemy_largest_height() {
	// @desc Get the enemy with the largest pixel height in global.enemies (for placement)
	if (not instance_exists(obj_enemy)) return 0; // If no enemies exist
	var _largest = 0;
	for (var _i = 0; _i < array_length(global.enemies); _i++) {
		if (_largest < sprite_get_height(global.enemies[_i].enemy_sprite)) _largest = sprite_get_height(global.enemies[_i].enemy_sprite);
	}
	return _largest;
}

function enemy_left_side() {
	// @desc Get left-most area to place enemies
	var _left = floor((GAME_X - enemy_total_width()) / 2);
	// if (_left % 8 != 0) return _left + 4;
	// else return _left;
	return _left;
}

function enemy_middle(_inst_num) {
	// @desc Get middle of enemy's location on the screen
	// @param inst_num
	var _left = enemy_left_side();
	for (var _i = 0; _i < array_length(global.enemies); _i++) {
		if (_i != _inst_num) _left += sprite_get_width(global.enemies[_i].enemy_sprite);
		else return _left + sprite_get_width(global.enemies[_i].enemy_sprite) / 2;
	}
}

function place_enemy(_inst_num) {
	// @desc Place each enemy according to instance number
	// @param inst_num
	var _left = enemy_left_side();
	for (var _i = 0; _i < array_length(global.enemies); _i++) {
		if (_i != _inst_num) _left += sprite_get_width(global.enemies[_i].enemy_sprite);
		else {
			var _height = sprite_get_height(global.enemies[_i].enemy_sprite);
			draw_sprite(global.enemies[_i].enemy_sprite, 0, _left, TILE_SIZE * 4 - _height);
		}
	}
}

function enemy_exists(_inst_num) {
	// @desc Check if an enemy with instance number exists
	// @param inst_num
	with (obj_enemy) {
		if (inst_num == _inst_num) return true;
	}
	return false;
}

function set_enemy_select() {
	// @desc Set the enemy select (usually after enemies are dead)
	with (obj_enemy) {
		return inst_num;
	}
}