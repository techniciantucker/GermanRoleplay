setGarageOpen ( 18, true )
setGarageOpen ( 33, true )
setGarageOpen ( 10, true )
MarkerTuning1 = createMarker ( -1936.0651855469, 245.01071166992, 33.385932922363, "cylinder", 3, 200, 0, 0, 200, getRootElement() )
MarkerTuning2 = createMarker ( 2386.8405761719, 1048.7375488281, 8.9104995727539, "cylinder", 3, 200, 0, 0, 200, getRootElement() )
MarkerTuning3 = createMarker ( 1041.4000244141,  -1020.5999755859, 30.89999961853, "cylinder", 3, 200, 0, 0, 200, getRootElement() )

westsideSetElementData ( MarkerTuning1, "sx", -1936.6840820313 )
westsideSetElementData ( MarkerTuning1, "sy", 220.6498260498 )
westsideSetElementData ( MarkerTuning1, "sz", 34.3125 )
westsideSetElementData ( MarkerTuning1, "sr", 0 )

westsideSetElementData ( MarkerTuning2, "sx", 2393.8520507813 )
westsideSetElementData ( MarkerTuning2, "sy", 989.70678710938 )
westsideSetElementData ( MarkerTuning2, "sz", 10.690312385559 )
westsideSetElementData ( MarkerTuning2, "sr", 0 )

westsideSetElementData ( MarkerTuning3, "sx", 1045 )
westsideSetElementData ( MarkerTuning3, "sy", -1044 )
westsideSetElementData ( MarkerTuning3, "sz", 32.20 )
westsideSetElementData ( MarkerTuning3, "sr", 0 )

function applyLightValues_func ( red, green, blue )
	local red = MySQL_Save ( red )
	local green = MySQL_Save ( green )
	local blue = MySQL_Save ( blue )
	local player = client
	local veh = getPedOccupiedVehicle ( player )
	setVehicleHeadLightColor ( veh, red, green, blue )
	local pname = westsideGetElementData ( veh, "owner" )
	local slot = westsideGetElementData ( veh, "carslotnr_owner" )
	if pname == getPlayerName ( player ) then
		lcolor = "|"..red.."|"..green.."|"..blue.."|"
		westsideSetElementData ( veh, "lcolor", lcolor )
		
		MySQL_SetString("vehicles", "Lights", lcolor, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '"..slot.."'")
	end
end
addEvent ( "applyLightValues", true )
addEventHandler ( "applyLightValues", getRootElement(), applyLightValues_func )

function applyCarColoursValues_func ( red, green, blue )
	local red = MySQL_Save ( red )
	local green = MySQL_Save ( green )
	local blue = MySQL_Save ( blue )
	local player = client
	local veh = getPedOccupiedVehicle ( player )
	setVehicleColor ( veh, red, green, blue )
	local pname = westsideGetElementData ( veh, "owner" )
	local slot = westsideGetElementData ( veh, "carslotnr_owner" )
	if pname == getPlayerName ( player ) then
		lightcolor = "|"..red.."|"..green.."|"..blue.."|"
		westsideSetElementData ( veh, "lightcolor", lightcolor )
	end
end
addEvent ( "applyCarColoursValues", true )
addEventHandler ( "applyCarColoursValues", getRootElement(), applyCarColoursValues_func )

function MarkerTuningHit ( hitElement, matchingDimension )
	if getElementType( hitElement ) == "vehicle" and matchingDimension then
		if getVehicleOccupant ( hitElement, 0 ) ~= false and getVehicleOccupant ( hitElement, 1 ) == false and getVehicleOccupant ( hitElement, 2 ) == false and getVehicleOccupant ( hitElement, 3 ) == false then
			if not copvehs[getElementModel ( hitElement )] then
				local player = getVehicleOccupant ( hitElement )
				if player then
					if westsideGetElementData ( hitElement, "owner" ) then
						if westsideGetElementData ( hitElement, "owner" ) == getPlayerName ( player ) then
						
							triggerClientEvent(player,"newloadscreen",player)
							
							local x, y, z = getElementPosition(player);
							setElementData(player, "old_position_x", x);
							setElementData(player, "old_position_y", y);
							setElementData(player, "old_position_z", z);
							
							setTimer(function()
							local x, y, z, r = westsideGetElementData ( source, "sx" ), westsideGetElementData ( source, "sy" ), westsideGetElementData ( source, "sz" ), westsideGetElementData( source, "sr" )
							
							if bikes[getElementModel ( hitElement )] or getElementModel ( hitElement ) == 462 or getElementModel ( hitElement ) == 448 then
								removePedFromVehicle ( player )
								warpPedIntoVehicle ( player, hitElement, 1 )
							end
							i = tonumber ( westsideGetElementData ( player, "playerid" ) )
							westsideSetElementData ( hitElement, "usingdim", i )
							setElementPosition ( hitElement, -2053.7531738281, 143.72497558594, 28.923471450806 )
							setVehicleRotation ( hitElement, 0, 0, 290 )
							setElementDimension ( hitElement, i )
							setElementDimension ( player, i )
							setElementInterior ( hitElement, i )
							setElementInterior ( player, i )
							setElementVelocity ( hitElement, 0, 0, 0 )
							setCameraMatrix ( player, -2059.251953125, 149.47894287109, 31.377527236938, -2047.3326416016, 137.53858947754, 29.064981460571 )
							triggerClientEvent ( player, "createTuningMenue", getRootElement() )
							showPlayerHudComponent ( player, "ammo", true )
							showPlayerHudComponent ( player, "weapon", true )
							showPlayerHudComponent ( player, "armour", true )
							showPlayerHudComponent ( player, "money", true )
							westsideSetElementData ( player, "ElementClicked", true )
							end,3000,1)
						else
							infobox(player,"Du kannst nur\nPrivatfahrzeuge tunen!",4000,255,0,0)
						end
					else
						infobox(player,"Du kannst nur\nPrivatfahrzeuge tunen!",4000,255,0,0)
					end
				end
			else
				infobox(player,"Du kannst nur\nPrivatfahrzeuge tunen!",4000,255,0,0)
			end
		end
	end
end
addEventHandler ( "onMarkerHit", MarkerTuning1, MarkerTuningHit )
addEventHandler ( "onMarkerHit", MarkerTuning2, MarkerTuningHit )
addEventHandler ( "onMarkerHit", MarkerTuning3, MarkerTuningHit )

function addSpecialTuning_func ( tuning )
	local player = source
	if player == client then
		local price = specialUpgradePrice[tuning]
		local money = westsideGetElementData ( player, "money" )
		if money >= price then
			local pname = MySQL_Save ( getPlayerName ( player ) )
			local veh = getPedOccupiedVehicle ( player )
			local totTuning = ""
			for i = 1, 6 do
				if i == tuning then
					westsideSetElementData ( veh, "stuning"..i, tuning )
					totTuning = totTuning.."1".."|"
					if i == 1 then
						outputChatBox ( "[INFO]: Dein Fahrzeug hat nun einen Kofferaum! Öffnen: /kofferraum!", player, 0,100,150)
						outputLog("[TUNINGS]: "..getPlayerName(player).." hat sich einen Kofferaum gekauft!","Tunings")
						westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 100)
					elseif i == 2 then
						outputChatBox ( "[INFO]: Dein Fahrzeug ist nun gepanzert!", player, 0,100,150)
						outputLog("[TUNINGS]: "..getPlayerName(player).." hat sich eine Panzerung gekauft!","Tunings")
						westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 100)
					elseif i == 3 then
						outputChatBox ( "[INFO]: Dein Fahrzeug verbraucht nun deutlich weniger Benzin!", player, 0,100,150)
						outputLog("[TUNINGS]: "..getPlayerName(player).." hat sich Benzin Ersparnis gekauft!","Tunings")
						westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 100)
					elseif i == 4 then
						outputChatBox ( "[INFO]: Dein Fahrzeug hat nun einen GPS-Sender!", player, 0,100,150)
						outputLog("[TUNINGS]: "..getPlayerName(player).." hat sich einen GPS Sender gekauft!","Tunings")
						westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 100)
					end
				else
					local tok = gettok ( westsideGetElementData ( veh, "stuning" ), i, string.byte ( '|' ) )
					totTuning = totTuning..tok.."|"
				end
			end
			totTuning = MySQL_Save ( totTuning )
			westsideSetElementData ( veh, "stuning", totTuning )
			MySQL_SetString("vehicles", "STuning", totTuning, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..westsideGetElementData ( veh, "carslotnr_owner" ).. "' ")
			specPimpVeh ( veh )
			specialTuningVehEnter ( player, 0 )
			westsideSetElementData ( player, "money", money - price )
		end
	end
end
addEvent ( "addSpecialTuning", true )
addEventHandler ( "addSpecialTuning", getRootElement(), addSpecialTuning_func )

function CancelTuning_func ( player, veh, c1, c2, c3, c4, paintjob, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16 )
	if player == client then
	
		paintjob = MySQL_Save ( paintjob )
		westsideSetElementData ( veh, "color", color )
		setPrivVehCorrectColor ( veh )
		setElementDimension ( player, 0 )
		setElementInterior ( player, 0 )
		setElementDimension ( veh, 0 )
		setElementInterior ( veh, 0 )

		local x, y, z =  getElementData(player, "old_position_x"), getElementData(player, "old_position_y"), getElementData(player, "old_position_z");
		setElementPosition(veh,x,y-15,z)
		setElementRotation ( veh, 0, 0, 90 )
		
		setElementFrozen ( veh, true )
		setElementVelocity ( veh, 0, 0, 0 )
		setTimer ( setElementVelocity, 1000, 1, veh, 0, 0, 0 )
		setTimer ( setElementFrozen, 2000, 1, veh, false )
		setTimer ( setElementVelocity, 2000, 1, veh, 0, 0, 0 )
		setCameraTarget ( player, player )
		for i = 0, 16 do
			local upgrade = getVehicleUpgradeOnSlot ( veh, i )
			if upgrade then
				removeVehicleUpgrade ( veh, upgrade )
			end
		end
		local tuning = "|"
		if t0 == false then t0 = 0 else addVehicleUpgrade ( veh, t0 ) end
		tuning = tuning..t0.."|"
		if t1 == false then t1 = 0 else addVehicleUpgrade ( veh, t1 ) end
		tuning = tuning..t1.."|"
		if t2 == false then t2 = 0 else addVehicleUpgrade ( veh, t2 ) end
		tuning = tuning..t2.."|"
		if t3 == false then t3 = 0 else addVehicleUpgrade ( veh, t3 ) end
		tuning = tuning..t3.."|"
		if t4 == false then t4 = 0 else addVehicleUpgrade ( veh, t4 ) end
		tuning = tuning..t4.."|"
		if t5 == false then t5 = 0 else addVehicleUpgrade ( veh, t5 ) end
		tuning = tuning..t5.."|"
		if t6 == false then t6 = 0 else addVehicleUpgrade ( veh, t6 ) end
		tuning = tuning..t6.."|"
		if t7 == false then t7 = 0 else addVehicleUpgrade ( veh, t7 ) end
		tuning = tuning..t7.."|"
		if t8 == false then t8 = 0 else addVehicleUpgrade ( veh, t8 ) end
		tuning = tuning..t8.."|"
		if t9 == false then t9 = 0 else addVehicleUpgrade ( veh, t9 ) end
		tuning = tuning..t9.."|"
		if t10 == false then t10 = 0 else addVehicleUpgrade ( veh, t10 ) end
		tuning = tuning..t10.."|"
		if t11 == false then t11 = 0 else addVehicleUpgrade ( veh, t11 ) end
		tuning = tuning..t11.."|"
		if t12 == false then t12 = 0 else addVehicleUpgrade ( veh, t12 ) end
		tuning = tuning..t12.."|"
		if t13 == false then t13 = 0 else addVehicleUpgrade ( veh, t13 ) end
		tuning = tuning..t13.."|"
		if t14 == false then t14 = 0 else addVehicleUpgrade ( veh, t14 ) end
		tuning = tuning..t14.."|"
		if t15 == false then t15 = 0 else addVehicleUpgrade ( veh, t15 ) end
		tuning = tuning..t15.."|"
		if t16 == false then t16 = 0 else addVehicleUpgrade ( veh, t16 ) end
		tuning = tuning..t16.."|"
		tuning = MySQL_Save ( tuning )
		local pname = MySQL_Save ( getPlayerName ( player ) )
		local slot = westsideGetElementData ( veh, "carslotnr_owner" )
		activeCarGhostMode ( player, 10000 )
		if slot then
			MySQL_SetString("vehicles", "Tuning", tuning, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Paintjob", paintjob, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
		end
	end
end
addEvent ( "CancelTuning", true )
addEventHandler ( "CancelTuning", getRootElement(), CancelTuning_func )

function buyTuningPart_func ( player, veh, part, price )
	if player == client then
		price = math.floor ( math.abs ( price ) )
		moneychange ( player, (price*-1) )
	end
end
addEvent ( "buyTuningPart", true )
addEventHandler ( "buyTuningPart", getRootElement(), buyTuningPart_func )