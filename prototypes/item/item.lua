local item_sounds = require("__base__.prototypes.item_sounds")

data:extend(
{
	{
		type = "item",
		name = "exoskeleton-mark-ii",
		icon = "__Exoskeleton Mark II__/graphics/icons/exoskeleton-mark-ii-equipment.png",
		placed_as_equipment_result = "exoskeleton-mark-ii",
		subgroup = "utility-equipment",
		order = "d[exoskeleton]-a[exoskeleton-mark-ii]",
		inventory_move_sound = item_sounds.exoskeleton_inventory_move,
		pick_sound = item_sounds.exoskeleton_inventory_pickup,
		drop_sound = item_sounds.exoskeleton_inventory_move,
		stack_size = 4
	}
}) 
