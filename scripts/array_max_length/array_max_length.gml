/// @desc Returns length of longest string in array
/// @param a, array
function array_max_length(argument0) {

	var _a = argument0;
	var _longest = string_length(_a[0]);

	if (array_length_1d(_a) > 1) {
		for (var _i = 1; _i < array_length_1d(_a); _i++) {
			if (string_length(_a[_i]) > _longest) _longest = string_length(_a[_i]);
		}
	}

	return _longest;


}
