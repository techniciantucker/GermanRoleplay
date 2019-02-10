----- Marker -----
local bank_sf_rein=createPickup(-1492.1828613281,920.1025390625,7.1875,3,1318,50)
local bank_sf_raus=createPickup(390.76821899414,173.81991577148,1008.3828125,3,1318,50)

setElementInterior(bank_sf_raus,3)
setElementDimension(bank_sf_raus,1)

addEventHandler('onPickupHit',bank_sf_rein,function(player)
	fadeElementInterior(player,3,388.29998779297,173.69999694824,1008.4000244141,90)
	setElementDimension(player,1)
end)
addEventHandler('onPickupHit',bank_sf_raus,function(player)
	if(getElementDimension(player)==1)then
		fadeElementInterior(player,0,-1496.8000488281,920.20001220703,7.1999998092651,90)
		setElementDimension(player,0)
	end
end)

local bank_lv_rein=createPickup(2239.0502929688,1285.69140625,10.8203125,3,1318,50)
local bank_lv_raus=createPickup(390.76821899414,173.81991577148,1008.3828125,3,1318,50)

setElementInterior(bank_lv_raus,3)
setElementDimension(bank_lv_raus,2)

addEventHandler('onPickupHit',bank_lv_rein,function(player)
	fadeElementInterior(player,3,388.29998779297,173.69999694824,1008.4000244141,90)
	setElementDimension(player,2)
end)
addEventHandler('onPickupHit',bank_lv_raus,function(player)
	if(getElementDimension(player)==2)then
		fadeElementInterior(player,0,2235.5,1285.5,10.800000190735,270)
		setElementDimension(player,0)
	end
end)

local bank_sf_menuemarker=createMarker(362.5,173.69999694824,1007,'cylinder',2,255,255,0)
local bank_lv_menuemarker=createMarker(362.5,173.69999694824,1007,'cylinder',2,255,255,0)

setElementAlpha(bank_sf_menuemarker,50)
setElementAlpha(bank_lv_menuemarker,50)

setElementInterior(bank_sf_menuemarker,3)
setElementInterior(bank_lv_menuemarker,3)

setElementDimension(bank_sf_menuemarker,1)
setElementDimension(bank_lv_menuemarker,2)

addEventHandler('onMarkerHit',bank_sf_menuemarker,function(player)
	if(getElementDimension(player)==1)then
		if(getElementData(player,'bankpin')==0)then
			infobox(player,'Du hast kein Konto! In der\nLS Bank kannst du eins beantragen.')
		else
			triggerClientEvent(player,'showCashPoint',player)
		end
	end
end)
addEventHandler('onMarkerHit',bank_lv_menuemarker,function(player)
	if(getElementDimension(player)==2)then
		if(getElementData(player,'bankpin')==0)then
			infobox(player,'Du hast kein Konto! In der\nLS Bank kannst du eins beantragen.')
		else
			triggerClientEvent(player,'showCashPoint',player)
		end
	end
end)