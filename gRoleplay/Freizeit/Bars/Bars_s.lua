biercost    = 2
whiskeycost = 5
weincost    = 15

ls_bar = createBlip (2310.00781, -1643.45862, 14.82705, 23, 2, 255, 0, 0, 255, 0, 200, getRootElement() )

----- Interior -----
barRein = createPickup(2310.00781, -1643.45862, 14.82705,3,1318,500)
barRaus = createPickup(501.90646, -67.56472, 998.75781,3,1318,500)
setElementInterior(barRaus,11)

addEventHandler("onPickupHit",barRein,function(player)
	fadeElementInterior(player,11,502.20337, -70.08888, 998.75781)
end)

addEventHandler("onPickupHit",barRaus,function(player)
	fadeElementInterior(player,0,2307.60254, -1645.34961, 14.82705)
end)

----- Marker -----
bar1 = createMarker(499.29998779297,-75.800003051758,997.79998779297,"cylinder",1,255,0,0)
bar2 = createMarker(496.39999389648,-75.800003051758,997.79998779297,"cylinder",1,255,0,0)
setElementInterior(bar1,11)
setElementInterior(bar2,11)

function triggerbarevent(player)
	triggerClientEvent(player,"bar",player)
end
addEventHandler("onMarkerHit",bar1,triggerbarevent)
addEventHandler("onMarkerHit",bar2,triggerbarevent)

----- Getränke -----


--- Bier ---
addEvent("bier",true)
addEventHandler("bier",root,function(player)
	if westsideGetElementData(player,"money") >= biercost then
		takePlayerSaveMoney(player,biercost)
		addPlayerHealth(player,25)
		westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))+10)
		if(westsideGetElementData(player,'hunger')>100)then
			westsideSetElementData(player,'hunger',100)
		end
		if(westsideGetElementData(player,'alkoholPegel')<100)then
			westsideSetElementData(player,'alkoholPegel',tonumber(westsideGetElementData(player,'alkoholPegel'))+10)
		end
		infobox(player,"Du hast dir ein Getränk gekauft!",4000,0,255,0)
		setElementFrozen(player,true)
		setPedAnimation ( player, "VENDING", "VEND_Drink2_P")
		setTimer(function()
			setPedAnimation(player,false)
			setElementFrozen(player,false)
		end,10000,1)
	else
		infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
	end
end)

--- Whiskey ---
addEvent("whiskey",true)
addEventHandler("whiskey",root,function(player)
	if westsideGetElementData(player,"money") >= whiskeycost then
		takePlayerSaveMoney(player,whiskeycost)
		addPlayerHealth(player,25)
		westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))+10)
		if(westsideGetElementData(player,'hunger')>100)then
			westsideSetElementData(player,'hunger',100)
		end
		if(westsideGetElementData(player,'alkoholPegel')<100)then
			westsideSetElementData(player,'alkoholPegel',tonumber(westsideGetElementData(player,'alkoholPegel'))+10)
		end
		infobox(player,"Du hast dir ein Getränk gekauft!",4000,0,255,0)
		setElementFrozen(player,true)
		setPedAnimation ( player, "VENDING", "VEND_Drink2_P")
		setTimer(function()
			setPedAnimation(player,false)
			setElementFrozen(player,false)
		end,10000,1)
	else
		infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
	end
end)

--- Wein ---
addEvent("wein",true)
addEventHandler("wein",root,function(player)
	if westsideGetElementData(player,"money") >= weincost then
		takePlayerSaveMoney(player,weincost)
		addPlayerHealth(player,25)
		westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))+10)
		if(westsideGetElementData(player,'hunger')>100)then
			westsideSetElementData(player,'hunger',100)
		end
		if(westsideGetElementData(player,'alkoholPegel')<100)then
			westsideSetElementData(player,'alkoholPegel',tonumber(westsideGetElementData(player,'alkoholPegel'))+15)
		end
		infobox(player,"Du hast dir ein Getränk gekauft!",4000,0,255,0)
		setElementFrozen(player,true)
		setPedAnimation ( player, "VENDING", "VEND_Drink2_P")
		setTimer(function()
			setPedAnimation(player,false)
			setElementFrozen(player,false)
		end,10000,1)
	else
		infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
	end
end)