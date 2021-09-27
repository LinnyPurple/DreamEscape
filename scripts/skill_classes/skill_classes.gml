// Skill classes
enum skill_kind {
	out_battle, // Skills used outside of battle (e.g. Escape, Return)
	in_battle,  // Skills used inside of battle (e.g. Fire, Holy)
	ambi_battle,// Skills used outside and inside of battle (e.g. Heal, Revive)
	height
}

function skill() constructor {
	skill_name = "";
	skill_type = 0;
	skill_subtype = 0; // Just to sort skills
	skill_description = "";
	skill_dp = 0;		// DP required to use
}