// Create items here

// Healing items
enum heal_items {
	h_dream_candy,
	h_water,
	height
}

// Weapon items
enum weapon_items {
	w_stick,
	w_knife,
	height
}

// Armor items
enum armor_items {
	a_cloth,
	height
}

// Accessory items
enum acc_items {
	a_lynhat,
	height
}

function heal_item(_item) : item() constructor {
	item_type = item_kind.heal;
	item_subtype = _item;
	switch(_item) {
		case heal_items.h_dream_candy:
			// Dream Candy
			item_name = "DrmCandy";
			item_price = 10;
			hp_heal = 20;
			item_description = "Heals 20 HP.";
			break;
		case heal_items.h_water:
			// Water
			item_name = "Water";
			item_price = 50;
			hp_heal = 30;
			item_description = "It's water.";
			break;
		default:
			break;
	}
}

function equip_item() : item() constructor {
	hp_add = 0;
	dp_add = 0;
	atk_add = 0;
	def_add = 0;
	mag_add = 0;
	spd_add = 0;
	item_equippable = [true, true];
}

function weapon(_item) : equip_item() constructor {
	item_type = item_kind.weapon;
	item_subtype = _item;
	switch (_item) {
		case weapon_items.w_stick:
			item_name = "Stick";
			item_price = 5;
			atk_add = 1;
			item_removable = false;
			item_equippable = [true, false];
			item_description = "STICK";
			break;
		case weapon_items.w_knife:
			item_name = "Knife";
			item_price = 10;
			atk_add = 3;
			item_description = "Stabs. Can use for\ncutting a\nfresh steak.";
			break;
		default:
			break;
	}
}

function armor_body(_item) : equip_item() constructor {
	item_type = item_kind.armor;
	item_subtype = _item;
	switch (_item) {
		case armor_items.a_cloth:
			item_name = "Cloth";
			item_price = 10;
			def_add = 1;
			item_description = "Don't wanna be na-\nked, do we?";
			break;
		default:
			break;
	}
}

function armor_acc(_item) : equip_item() constructor {
	item_type = item_kind.accessory;
	item_subtype = _item;
	switch (_item) {
		case acc_items.a_lynhat:
			item_name = "Lyn's Hat";
			item_price = 0;
			def_add = 2;
			mag_add = 2;
			item_equippable = [false, true];
			item_description = "Smells like years\nworth of adven-\ntures.";
			break;
		default:
			break;
	}
}