// Enemy classes
enum enemy_kind {
	e_dream_cell,
	e_dream_cell_2,
	height
}

enum enemy_stat {
	hp,
	maxhp,
	dp,
	maxdp,
	atk,
	def,
	mag,
	spd,
	crit,
	eva,
	experience,
	dmoney
}

function enemy() constructor {
	enemy_name = "";
	enemy_sprite = spr_enemy_1;
	enemy_stats =  [0,				// HP
					0,				// Max HP
					0,				// DP
					0,				// Max DP
					0,				// Attack
					0,				// Defense
					0,				// Magic
					0,				// Speed
					0,				// Critical Hit %
					0,				// Evasion %
					0,				// Experience
					0];				// D-Money
	enemy_status = status.none;
	enemy_skills = 3;
	enemy_type = enemy_kind.e_dream_cell;
}