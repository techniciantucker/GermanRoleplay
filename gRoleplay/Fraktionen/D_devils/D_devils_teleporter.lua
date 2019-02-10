VonAussenNachInnen = createPickup ( 681.64581, -473.34628, 16.53352, 3,1318,500)
VonInnenNachAussen = createPickup ( -229.5,1401.1999511719,27.765625, 3,1318,500)
setElementInterior (VonInnenNachAussen, 18)

addEventHandler ("onPickupHit", VonAussenNachInnen,function (source, dim )
	if isPedInVehicle (source) == false then
		if isBiker(source) then
			fadeElementInterior (source,18,-227,1401.0999755859,27.799999237061)
			setElementRotation (source,0,0,270)
		else
			infobox(source,"Du hast keinen Schlüssel\nfür diese Tür!")
		end
	end
end)

addEventHandler ("onPickupHit", VonInnenNachAussen,function (source, dim )
	if isPedInVehicle (source) == false then
		if isBiker(source) then
			fadeElementInterior (source,0,681.24237, -476.74292, 16.33594)
			setElementRotation (source,0,0,90)
		else
			infobox(source,"Du hast keinen Schlüssel\nfür diese Tür!")
		end
	end
end)