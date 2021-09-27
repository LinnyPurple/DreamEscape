// Item classes
enum item_kind {
	heal,
	battle,
	weapon,
	armor,
	accessory,
	key,
	height
}

function item() constructor {
	item_name = "";
	item_price = 0;
	item_type = 0; // Created so I can easily sort in the future
	item_subtype = 0; // Sort items within their own kind
	item_removable = true;
	item_equippable = [false, false]; // Checks if both members can equip
	item_description = "";
}