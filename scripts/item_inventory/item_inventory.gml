// Scripts to add/remove items from the inventory

function get_item(_pos) {
	// Get an item at a specific location
	if (global.inventory[_pos] == -1) return -1; // If no item exists
	return global.inventory[_pos];
}

function inventory_num() {
	// Obtain the number of items in the inventory
	var _i = 0;
	while _i < array_length(global.inventory) {
		if (get_item(_i) == -1) break;
		else _i += 1;
	}
	return _i;
}

function add_item(_item) {
	// Add item to the inventory
	var _i = 0;
	while _i < array_length(global.inventory) {
		if (global.inventory[_i] == -1) {
			global.inventory[_i] = _item;
			break;
		}
		_i += 1;
	}
}

function remove_item(_pos) {
	// Remove item from the inventory
	global.inventory[_pos] = -1;
	var _i = _pos;
	while _i < array_length(global.inventory) - 1 {
		if (global.inventory[_i + 1] != -1) {
			var _temp = global.inventory[_i];
			global.inventory[_i] = global.inventory[_i + 1];
			global.inventory[_i + 1] = _temp;
		} else {
			break;
		}
		_i += 1;
	}
}

function sort_items() {
	// Sorts the items via item_type and item_subtype
	var _limit = inventory_num();
	for (var _i = 0; _i < _limit; _i++) {
		for (var _j = _i + 1; _j < _limit; _j++) {
			if (global.inventory[_i].item_type > global.inventory[_j].item_type
			or global.inventory[_i].item_type == global.inventory[_j].item_type
			and global.inventory[_i].item_subtype > global.inventory[_j].item_subtype) {
				var _temp = global.inventory[_j];
				global.inventory[_j] = global.inventory[_i];
				global.inventory[_i] = _temp;
			}
		}
	}
}

function use_item(_item, _character) {
	// @desc Use an item from the inventory and apply its effects
	// @param _item: The item selected by the player
	// @param _character: The character to apply the item to
	var _selected_item = global.inventory[_item];
	if (_selected_item.item_type == item_kind.heal) {
		obj_game.p_stats[_character][stats.hp] += _selected_item.hp_heal;
		obj_game.p_stats[_character][stats.hp] = min(obj_game.p_stats[_character][stats.hp], obj_game.p_stats[_character][stats.maxhp]);
		obj_game.p_stats[_character][stats.dp] += _selected_item.dp_heal;
		obj_game.p_stats[_character][stats.dp] = min(obj_game.p_stats[_character][stats.dp], obj_game.p_stats[_character][stats.maxdp]);
	}
}

// Sort function made in Python3
//def sort(l):
//	for i in range(0, len(l)):
//		for j in range(i + 1, len(l)):
//			if l[i][0] > l[j][0]:
//				temp = l[j]
//				l[j] = l[i]
//				l[i] = temp
//			elif l[i][0] == l[j][0] and l[i][1] > l[j][1]:
//				temp = l[j]
//				l[j] = l[i]
//				l[i] = temp
//	return l