data:extend({
	{
		type = "movement-bonus-equipment",
		name = "exoskeleton-mark-ii",
		sprite = 
		{
			filename = "__Exoskeleton Mark II__/graphics/exoskeleton-mark-ii-sprite.png",
			width = 64,
			height = 128,
			priority = "medium"
		},
		shape =
		{
			width = 2,
			height = 4,
			type = "full"
		},
		energy_source =
		{
			type = "electric",
			usage_priority = "secondary-input"
		},
		energy_consumption = "1400W",
		movement_bonus = 1.0,
		categories = {"armor"}
	}
})