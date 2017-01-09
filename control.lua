function grid_has_equipment (grid, equipment_name)
    for index, equipment in ipairs (grid) do
        if equipment.name == equipment_name then
            return true
        end
    end
    return false
end

script.on_configuration_changed(function(event) 
	for _, force in ipairs(game.forces) do
		force.technologies["exoskeleton-mark-ii-tech"].reload()
		force.recipes["exoskeleton-mark-ii"].reload()
		force.print("Exoskeleton Mark II mod updated!")
	end
end)
script.on_event(defines.events.on_player_placed_equipment, function(event)
	if event.equipment.name == "exoskeleton-mark-ii" then				
		if game.players[event.player_index].character_inventory_slots_bonus ~= 60 then
			game.players[event.player_index].character_inventory_slots_bonus  = 60
		end
		if game.players[event.player_index].quickbar_count_bonus ~= 1 then
			game.players[event.player_index].quickbar_count_bonus = 1
		end
		if game.players[event.player_index].character_logistic_slot_count_bonus ~= 5 then
			game.players[event.player_index].character_logistic_slot_count_bonus = 5
		end
		if game.players[event.player_index].character_trash_slot_count_bonus ~= 10 then
			game.players[event.player_index].character_trash_slot_count_bonus = 10
		end
	end
end)
script.on_event(defines.events.on_player_removed_equipment, function(event)
	if event.equipment == "exoskeleton-mark-ii" then
		if event.grid.valid then
			if grid_has_equipment(event.grid.equipment, "exoskeleton-mark-ii") then
				if game.players[event.player_index].character_inventory_slots_bonus ~= 60 then
					game.players[event.player_index].character_inventory_slots_bonus  = 60
				end
				if game.players[event.player_index].quickbar_count_bonus ~= 1 then
					game.players[event.player_index].quickbar_count_bonus = 1
				end
				if game.players[event.player_index].character_logistic_slot_count_bonus ~= 5 then
					game.players[event.player_index].character_logistic_slot_count_bonus = 5
				end
				if game.players[event.player_index].character_trash_slot_count_bonus ~= 10 then
					game.players[event.player_index].character_trash_slot_count_bonus = 10
				end
				return
			else
				game.players[event.player_index].character_inventory_slots_bonus  = 0
				game.players[event.player_index].quickbar_count_bonus = 0
				game.players[event.player_index].character_logistic_slot_count_bonus = 0
				game.players[event.player_index].character_trash_slot_count_bonus = 0
			end
		end
	else
		return
	end
end)
script.on_event(defines.events.on_player_armor_inventory_changed, function(event)
	local armor_inventory = game.players[event.player_index].get_inventory(defines.inventory.player_armor)
	if not armor_inventory.is_empty() and armor_inventory[1].valid then
		if armor_inventory[1].grid ~= nil and armor_inventory[1].grid.valid then
			if grid_has_equipment(armor_inventory[1].grid.equipment, "exoskeleton-mark-ii") then
				if game.players[event.player_index].character_inventory_slots_bonus ~= 60 then
					game.players[event.player_index].character_inventory_slots_bonus  = 60
				end
				if game.players[event.player_index].quickbar_count_bonus ~= 1 then
					game.players[event.player_index].quickbar_count_bonus = 1
				end
				if game.players[event.player_index].character_logistic_slot_count_bonus ~= 5 then
					game.players[event.player_index].character_logistic_slot_count_bonus = 5
				end
				if game.players[event.player_index].character_trash_slot_count_bonus ~= 10 then
					game.players[event.player_index].character_trash_slot_count_bonus = 10
				end
				return
			end
		end
	end
	game.players[event.player_index].character_inventory_slots_bonus  = 0
	game.players[event.player_index].quickbar_count_bonus = 0
	game.players[event.player_index].character_logistic_slot_count_bonus = 0
	game.players[event.player_index].character_trash_slot_count_bonus = 0
end)