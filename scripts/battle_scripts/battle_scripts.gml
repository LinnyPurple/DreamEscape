// Battle scripts

function num_player_alive() {
	// @desc Return the number of players currently alive
	var _result = 0;
	for (var _i = 0; _i < array_length(obj_game.p_status); _i++) {
		if (obj_game.p_status[_i] != status.dead) _result++;
	}
	return _result;
}

function num_enemy_alive() {
	// @desc Return the number of enemies currently alive
	var _result = 0;
	for (var _i = 0; _i < array_length(global.enemies); _i++) {
		show_debug_message(global.enemies[_i].enemy_status);
		if (global.enemies[_i].enemy_status != status.dead) _result++;
	}
	return _result;
}

function get_turn_order() {
	// @desc Get actions for players/enemies, will sort in another function
	// Add stuff here to check for player state
	var _player_alive = array_length(obj_game.p_name);
	var _enemy_alive = array_length(global.enemies);
	var _instance_alive = _player_alive + _enemy_alive;
	// Should have at least 1 player and enemy alive, with a max of 2 players, 3 enemies
	switch (_instance_alive) {
		case 2:
			global.turn_order = [-1, -1];
			break;
		case 3:
			global.turn_order = [-1, -1, -1];
			break;
		case 4:
			global.turn_order = [-1, -1, -1, -1];
			break;
		case 5:
			global.turn_order = [-1, -1, -1, -1, -1];
			break;
		default:
			break;
	}
	// Add player speeds and action list to global.turn_order
	for (var _i = 0; _i < _player_alive; _i++) {
		global.turn_order[_i] = [obj_game.p_spd[_i], [0]];
	}
	// Add enemy speeds and action list to global.turn_order
	var _j = _player_alive;
	while (_j < _instance_alive) {
		var _k = _j - _player_alive;
		if (global.enemies[_k].enemy_status != status.dead) global.turn_order[_j] = [global.enemies[_k].enemy_stats[enemy_stat.spd], [_k]];
		_j++;
	}
}

function set_player_action(_player, _response, _sub_response, _target) {
	// @desc Set the player's action for the turn
	// @param player_id
	// @param response_selected (e.g. FIGHT)
	// @param sub_response_selected (e.g. An item in ITEMS, otherwise set to -1)
	// @param target (e.g. An ally if healing)
	// First index indicates a player attack
	global.turn_order[_player, 1] = [0, _player, _response, _sub_response, _target];
}

function set_enemy_action(_enemy, _response, _sub_response, _target, _player_action) {
	// @desc Set the enemy's action for the turn
	// @param enemy_id
	// @param enemy_skill (e.g. Dream Cell uses Stomp)
	// @param target (e.g. Which character the enemy is attacking)
	// @param player_action (How many players will perform an action)
	if (global.enemies[_enemy].enemy_status != status.dead) {
		global.turn_order[_enemy + _player_action + 1, 1]
		= [1, _enemy, _response, _sub_response, _target];
	}
}

function set_turn_order() {
	// @desc Sets the turn order given the turn order
	for (var _i = 0; _i < array_length(global.turn_order); _i++) {
		for (var _j = _i + 1; _j < array_length(global.turn_order); _j++) {
			// Check if instance in global.turn_order[_i] isn't dead (i.e. -1)
			// and send to end of turn order
			if (typeof(global.turn_order[_i]) != "array") {
				var _temp = global.turn_order[_i];
				global.turn_order[_i] = global.turn_order[_j];
				global.turn_order[_j] = _temp;
			// Should have two values that are arrays
			} else if (typeof(global.turn_order[_j]) == "array" and global.turn_order[_i, 0] < global.turn_order[_j, 0]) {
				var _temp = global.turn_order[_i];
				global.turn_order[_i] = global.turn_order[_j];
				global.turn_order[_j] = _temp;
			}
		}
	}
}

function player_act(_player, _response, _sub_response, _target) {
	// @desc Player performs action
	// @param player_id
	// @param response_selected (e.g. FIGHT)
	// @param sub_response_selected (e.g. An item in ITEMS, otherwise set to -1)
	// @param target (e.g. An ally if healing)
	switch (_response) {
		case 0:
			// FIGHT
			var _hp_loss = (obj_game.p_stats[_player, stats.atk] + obj_game.p_boost[_player, stats.atk]) * 2
			- global.enemies[_target].enemy_stats[enemy_stat.def];
			var _variance = random_range(0.8, 1.2);
			var _crit_chance = irandom_range(1, 100);
			if (obj_game.p_stats[_player, stats.crit] + obj_game.p_boost[_player, stats.crit] >= _crit_chance) {
				_hp_loss += global.enemies[_target].enemy_stats[enemy_stat.def];
				var _crit_variance = random_range(1.5, 2);
				_hp_loss = floor(_hp_loss * _crit_variance);
				global.critical_hit = true;
			} else _hp_loss = floor(_hp_loss * _variance);
			if (_hp_loss < 0) return 0;
			return _hp_loss;
			break;
		case 1:
			// SKILL
			break;
		case 2:
			// ITEM
			break;
		case 3:
			// FLEE
			break;
		default:
			break;
	}
}