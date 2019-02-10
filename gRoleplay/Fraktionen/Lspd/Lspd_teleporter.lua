local abgeschlossen = false

addCommandHandler("pdlock",function(player)
	if isCop(player) or isFBI(player) or isArmy(player) and getElementData(player,"onDuty") == true then
		if westsideGetElementData(player,"rang") > 3 then
			if abgeschlossen == false then
				outputChatBox("Das LSPD wurde abgeschlossen!",root)
				abgeschlossen = true
			else
				outputChatBox("Das LSPD wurde aufgeschlossen!",root)
				abgeschlossen = false
			end
		else
			infobox(player,"Dein Rang ist zu niedrig!")
		end
	end
end)

-- Von außen nach innen
VonAussenNachInnen = createPickup (1555.4812011719,-1675.4100341797,16.1953125,3,1318,500)
VonInnenNachAussen = createPickup ( 246.62661743164,62.32368850708,1003.640625,3,1318,500)
setElementInterior (VonInnenNachAussen, 6)

function in_func(source,dim)
	if isPedInVehicle (source) == false then
		if abgeschlossen == false then
			fadeElementInterior (source, 6, 246.89999389648,64.300003051758,1003.5999755859)
			setElementRotation (source, 0, 0, 0.00274658)
		else
			if isCop(source) or isFBI(source) or isArmy(source) then
			fadeElementInterior (source, 6, 246.89999389648,64.300003051758,1003.5999755859)
			setElementRotation (source, 0, 0, 0.00274658)
			else
				infobox(source,"Du hast keinen Schlüssel\nfür diese Tür!")
			end
		end
	end
end
addEventHandler("onPickupHit",VonAussenNachInnen,in_func)

function out_func(source,dim)
	if isPedInVehicle (source) == false then
		fadeElementInterior (source, 0, 1552.6999511719,-1675.6999511719,16.200000762939)
		setElementRotation (source, 0, 0, 90)
	end
end
addEventHandler("onPickupHit",VonInnenNachAussen,out_func)

-- Von innen zum Dach
VonAussenNachInnen = createPickup (1565.1563720703,-1666.9028320313,28.395606994629,3,1318,500)
VonInnenZumDach = createPickup ( 227.15037536621,75.679725646973,1005.0390625,3,1318,500)
setElementInterior (VonInnenZumDach, 6)

addEventHandler ("onPickupHit", VonAussenNachInnen, function (source, dim )
	if isPedInVehicle (source) == false then
		if isCop (source ) or isFBI (source) or isArmy(source) then
			fadeElementInterior (source, 6, 228.5, 75.900001525879, 1005)
			setElementRotation (source, 0, 0, 270)
		else
			infobox(source,"Du hast keinen Schlüssel\nfür diese Tür!")
		end
	end
end)

addEventHandler ("onPickupHit", VonInnenZumDach,function (source, dim )
	if isPedInVehicle (source) == false then
		if isCop (source ) or isFBI (source) or isArmy(source) then
			fadeElementInterior (source, 0, 1564.6999511719, -1665, 28.39999961853)
			setElementRotation (source, 0, 0, 0.00274658)
		else
			infobox(source,"Du hast keinen Schlüssel\nfür diese Tür!")
		end
	end
end)

-- Von innen zur Garage
VonAussenNachInnen = createPickup (1524.4831542969,-1677.935546875,6.21875,3,1318,500)
VonInnenZurGarage = createPickup ( 259.14724731445,73.874893188477,1003.640625,3,1318,500)
setElementInterior (VonInnenZurGarage, 6)

addEventHandler ("onPickupHit", VonAussenNachInnen, function (source, dim )
	if isPedInVehicle (source) == false then
		if isCop (source ) or isFBI (source) or isArmy(source) then
			fadeElementInterior (source, 6, 256.70184326172,74.462997436523,1003.640625)
			setElementRotation (source, 0, 0, 180)
		else
			infobox(source,"Du hast keinen Schlüssel\nfür diese Tür!")
		end
	end
end)

addEventHandler ("onPickupHit", VonInnenZurGarage,function (source, dim )
	if isPedInVehicle (source) == false then
		if isCop (source ) or isFBI (source) or isArmy(source) then
			fadeElementInterior (source, 0, 1528.5717773438,-1677.6092529297,5.890625)
			setElementRotation (source, 0, 0, 274.500335)
		else
			infobox(source,"Du hast keinen Schlüssel\nfür diese Tür!")
		end
	end
end)

-- Peds
pdPed1 = createPed (280,251.39999389648,66.400001525879,1003.5999755859)
setPedRotation (pdPed1, 90)
setElementFrozen (pdPed1, true)
setElementInterior (pdPed1, 6)

pdPed2 = createPed (280,251.39999389648,68.400001525879,1003.5999755859)
setPedRotation (pdPed2, 90)
setElementFrozen (pdPed2, true)
setElementInterior (pdPed2, 6)

createObject (3089, 1564.3000488281, -1667.3000488281, 28.700000762939, 0, 0, 0) -- Tür auf dem Dach