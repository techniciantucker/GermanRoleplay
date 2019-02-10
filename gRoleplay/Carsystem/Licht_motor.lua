noengine = { [509]=true, [481]=true, [510]=true, [462]=true }

function toggleVehicleLights ( player, key, state )
	if ( getPedOccupiedVehicleSeat ( player ) == 0 ) then
		local veh = getPedOccupiedVehicle ( player )
		if getElementModel ( veh ) ~= 438 then
			if ( getVehicleOverrideLights ( veh ) ~= 2 ) then
				setVehicleOverrideLights ( veh, 2 )
				westsideSetElementData ( veh, "light", true)
			else
				setVehicleOverrideLights ( veh, 1 )
				westsideSetElementData ( veh, "light", false)
			end
		end
	end
end

function rebindTrunk ( player )
	bindKey ( player, "sub_mission", "down", toggleVehicleTrunkBind, "Kofferraum auf/zu" )
end

function toggleVehicleEngine ( player, key, state )
	local veh = getPedOccupiedVehicle ( player )
	if getElementModel ( veh ) ~= 438 then
		if ( getPedOccupiedVehicleSeat ( player ) == 0 ) then
			-- // Falls das Fahrzeug neu gespawnt ist und noch keinen Benzinwert hat
			if not getElementData ( veh, "fuelstate" ) then
				westsideSetElementData ( veh, "fuelstate", 100 )
				westsideSetElementData ( veh, "engine", false )
				setVehicleOverrideLights ( veh, 1 )
				westsideSetElementData ( veh, "light", false)
				setVehicleEngineState ( veh, false )
			end
			-- // Falls der Motor läuft -> immer abschalten
			if getVehicleEngineState ( veh ) then
				setVehicleEngineState ( veh, false )
				westsideSetElementData ( veh, "engine", false )
			-- // Falls der Motor NICHT läuft, dem Spieler das Fahrzeug jedoch gehört
			elseif westsideGetElementData ( veh, "owner" ) == getPlayerName ( player ) and westsideGetElementData ( veh, "owner"  ) then
			-- // Falls das Fahrzeug noch genug Benzin hat
				if tonumber ( westsideGetElementData ( veh, "fuelstate" ) ) >= 1 then
					setVehicleEngineState ( veh, true )
					westsideSetElementData ( veh, "engine", true )
					if not westsideGetElementData ( veh, "timerrunning" ) then
						setVehicleNewFuelState ( veh )
						westsideSetElementData ( veh, "timerrunning", true )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Dieses Fahrzeug hat\nkein Benzin mehr!", 2500, 125,0,0 )
				end
			-- // Kein Besitzer bzw. Fraktionswagen / gespawnte Fahrzeuge
			elseif not westsideGetElementData ( veh, "owner" ) then
				if westsideGetElementData ( veh, "fuelstate" ) >= 1 then
					setVehicleEngineState ( veh, true )
					westsideSetElementData ( veh, "engine", true )
					if not westsideGetElementData ( veh, "timerrunning" ) then
						setVehicleNewFuelState ( veh )
						westsideSetElementData ( veh, "timerrunning", true )
					end
				end
			elseif westsideGetElementData ( veh, "ownerfraktion" ) then
				local car_acess
				if tonumber(westsideGetElementData( veh, "ownerfraktion" )) == tonumber(westsideGetElementData ( player, "fraktion" )) then
					car_acess = true
				elseif tonumber(westsideGetElementData( veh, "ownerfraktion" )) == 1 then
					if isStateFaction(player) then
						car_acess = true				
					end
				elseif tonumber(westsideGetElementData( veh, "ownerfraktion" )) == 6 then
					if isArmy(player) or isFBI(player) then
						car_acess = true				
					end
				end
				if westsideGetElementData ( veh, "fuelstate" ) >= 1 and car_acess == true then
					setVehicleEngineState ( veh, true )
					westsideSetElementData ( veh, "engine", true )
					if not westsideGetElementData ( veh, "timerrunning" ) then
						setVehicleNewFuelState ( veh )
						westsideSetElementData ( veh, "timerrunning", true )
					end
				end
			end
		end
	end
end

function enginecheck ( veh, seat )
	if seat == 0 then
		if ( not noengine[getElementModel ( veh )] or ( noengine[getElementModel ( veh )] and westsideGetElementData ( veh, "owner" ) ) ) and getElementModel ( veh ) ~= 438 then
			if not westsideGetElementData ( veh, "engine" ) then
				westsideSetElementData ( veh, "engine", false )
				setVehicleEngineState ( veh, false )
			end
			if not westsideGetElementData ( veh, "light" ) then
				westsideSetElementData ( veh, "light", false )
				setVehicleOverrideLights ( veh, 1 )
			end
			if getElementType ( source ) == "player" then
				if not isKeyBound ( source, "l", "down", toggleVehicleLights ) then
					bindKey ( source, "l", "down", toggleVehicleLights, "Licht an/aus" )
					bindKey ( source, "x", "down", toggleVehicleEngine, "Motor an/aus" )
				end
			end
		end
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), enginecheck )

function vehexit ()
	unbindKey ( source, "l", "down", toggleVehicleLights, "Licht an/aus" )
	unbindKey ( source, "x", "down", toggleVehicleEngine, "Motor an/aus" )
	unbindKey ( source, "sub_mission", "down", toggleVehicleTrunkBind, "Kofferraum auf/zu" )
end
addEventHandler ("onPlayerVehicleExit", getRootElement(), vehexit )