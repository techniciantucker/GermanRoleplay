setGarageOpen ( 45, true )

function changeVehicleColor_func ( c1, c2, c3, c4 )

	local veh = getPedOccupiedVehicle ( client )
	if veh then
		if getPedOccupiedVehicleSeat ( client ) == 0 then
			setVehicleColor ( veh, c1, c2, c3, c4 )
		end
	end
end
addEvent ( "changeVehicleColor", true )
addEventHandler ( "changeVehicleColor", getRootElement(), changeVehicleColor_func )

PnsLVCity = createColSphere ( 1976.6048583984, 2162.4150390625, 9.5703125, 3 )
PnsFortCarson = createColSphere ( -99.773811340332, 1118.3737792969, 18.294296264648, 3 )
PnsLSTemple = createColSphere ( 487.10000610352, -1743.1999511719, 10.10000038147, 4.5 )
setGarageOpen ( 36, true )
setGarageOpen ( 41, true )
setGarageOpen ( 12, true )
setGarageOpen ( 11, true )
setGarageOpen ( 8, true )
PnsLVCityBlip = createBlip ( 1976.6048583984, 2162.4150390625, 9.5703125, 63, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
PnsFortCarsonBlip = createBlip ( -99.773811340332, 1118.3737792969, 18.294296264648, 63, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
PnsLSTempleBlip = createBlip ( 487.10000610352, -1743.1999511719, 10.10000038147, 63, 2, 255, 0, 0, 255, 0, 200, getRootElement() )

PnsLSNordBlip = createBlip ( 1024.9000244141, -1022.4000244141, 32.099998474121, 63, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
PnsLSNord = createColSphere ( 1024.9000244141, -1022.4000244141, 32.099998474121, 3 )

PnsLSOstBlip = createBlip ( 2063.6000976563, -1831.5999755859, 11, 63, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
PnsLSOst = createColSphere ( 2063.6000976563, -1831.5999755859, 11, 3 )

westsideSetElementData ( PnsLVCity, "gateID", 36 )
westsideSetElementData ( PnsFortCarson, "gateID", 41 )
westsideSetElementData ( PnsLSTemple, "gateID", 12 )
westsideSetElementData ( PnsLSNord, "gateID", 11 )
westsideSetElementData ( PnsLSOst, "gateID", 8 )

PnsSFWangCars = createColCircle (-1904.47949, 289.4714660, 5 )
PnsSFJuniperHill = createColCircle (-2425.8376464844, 1020.0791015625, 5 )
PnsSFJuniperHillBlip = createBlip ( -2425.8376464844, 1020.0791015625, 50, 63, 2, 255, 0, 0, 255, 0, 200, getRootElement() )


setGarageOpen ( 19, true )
setGarageOpen ( 27, true )

function PnsSFWangCarsHit ( hitelement )
	if getElementType ( hitelement ) == "vehicle" then
		if getVehicleOccupant ( hitelement ) ~= false then
			local player = getVehicleOccupant ( hitelement )
			if westsideGetElementData ( player, "money" ) >= paynsprayprice then
				westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - paynsprayprice )
				takePlayerMoney ( player, paynsprayprice )
				local veh = hitelement
				local x, y, z = getElementPosition ( hitelement )
				if z > 37 and z < 46 and motorboats[getElementModel ( veh )] ~= true and raftboats[getElementModel ( veh )] ~= true and helicopters[getElementModel ( veh )] ~= true and planea[getElementModel ( veh )] ~= true and planeb[getElementModel ( veh )] ~= true then
					setElementFrozen ( player, true )
					setElementFrozen ( veh, true )
					setTimer ( wangrepair, 3000, 1, veh, hitelement )
					
					setTimer(function()
						activeCarGhostMode ( player, 10000 )
					end,3000,1)
					
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 5)
					outputLog("[PAYNSPRAY]: "..getPlayerName(player).." hat sein Fahrzeug repariert!","Paynspray")
					if isGarageOpen ( 19 ) == true then
						setGarageOpen ( 19, false )
					end
				end
			else
				infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
			end
		end
	end
end
addEventHandler ( "onColShapeHit", PnsSFWangCars, PnsSFWangCarsHit )

function PnsSFJuniperHillHit ( hitelement )
	if getElementType ( hitelement ) == "vehicle" then
		if getVehicleOccupant ( hitelement ) ~= false then
			local player = getVehicleOccupant ( hitelement )
			if westsideGetElementData ( player, "money" ) >= paynsprayprice then
				local veh = hitelement
				if not helicopters[getElementModel ( veh )] and not planea[getElementModel ( veh )] and not planeb[getElementModel ( veh )] then
					westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - paynsprayprice )
					takePlayerMoney ( player, paynsprayprice )
					local x, y, z = getElementPosition ( hitelement )
					setElementFrozen ( player, true )
					setElementFrozen ( veh, true )
					setTimer ( juniperrepair, 3000, 1, veh, hitelement )
					
					setTimer(function()
						activeCarGhostMode ( player, 10000 )
					end,3000,1)
					
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 5)
					outputLog("[PAYNSPRAY]: "..getPlayerName(player).." hat sein Fahrzeug repariert!","Paynspray")
					if isGarageOpen ( 27 ) then
						setGarageOpen ( 27, false )
					end
				end
			else
				infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
			end
		end
	end
end
addEventHandler ( "onColShapeHit", PnsSFJuniperHill, PnsSFJuniperHillHit )

function PnsLVHit ( hitelement )
	if getElementType ( hitelement ) == "vehicle" then
		if getVehicleOccupant ( hitelement ) ~= false then
			local player = getVehicleOccupant ( hitelement )
			if westsideGetElementData ( player, "money" ) >= paynsprayprice then
				local veh = hitelement
				if not helicopters[getElementModel ( veh )] and not planea[getElementModel ( veh )] and not planeb[getElementModel ( veh )] then
					westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - paynsprayprice )
					takePlayerMoney ( player, paynsprayprice )
					local x, y, z = getElementPosition ( hitelement )
					setElementFrozen ( player, true )
					setElementFrozen ( veh, true )
					local gateID = westsideGetElementData ( source, "gateID" )
					if isGarageOpen ( gateID ) then
						setGarageOpen ( gateID, false )
					end
					setTimer ( LVRepair, 3000, 1, veh, hitelement, gateID )
					
					setTimer(function()
						activeCarGhostMode ( player, 10000 )
					end,3000,1)
					
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 5)
					outputLog("[PAYNSPRAY]: "..getPlayerName(player).." hat sein Fahrzeug repariert!","Paynspray")
				end
			else
				infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
			end
		end
	end
end

function PnsLSHit ( hitelement )
	if getElementType ( hitelement ) == "vehicle" then
		if getVehicleOccupant ( hitelement ) ~= false then
			local player = getVehicleOccupant ( hitelement )
			if westsideGetElementData ( player, "money" ) >= paynsprayprice then
				local veh = hitelement
				if not helicopters[getElementModel ( veh )] and not planea[getElementModel ( veh )] and not planeb[getElementModel ( veh )] then
					westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - paynsprayprice )
					takePlayerMoney ( player, paynsprayprice )
					local x, y, z = getElementPosition ( hitelement )
					setElementFrozen ( player, true )
					setElementFrozen ( veh, true )
					local gateID = westsideGetElementData ( source, "gateID" )
					if isGarageOpen ( gateID ) then
						setGarageOpen ( gateID, false )
					end
					setTimer ( LSRepair, 3000, 1, veh, hitelement, gateID )
					
					setTimer(function()
						activeCarGhostMode ( player, 10000 )
					end,3000,1)
					
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 5)
					outputLog("[PAYNSPRAY]: "..getPlayerName(player).." hat sein Fahrzeug repariert!","Paynspray")
				end
			else
				infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
			end
		end
	end
end

function PnsLS1Hit ( hitelement )
	if getElementType ( hitelement ) == "vehicle" then
		if getVehicleOccupant ( hitelement ) ~= false then
			local player = getVehicleOccupant ( hitelement )
			if westsideGetElementData ( player, "money" ) >= paynsprayprice then
				local veh = hitelement
				if not helicopters[getElementModel ( veh )] and not planea[getElementModel ( veh )] and not planeb[getElementModel ( veh )] then
					westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - paynsprayprice )
					takePlayerMoney ( player, paynsprayprice )
					local x, y, z = getElementPosition ( hitelement )
					setElementFrozen ( player, true )
					setElementFrozen ( veh, true )
					local gateID = westsideGetElementData ( source, "gateID" )
					if isGarageOpen ( gateID ) then
						setGarageOpen ( gateID, false )
					end
					setTimer ( LSRepair, 3000, 1, veh, hitelement, gateID )
					
					setTimer(function()
						activeCarGhostMode ( player, 10000 )
					end,3000,1)
					
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 5)
					outputLog("[PAYNSPRAY]: "..getPlayerName(player).." hat sein Fahrzeug repariert!","Paynspray")
				end
			else
				infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
			end
		end
	end
end

function PnsLSOst1 ( hitelement )
	if getElementType ( hitelement ) == "vehicle" then
		if getVehicleOccupant ( hitelement ) ~= false then
			local player = getVehicleOccupant ( hitelement )
			if westsideGetElementData ( player, "money" ) >= paynsprayprice then
				local veh = hitelement
				if not helicopters[getElementModel ( veh )] and not planea[getElementModel ( veh )] and not planeb[getElementModel ( veh )] then
					westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - paynsprayprice )
					takePlayerMoney ( player, paynsprayprice )
					local x, y, z = getElementPosition ( hitelement )
					setElementFrozen ( player, true )
					setElementFrozen ( veh, true )
					local gateID = westsideGetElementData ( source, "gateID" )
					if isGarageOpen ( gateID ) then
						setGarageOpen ( gateID, false )
					end
					setTimer ( LSRepair, 3000, 1, veh, hitelement, gateID )
					
					setTimer(function()
						activeCarGhostMode ( player, 10000 )
					end,3000,1)
					
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 5)
					outputLog("[PAYNSPRAY]: "..getPlayerName(player).." hat sein Fahrzeug repariert!","Paynspray")
				end
			else
				infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
			end
		end
	end
end
addEventHandler ( "onColShapeHit", PnsLSTemple, PnsLSHit )
addEventHandler ( "onColShapeHit", PnsLSOst, PnsLSOst1 )
addEventHandler ( "onColShapeHit", PnsLSNord, PnsLS1Hit )
addEventHandler ( "onColShapeHit", PnsLVCity, PnsLVHit )
addEventHandler ( "onColShapeHit", PnsFortCarson, PnsLVHit )

function wangrepair ( veh, hitelement )
	if not isGarageOpen ( 19 ) then
		setGarageOpen ( 19, true )
	end
	playSoundFrontEnd ( getVehicleOccupant ( hitelement ), 46 )
	setElementFrozen ( getVehicleOccupant ( hitelement ), false )
	pnsFixVehicle ( veh )
end

function juniperrepair ( veh, hitelement )
	if not isGarageOpen ( 27 ) then
		setGarageOpen ( 27, true )
	end
	playSoundFrontEnd ( getVehicleOccupant ( hitelement ), 46 )
	setElementFrozen ( getVehicleOccupant ( hitelement ), false )
	pnsFixVehicle ( veh )
end

function LVRepair ( veh, hit, gateID )
	local player = getVehicleOccupant ( hit )
	if not isGarageOpen ( gateID ) then
		setGarageOpen ( gateID, true )
	end
	playSoundFrontEnd ( player, 46 )
	setElementFrozen ( player, false )
	pnsFixVehicle ( veh )
end

function LSRepair ( veh, hit, gateID )
	local player = getVehicleOccupant ( hit )
	if not isGarageOpen ( gateID ) then
		setGarageOpen ( gateID, true )
	end
	playSoundFrontEnd ( player, 46 )
	setElementFrozen ( player, false )
	pnsFixVehicle ( veh )
end

function LSRepair1 ( veh, hit, gateID )
	local player = getVehicleOccupant ( hit )
	if not isGarageOpen ( gateID ) then
		setGarageOpen ( gateID, true )
	end
	playSoundFrontEnd ( player, 46 )
	setElementFrozen ( player, false )
	pnsFixVehicle ( veh )
end

function LSRepair1 ( veh, hit, gateID )
	local player = getVehicleOccupant ( hit )
	if not isGarageOpen ( gateID ) then
		setGarageOpen ( gateID, true )
	end
	playSoundFrontEnd ( player, 46 )
	setElementFrozen ( player, false )
	pnsFixVehicle ( veh )
end

function pnsFixVehicle ( veh )
	fixVehicle ( veh )
	if westsideGetElementData ( veh, "stuning2" ) then
		setElementHealth ( veh, 1700 )
	end
	setElementFrozen ( veh, false )
end