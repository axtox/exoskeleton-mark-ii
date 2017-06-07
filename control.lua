--- Checks if armor grid has equipment with provided name (equipment_name)
-- @param grid Armor grid that will be used to search for equipment
-- @param equipment_name Equipment name (usually prototype name)
function grid_has_equipment (grid, equipment_name)
    for index, equipment in ipairs (grid) do
        if equipment.name == equipment_name then
            return true
        end
    end
    return false
end

--- Enables all modifiers for this player (player) 
-- The modifiers values are: 
-- character_inventory_slots_bonus = 60, which means +60 inventory slots
-- quickbar_count_bonus = 1, which means +1 line of quick bar inventory slots
-- character_logistic_slot_count_bonus = 5, which adds +5 logistic inventory slots 
-- character_trash_slot_count_bonus = 10, which adds +10 trash inventory slots
-- character_mining_speed_modifier = 0.3, which speeds up the mining speed +30%
-- @param player Player whom modifiers must be updated
function enable_modifiers(player)
	if player.character_inventory_slots_bonus ~= 60 then
		player.character_inventory_slots_bonus  = 60
	end
	if player.quickbar_count_bonus ~= 1 then
		player.quickbar_count_bonus = 1
	end
	if player.character_logistic_slot_count_bonus ~= 5 then
		player.character_logistic_slot_count_bonus = 5
	end
	if player.character_trash_slot_count_bonus ~= 10 then
		player.character_trash_slot_count_bonus = 10
	end
	if player.character_mining_speed_modifier ~= 0.3 then
		player.character_mining_speed_modifier = 0.3
	end
end
--- Disables all modifiers for this player (player) 
-- The modifiers values are: 
-- character_inventory_slots_bonus = 0, which means +0 inventory slots
-- quickbar_count_bonus = 0, which means +0 line of quick bar inventory slots
-- character_logistic_slot_count_bonus = 0, which adds +0 logistic inventory slots 
-- character_trash_slot_count_bonus = 0, which adds +0 trash inventory slots
-- character_mining_speed_modifier = 0, which speeds up the mining speed +0%
-- @param player Player whom modifiers must be updated
function disable_modifiers(player)
	player.character_inventory_slots_bonus  = 0
	player.quickbar_count_bonus = 0
	player.character_logistic_slot_count_bonus = 0
	player.character_trash_slot_count_bonus = 0
	player.character_mining_speed_modifier = 0
end

--- Configuration changed event handler
-- Updates Exoskeleton Mark II recepie and technologie
script.on_configuration_changed(function(event)
	if event.mod_changes ~= nil then
		local changes = event.mod_changes["Exoskeleton Mark II"]
		if changes ~= nil then
			for _, force in pairs(game.forces) do
				force.technologies["exoskeleton-mark-ii-tech"].reload()
				force.recipes["exoskeleton-mark-ii"].reload()
				force.print("Exoskeleton Mark II mod has been updated!")
				if force.players ~= nil then -- if force has players, update thair armor inventory to recalculate bonuses
					for _, player in pairs(force.players) do
						script.raise_event(defines.events.on_player_armor_inventory_changed, {player_index = player.index})
					end
				end
			end
		end
	end
end)

--- New equipment placed to armor grid event handler
-- Tries to enable modifiers (@see enable_modifiers) for current player
-- if equiped item is Exoskeleton Mark II
script.on_event(defines.events.on_player_placed_equipment, function(event)
	if event.equipment.name == "exoskeleton-mark-ii" then
		enable_modifiers(game.players[event.player_index])
	end
end)

--- Equipment removed from armor grid event handler
-- Tries to disable modifiers (@see enable_modifiers) for current player
-- if removed item is Exoskeleton Mark II. 
-- Also re-enables modifiers in case if removed item is not last in grid
script.on_event(defines.events.on_player_removed_equipment, function(event)
	if event.equipment == "exoskeleton-mark-ii" then
		if event.grid.valid then
			if grid_has_equipment(event.grid.equipment, "exoskeleton-mark-ii") then
				enable_modifiers(game.players[event.player_index])
				return
			else
				disable_modifiers(game.players[event.player_index])
			end
		end
	else
		return
	end
end)

--- Armor removed from player inventroy or another changes made to equipments
-- Tries to disable modifiers (@see enable_modifiers) for current player
-- if removed item is Exoskeleton Mark II or armor itself. 
-- Also re-enables modifiers in case if new armor contains Exoskeleton Mark II
script.on_event(defines.events.on_player_armor_inventory_changed, function(event)
	local armor_inventory = game.players[event.player_index].get_inventory(defines.inventory.player_armor)
	if not armor_inventory.is_empty() and armor_inventory[1].valid then
		if armor_inventory[1].grid ~= nil and armor_inventory[1].grid.valid then
			if grid_has_equipment(armor_inventory[1].grid.equipment, "exoskeleton-mark-ii") then
					enable_modifiers(game.players[event.player_index])
				return
			end
		end
	end
	disable_modifiers(game.players[event.player_index])
end)