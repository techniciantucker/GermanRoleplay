VonAussenNachInnen = createPickup (2462.99390, -1691.64905, 14.40640,3,1318,500)

VonInnenNachAussen = createPickup (2495.96362, -1692.08472, 1014.74219,3,1318,500)
setElementInterior (VonInnenNachAussen, 3)

addEventHandler ("onPickupHit", VonAussenNachInnen, function (source, dim )
	if isGrove (source ) then
		if isPedInVehicle (source) == false then
			fadeElementInterior (source,3, 2495.68799, -1694.74902, 1014.74219)
			setElementRotation (source,0,0,0)
		else
			infobox(source,"Du hast keinen Schlüssel\nfür diese Tür!")
		end
	end
end)

addEventHandler ("onPickupHit", VonInnenNachAussen, function (source, dim )
	if isPedInVehicle (source) == false then
		if isGrove (source ) then
			fadeElementInterior (source,0, 2463.14087, -1688.50464, 13.51526)
			setElementRotation (source,0,0,270)
		else
			infobox(source,"Du hast keinen Schlüssel\nfür diese Tür!")
		end
	end
end)