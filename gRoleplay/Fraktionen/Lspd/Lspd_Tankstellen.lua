-- Marker
MarkerRepair = createMarker(1549.5,-1608.5999755859,12.39999961853,"cylinder",3,200,200,0)

addEventHandler("onMarkerHit",MarkerRepair,function(player)
	if isCop(player) or isFBI(player) or isArmy(player) and getElementData(player,"onDuty") == true then
		if isPedInVehicle ( player ) == true then
			outputChatBox("[INFO]: Tippe /repaircop, um dein Fahrzeug zu Reparieren.",player,0,100,150)
		end
	end
end)

-- Funktionen
function PDCarRepair_func(player,cmd)
local vehicle = getPedOccupiedVehicle(player)

	if isCop(player) or isFBI(player) or isArmy(player) and getElementData(player,"onDuty") == true then
		if getDistanceBetweenPoints3D(1549.5,-1608.5999755859,12.39999961853,getElementPosition(player)) < 10 then
			if (vehicle) then
				fixVehicle(vehicle)
				infobox(player,"Fahrzeug repariert!",2500,0,200,0)
			end
		end
	end
end
addCommandHandler("repaircop",PDCarRepair_func)