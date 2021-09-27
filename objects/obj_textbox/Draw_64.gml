/// @description Draw textbox

text_box_slice(spr_textbox, x1, y1, x2, y2, textbox_background);
draw_set_font(f_text);
draw_set_color(global.text_color);
var _print = string_copy(message, 1, text_progress);
draw_text_ext(x1 + TILE_SIZE / 2, y1, _print, TILE_SIZE, TILE_SIZE * 10);

var _r_x1 = GAME_X - TILE_SIZE * (array_max_length(responses) / 2 + 1);
var _r_y1 = GAME_Y - TILE_SIZE * (array_length(responses) - 2 + 7);

if (responses[0] != -1 and responses[0] != "" and text_progress >= string_length(message)) {
	text_box_slice(spr_textbox, _r_x1 - TILE_SIZE / 2, _r_y1 + TILE_SIZE, r_x2, r_y2 - TILE_SIZE / 2, textbox_background);
	for (var _i = 0; _i < array_length(responses); _i++) {
		if (_i == response_selected) {
			draw_text(_r_x1, _r_y1 + TILE_SIZE * (1 + _i), ">" + responses[_i]);
		} else if (_i != response_selected) {
			draw_text(_r_x1, _r_y1 + TILE_SIZE * (1 + _i), " " + responses[_i]);
		}
	}
}