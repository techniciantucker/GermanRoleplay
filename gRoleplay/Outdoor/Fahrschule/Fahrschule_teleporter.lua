---- Pickup (Von aussen nach innen) ----
FahrschuleRein = createPickup (1132.5999755859,-1696.5,13.878098487854,3,1318,500)

FahrschuleRaus = createPickup ( -2026.9000244141,-103.80000305176,1035.171875,3,1318,500)
setElementInterior (FahrschuleRaus, 3)

addEventHandler ("onPickupHit", FahrschuleRein, function (source, dim )
	if isPedInVehicle ( source ) == false then
		fadeElementInterior (source, 3, -2028.8000488281,-105.30000305176,1035.1999511719)
		setElementRotation (source, 0, 0, 96)
	end
end)

addEventHandler ("onPickupHit", FahrschuleRaus, function (source, dim )
	if isPedInVehicle ( source ) == false then
		fadeElementInterior (source, 0, 1130.5999755859,-1696.5999755859,13.89999961853)
		setElementRotation (source, 0, 0, 94.0032043)
	end
end)