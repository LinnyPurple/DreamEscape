/// @desc ScreenShake(magnitude, frames)
/// @param magnitude sets the strength of the shake (distance range)
/// @param frames sets the length of the shake in frames
function screen_shake(argument0, argument1) {

	with (global.i_camera) {
		if (argument0 > shake_remain) {
			shake_magnitude = argument0;
			shake_remain = shake_magnitude;
			shake_length = argument1;
		}
	}


}
