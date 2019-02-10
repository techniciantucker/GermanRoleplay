createBlip ( 2644.8999023438,-2042.5999755859,12.60000038147, 38, 2, 255, 0, 0, 255, 0, 200, getRootElement() )

local thismarker = createMarker(2644.8999023438,-2042.5999755859,12.60000038147, "cylinder", 2.5, 0,100,150)

function showpaintmenue ( hitElement, matchingDimension )
	if getElementType( hitElement ) == "vehicle" and matchingDimension then
		if getVehicleOccupant ( hitElement, 0 ) ~= false and getVehicleOccupant ( hitElement, 1 ) == false and getVehicleOccupant ( hitElement, 2 ) == false and getVehicleOccupant ( hitElement, 3 ) == false then
			local player = getVehicleOccupant ( hitElement )
			if player then
				if not copvehs[getElementModel ( hitElement )] then
					if westsideGetElementData ( hitElement, "owner" ) then
						if westsideGetElementData ( hitElement, "owner" ) == getPlayerName ( player ) then
							triggerClientEvent(player,"newloadscreen",player)
						
							setTimer(function()
							setElementVelocity ( hitElement, 0, 0, 0 )
							local thedim = math.random(500, 65000)
							setElementDimension(player, thedim)
							setElementDimension(hitElement, thedim)
							setElementPosition(hitElement, 2645.43994, -2034.59106, 12.97030)
							triggerClientEvent ( player, "showpaintmenue", player )
							local NT1 = westsideGetElementData ( getPedOccupiedVehicle(player), "NewTuningTL" )
							local NT2 = westsideGetElementData ( getPedOccupiedVehicle(player), "NewTuningMU" )
							end,4500,1)
						else
							infobox(player,"Du kannst nur\nPrivatfahrzeuge tunen!",4000,255,0,0)
						end
					else
						infobox(player,"Du kannst nur\nPrivatfahrzeuge tunen!",4000,255,0,0)
					end
				else
					infobox(player,"Du kannst nur\nPrivatfahrzeuge tunen!",4000,255,0,0)
				end
			end
		end
	end
end
addEventHandler ( "onMarkerHit", thismarker, showpaintmenue )

function setVehicleHandling_func (item, value)
	local tow = getPedOccupiedVehicle( source )
	local id = getElementModel(tow)
	local this = getOriginalHandling ( id )
	setVehicleHandling(tow, "suspensionLowerLimit", this["suspensionLowerLimit"]-0.2)
	setVehicleHandling(tow, "suspensionLowerLimit", this["suspensionLowerLimit"]+0.05*value)
	setVehicleHandling(tow, "suspensionLowerLimit", this["suspensionLowerLimit"]+0.05*value)
	setControlState(source, "backwards", true)
	setTimer(setControlState, 50, 1, source, "backwards", false)
	
	outputLog("[TUNING]: "..getPlayerName(player).." hat sich ein Tuning gekauft!","Spezialtunings")
end
addEvent ( "setVehicleHandling", true)
addEventHandler ( "setVehicleHandling", getRootElement(), setVehicleHandling_func)

function cancelpaintshop (player)
	local theVehicle = getPedOccupiedVehicle ( player )
	setElementDimension(theVehicle, 0)
	setElementDimension(player, 0)
	showCursor(player, false)
	local colors = westsideGetElementData ( getPedOccupiedVehicle(player), "color" )
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
		setVehicleColor ( getPedOccupiedVehicle(player), c1a, c1b, c1c, c2a, c2b, c2c, c3a, c3b, c3c, c4a, c4b, c4c )
		setTimer ( setVehicleColor, 100, 1, getPedOccupiedVehicle(player), c1a, c1b, c1c, c2a, c2b, c2c, c3a, c3b, c3c, c4a, c4b, c4c )
	else
		setVehicleColor ( getPedOccupiedVehicle(player), c1, c2, c3, c4 )
		setTimer ( setVehicleColor, 100, 1, getPedOccupiedVehicle(player), c1, c2, c3, c4 )
	end
	local NT1 = westsideGetElementData ( getPedOccupiedVehicle(player), "NewTuningTL" )
	local NT2 = westsideGetElementData ( getPedOccupiedVehicle(player), "NewTuningMU" )
	local tow = getPedOccupiedVehicle( source )
	local id = getElementModel(tow)
	local this = getOriginalHandling ( id )
	setVehicleHandling(tow, "suspensionLowerLimit", this["suspensionLowerLimit"]+0.05*NT1)
	setVehicleHandling(tow, "maxVelocity", this["maxVelocity"]+30/3*NT2)
	setVehicleHandling(tow, "engineAcceleration", this["engineAcceleration"]/this["maxVelocity"]*(this["maxVelocity"]+100/3*NT2))
	setVehicleHandling(tow, "engineInertia", this["engineInertia"]/this["maxVelocity"]*(this["maxVelocity"]+100/3*NT2))
end
addEvent ( "cancelpaintshop", true)
addEventHandler ( "cancelpaintshop", getRootElement(), cancelpaintshop)

function finishpaintshop ( player, veh, color )
local money = westsideGetElementData ( player, "money" )
	if money >= 3000 then
		takePlayerSaveMoney ( player, 3000 )
		local slot = westsideGetElementData ( veh, "carslotnr_owner" )
		local pname = MySQL_Save ( getPlayerName ( player ) )
		triggerClientEvent ( player, "showcsinfo", player, "Spezial-Lackierung wurde erfolgreich gekauft.", 0, 125, 0)
		westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 100)
		
		outputLog("[TUNING]: "..getPlayerName(player).." hat sich ein Tuning gekauft!","Spezialtunings")
		if slot then
			MySQL_SetString("vehicles", "Farbe", color, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			westsideSetElementData ( veh, "color", color )
		end
			local theVehicle = getPedOccupiedVehicle ( player )
			setElementDimension(theVehicle, 0)
			setElementDimension(player, 0)
			showCursor(player, false)
			local colors = westsideGetElementData ( getPedOccupiedVehicle(player), "color" )
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
				setVehicleColor ( getPedOccupiedVehicle(player), c1a, c1b, c1c, c2a, c2b, c2c, c3a, c3b, c3c, c4a, c4b, c4c )
				setTimer ( setVehicleColor, 100, 1, getPedOccupiedVehicle(player), c1a, c1b, c1c, c2a, c2b, c2c, c3a, c3b, c3c, c4a, c4b, c4c )
		else
			setVehicleColor ( getPedOccupiedVehicle(player), c1, c2, c3, c4 )
			setTimer ( setVehicleColor, 100, 1, getPedOccupiedVehicle(player), c1, c2, c3, c4 )
		end
		local NT1 = westsideGetElementData ( getPedOccupiedVehicle(player), "NewTuningTL" )
		local NT2 = westsideGetElementData ( getPedOccupiedVehicle(player), "NewTuningMU" )
		local tow = getPedOccupiedVehicle( source )
		local id = getElementModel(tow)
		local this = getOriginalHandling ( id )
		setVehicleHandling(tow, "suspensionLowerLimit", this["suspensionLowerLimit"]+0.05*NT1)
		setVehicleHandling(tow, "maxVelocity", this["maxVelocity"]+30/3*NT2)
		setVehicleHandling(tow, "engineAcceleration", this["engineAcceleration"]/this["maxVelocity"]*(this["maxVelocity"]+100/3*NT2))
		setVehicleHandling(tow, "engineInertia", this["engineInertia"]/this["maxVelocity"]*(this["maxVelocity"]+100/3*NT2))
		
		outputLog("[TUNING]: "..getPlayerName(player).." hat sich ein Tuning gekauft!","Spezialtunings")
	else
		triggerClientEvent ( player, "showcsinfo", player, "Du hast nicht genug Geld!", 255, 0, 0)
		
		outputLog("[TUNING]: "..getPlayerName(player).." hat sich ein Tuning gekauft!","Spezialtunings")
	end
end
addEvent ( "finishpaintshop", true)
addEventHandler ( "finishpaintshop", getRootElement(), finishpaintshop)

function finishpaintshop1 ( player, veh, tl )
	local preis = 999999999999
	local money = westsideGetElementData ( player, "money" )
	if tl == 1 then
		preis = 5000
	elseif tl == 2 then
		preis = 8000
	elseif tl == 3 then
		preis = 12000
	elseif tl == 4 then
		preis = 15000
	elseif tl == 5 then
		preis = 19500
	end
	if money >= preis then
		takePlayerSaveMoney ( player, preis )
		local slot = westsideGetElementData ( veh, "carslotnr_owner" )
		local pname = MySQL_Save ( getPlayerName ( player ) )
		triggerClientEvent ( player, "showcsinfo", player, "Tieferlegung wurde erfolgreich gekauft.", 0, 125, 0)
		westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 100)
		
		outputLog("[TUNING]: "..getPlayerName(player).." hat sich ein Tuning gekauft!","Spezialtunings")
		if slot then
			MySQL_SetString("vehicles", "NewTuningTL", tl, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			westsideSetElementData ( veh, "NewTuningTL", tl )
		end
		local theVehicle = getPedOccupiedVehicle ( player )
		setElementDimension(theVehicle, 0)
		setElementDimension(player, 0)
		showCursor(player, false)
		local colors = westsideGetElementData ( getPedOccupiedVehicle(player), "color" )
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
			setVehicleColor ( getPedOccupiedVehicle(player), c1a, c1b, c1c, c2a, c2b, c2c, c3a, c3b, c3c, c4a, c4b, c4c )
			setTimer ( setVehicleColor, 100, 1, getPedOccupiedVehicle(player), c1a, c1b, c1c, c2a, c2b, c2c, c3a, c3b, c3c, c4a, c4b, c4c )
		else
			setVehicleColor ( getPedOccupiedVehicle(player), c1, c2, c3, c4 )
			setTimer ( setVehicleColor, 100, 1, getPedOccupiedVehicle(player), c1, c2, c3, c4 )
		end
		local NT1 = westsideGetElementData ( getPedOccupiedVehicle(player), "NewTuningTL" )
		local NT2 = westsideGetElementData ( getPedOccupiedVehicle(player), "NewTuningMU" )
		local tow = getPedOccupiedVehicle( source )
		local id = getElementModel(tow)
		local this = getOriginalHandling ( id )
		setVehicleHandling(tow, "suspensionLowerLimit", this["suspensionLowerLimit"]+0.05*NT1)
		setVehicleHandling(tow, "maxVelocity", this["maxVelocity"]+30/3*NT2)
		setVehicleHandling(tow, "engineAcceleration", this["engineAcceleration"]/this["maxVelocity"]*(this["maxVelocity"]+100/3*NT2))
		setVehicleHandling(tow, "engineInertia", this["engineInertia"]/this["maxVelocity"]*(this["maxVelocity"]+100/3*NT2))
		
		outputLog("[TUNING]: "..getPlayerName(player).." hat sich ein Tuning gekauft!","Spezialtunings")
	else
		triggerClientEvent ( player, "showcsinfo", player, "Du hast nicht genug Geld!", 255, 0, 0)
		
		outputLog("[TUNING]: "..getPlayerName(player).." hat sich ein Tuning gekauft!","Spezialtunings")
	end
end
addEvent ( "finishpaintshop1", true)
addEventHandler ( "finishpaintshop1", getRootElement(), finishpaintshop1)

function output (player)
	local tow = getPedOccupiedVehicle( player )
	local id = getElementModel(tow)
	local this1 = getOriginalHandling ( id )
	local this2 = getVehicleHandling ( tow )
	outputChatBox(this1["maxVelocity"])
	outputChatBox(this1["maxVelocity"]+30/3*3)
	outputChatBox(this2["maxVelocity"])
end

function finishpaintshop2 ( player, veh, mu )
	local preis = 999999999999
	local money = westsideGetElementData ( player, "money" )
	if mu == 1 then
		preis = 15000
	elseif mu == 2 then
		preis = 20000
	elseif mu == 3 then
		preis = 35000
	end
	if money >= preis then
		takePlayerSaveMoney ( player, preis )
		local slot = westsideGetElementData ( veh, "carslotnr_owner" )
		local pname = MySQL_Save ( getPlayerName ( player ) )
		triggerClientEvent ( player, "showcsinfo", player, "Spezial-Motor wurde erfolgreich gekauft.", 0, 125, 0)
		westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 100)
		
		outputLog("[TUNING]: "..getPlayerName(player).." hat sich ein Tuning gekauft!","Spezialtunings")
		
		if slot then
			MySQL_SetString("vehicles", "NewTuningMU", mu, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			westsideSetElementData ( veh, "NewTuningMU", mu )
		end
		local theVehicle = getPedOccupiedVehicle ( player )
		setElementDimension(theVehicle, 0)
		setElementDimension(player, 0)
		showCursor(player, false)
		local colors = westsideGetElementData ( getPedOccupiedVehicle(player), "color" )
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
			setVehicleColor ( getPedOccupiedVehicle(player), c1a, c1b, c1c, c2a, c2b, c2c, c3a, c3b, c3c, c4a, c4b, c4c )
			setTimer ( setVehicleColor, 100, 1, getPedOccupiedVehicle(player), c1a, c1b, c1c, c2a, c2b, c2c, c3a, c3b, c3c, c4a, c4b, c4c )
		else
			setVehicleColor ( getPedOccupiedVehicle(player), c1, c2, c3, c4 )
			setTimer ( setVehicleColor, 100, 1, getPedOccupiedVehicle(player), c1, c2, c3, c4 )
		end
		local NT1 = westsideGetElementData ( getPedOccupiedVehicle(player), "NewTuningTL" )
		local NT2 = westsideGetElementData ( getPedOccupiedVehicle(player), "NewTuningMU" )
		local tow = getPedOccupiedVehicle( source )
		local id = getElementModel(tow)
		local this = getOriginalHandling ( id )
		setVehicleHandling(tow, "suspensionLowerLimit", this["suspensionLowerLimit"]+0.05*NT1)
		setVehicleHandling(tow, "maxVelocity", this["maxVelocity"]+30/3*NT2)
		setVehicleHandling(tow, "engineAcceleration", this["engineAcceleration"]/this["maxVelocity"]*(this["maxVelocity"]+100/3*NT2))
		setVehicleHandling(tow, "engineInertia", this["engineInertia"]/this["maxVelocity"]*(this["maxVelocity"]+100/3*NT2))
		
		outputLog("[TUNING]: "..getPlayerName(player).." hat sich ein Tuning gekauft!","Spezialtunings")
	else
		triggerClientEvent ( player, "showcsinfo", player, "Du hast nicht genug Geld!", 255, 0, 0)
		
		outputLog("[TUNING]: "..getPlayerName(player).." hat sich ein Tuning gekauft!","Spezialtunings")
	end
end
addEvent ( "finishpaintshop2", true)
addEventHandler ( "finishpaintshop2", getRootElement(), finishpaintshop2)