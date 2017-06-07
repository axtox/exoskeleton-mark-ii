data:extend({
	{
		type = "technology",
		name = "exoskeleton-mark-ii-tech",
		icon_size = 128,
		icon = "__Exoskeleton Mark II__/graphics/exoskeleton-mark-ii-tech.png",
		effects =
		{
			{
				type = "unlock-recipe",
				recipe = "exoskeleton-mark-ii"
			}
		},
		prerequisites = {"exoskeleton-equipment", "speed-module-3"},
		unit =
		{
			count = 200,
			ingredients =
			{
				{"science-pack-1", 1},
				{"science-pack-2", 2},
				{"science-pack-3", 3},
				{"high-tech-science-pack", 3}
			},
			time = 60
		},
	 	upgrade = true,
	 	order = "g-h"
	}
})