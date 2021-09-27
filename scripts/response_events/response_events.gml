/// @desc What happens when you choose a response
/// @param response
function response_events(argument0) {

	global.in_text = true;

	switch (argument0) {
		case 0: break;
		case 1: text_box("You have interes-\nting tastes.", 0); break;
		case 2: {
			text_box("YEEEEEEEE", 0);
			text_box("WHAT IS WRONG WITH\nYOU!?!?", 0, ["3:Yes", "0:No"]);
			break;
		}
		case 3: {
			text_box("AAAAAAAAAAAAA", 0);
			text_box("I eat cardboard\nfor dinner.", 0, ["4:"]);
			break;
		}
		case 4: {
			room_transition(transition_type.rm, r_town2);
		}
		default: break;
	}


}
