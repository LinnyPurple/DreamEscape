/// @description Initialize camera

camera = view_camera[0];
follow = obj_player;
view_x_center = camera_get_view_width(camera) / 2;
view_y_center = camera_get_view_height(camera) / 2;
x_to = xstart;
y_to = ystart;

shake_length = 0;
shake_magnitude = 0;
shake_remain = 0;