function player_animate() {
	// @desc Animate the player

	if (mod_four_hit == false) {
		sprite_index = sprite_walk;
		image_index = floor((dir / 45) + (steps % 2));
	}
	if (x % TILE_SIZE == (TILE_SIZE / 2) or y % TILE_SIZE == (TILE_SIZE / 2)) {
		mod_four_hit = true;
		sprite_index = sprite_idle;
		image_index = floor(dir / 90);
	}
	if (x % TILE_SIZE == 0 and y % TILE_SIZE == 0) {
		steps += 1;
		speed_x = 0;
		speed_y = 0;
		mod_four_hit = false;
		moving = false;
	}


}
