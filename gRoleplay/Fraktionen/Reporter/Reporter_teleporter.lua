ReporterRein = createPickup (736.96118164063,-1359.0936279297,13.5,3,1318,500)

ReporterRaus = createPickup (732.51629638672,-1360.5389404297,25.692211151123,3,1318,500)

addEventHandler ("onPickupHit", ReporterRein, function (source, dim )
	if isPedInVehicle (source) == false then
		fadeElementInterior (source, 0, 734.00677490234,-1360.8745117188,25.692211151123)
		setElementRotation (source, 0, 0, 270)
	else
		infobox(source,"Du hast keinen Schlüssel\nfür diese Tür!")
	end
end)

addEventHandler ("onPickupHit", ReporterRaus, function (source, dim )
	if isPedInVehicle (source) == false then
		fadeElementInterior (source, 0, 736.87573242188,-1356.2982177734,13.5)
		setElementRotation (source, 0, 0, 180)
	else
		infobox(source,"Du hast keinen Schlüssel\nfür diese Tür!")
	end
end)