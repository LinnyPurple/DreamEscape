// Equip scripts

function equip_add_stats(_equip, _player) {
	// @desc Add stats when equipping an item
	// @param equipment_slot
	// @param player
	obj_game.p_boost[_player][stats.maxhp] += obj_game.p_equip[_player][_equip].hp_add;
	obj_game.p_boost[_player][stats.maxdp] += obj_game.p_equip[_player][_equip].dp_add;
	obj_game.p_boost[_player][stats.atk] += obj_game.p_equip[_player][_equip].atk_add;
	obj_game.p_boost[_player][stats.def] += obj_game.p_equip[_player][_equip].def_add;
	obj_game.p_boost[_player][stats.mag] += obj_game.p_equip[_player][_equip].mag_add;
	obj_game.p_boost[_player][stats.spd] += obj_game.p_equip[_player][_equip].spd_add;
	show_debug_message(obj_game.p_boost[_player]);
	
}

function equip_remove_stats(_equip, _player) {
	// @desc Remove stats when removing or replacing an equipped item
	// @param equipment_slot
	// @param player
	obj_game.p_boost[_player][stats.maxhp] -= obj_game.p_equip[_player][_equip].hp_add;
	obj_game.p_boost[_player][stats.maxdp] -= obj_game.p_equip[_player][_equip].dp_add;
	obj_game.p_boost[_player][stats.atk] -= obj_game.p_equip[_player][_equip].atk_add;
	obj_game.p_boost[_player][stats.def] -= obj_game.p_equip[_player][_equip].def_add;
	obj_game.p_boost[_player][stats.mag] -= obj_game.p_equip[_player][_equip].mag_add;
	obj_game.p_boost[_player][stats.spd] -= obj_game.p_equip[_player][_equip].spd_add;
	show_debug_message(obj_game.p_boost[_player]);
}

function equip(_inventory, _equip, _player) {
	// @desc Equip item onto player
	// @param inventory_slot
	// @param equipment_slot
	// @param player
	var _temp = obj_game.p_equip[_player][_equip]; // Equipment slot for player
	if (_temp != -1) equip_remove_stats(_equip, _player);
	obj_game.p_equip[_player][_equip] = global.inventory[_inventory];
	if (_temp == -1) { // Check if anything is equipped in slot for player
		remove_item(_inventory);
		equip_add_stats(_equip, _player);
	} else { // Something is already equipped for said player
		global.inventory[_inventory] = _temp;
		equip_add_stats(_equip, _player);
	}
}

function equip_into_inventory(_equip, _player) {
	// @desc Places equipped item back into the inventory (if possible)
	// @param equipment_slot
	// @param player
	if (inventory_num() < array_length(global.inventory)) {
		global.inventory[inventory_num()] = obj_game.p_equip[_player][_equip];
		equip_remove_stats(_equip, _player);
		obj_game.p_equip[_player][_equip] = -1;
		text_box("Item removed!");
	// TODO: DOESN'T WORK BELOW, FIX IN THE MORNING
	} else {
		text_box("Cannot place back\nsince inventory is\nfull.", 0);
	}
}