function player_state_free() {
	if (not moving) {
		if (k_right) {
			moving = true;
			speed_x = speed_walk;
			speed_y = 0;
			dir = 0;
		} else if (k_up) {
			moving = true;
			speed_x = 0;
			speed_y = -speed_walk;
			dir = 90;
		} else if (k_left) {
			moving = true;
			speed_x = -speed_walk;
			speed_y = 0;
			dir = 180;
		} else if (k_down) {
			moving = true;
			speed_x = 0;
			speed_y = speed_walk;
			dir = 270;
		}
	}
	player_collision();

	// Activate key logic
	if (k_a) {
		// Check for entity to activate
		// Nothing exists, or something with no script does
		// Something with a script exists
	
		if (x % TILE_SIZE == 0 and y % TILE_SIZE == 0) {
			var _activate_x = lengthdir_x(TILE_SIZE, obj_player.dir);
			var _activate_y = lengthdir_y(TILE_SIZE, obj_player.dir);
			activate = instance_position(x + _activate_x, y + _activate_y, obj_par_entity);
	
			if (activate == noone or activate.entity_activate_script == -1) {
				// nothing here right now
			} else {
				// Activate the entity
				script_execute_array(activate.entity_activate_script, activate.entity_activate_args);
				// Make NPC character face us
				if (activate.entity_npc) {
					with (activate) {
						direction = point_direction(x,y,other.x,other.y);
						image_index = floor((obj_player.dir / 90 + 2) % 4);
				
					}
				}
			}
		}
	}


}
