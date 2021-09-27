/// @description Draw menu

text_box_slice(spr_textbox, x1, y1, x2, y2, textbox_background);
draw_set_font(f_text);
draw_set_color(global.text_color);

for (var _i = 0; _i < array_length(menu_pages); _i++) {
	if (_i == response_selected) {
		draw_text(x1 + TILE_SIZE / 2, y1 + TILE_SIZE * (_i), ">" + menu_pages[_i]);
	} else if (_i != response_selected) {
		draw_text(x1 + TILE_SIZE / 2, y1 + TILE_SIZE * (_i), " " + menu_pages[_i]);
	}
}

if (obj_player.state != player_state_menu) {
	switch (response_selected) {
		case 0:
			// ITEM
			text_box_slice(spr_textbox, 0, 0, x1, GAME_Y - TILE_SIZE * 1.5, textbox_background);
			draw_text(TILE_SIZE / 2, 0, menu_pages[response_selected]);
			var _limit = item_response_selected[0];
			var _limit0 = _limit * items_per_page;
			// How many items are items
			for (var _i = _limit * items_per_page; _i < (_limit + 1) * items_per_page; _i++) {
				if (global.inventory[_i] != -1) _limit0 = _i + 1;
			}
			for (var _i = _limit * items_per_page; _i < _limit0; _i++) {
				var _j = _i % items_per_page;
				// FIGURE OUT HOW TO DO ARROW STUFF IF PAGE IS NOT FULL
				if (_i == item_response_selected[1] + _limit * items_per_page) {
					draw_text(TILE_SIZE / 2, TILE_SIZE * (1 + _j), ">" + global.inventory[_i].item_name);
				} else if (_i != item_response_selected[1]) {
					draw_text(TILE_SIZE / 2, TILE_SIZE * (1 + _j), " " + global.inventory[_i].item_name);
				}
			}
			if (item_selected) {
				text_box_slice(spr_textbox, x1 + TILE_SIZE / 2, y1, x2, y2 - TILE_SIZE * 2, textbox_background);
				for (var _i = 0; _i < array_length(item_pages); _i++) {
					if (_i == item_selected_response_selected) {
						draw_text(x1 + TILE_SIZE, y1 + TILE_SIZE * _i, ">" + item_pages[_i]);
					} else {
						draw_text(x1 + TILE_SIZE, y1 + TILE_SIZE * _i, " " + item_pages[_i]);
					}
				}
			}
			break;
		case 1:
			// SKILL
			text_box_slice(spr_textbox, 0, 0, x1, GAME_Y - TILE_SIZE * 1.5, textbox_background);
			draw_text(TILE_SIZE / 2, 0, menu_pages[response_selected]);
			break;
		case 2:
			// EQUIP
			text_box_slice(spr_textbox, 0, 0, x1, GAME_Y - TILE_SIZE * 2, textbox_background);
			if (equipping_item) {
				text_box_slice(spr_textbox, 0, 0, x1, GAME_Y - TILE_SIZE * 1.5, textbox_background);
				draw_text(TILE_SIZE / 2, 0, menu_pages[response_selected]);
				var _limit = item_response_selected[0];
				var _limit0 = _limit * items_per_page;
				// How many items are items
				for (var _i = _limit * items_per_page; _i < (_limit + 1) * items_per_page; _i++) {
					if (global.inventory[_i] != -1) _limit0 = _i + 1;
				}
				for (var _i = _limit * items_per_page; _i < _limit0; _i++) {
					var _j = _i % items_per_page;
					// FIGURE OUT HOW TO DO ARROW STUFF IF PAGE IS NOT FULL
					if (_i == item_response_selected[1] + _limit * items_per_page) {
						draw_text(TILE_SIZE / 2, TILE_SIZE * (1 + _j), ">" + global.inventory[_i].item_name);
					} else if (_i != item_response_selected[1]) {
						draw_text(TILE_SIZE / 2, TILE_SIZE * (1 + _j), " " + global.inventory[_i].item_name);
					}
				}
			} else { // Show equipped items for each player
				draw_text(TILE_SIZE / 2, 0, menu_pages[response_selected]);
				draw_text(TILE_SIZE / 2, TILE_SIZE, obj_game.p_name[equip_response_selected[0]]);
				draw_text(TILE_SIZE, TILE_SIZE * 2, "Weapon:");
				draw_text(TILE_SIZE, TILE_SIZE * 3, "Armor:");
				draw_text(TILE_SIZE, TILE_SIZE * 4, "Acces.:");
				draw_text(TILE_SIZE, TILE_SIZE * 5, "Acces.:");
				for (var _i = 0; _i < array_length(obj_game.p_equip[equip_response_selected[0]]); _i++) {
					if (obj_game.p_equip[equip_response_selected[0]][_i] != -1) {
						draw_text(TILE_SIZE * 1.5, TILE_SIZE * (2.5 + _i), string(obj_game.p_equip[equip_response_selected[0]][_i].item_name));
					}
					if (_i == equip_response_selected[1]) draw_text(TILE_SIZE / 2, TILE_SIZE * (_i + 2), ">");
				}
			}
			if (removing_equip) {
				// Showing remove and replace
				var _r_x1 = GAME_X - TILE_SIZE * (array_max_length(removing_equip_responses) / 2 + 1);
				var _r_y1 = GAME_Y - TILE_SIZE * (array_length(removing_equip_responses) - 2 + 7);
				var _r_x2 = GAME_X;
				var _r_y2 = GAME_Y - TILE_SIZE * 3;
				if (removing_equip_responses[0] != -1 and removing_equip_responses[0] != "") {
				text_box_slice(spr_textbox, _r_x1 - TILE_SIZE / 2, _r_y1 + TILE_SIZE, _r_x2, _r_y2 - TILE_SIZE / 2, textbox_background);
				for (var _i = 0; _i < array_length(removing_equip_responses); _i++) {
					if (_i == removing_equip_responses_selected) {
						draw_text(_r_x1, _r_y1 + TILE_SIZE * (1 + _i), ">" + removing_equip_responses[_i]);
					} else if (_i != removing_equip_responses_selected) {
						draw_text(_r_x1, _r_y1 + TILE_SIZE * (1 + _i), " " + removing_equip_responses[_i]);
					}
				}
			}
			}
			break;
		case 3:
			// STATS
			text_box_slice(spr_textbox, 0, 0, x1 + TILE_SIZE / 2, GAME_Y - TILE_SIZE * 1.5, textbox_background);
			draw_text(TILE_SIZE / 2, 0, menu_pages[response_selected]);
			draw_text(TILE_SIZE / 2, TILE_SIZE, obj_game.p_name[stats_response_selected]);
			draw_text(TILE_SIZE / 2, TILE_SIZE * 1.5, "LVL: " + string(obj_game.p_level[stats_response_selected]));
			var _i = 2.5;
			var _text_hp = string_repeat(" ", 3 - string_length(string(obj_game.p_hp[stats_response_selected]))) + string(obj_game.p_hp[stats_response_selected]);
			var _text_maxhp = string_repeat(" ", 3 - string_length(string(obj_game.p_maxhp[stats_response_selected]))) + string(obj_game.p_maxhp[stats_response_selected]);
			draw_text(TILE_SIZE / 2, TILE_SIZE * _i, "HP: " + _text_hp + "/" + _text_maxhp);
			var _text_dp = string_repeat(" ", 3 - string_length(string(obj_game.p_dp[stats_response_selected]))) + string(obj_game.p_dp[stats_response_selected]);
			var _text_maxdp = string_repeat(" ", 3 - string_length(string(obj_game.p_maxdp[0]))) + string(obj_game.p_maxdp[stats_response_selected]);
			draw_text(TILE_SIZE / 2, TILE_SIZE * (_i + 0.5), "DP: " + _text_dp + "/" + _text_maxdp);
			draw_text(TILE_SIZE / 2, TILE_SIZE * (_i + 1), "ATK: " + string_repeat(" ", 5) + string(obj_game.p_atk[stats_response_selected]));
			draw_text(TILE_SIZE / 2, TILE_SIZE * (_i + 1.5), "DEF: " + string_repeat(" ", 5) + string(obj_game.p_def[stats_response_selected]));
			draw_text(TILE_SIZE / 2, TILE_SIZE * (_i + 2), "MAG: " + string_repeat(" ", 5) + string(obj_game.p_mag[stats_response_selected]));
			draw_text(TILE_SIZE / 2, TILE_SIZE * (_i + 2.5), "AGI: " + string_repeat(" ", 5) + string(obj_game.p_spd[stats_response_selected]));
			break;
		case 4:
			// QUIT
			show_debug_message("WE SHOULDN'T GET HERE");
			instance_destroy();
			with (obj_player) state = player_state_free;
			break;
		default:
			show_debug_message("WE SHOULDN'T GET HERE EITHER");
			break;
	}
}