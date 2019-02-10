----- Teleporter -----
local DonutShopRein = createMarker(1038.1999511719,-1340.3000488281,12.800000190735,'cylinder',2,0,0,200)
local DonutShopRaus = createMarker(377.20001220703,-193.19999694824,999.70001220703,'cylinder',1,0,0,200)
setElementInterior(DonutShopRaus,17)
local DonutShopBuy = createPickup(379.33203, -190.46263, 1000.63281,3,1239,50)
setElementInterior(DonutShopBuy,17)

addEventHandler('onMarkerHit',DonutShopRein,function(player)
	fadeElementInterior(player,17,377.39999389648,-191.89999389648,1000.5999755859,0.00274658)
end)
addEventHandler('onMarkerHit',DonutShopRaus,function(player)
	fadeElementInterior(player,0,1038.0999755859,-1337.5,13.699999809265,0.00274658)
end)

addEventHandler('onPickupHit',DonutShopBuy,function(player)
	triggerClientEvent(player,'donutWindow',player)
end)


-- Menüs --
function KleinesDonutMenue_func(player)
	if westsideGetElementData ( player, "money" ) >= 25 then
		infobox(player,"Menü gekauft.",2500,0,255,0)
		addPlayerHealth(player,100)
		
		westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))+25)
		if(westsideGetElementData(player,'hunger')>100)then
			westsideSetElementData(player,'hunger',100)
		end
		
		takePlayerSaveMoney ( player, 25 )
	else
		infobox(player,"Du hast nicht genug Geld!",2500,255,0,0)
	end
end
addEvent("KleinesDonutMenue",true)
addEventHandler("KleinesDonutMenue",getRootElement(),KleinesDonutMenue_func)

function MittleresDonutMenue_func(player)
	if westsideGetElementData ( player, "money" ) >= 50 then
		infobox(player,"Menü gekauft.",2500,0,255,0)
		addPlayerHealth(player,100)
		
		westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))+50)
		if(westsideGetElementData(player,'hunger')>100)then
			westsideSetElementData(player,'hunger',100)
		end
		
		takePlayerSaveMoney ( player, 50 )
	else
		infobox(player,"Du hast nicht genug Geld!",2500,255,0,0)
	end
end
addEvent("MittleresDonutMenue",true)
addEventHandler("MittleresDonutMenue",getRootElement(),MittleresDonutMenue_func)

function GrosesDonutMenue_func(player)
	if westsideGetElementData ( player, "money" ) >= 725 then
		infobox(player,"Menü gekauft.",2500,0,255,0)
		addPlayerHealth(player,75)
		
		westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))+50)
		if(westsideGetElementData(player,'hunger')>100)then
			westsideSetElementData(player,'hunger',100)
		end
		
		takePlayerSaveMoney ( player, 75 )
	else
		infobox(player,"Du hast nicht genug Geld!",2500,255,0,0)
	end
end
addEvent("GrosesDonutMenue",true)
addEventHandler("GrosesDonutMenue",getRootElement(),GrosesDonutMenue_func)

function BigDonutMenue_func(player)
	if westsideGetElementData ( player, "money" ) >= 100 then
		infobox(player,"Menü gekauft.",2500,0,255,0)
		setElementHealth(player,100)
		
		westsideSetElementData(player,'hunger',100)
		
		takePlayerSaveMoney ( player, 100 )
	else
		infobox(player,"Du hast nicht genug Geld!",2500,255,0,0)
	end
end
addEvent("BigDonutMenue",true)
addEventHandler("BigDonutMenue",getRootElement(),BigDonutMenue_func)