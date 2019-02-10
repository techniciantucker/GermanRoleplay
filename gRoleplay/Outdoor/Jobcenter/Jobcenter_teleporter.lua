---- Pickup (Von aussen nach innen) ----
JobcenterRein = createPickup (1481.0999755859,-1771.9000244141,18.795755386353,3,1318,500)

JobcenterRaus = createPickup (390.60000610352,173.80000305176,1008.3828125, 3,1318,500)
setElementInterior (JobcenterRaus, 3)

addEventHandler ("onPickupHit", JobcenterRein, function (source, dim )
	if isPedInVehicle (source) == false then
		fadeElementInterior (source, 3, 388.29998779297,173.69999694824,1008.4000244141)
		setElementRotation (source, 0, 0, 85.5051574)
	end
end)

addEventHandler ("onPickupHit", JobcenterRaus, function (source, dim )
	if isPedInVehicle (source) == false then
		fadeElementInterior (source, 0, 1481.0999755859, -1769.4000244141, 18.799999237061)
		setElementRotation (source, 0, 0, 0.00274658)
	end
end)

local JobcenterKloRein=createMarker(366.60000610352,158.60000610352,1007.4000244141,'cylinder',1,0,0,200)
local JobcenterKloRaus=createMarker(272.79998779297,162.80000305176,965.59997558594,'cylinder',1,0,0,200)
local JobcenterPissen1=createMarker(278.05441, 162.96468, 966.56873,'corona',1,0,0,200)
local JobcenterPissen2=createMarker(280.10773, 163.16957, 966.56873,'corona',1,0,0,200)
local JobcenterPissen3=createMarker(282.44516, 163.17238, 966.56873,'corona',1,0,0,200)
setElementInterior(JobcenterKloRein,3)
setElementInterior(JobcenterKloRaus,3)
setElementInterior(JobcenterPissen1,3)
setElementInterior(JobcenterPissen2,3)
setElementInterior(JobcenterPissen3,3)
setElementAlpha(JobcenterPissen1,50)
setElementAlpha(JobcenterPissen2,50)
setElementAlpha(JobcenterPissen3,50)

function jobcenterPissen(player)
	if(westsideGetElementData(player,'harndrang')>0)then
		infobox(player,'Das pinkeln dauert 10 Sekunden..')
		setPedAnimation ( player, "PAULNMAC", "Piss_loop")
		setTimer(function()
			setPedAnimation(player,false)
			setElementFrozen(player,false)
			westsideSetElementData(player,'harndrang',0)
			infobox(player,'Du hast deine Blase entleert.')
		end,10000,1)
	else
		infobox(player,'Du musst nicht pinkeln!')
	end
end
addEventHandler('onMarkerHit',JobcenterPissen1,jobcenterPissen)
addEventHandler('onMarkerHit',JobcenterPissen2,jobcenterPissen)
addEventHandler('onMarkerHit',JobcenterPissen3,jobcenterPissen)

addEventHandler('onMarkerHit',JobcenterKloRein,function(player)
	fadeElementInterior(player,3,275.10000610352,162.30000305176,966.59997558594,180)
end)
addEventHandler('onMarkerHit',JobcenterKloRaus,function(player)
	fadeElementInterior(player,3,366.60000610352,161.30000305176,1008.4000244141,0)
end)