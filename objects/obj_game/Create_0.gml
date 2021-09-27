/// @description Game intitialization with global variables

randomize();

global.game_paused = false;
global.text_speed = 0.5;
global.i_camera = instance_create_layer(0, 0, layer, obj_camera);
global.target_room = -1;
global.target_x = -1;
global.target_y = -1;
global.target_direction = 0;
global.text_color = make_color_rgb(248, 248, 248);
global.text_bg = 0; // Textbox background
global.in_text = false;
global.remember = true; // Used for menus and tracking and stuff
global.scale = 10;

// USE THIS WITH THE TEXTBOXES TO DO SHIT
global.switch_var = false;

// Items (24 slots)
global.inventory = [-1, -1, -1, -1, -1, -1, -1, -1,
					-1, -1, -1, -1, -1, -1, -1, -1,
					-1, -1, -1, -1, -1, -1, -1, -1];

// Critical hit
global.critical_hit = false;

p_name = ["First", "Second"];

// Party stats
enum stats {
	level,			// Level
	experience,		// Experience
	hp,				// HP
	maxhp,			// Maximum HP
	dp,				// DP
	maxdp,			// Maximum DP
	atk,			// Attack
	def,			// Defense
	mag,			// Magic
	spd,			// Speed
	crit,			// Critical Hit %
	eva,			// Evasion %
	height
}
p_level = [1, 1];
p_exp = [0, 0];
p_hp = [12, 10];
p_maxhp = [12, 10];
p_dp = [5, 8];
p_maxdp = [5, 8];
p_atk = [3, 2];
p_def = [3, 2];
p_mag = [3, 4];
p_spd = [3, 4];
p_crit = [5, 5];
p_eva = [5, 5];
p_equip = [[-1, -1, -1, -1], [-1, -1, -1, -1]]; // [Weapon, Armor, Accessory, Accesory]
p_stats = [[1, 0, 12, 12, 5, 5, 3, 3, 3, 3, 5, 5], // Might use these instead for stats
		   [1, 0, 10, 10, 8, 8, 2, 2, 4, 4, 5, 5]]
p_boost = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], // Used for equipments
		   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
p_battle = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], // Used for battle stat buffs (or debuffs)
		    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]] // E.g. Swords Dance or Screech in Pokemon

enum status {
	none,
	dead,
	poisoned,
	stunned,
	height
}
p_status = [status.none, status.none];

// BATTLE STUFF
// Enemy list
global.enemies = [-1];
// Turn order
global.turn_order = [-1];

// Game start
surface_resize(application_surface, GAME_X, GAME_Y);
room_goto(ROOM_START);