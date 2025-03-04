data:extend({
	{
		type = "technology",
		name = "exoskeleton-mark-ii-tech",
		icons = util.technology_icon_constant_equipment("__Exoskeleton Mark II__/graphics/technology/exoskeleton-mark-ii-equipment.png"),
		prerequisites = {"exoskeleton-equipment", "speed-module-3"},
		effects =
		{
			{
				type = "unlock-recipe",
				recipe = "exoskeleton-mark-ii"
			}
		},
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
	 	order = "g-hb"
	}
})