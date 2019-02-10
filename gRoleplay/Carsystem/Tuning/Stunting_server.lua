function specPimpVeh ( veh )

	local stuning = westsideGetElementData ( veh, "stuning" )
	for i = 1, 6 do
		westsideSetElementData ( veh, "stuning"..i, tonumber ( gettok ( stuning, i, string.byte ( "|" ) ) ) )
	end
	-- Kofferraum
	if westsideGetElementData ( veh, "stuning1" ) >= 1 then
		
	else
		westsideSetElementData ( veh, "stuning1", false )
	end
	-- Panzerung
	if westsideGetElementData ( veh, "stuning2" ) >= 1 then
		setElementHealth ( veh, 1700 )
	else
		westsideSetElementData ( veh, "stuning2", false )
	end
	-- Benzinersparnis
	if westsideGetElementData ( veh, "stuning3" ) >= 1 then
		westsideSetElementData ( veh, "fuelSaving", true )
	else
		westsideSetElementData ( veh, "stuning3", false )
	end
	-- GPS
	if westsideGetElementData ( veh, "stuning4" ) >= 1 then
		westsideSetElementData ( veh, "gps", true )
	else
		westsideSetElementData ( veh, "stuning4", false )
	end
	local event = false
	-- Doppelreifen
	if westsideGetElementData ( veh, "stuning5" ) >= 1 then
		westsideSetElementData ( veh, "wheelrefreshable", true )
		event = true
	else
		westsideSetElementData ( veh, "stuning5", false )
	end
	-- Nebelwerfer
	if westsideGetElementData ( veh, "stuning6" ) >= 1 then
		westsideSetElementData ( veh, "smokeable", true )
		event = true
	else
		westsideSetElementData ( veh, "stuning6", false )
	end
	if event then
		addEventHandler ( "onVehicleEnter", veh, specialTuningVehEnter )
		addEventHandler ( "onVehicleExit", veh, specialTuningVehExit )
	end
end

function createSmokeBehindVehicle ( player )
	local veh = getPedOccupiedVehicle ( player )
	if westsideGetElementData ( veh, "smokeable" ) then
		westsideSetElementData ( veh, "smokeable", false )
		local x, y, z = getElementPosition ( veh )
		local smoker1 = createObject ( 2780, x, y-0.1, z )
		local smoker2 = createObject ( 2780, x, y, z )
		local smoker3 = createObject ( 2780, x, y+0.1, z )
		setElementAlpha ( smoker1, 0 )
		setElementAlpha ( smoker2, 0 )
		setElementAlpha ( smoker3, 0 )
		attachElementsInCorrectWay ( smoker1, veh )
		attachElementsInCorrectWay ( smoker2, veh )
		attachElementsInCorrectWay ( smoker3, veh )
		setTimer ( destroyElement, 7500, 1, smoker1 )
		setTimer ( destroyElement, 7500, 1, smoker2 )
		setTimer ( destroyElement, 7500, 1, smoker3 )
		outputChatBox ( "[INFO]: Nebelwand: Verfügbar nach dem Respawn deines Fahrzeuges!", player, 0,100,150 )
	else
		outputChatBox ( "[INFO]: Nebelwand: Nicht verügbar! (Respawne dein Fahrzeug)!", player, 0,100,150 )
	end
end

function refreshWheels ( player )
	local veh = getPedOccupiedVehicle ( player )
	if westsideGetElementData ( veh, "wheelrefreshable" ) then
		westsideSetElementData ( veh, "wheelrefreshable", false )
		setVehicleWheelStates ( veh, 0, 0, 0, 0 )
		infobox(player,"Reifen aufgepumpt!",4000,0,255,0)
	end
end

function specialTuningVehEnter ( player, seat )
	local veh = getPedOccupiedVehicle ( player )
	if seat == 0 then
		if not isKeyBound ( player, "n", "down", createSmokeBehindVehicle ) then
			if westsideGetElementData ( veh, "smokeable" ) then
				outputChatBox ( "[INFO]: Nebelwand: Verfügbar! Tippe 'N' um sie zu benutzen!", player,0,100,150 )
				bindKey ( player, "n", "down", createSmokeBehindVehicle )
			elseif westsideGetElementData ( veh, "stuning6" ) then
				outputChatBox ( "[INFO]: Nebelwand: Nicht verfügbar! (Respawne dein Fahrzeug)!", player, 0,100,150 )
			end
		end
		if not isKeyBound ( player, "r", "down", refreshWheels ) then
			if westsideGetElementData ( veh, "wheelrefreshable" ) then
				outputChatBox ( "[INFO]: Reifen-Pumpe: Verfügbar! Tippe 'R' um sie zu benutzen!", player, 0,100,150 )
				bindKey ( player, "r", "down", refreshWheels )
			elseif westsideGetElementData ( veh, "stuning5" ) then
				outputChatBox ( "[INFO]: Reifen-Pumpe: Nicht verfügbar! (Respawne dein Fahrzeug)!", player, 0,100,150 )
			end
		end
	end
end

function specialTuningVehExit ( player, seat )
	local veh = getPedOccupiedVehicle ( player )
	if seat == 0 then
		if isKeyBound ( player, "n", "down", createSmokeBehindVehicle ) then
			unbindKey ( player, "n", "down", createSmokeBehindVehicle )
		end
		if isKeyBound ( player, "r", "down", refreshWheels ) then
			unbindKey ( player, "r", "down", refreshWheels )
		end
	end
end

----- Kofferraum -----
function trunkStorageServer_func ( element, value, take )
	if source == client then
		if tostring ( element ) == MySQL_Save ( element ) and tostring ( value ) == MySQL_Save ( value ) then
			local player = source
			local veh    = getPedOccupiedVehicle(player)
			
			local data = MySQL_GetString( "vehicles", "Kofferraum", "Besitzer LIKE '"..westsideGetElementData ( veh, "owner" ).."' AND Slot LIKE '"..westsideGetElementData ( veh, "carslotnr_owner" ).."'" )
			
			local drugs  = tonumber ( gettok ( data, 1, string.byte ( '|' ) ) )
			local mats   = tonumber ( gettok ( data, 2, string.byte ( '|' ) ) )
			
			if element == "drugs" or element == "mats" then
				value = math.abs ( math.floor ( tonumber ( value ) ) )
			end
			
			if take then
				if element == "drugs" then
					if drugs >= value then
						drugs = drugs - value
						westsideSetElementData ( player, "drugs", westsideGetElementData ( player, "drugs" ) + value )
					end
				elseif element == "mats" then
					if mats >= value then
						mats = mats - value
						westsideSetElementData ( player, "mats", westsideGetElementData ( player, "mats" ) + value )
					end
				end
			else
				if element == "drugs" then
					if westsideGetElementData ( player, "drugs" ) >= value then
						drugs = drugs + value
						westsideSetElementData ( player, "drugs", westsideGetElementData ( player, "drugs" ) - value )
					end
				elseif element == "mats" then
					if westsideGetElementData ( player, "mats" ) >= value then
						mats = mats + value
						westsideSetElementData ( player, "mats", westsideGetElementData ( player, "mats" ) - value )
					end
				end
			end

			local string   = tostring ( drugs.."|"..mats.."|")
			local Besitzer = westsideGetElementData ( veh, "owner" )
			local slot     = tonumber ( westsideGetElementData ( veh, "carslotnr_owner" ) )
			
			MySQL_SetString ( "vehicles", "Kofferraum", string, "Besitzer LIKE '"..Besitzer.."' AND Slot LIKE '" ..slot.. "' ")
		end
	end
end
addEvent ( "trunkStorageServer", true )
addEventHandler ( "trunkStorageServer", getRootElement(), trunkStorageServer_func )