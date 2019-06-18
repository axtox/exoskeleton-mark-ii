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
				{"automation-science-pack", 1},
				{"logistic-science-pack", 2},
				{"chemical-science-pack", 3},
				{"utility-science-pack", 3}
			},
			time = 60
		},
	 	upgrade = true,
	 	order = "g-h"
	}
})
