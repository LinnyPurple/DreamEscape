/// @description Update menu

with (obj_player) {
	if (state != player_state_item
	and state != player_state_skill
	and state != player_state_equip
	and state != player_state_stats) {
		state = player_state_menu;
	}
}

// Cycle through responses (MENU)
k_up = keyboard_check_pressed(vk_up);
k_down = keyboard_check_pressed(vk_down);
k_left = keyboard_check_pressed(vk_left);
k_right = keyboard_check_pressed(vk_right);
if (obj_player.state == player_state_menu) response_selected += (k_down - k_up);
var _min = 0;
var _max = array_length(menu_pages) - 1;
if (response_selected > _max) response_selected = _min;
if (response_selected < _min) response_selected = _max;

// ITEM
var _item_hmin = 0;
var _item_hmax = floor((inventory_num() - 1) / items_per_page);
if (inventory_num() == 0) _item_hmax = 0;
var _item_vmin = 0;
var _item_vmax = items_per_page - 1;
var _item_selected_min = 0;
var _item_selected_max = array_length(item_pages) - 1;
// Make sure an item exists while not showing description of said item
// Or scrolling through items to equip
if (obj_player.state == player_state_item and inventory_num() != 0
and not instance_exists(obj_textbox) and not item_selected
or (obj_player.state == player_state_equip and equipping_item)) {
	item_response_selected[0] += (k_right - k_left);
	item_response_selected[1] += (k_down - k_up);
// Scrolls through the USE, INFO, DROP section of the items
} else if (item_selected and not instance_exists(obj_textbox)) {
	item_selected_response_selected += (k_down - k_up);
}
if (item_response_selected[0] > _item_hmax) item_response_selected[0] = _item_hmin;
if (item_response_selected[0] < _item_hmin) item_response_selected[0] = _item_hmax;
if (item_selected_response_selected > _item_selected_max) item_selected_response_selected = _item_selected_min;
if (item_selected_response_selected < _item_selected_min) item_selected_response_selected = _item_selected_max;
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

// EQUIP
var _equip_hmin = 0; // Switching between the characters
var _equip_hmax = array_length(obj_game.p_name) - 1; // Should have two members
var _equip_vmin = 0; // Switching between the different types of equipment
var _equip_vmax = array_length(obj_game.p_equip[equip_response_selected[0]]) - 1;
var _equip_response_min = 0; // Used for "Remove" and "Replace"
var _equip_response_max = array_length(removing_equip_responses) - 1;
if (obj_player.state == player_state_equip and not equipping_item and not removing_equip
and not instance_exists(obj_textbox)) {
	equip_response_selected[0] += (k_right - k_left);
	equip_response_selected[1] += (k_down - k_up);
} else if (removing_equip) removing_equip_responses_selected += (k_down - k_up);
if (equip_response_selected[0] > _equip_hmax) equip_response_selected[0] = _equip_hmin;
if (equip_response_selected[0] < _equip_hmin) equip_response_selected[0] = _equip_hmax;
if (equip_response_selected[1] > _equip_vmax) equip_response_selected[1] = _equip_vmin;
if (equip_response_selected[1] < _equip_vmin) equip_response_selected[1] = _equip_vmax;
if (removing_equip_responses_selected > _equip_response_max) removing_equip_responses_selected = _equip_response_min;
if (removing_equip_responses_selected < _equip_response_min) removing_equip_responses_selected = _equip_response_max;

// STATS
var _stats_min = 0;
var _stats_max = array_length(obj_game.p_name) - 1; // Should have two members
if (obj_player.state == player_state_stats) {
	stats_response_selected += (k_right - k_left);
}
if (stats_response_selected > _stats_max) stats_response_selected = _stats_min;
if (stats_response_selected < _stats_min) stats_response_selected = _stats_max;


// Pressing "A" ("Z" on keyboard)
if (obj_player.k_a) {
	if (obj_player.state == player_state_menu) {
		switch (response_selected) {
			case 0:
				// ITEM
				obj_player.state = player_state_item;
				break;
			case 1:
				// SKILL
				obj_player.state = player_state_skill;
				break;
			case 2:
				// EQUIP
				obj_player.state = player_state_equip;
				break;
			case 3:
				// STATS
				obj_player.state = player_state_stats;
				stats_response_selected = 0;
				break;
			case 4:
				// QUIT
				instance_destroy();
				with (obj_player) state = player_state_free;
				break;
			default:
				break;
		}
	} else if (obj_player.state == player_state_item) {
		// Make sure an item isn't selected
		if (inventory_num() != 0 and not item_selected and not instance_exists(obj_textbox)) {
			item_selected = true;
			item_selected_response_selected = 0;
		} else {
			switch (item_selected_response_selected) {
				case 0:
					// USE
					// Find a way to use the item here
					break;
				case 1:
					// INFO
					if (not instance_exists(obj_textbox)) {
						var _selected_item = item_response_selected[0] * items_per_page + item_response_selected[1];
						text_box(global.inventory[_selected_item].item_description, 0);
					}
					break;
				case 2:
					// DROP
					// Remove the item from the items (if possible)
					var _selected_item = item_response_selected[0] * items_per_page + item_response_selected[1];
					if (global.inventory[_selected_item].item_removable) {
						remove_item(_selected_item);
						if (not instance_exists(obj_textbox)) {
							text_box("Removed item!", 0);
						}
						item_selected = false;
						item_selected_response_selected = 0;
					} else { // Cannot remove item
						if (not instance_exists(obj_textbox)) {
							text_box("Cannot remove\nitem! Must be\nimportant...", 0);
						}
					}
					break;
				default:
					break;
			}
		}
	} else if (obj_player.state == player_state_equip) {
		// Go into process of equpping item
		if (equipping_item) {
			var _selected_item = item_response_selected[0] * items_per_page + item_response_selected[1];
			if (global.inventory[_selected_item].item_equippable[equip_response_selected[0]]
			and not instance_exists(obj_textbox)) {
				equip(_selected_item, equip_response_selected[1], equip_response_selected[0]);
				equipping_item = false;
			} else if (not instance_exists(obj_textbox)) {
				text_box("This item cannot\nbe equipped!", 0);
			}
		} else if (obj_game.p_equip[equip_response_selected[0]][equip_response_selected[1]] == -1
		and inventory_num() != 0 and not instance_exists(obj_textbox)) {
			equipping_item = true;
		}
		else if (obj_game.p_equip[equip_response_selected[0]][equip_response_selected[1]] != -1
		and not instance_exists(obj_textbox) and not removing_equip) {
			removing_equip = true;
			removing_equip_responses_selected = 0;
		}
		else if (not instance_exists(obj_textbox) and not instance_exists(obj_textqueue) and not removing_equip) text_box("No items", 0);
		else if (removing_equip) {
			switch (removing_equip_responses_selected) {
				case 1:
					// REMOVE
					equip_into_inventory(equip_response_selected[1], equip_response_selected[0]);
					break;
				case 0:
					// REPLACE
					equipping_item = true;
					break;
				default:
					break;
			}
			removing_equip = false;
		}
	}
}

// Pressing "B" ("X" on keyboard)
if (obj_player.k_b) {
	if (obj_player.state == player_state_menu) {
		instance_destroy();
		with (obj_player) state = player_state_free;
	} else if (not instance_exists(obj_textbox)) {
		switch (response_selected) {
			case 0:
				// ITEM
				if (item_selected) item_selected = false;
				else obj_player.state = player_state_menu;
				break;
			case 1:
				// SKILL
				obj_player.state = player_state_menu;
				break;
			case 2:
				// EQUIP
				if (equipping_item) equipping_item = false;
				else if (removing_equip) removing_equip = false;
				else obj_player.state = player_state_menu;
				break;
			case 3:
				// STATS
				obj_player.state = player_state_menu;
				break;
			case 4:
				// QUIT
				instance_destroy();
				with (obj_player) state = player_state_free;
				break;
			default:
				break;
		}
	}
}