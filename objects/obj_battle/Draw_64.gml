/// @description Draw battle stuff

draw_set_font(f_text);
draw_set_color(global.text_color);

if (b_state != battle_state.battle_enemy_select) {
	// Draw menu select
	text_box_slice(spr_textbox, menu_x1, menu_y1, menu_x2, menu_y2, 0);
	for (var _i = 0; _i < array_length(menu_options); _i++) {
		if (response_selected == _i) {
			draw_text(menu_x1 + TILE_SIZE / 2, menu_y1 + TILE_SIZE * (_i), ">" + menu_options[_i]);
		} else {
			draw_text(menu_x1 + TILE_SIZE / 2, menu_y1 + TILE_SIZE * (_i), " " + menu_options[_i]);
		}
	}
	// Draw active player
	text_box_slice(spr_textbox, player_x1, player_y1, player_x2, player_y2, 0);
	draw_text(player_x1 + TILE_SIZE / 2, player_y1, obj_game.p_name[player_action]);
	draw_text(player_x1 + TILE_SIZE / 2, player_y1 + TILE_SIZE / 2, "HP:" + string(obj_game.p_stats[player_action][stats.hp]));
	draw_text(player_x1 + TILE_SIZE / 2, player_y1 + TILE_SIZE, "DP:" + string(obj_game.p_stats[player_action][stats.dp]));
}

switch (b_state) {
	case battle_state.battle_start:
		break;
	case battle_state.battle_choose:
		break;
	case battle_state.battle_skill:
		break;
	case battle_state.battle_item:
		text_box_slice(spr_textbox, item_x1, item_y1, item_x2, item_y2, 0);
		draw_text(item_x1 + TILE_SIZE / 2, item_y1, menu_options[response_selected]);
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
					draw_text(item_x1 + TILE_SIZE / 2, item_y1 + TILE_SIZE * (1 + _j), ">" + global.inventory[_i].item_name);
				} else if (_i != item_response_selected[1]) {
					draw_text(item_x1 + TILE_SIZE / 2, item_y1 + TILE_SIZE * (1 + _j), " " + global.inventory[_i].item_name);
				}
			}
		break;
	case battle_state.battle_enemy_select:
		switch (attack_progress) {
			case 0:
				// Draw enemy name and HP bar
				text_box_slice(spr_textbox, enemy_x1, enemy_y1, enemy_x2, enemy_y2, 0);
				for (var _i = 0; _i < array_length(global.enemies); _i++) {
					if (_i == enemy_response_selected) {
						draw_text(enemy_x1 + TILE_SIZE / 2, enemy_y1, global.enemies[_i].enemy_name);
						var _middle = enemy_middle(_i) - 4;
						draw_sprite(spr_arrow_up, -1, _middle, TILE_SIZE * 4);
						var _enemy_hp = global.enemies[_i].enemy_stats[enemy_stat.hp];
						var _enemy_maxhp = global.enemies[_i].enemy_stats[enemy_stat.maxhp];
						draw_text(0, 0, _enemy_hp);
						var _hp = enemy_middle(_i);
						draw_set_color(c_black);
						draw_rectangle(_hp - TILE_SIZE / 2, TILE_SIZE * 2, _hp + TILE_SIZE / 2, TILE_SIZE * 2.25, false);
						var _hp_x = floor((TILE_SIZE - 2) / _enemy_maxhp * _enemy_hp + _hp - TILE_SIZE / 2 + 1);
						if (_enemy_hp / _enemy_maxhp >= 0.5) draw_set_color(make_color_rgb(0, 248, 0));
						else if (_enemy_hp / _enemy_maxhp >= 0.25) draw_set_color(make_color_rgb(248, 248, 0));
						else draw_set_color(make_color_rgb(248, 0, 0));
						draw_rectangle(_hp - TILE_SIZE / 2 + 1, TILE_SIZE * 2 + 1, _hp_x, TILE_SIZE * 2.25 - 1, false);
					}
				}
				break;
			case 1:
				break;
			case 2:
				// Play animation
				for (var _i = 0; _i < array_length(global.enemies); _i++) {
					if (_i == enemy_response_selected) {
						var _middle = enemy_middle(_i) - sprite_get_width(spr_ani_slash_1) / 2;
						draw_sprite(spr_ani_slash_1, floor(animation_progress / animation_wait), _middle, TILE_SIZE * 3);
					}
				}
				break;
			case 3:
				// Show damage dealt
				for (var _i = 0; _i < array_length(global.enemies); _i++) {
					if (_i == enemy_response_selected) {
						var _middle = enemy_middle(_i) - 4 * damage_length;
						for (var _j = 0; _j < damage_length; _j++) {
							if (damage_progress >= _j * damage_number_wait) {
								var _progress = damage_progress - _j * damage_number_wait;
								var _number = 0;
								if (_progress == 8) _number = 8;
								else _number = floor(abs((72 / pi * sin(pi / 8 * _progress)) / (_progress - 8)));
								draw_sprite(spr_damage, damage_array[_j], _middle + _j * TILE_SIZE / 2,
								TILE_SIZE * 3.5 - _number);
							}
						}
						if (global.critical_hit) {
							image_speed = 15 / FRAMES;
							draw_sprite(spr_crit, -1, enemy_middle(_i) - sprite_get_width(spr_crit) / 2, TILE_SIZE * 1.5);
						}
					}
				}
				break;
			case 4:
				image_speed = 2 / FRAMES;
				break;
			case 5:
				break;
			default:
				break;
		}
		break;
	default:
		break;
}