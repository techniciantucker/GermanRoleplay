TriadenRein = createPickup (893.62799, -1635.69812, 14.92969, 3,1318,500)

TriadenRaus = createPickup (-2170.37549, 635.39209, 1052.37500, 3,1318,500)
setElementInterior (TriadenRaus, 1)

addEventHandler ("onPickupHit", TriadenRein, function (source, dim )
	if isTriaden (source ) then
		if isPedInVehicle (source) == false then
			fadeElementInterior (source,1,-2170.3000488281,638.20001220703,1052.4000244141)
			setElementRotation (source,0,0,0.00274658)
		end
	else
		infobox(source,"Du hast keinen Schlüssel\nfür diese Tür!")
	end
end)

addEventHandler ("onPickupHit", TriadenRaus, function (source, dim )
	if isTriaden (source ) then
		if isPedInVehicle (source) == false then
			fadeElementInterior (source,0,893.79998779297,-1638.5,14.89999961853)
			setElementRotation (source,0,0,180)
		end
	else
		infobox(source,"Du hast keinen Schlüssel\nfür diese Tür!")
	end
end)