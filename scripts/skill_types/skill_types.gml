// Skill types

// Outside Battle Scripts
enum ob_skills {
	s_escape,		// Escape from a dungeon
	s_return,		// Return to a previous town
	height
}

// Inside Battle Scripts
enum ib_skills {
	// PLAYER AND ENEMY SKILLS
	s_attack,		// Regular attack
	s_fire1,		// Weak fire attack
	// ONLY ENEMY SKILLS
	s_stomp,		// Dream Cell
	height
}

// Outside/Inside Battle Scripts
enum ab_skills {
	// PLAYER AND ENEMY SKILLS
	s_heal1,		// Weak heal
	// ONLY ENEMY SKILLS
	height
}
// Outside Battle Skills
function ob_skill(_skill) : skill() constructor {
	skill_type = skill_kind.out_battle;
	skill_subtype = _skill;
	switch (_skill) {
		case ob_skills.s_escape:
			skill_name = "Escape";
			skill_description = "Allows the player\nto escape a\ndungeon.";
			break;
		case ob_skills.s_return:
			skill_name = "Return";
			skill_description = "Allows the player\nto return to a\nvisited location.";
			break;
		default:
			break;
	}
}

// Inside Battle Skills
function ib_skill(_skill) : skill() constructor {
	skill_type = skill_kind.in_battle;
	skill_subtype = _skill;
	switch (_skill) {
		case ib_skills.s_attack:
			skill_name = "Attack";
			skill_description = "FIGHT";	// "FIGHT" option in battle
			break;
		case ib_skills.s_fire1:
			skill_name = "Fire I";
			skill_description = "Weak fire attack.\nUse for small camp-\nfires.";
			skill_dp = 3;
			break;
		case ib_skills.s_stomp:
			skill_name = "Stomp";
			skill_description = "STOMP";
			break;
		default:
			break;
	}
}

// Outside/Inside Battle Skills
function ab_skill(_skill) : skill() constructor {
	skill_type = skill_kind.ambi_battle;
	skill_subtype = _skill;
	switch (_skill) {
		case ab_skills.s_heal1:
			skill_name = "Heal I";
			skill_description = "Heals a small a-\nmount of HP.";
			skill_dp = 2;
			break;
		default:
			break;
	}
}