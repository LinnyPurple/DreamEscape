/// @description Add stick

item_stick = new weapon(weapon_items.w_stick);
add_item(item_stick);
item_water = new heal_item(heal_items.h_water);
add_item(item_water);
item_knife = new weapon(weapon_items.w_knife);
add_item(item_knife);
show_debug_message(string(inventory_num()) + " item(s) in inventory");