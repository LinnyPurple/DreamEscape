/// @desc Workaround for multiple textboxes and for longer events
/// @param Event number
function room_events_town(argument0) {

	switch (argument0) {
		case 0: {
			text_box("Hello!", 0);
			text_box("Do you find con-\nsuming cardboard\nto be fun?", 0, ["1:Yes", "2:No"]);
			break;
		}
		default: {
			show_debug_message("SHOULDN'T REACH HERE");
			break;
		}
	}


}
