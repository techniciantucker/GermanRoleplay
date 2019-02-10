InsInterior = createPickup (1221.9445800781,-1811.6937255859,16.59375,3,1318,500)
NachDraussen = createPickup (1197.9631347656,-1811.7817382813,30.035457611084,3,1318,500)

addEventHandler ("onPickupHit", InsInterior, function (source, dim )
	if isPedInVehicle (source) == false then
		if isFBI(source) then
			fadeElementInterior (source, 0, 1198.1662597656,-1814.8054199219,30.035457611084)
			setElementRotation (source, 0, 0, 180)
		else
			infobox(source,"Du hast keinen Schlüssel\nfür diese Tür!")
		end
	end
end)

addEventHandler ("onPickupHit", NachDraussen, function (source, dim )
	if isPedInVehicle (source) == false then
		if isFBI(source) then
			fadeElementInterior (source, 0, 1221.9494628906,-1814.1940917969,16.59375)
			setElementRotation (source, 0 , 0, 180)
		else
			infobox(source,"Du hast keinen Schlüssel\nfür diese Tür!")
		end
	end
end)