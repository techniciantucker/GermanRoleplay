BrigadaIn = createPickup(254.63174, -1368.05420, 53.10938,3,1318,500)
BrigadaOut = createPickup(966.87634, -53.16866, 1001.12457,3,1318,500)
setElementInterior(BrigadaOut,3)

function BrigadaInn_func(source,dim)
	if isPedInVehicle (source) == false then
		if isBrigada(source) then
			fadeElementInterior(source,3,963.31934, -53.34271, 1001.12457)
		else
			infobox(source,"Du hast keinen Schlüssel\nfür diese Tür!")
		end
	end
end
addEventHandler("onPickupHit",BrigadaIn,BrigadaInn_func)

function BrigadaOutt_func(source,dim)
	if isPedInVehicle (source) == false then
		if isBrigada(source) then
			fadeElementInterior(source,0,256.80856, -1366.13696, 53.10938)
		else
			infobox(source,"Du hast keinen Schlüssel\nfür diese Tür!")
		end
	end
end
addEventHandler("onPickupHit",BrigadaOut,BrigadaOutt_func)

------------------------------
Wand = createObject ( 3095, 968.59997558594, -55.599998474121, 1000.4000244141, 0, 90, 0 )
setElementInterior (Wand, 3)