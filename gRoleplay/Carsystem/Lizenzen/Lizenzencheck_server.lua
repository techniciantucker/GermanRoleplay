camper = {
 [483]=true,
 [508]=true
}

function hasPlayerLicense ( player, id )
	if cars[id] then
		if tonumber ( westsideGetElementData ( player, "carlicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif bikes[id] then
		if tonumber ( westsideGetElementData ( player, "bikelicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif helicopters[id] then
		if tonumber ( westsideGetElementData ( player, "helilicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif planea[id] then
		if tonumber ( westsideGetElementData ( player, "planelicensea" ) ) == 1 then
			return true
		else
			return false
		end
	elseif planeb[id] then
		if tonumber ( westsideGetElementData ( player, "planelicenseb" ) ) == 1 then
			return true
		else
			return false
		end
	elseif motorboats[id] then
		if tonumber ( westsideGetElementData ( player, "motorbootlicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif raftboats[id] then
		if tonumber ( westsideGetElementData ( player, "segellicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif nolicense[id] then
		return true
	else
		return true
	end
end

function opticExitVehicle ( player )
	local veh = getPedOccupiedVehicle ( player )
	if isElement ( veh ) then
		if getPedOccupiedVehicleSeat ( player ) == 0 then
			setElementVelocity ( veh, 0, 0, 0 )
		end
		setControlState ( player, "enter_exit", false )
		setTimer ( removePedFromVehicle, 750, 1, player )
		setTimer ( setControlState, 125, 1, player, "enter_exit", false )
		setTimer ( setControlState, 125, 1, player, "enter_exit", true )
		setTimer ( setControlState, 700, 1, player, "enter_exit", false )
	end
end
addEvent ( "opticExitVehicle", true )
addEventHandler ( "opticExitVehicle", getRootElement(), function ()
	opticExitVehicle ( client )
end)