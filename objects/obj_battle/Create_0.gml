/// @description Initiate battle
enum battle_state {
	battle_start,
	battle_choose,
	battle_skill,
	battle_item,
	battle_enemy_select,
	battle_party_select,
	battle_end
}
player_action = 0;
response_selected = 0;
enemy_response_selected = 0;
item_response_selected = [0, 0]
items_per_page = 3;
b_state = battle_state.battle_choose;
b_player = 0;
b_acting = 0; // Used to see who is acting in battle
attack_progress = 0;
animation_progress = 0;
animation_wait = 4; // Number of frames to show each sprite of the animation
damage_dealt = 0;
damage_array = [-1, -1, -1, -1, -1, -1, -1, -1, -1];
damage_length = 0;
damage_progress = 0;
damage_wait = 60; // How long to show the damage
damage_number_wait = 5;

// Battle menu window
menu_x1 = 0;
menu_y1 = GAME_Y - TILE_SIZE * 4.5;
menu_x2 = TILE_SIZE * 4;
menu_y2 = GAME_Y;
menu_options = ["FIGHT", "SKILL", "ITEM", "FLEE"];

// Battle active player window
player_x1 = 0;
player_y1 = 0;
player_x2 = TILE_SIZE * 4;
player_y2 = TILE_SIZE * 3;

// Battle enemy select window
enemy_x1 = 0;
enemy_y1 = GAME_Y - TILE_SIZE * 1.5;
enemy_x2 = GAME_X;
enemy_y2 = GAME_Y;

// Battle item window
item_x1 = TILE_SIZE * 4;
item_y1 = GAME_Y - TILE_SIZE * 4.5;
item_x2 = GAME_X;
item_y2 = GAME_Y;

image_speed = 2 / FRAMES;

check = true;

// Generate enemies
generate_enemy_group(r_town);