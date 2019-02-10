local usedCarStrings = {}
debug.sethook()
carsSpawned = false

function privVeh_spawning()
	caramount = 0
	deletedcars = 0
	result = mysql_query(handler, "SELECT * FROM vehicles")
	if( not result) then
		 outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
	else
		if(mysql_num_rows(result) > 0) then
			carsData = mysql_fetch_assoc(result)
			mySQLCarCreate ()
		else
			mysql_free_result(result)
			outputServerLog("Es wurden keine Autos gefunden")
		end
	end
end
setTimer ( privVeh_spawning, 5000, 1 )

function mySQLCarCreate ()
	if not carsSpawned then
		caramount = caramount + 1
		local Besitzer = carsData["Besitzer"]
		local valid = true

		if valid then
			if Besitzer == MySQL_Save ( Besitzer ) then
				if isOwnerActive ( Besitzer ) then
					local Typ = carsData["Typ"]
					local Tuning = carsData["Tuning"]
					local Spawnpos_X = tonumber(carsData["Spawnpos_X"])
					local Spawnpos_Y = tonumber(carsData["Spawnpos_Y"])
					local Slot = carsData["Slot"]
					local tmp = getPrivVehString ( Besitzer, Slot )
					if not badMySQLCarHouseXSpawns[math.floor ( Spawnpos_X )] and not badMySQLCarHouseYSpawns[math.floor ( Spawnpos_Y )] and not usedCarStrings[tmp] then
						usedCarStrings[tmp] = true
						local Spawnpos_Z = tonumber(carsData["Spawnpos_Z"])
						local Spawnrot_X = tonumber(carsData["Spawnrot_X"])
						local Spawnrot_Y = tonumber(carsData["Spawnrot_Y"])
						local Spawnrot_Z = tonumber(carsData["Spawnrot_Z"])
						local Special = tonumber(carsData["Special"]) 
						local Farbe = carsData["Farbe"]
						local Tieferlegung = tonumber(carsData["NewTuningTL"])
						local MotorUpgrade = tonumber(carsData["NewTuningMU"])
						if #( tostring ( Farbe ) )<= 3 then
							Farbe = "0|0|0|0"
							MySQL_SetString("vehicles", "Farbe", Farbe, "Besitzer LIKE '" ..Besitzer.."' AND Slot LIKE '" ..tonumber(Slot).. "' ")
						end
						local Paintjob = carsData["Paintjob"]
						local Benzin = carsData["Benzin"]
						local Gang = carsData["Gang"]
						_G[getPrivVehString ( Besitzer, Slot )] = createVehicle ( Typ, Spawnpos_X, Spawnpos_Y, Spawnpos_Z, 0, 0, 0, Besitzer )
						if Special == 2 then
							local vx, vy, vz = Spawnpos_X, Spawnpos_Y-2, 1.55
							both = Besitzer..Slot
							_G["ObjYacht"..both] = createObject ( 1337, vx, vy, vz )
							attachElements ( _G["ObjYacht"..both], _G[getPrivVehString ( Besitzer, Slot )], 0, 2, 1.55 )
							setElementDimension ( _G["ObjYacht"..both], 1 )
						end
						local veh = _G[getPrivVehString ( Besitzer, Slot )]

						if not isNotCarTowing(player,Slot) then
						setElementDimension(veh,99999);
						end
						
						local STuning = MySQL_GetString("vehicles", "STuning", "Besitzer LIKE '"..Besitzer.."' AND Slot LIKE '"..Slot.."'")
						westsideSetElementData ( veh, "stuning", STuning )
						setVehicleRotation ( veh, Spawnrot_X, Spawnrot_Y, Spawnrot_Z )
						westsideSetElementData ( veh, "owner", Besitzer )
						westsideSetElementData ( veh, "name", veh )
						westsideSetElementData ( veh, "carslotnr_owner", Slot )
						westsideSetElementData ( veh, "locked", true )
						westsideSetElementData ( veh, "color", Farbe )
						westsideSetElementData ( veh, "NewTuningTL", Tieferlegung )
						westsideSetElementData ( veh, "NewTuningMU", MotorUpgrade )
						westsideSetElementData ( veh, "spawnpos_x", Spawnpos_X )
						westsideSetElementData ( veh, "spawnpos_y", Spawnpos_Y )
						westsideSetElementData ( veh, "spawnpos_z", Spawnpos_Z )
						westsideSetElementData ( veh, "spawnrot_x", Spawnrot_X )
						westsideSetElementData ( veh, "spawnrot_y", Spawnrot_Y )
						westsideSetElementData ( veh, "spawnrot_z", Spawnrot_Z )
						westsideSetElementData ( veh, "special", Special )
						westsideSetElementData ( veh, "lcolor", carsData["Lights"] )
						westsideSetElementData ( veh, "distance", tonumber ( carsData["Distance"] ) )
						setPrivVehCorrectLightColor ( veh )
						setVehicleLocked ( veh, true )
						westsideSetElementData ( veh, "fuelstate", tonumber ( Benzin ) )
						setPrivVehCorrectColor ( veh )
						setVehiclePaintjob ( veh, Paintjob )
						setElementFrozen ( veh, true )
						if tonumber(Tuning) == 1 then
							MySQL_SetString("vehicles", "Tuning", "|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|", "Besitzer LIKE '"..Besitzer.."' AND Slot LIKE '"..Slot.."'")
							local Tuning = "|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|"
						else
							pimpVeh ( veh, Tuning )
						end
						
						westsideSetElementData ( veh, "rcVehicle", tonumber ( carsData["rc"] ) )
					end
				else
					local Besitzer = carsData["Besitzer"]
					local bantime = tonumber ( MySQL_GetString ( "ban", "STime", "Name LIKE '"..Besitzer.."'" ) )
					local diff = math.floor ( ( ( bantime - getTBanSecTime ( 0 ) ) / 60 ) * 100 ) / 100
				end
			end
		end
		carsData = mysql_fetch_assoc(result)
		if carsData then
			mySQLCarCreate()
		else
			mysql_free_result(result)
			carsSpawned = true
			outputServerLog("Es wurden "..caramount.." Fahrzeuge gefunden und "..deletedcars.." Fahrzeuge von inaktiven Benutzern entfernt.")
		end
	end
end
	
function pimpVeh ( veh, tuning )
	for i = 0, 16 do
		local x = i + 1
		_G["tunepart"..i] = tonumber(gettok ( tuning, x, string.byte('|') ))
	end
	for i = 0, 16 do
		if _G["tunepart"..i] > 0 then
			addVehicleUpgrade ( veh, _G["tunepart"..i] )
		end
	end
	specPimpVeh ( veh )
end

function setPrivVehCorrectColor ( veh )
	local colors = westsideGetElementData ( veh, "color" )
	local c1 = gettok ( colors, 1, string.byte( '|' ) )
	local c2 = gettok ( colors, 2, string.byte( '|' ) )
	local c3 = gettok ( colors, 3, string.byte( '|' ) )
	local c4 = gettok ( colors, 4, string.byte( '|' ) )
	if string.find ( c1, "," ) then
		local c1a = gettok ( c1, 1, string.byte( ',' ) )
		local c1b = gettok ( c1, 2, string.byte( ',' ) )
		local c1c = gettok ( c1, 3, string.byte( ',' ) )
		local c2a = gettok ( c2, 1, string.byte( ',' ) )
		local c2b = gettok ( c2, 2, string.byte( ',' ) )
		local c2c = gettok ( c2, 3, string.byte( ',' ) )
		local c3a = gettok ( c3, 1, string.byte( ',' ) )
		local c3b = gettok ( c3, 2, string.byte( ',' ) )
		local c3c = gettok ( c3, 3, string.byte( ',' ) )
		local c4a = gettok ( c4, 1, string.byte( ',' ) )
		local c4b = gettok ( c4, 2, string.byte( ',' ) )
		local c4c = gettok ( c4, 3, string.byte( ',' ) )
		setVehicleColor ( veh, c1a, c1b, c1c, c2a, c2b, c2c, c3a, c3b, c3c, c4a, c4b, c4c )
		setTimer ( setVehicleColor, 100, 1, veh, c1a, c1b, c1c, c2a, c2b, c2c, c3a, c3b, c3c, c4a, c4b, c4c )
	else
		setVehicleColor ( veh, c1, c2, c3, c4 )
		setTimer ( setVehicleColor, 100, 1, veh, c1, c2, c3, c4 )
	end
	local NT1 = westsideGetElementData ( veh, "NewTuningTL" )
	local NT2 = westsideGetElementData ( veh, "NewTuningMU" )
	local id = getElementModel(veh)
	local this = getOriginalHandling ( id )
	if NT1 >= 1 and NT1 <= 5 then
		setVehicleHandling(veh, "suspensionLowerLimit", this["suspensionLowerLimit"]+0.05*NT1)
	end
	if NT2 >= 1 and NT2 <= 3 then
		setVehicleHandling(veh, "maxVelocity", this["maxVelocity"]+30/3*NT2)
		setVehicleHandling(veh, "engineAcceleration", this["engineAcceleration"]/this["maxVelocity"]*(this["maxVelocity"]+100/3*NT2))
		setVehicleHandling(veh, "engineInertia", this["engineInertia"]/this["maxVelocity"]*(this["maxVelocity"]+100/3*NT2))
	end
end

function setPrivVehCorrectLightColor ( veh )
	if veh then
		local colors = westsideGetElementData ( veh, "lcolor" )
		if colors then
			local c1 = tonumber ( gettok ( colors, 1, string.byte( '|' ) ))
			local c2 = tonumber ( gettok ( colors, 2, string.byte( '|' ) ))
			local c3 = tonumber ( gettok ( colors, 3, string.byte( '|' ) ))
			westsideSetElementData ( veh, "lc1", c1 )
			westsideSetElementData ( veh, "lc2", c2 )
			westsideSetElementData ( veh, "lc3", c3 )
			setVehicleHeadLightColor ( veh, c1, c2, c3 )
		end
	end
end

function isOwnerActive ( pname )
	return true
end