function player_collision() {
	// Check for collision
	var _entity_list = ds_list_create();
	var _entity_count;

	// Horizontal collision
	if (speed_x != 0) {
		if (tilemap_get_at_pixel(collision_map, round(bbox_right + speed_x), bbox_bottom) == 0
		and tilemap_get_at_pixel(collision_map, round(bbox_left + speed_x), bbox_bottom) == 0
		and tilemap_get_at_pixel(collision_map, round(bbox_right + speed_x), bbox_top) == 0
		and tilemap_get_at_pixel(collision_map, round(bbox_left + speed_x), bbox_top) == 0) {
			// Horizontal entities (check for moving right)
			if (speed_x == 1) {
				_entity_count = instance_position_list(x + TILE_SIZE + speed_x, y, obj_par_entity, _entity_list, false);
			} else if (speed_x == -1) {
				_entity_count = instance_position_list(x + speed_x, y, obj_par_entity, _entity_list, false);
			}
			while (_entity_count > 0) {
				var _entity_check = _entity_list[| 0];
				if (_entity_check.entity_collision) {
					// Move as close as we can
					if (speed_x == 1) x = _entity_check.bbox_left - TILE_SIZE;
					else if (speed_x == -1) x = _entity_check.bbox_right + 1;
					speed_x = 0;
					sprite_index = sprite_idle;
					image_index = floor(dir / 90);
					moving = false;
					_entity_count = 0;
				}
				ds_list_delete(_entity_list, 0);
				_entity_count--;
			}
			x += speed_x;
			player_animate();
		} else {
			//if (speed_x > 0) {
			//	x = floor(x);
			//	x = x - (bbox_right % TILE_SIZE) + TILE_SIZE - 1;
			//} else if (speed_x < 0) {
			//	x = ceil(x);
			//	x = x - (bbox_left % TILE_SIZE);
			//}
			speed_x = 0;
			sprite_index = sprite_idle;
			image_index = floor(dir / 90);
			moving = false;
		}
	}

	// Clear list between axes
	ds_list_clear(_entity_list);

	// Vertical collision
	if (speed_y != 0) {
		if (tilemap_get_at_pixel(collision_map, bbox_right, round(bbox_bottom + speed_y)) == 0
		and tilemap_get_at_pixel(collision_map, bbox_right, round(bbox_top + speed_y)) == 0
		and tilemap_get_at_pixel(collision_map, bbox_left, round(bbox_bottom + speed_y)) == 0
		and tilemap_get_at_pixel(collision_map, bbox_left, round(bbox_top + speed_y)) == 0) {
			// Horizontal entities (check for moving right)
			if (speed_y == 1) {
				_entity_count = instance_position_list(x, y + TILE_SIZE + speed_y, obj_par_entity, _entity_list, false);
			} else if (speed_y == -1) {
				_entity_count = instance_position_list(x, y + speed_y, obj_par_entity, _entity_list, false);
			}
			while (_entity_count > 0) {
				var _entity_check = _entity_list[| 0];
				if (_entity_check.entity_collision) {
					// Move as close as we can
					if (speed_y == 1) y = _entity_check.bbox_top - TILE_SIZE;
					else if (speed_y == -1) y = _entity_check.bbox_bottom + 1;
					speed_y = 0;
					sprite_index = sprite_idle;
					image_index = floor(dir / 90);
					moving = false;
					_entity_count = 0;
				}
				ds_list_delete(_entity_list, 0);
				_entity_count--;
			}
			y += speed_y;
			player_animate();
		} else {
			//if (speed_y > 0) {
			//	y = floor(y);
			//	y = y - (bbox_bottom % TILE_SIZE) + TILE_SIZE - 1;
			//} else if (speed_y < 0) {
			//	y = ceil(y);
			//	y = y - (bbox_top % TILE_SIZE);
			//}
			speed_y = 0;
			sprite_index = sprite_idle;
			image_index = floor(dir / 90);
			moving = false;
		}
	}

	ds_list_destroy(_entity_list);


}
