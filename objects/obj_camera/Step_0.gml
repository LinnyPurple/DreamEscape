/// @description Update camera

// Update destination
if (instance_exists(follow)) {
	x_to = follow.x;
	y_to = follow.y;
}

// Update object position
x += x_to - x;
y += y_to - y;

// Keep camera center inside room
x = clamp(x, view_x_center, room_width - view_x_center);
y = clamp(y, view_y_center, room_height - view_y_center);

// Screen shake
x += random_range(-shake_remain, shake_remain);
y += random_range(-shake_remain, shake_remain);

shake_remain = max(0, shake_remain - (1 / shake_length * shake_magnitude));

camera_set_view_pos(camera, x - view_x_center, y - view_y_center);