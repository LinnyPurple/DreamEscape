/// @description Initialize menu

menu_pages = ["ITEM", "SKILL", "EQUIP", "STATS", "QUIT"];
response_selected = 0;
item_response_selected = [0, 0];
item_selected = false;
item_selected_response_selected = 0; // USE, INFO, DROP
item_pages = ["USE", "INFO", "DROP"];
items_per_page = 6;
equip_response_selected = [0, 0];
equipping_item = false;
removing_equip = false; // Used to either remove equipped item or replace it
removing_equip_responses = ["Replace", "Remove"];
removing_equip_responses_selected = 0;
stats_response_selected = 0;
textbox_background = global.text_bg;

x1 = GAME_X - TILE_SIZE * 4;
y1 = 0;
x2 = GAME_X;
y2 = TILE_SIZE * (array_length(menu_pages) + 1 / 2);