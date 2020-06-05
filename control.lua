--- Event handler for all eqipment-oriented events, that has player_index event argument
-- Starts update modifiers state sequence for this player
-- @param player_index Index of player that raised event
function on_equipment_changed(event_args)
	update_modifiers(game.players[event_args.player_index])
end

--- Update status of modifiers (disable or enable) based on armor type and grid contents
-- This method does all checkings that needed to verify if player has to have modifiers or not.
-- For enabling modifiers player must be not nil, has to wear armor with grid that contains
-- Exoskeleton Mark II equipment in it (at least one copy).
-- @param player The player whom modifiers will be updated
function update_modifiers(player)
	if player == nil or not player.connected or player.character == nil then
		return
	end

	local armor_inventory = player.get_inventory(defines.inventory.character_armor);
	if armor_inventory == nil or armor_inventory.is_empty() then -- cheking if armor itself is equipped and not empty
		disable_modifiers(player)
		return
	end

	local armor = armor_inventory[1] -- getting the armor itself from armor inventory cell (basicly it has only one cell, which is first)
	if armor == nil or not armor.valid or armor.grid == nil or not armor.grid.valid then -- checking if armor has a valid grid (not all armors has a grid)
		disable_modifiers(player)
		return
	end

	if grid_has_equipment(armor.grid.equipment, "exoskeleton-mark-ii") then -- finally check if this grid of armor inventory has our equipment
		enable_modifiers(player)
	else
		disable_modifiers(player)
	end
end

--- Enables all modifiers for this player (player) 
-- The modifiers values are: 
-- character_inventory_slots_bonus = 60, which means +60 inventory slots
-- character_logistic_slot_count = 5, which adds +5 logistic inventory slots 
-- character_trash_slot_count_bonus = 10, which adds +10 trash inventory slots
-- character_mining_speed_modifier = 0.3, which speeds up the mining speed +30%
-- @param player Player whom modifiers must be updated
function enable_modifiers(player)
	if player.character_inventory_slots_bonus ~= 60 then
		player.character_inventory_slots_bonus  = 60
	end
	if player.character_logistic_slot_count ~= 6 then
		player.character_logistic_slot_count = 6
	end
	if player.character_trash_slot_count_bonus ~= 12 then
		player.character_trash_slot_count_bonus = 12
	end
	if player.character_mining_speed_modifier ~= 0.3 then
		player.character_mining_speed_modifier = 0.3
	end
end

--- Disables all modifiers for this player (player) 
-- The modifiers values are: 
-- character_inventory_slots_bonus = 0, which means +0 inventory slots
-- character_logistic_slot_count = 0, which adds +0 logistic inventory slots 
-- character_trash_slot_count_bonus = 0, which adds +0 trash inventory slots
-- character_mining_speed_modifier = 0, which speeds up the mining speed +0%
-- @param player Player whom modifiers must be updated
function disable_modifiers(player)
	player.character_inventory_slots_bonus  = 0
	player.character_logistic_slot_count = 0
	player.character_trash_slot_count_bonus = 0
	player.character_mining_speed_modifier = 0
end


--- Checks if armor grid has equipment with provided name (equipment_name)
-- @param grid Armor grid that will be used to search for equipment
-- @param equipment_name Equipment name (usually prototype name)
function grid_has_equipment(grid, equipment_name)
    for index, equipment in ipairs (grid) do
        if equipment.name == equipment_name then
            return true
        end
    end
    return false
end

--- New equipment placed to armor grid event handler
-- Tries to enable modifiers (@see enable_modifiers) for current player
-- if equiped item is Exoskeleton Mark II
script.on_event(defines.events.on_player_placed_equipment, on_equipment_changed)

--- Equipment removed from armor grid event handler
-- Tries to disable modifiers (@see enable_modifiers) for current player
-- if removed item is Exoskeleton Mark II. 
-- Also re-enables modifiers in case if removed item is not last in grid
script.on_event(defines.events.on_player_removed_equipment, on_equipment_changed)

--- Armor removed from player inventroy or another changes made to equipments
-- Tries to disable modifiers (@see enable_modifiers) for current player
-- if removed item is Exoskeleton Mark II or armor itself. 
-- Also re-enables modifiers in case if new armor contains Exoskeleton Mark II
script.on_event(defines.events.on_player_armor_inventory_changed, on_equipment_changed)

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
						on_equipment_changed{player_index = player.index}
					end
				end
			end
		end
	end
end)
