/// @desc Menu events
/// @param response
function menu_events(_response) {
	global.in_text = true;
	switch (_response) {
		case 0:
			equip_into_inventory(obj_menu.equip_response_selected[1], obj_menu.equip_response_selected[0]);
			break;
		case 1:
			obj_menu.equipping_item = true;
			break;
		default:
			break;
	}
	obj_menu.removing_equip = false;
}