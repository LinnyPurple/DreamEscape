/// @description Update battle

if (check) {
	get_turn_order();
	check = false;
}

// Cycle through responses (MENU)
k_up = keyboard_check_pressed(vk_up);
k_down = keyboard_check_pressed(vk_down);
k_left = keyboard_check_pressed(vk_left);
k_right = keyboard_check_pressed(vk_right);
if (b_state == battle_state.battle_choose) response_selected += (k_down - k_up);
var _min = 0;
var _max = array_length(menu_options) - 1;
if (response_selected > _max) response_selected = _min;
if (response_selected < _min) response_selected = _max;

// FIGHT
var _enemy_min = 0;
var _enemy_max = array_length(global.enemies) - 1;
if (b_state == battle_state.battle_enemy_select) enemy_response_selected += (k_right - k_left);
// Scroll through the enemies if selecting one to attack
while (not enemy_exists(enemy_response_selected) and instance_exists(obj_enemy)
and attack_progress == 0) {
	if (k_left) enemy_response_selected -= 1;
	else if (k_right) enemy_response_selected += 1;
	if (enemy_response_selected > _enemy_max) enemy_response_selected = _enemy_min;
	if (enemy_response_selected < _enemy_min) enemy_response_selected = _enemy_max;
}

// ITEM
var _item_hmin = 0;
var _item_hmax = floor((inventory_num() - 1) / items_per_page);
if (inventory_num() == 0) _item_hmax = 0;
var _item_vmin = 0;
var _item_vmax = items_per_page - 1;
// Make sure an item exists while not showing description of said item
if (b_state == battle_state.battle_item and inventory_num() != 0 and not instance_exists(obj_textbox)) {
	item_response_selected[0] += (k_right - k_left);
	item_response_selected[1] += (k_down - k_up);
}
if (item_response_selected[0] > _item_hmax) item_response_selected[0] = _item_hmin;
if (item_response_selected[0] < _item_hmin) item_response_selected[0] = _item_hmax;
// Change _item_vmax if page isn't full
var _limit = item_response_selected[0];
for (var _i = _limit * items_per_page; _i < (_limit + 1) * items_per_page; _i++) {
	if (global.inventory[_i] == -1) {
		var _j = _i % items_per_page;
		_item_vmax = _j - 1;
		break;
	}
}
if (item_response_selected[1] > _item_vmax) item_response_selected[1] = _item_vmin;
if (item_response_selected[1] < _item_vmin) item_response_selected[1] = _item_vmax;

if (obj_player.k_a) {
	switch (b_state) {
		case battle_state.battle_start:
			break;
		case battle_state.battle_choose:
			switch (response_selected) {
			case 0:
				// FIGHT
				image_index = 0;
				if (instance_exists(obj_enemy)) b_state = battle_state.battle_enemy_select;
				break;
			case 1:
				// SKILL
				break;
			case 2:
				// ITEM
				b_state = battle_state.battle_item;
				break;
			case 3:
				// FLEE
				break;
			default:
				break;
			}
			break;
		case battle_state.battle_skill:
			break;
		case battle_state.battle_item:
			break;
		case battle_state.battle_enemy_select:
			// set_turn_order();
			if (attack_progress == 0) {
				set_player_action(player_action, response_selected, enemy_response_selected, enemy_response_selected);
				// Check if second player has chosen to attack
				if (player_action == 1) {
					// Set enemy actions
					for (var _i = 0; _i < array_length(global.enemies); _i++) {
						set_enemy_action(_i, 0, 0, 0, player_action);
					}
					set_turn_order();
					show_debug_message(global.turn_order);
					attack_progress += 1;
				} else {
					player_action += 1;
					b_state = battle_state.battle_choose;
				}
			}
			break;
		default:
			break;
	}
}

if (obj_player.k_b) {
	switch (b_state) {
		case battle_state.battle_start:
			break;
		case battle_state.battle_choose:
			if (player_action == 1) {
				player_action -= 1;
			}
			break;
		case battle_state.battle_skill:
			b_state = battle_state.battle_choose;
			break;
		case battle_state.battle_item:
			b_state = battle_state.battle_choose;
			break;
		case battle_state.battle_enemy_select:
			b_state = battle_state.battle_choose;
			break;
		default:
			break;
	}
}

switch (attack_progress) {
	case 0:
		break;
	case 1:
		// Go through turn order to see who should move
		// Work on getting the players to attack first before doing anything with
		// the enemies
		if (b_acting >= array_length(global.turn_order)
		or global.turn_order[b_acting] == -1) {
			attack_progress = 5;
		} else {
			var _action = global.turn_order[b_acting, 1];
			if (_action[0] == 0) { // Confirming a player is performing an action
				// Choose player who is attacking first
				player_action = _action[1]; // Which player (0 or 1)
				response_selected = _action[2]; // FIGHT, SKILL, ITEM, FLEE (0 to 3)
				enemy_response_selected = _action[3]; // Enemy to attack (0 to 2)
				// If player/enemy is moving later but target is dead, change target
				while (global.enemies[enemy_response_selected].enemy_status == status.dead) {
					enemy_response_selected = irandom_range(0, array_length(global.enemies) - 1);
				}
				attack_progress += 1;
			} else if (b_acting != array_length(global.turn_order)
			and global.turn_order[b_acting] != -1) {
				b_acting += 1;
			}
		}
		break;
	case 2:
		// SHOW ATTACK ANIMATION
		if (animation_progress < sprite_get_number(spr_ani_slash_1) * animation_wait - 1) {
			animation_progress += 1;
		} else {
			// Setup for damage showing
			damage_dealt = player_act(player_action, response_selected, enemy_response_selected, enemy_response_selected);
			var _damage_string = string(damage_dealt);
			for (var _i = 0; _i < string_length(_damage_string); _i++) {
				damage_array[_i] = real(string_char_at(_damage_string, _i + 1));
			}
			while (damage_array[damage_length] != -1) {
				damage_length += 1;
			}
			attack_progress += 1;
		}
		break;
	case 3:
		// SHOW DAMAGE DEALT
		if (damage_progress < damage_wait) damage_progress += 1;
		else attack_progress += 1;
		break;
	case 4:
		// KILL ENEMY
		// Reset stuff
		player_action = 0;
		animation_progress = 0;
		damage_array = [-1, -1, -1, -1, -1, -1, -1, -1, -1];
		damage_length = 0;
		damage_progress = 0;
		global.critical_hit = false;
		with (obj_enemy) {
			if (inst_num == obj_battle.enemy_response_selected) {
				global.enemies[inst_num].enemy_stats[enemy_stat.hp] -= obj_battle.damage_dealt;
				if (global.enemies[inst_num].enemy_stats[enemy_stat.hp] <= 0) {
					global.enemies[inst_num].enemy_stats[enemy_stat.hp] = 0;
					global.enemies[inst_num].enemy_status = status.dead;
					instance_destroy(self);
				}
			}
		}
		damage_dealt = 0;
		b_acting += 1;
		attack_progress = 1;
		break;
	case 5:
		// End turn if everyone has gone
		attack_progress = 0;
		b_acting = 0;
		check = true;
		// Reset enemy select (if one exists)
		if (instance_exists(obj_enemy)) enemy_response_selected = obj_enemy.inst_num;
		b_state = battle_state.battle_choose;
		break;
	default:
		break;
}

if (not instance_exists(obj_enemy)) {
	text_box("All enemies have\nbeen defeated!\nGood work!");
	instance_destroy(obj_battle);
}