// List of enemies
function enemy_dream_cell() : enemy() constructor {
	enemy_name = "Dream Cell";
	enemy_sprite = spr_enemy_1;
	enemy_stats =  [5,				// HP
					5,				// Max HP
					5,				// DP
					5,				// Max DP
					2,				// Attack
					2,				// Defense
					2,				// Magic
					2,				// Speed
					5,				// Critical Hit %
					5,				// Evasion %
					2,				// Experience
					2];				// D-Money
	enemy_skills = [[ib_skills.s_attack, 2],
					[ib_skills.s_stomp, 1]];
	enemy_type = enemy_kind.e_dream_cell;
}

function enemy_dream_cell_2() : enemy() constructor {
	enemy_name = "Dream Cell-2";
	enemy_sprite = spr_enemy_2;
	enemy_stats =  [20,				// HP
					20,				// Max HP
					5,				// DP
					5,				// Max DP
					5,				// Attack
					5,				// Defense
					3,				// Magic
					6,				// Speed
					5,				// Critical Hit %
					5,				// Evasion %
					8,				// Experience
					8];				// D-Money
	enemy_skills = [[ib_skills.s_attack, 1],
					[ib_skills.s_stomp, 1]];
	enemy_type = enemy_kind.e_dream_cell_2;
}