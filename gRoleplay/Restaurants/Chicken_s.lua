createBlip(2398.51978, -1899.19775, 13.54688, 14, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(2419.71411, -1509.07349, 24.00000, 14, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(928.91223, -1352.93433, 13.34375, 14, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(-2155.31714, -2460.16821, 30.85156, 14, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(-2671.60376, 257.92438, 4.63281, 14, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(-1816.62280, 618.67236, 35.17188, 14, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(2845.93188, 2415.43701, 11.06250, 14, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(2393.20605, 2041.56494, 10.82031, 14, 2, 255, 0, 0, 255, 0, 200,root)

local chickenMarker={
[1]=createPickup(2398.51978, -1899.19775, 13.54688,3,1318,50),
[2]=createPickup(2419.71411, -1509.07349, 24.00000,3,1318,50),
[3]=createPickup(928.91223, -1352.93433, 13.34375,3,1318,50),
[4]=createPickup(-2155.31714, -2460.16821, 30.85156,3,1318,50),
[5]=createPickup(-2671.60376, 257.92438, 4.63281,3,1318,50),
[6]=createPickup(-1816.62280, 618.67236, 35.17188,3,1318,50),
[7]=createPickup(2845.93188, 2415.43701, 11.06250,3,1318,50),
[8]=createPickup(2393.20605, 2041.56494, 10.82031,3,1318,50),
}

for i, chickenmarker in pairs(chickenMarker)do
	addEventHandler('onPickupHit',chickenmarker,function(player)
		if(not(isPedInVehicle(player)))then
			local x,y,z=getElementPosition(player)
			setElementData(player,'saveposx',x)
			setElementData(player,'saveposy',y)
			setElementData(player,'saveposz',z)
			setElementPosition(player,365.20651245117,-9.0741882324219,1001.8515625)
			setPedRotation(player,0)
			setElementInterior(player,9)
			setElementDimension(player,i)
			
			chickenPed=createPed(167,369.60000610352,-4.5,1001.9000244141,180)
			setElementInterior(chickenPed,9)
			setElementDimension(chickenPed,i)
			
			chickenmarkerRaus=createPickup(365.01297, -11.84305, 1001.85156,3,1318,50)
			setElementInterior(chickenmarkerRaus,9)
			setElementDimension(chickenmarkerRaus,i)
			chickenKaufen=createMarker(369.60000610352,-6.1999998092651,1000.9000244141,'cylinder',1,0,0,200)
			setElementInterior(chickenKaufen,9)
			setElementDimension(chickenKaufen,i)
			
			addEventHandler('onMarkerHit',chickenKaufen,chicken_open)
			addEventHandler('onPickupHit',chickenmarkerRaus,chicken_leave)
		end
	end)
end

function chicken_leave(player)
	setElementPosition(player,getElementData(player,'saveposx'),getElementData(player,'saveposy'),getElementData(player,'saveposz'))
	setElementDimension(player,0)
	setElementInterior(player,0)
	setElementData(player,'saveposx',nil)
	setElementData(player,'saveposy',nil)
	setElementData(player,'saveposz',nil)
end

function chicken_open(player)
	triggerClientEvent(player,'show_Chicken_GUI',player)
end

function KleinesChickenMenue_func(player)
	if westsideGetElementData ( player, "money" ) >= 25 then
		infobox(player,"Menü gekauft!",4000,0,255,0)
		addPlayerHealth(player,25)
		westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))+25)
		if(westsideGetElementData(player,'hunger')>100)then
			westsideSetElementData(player,'hunger',100)
		end
		takePlayerSaveMoney ( player, 25 )
		setElementFrozen(player,true)
		setPedAnimation ( player, "FOOD", "EAT_Chicken")
		setTimer(function()
			setPedAnimation(player,false)
			setElementFrozen(player,false)
		end,10000,1)
	else
		infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
	end
end
addEvent("KleinesChickenMenue",true)
addEventHandler("KleinesChickenMenue",getRootElement(),KleinesChickenMenue_func)

function MittleresChickenMenue_func(player)
	if westsideGetElementData ( player, "money" ) >= 50 then
		infobox(player,"Menü gekauft!",4000,0,255,0)
		addPlayerHealth(player,50)
		westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))+50)
		if(westsideGetElementData(player,'hunger')>100)then
			westsideSetElementData(player,'hunger',100)
		end
		takePlayerSaveMoney ( player, 50 )
		setElementFrozen(player,true)
		setPedAnimation ( player, "FOOD", "EAT_Chicken")
		setTimer(function()
			setPedAnimation(player,false)
			setElementFrozen(player,false)
		end,10000,1)
	else
		infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
	end
end
addEvent("MittleresChickenMenue",true)
addEventHandler("MittleresChickenMenue",getRootElement(),MittleresChickenMenue_func)

function GrosesChickenMenue_func(player)
	if westsideGetElementData ( player, "money" ) >= 75 then
		infobox(player,"Menü gekauft!",4000,0,255,0)
		addPlayerHealth(player,75)
		westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))+75)
		if(westsideGetElementData(player,'hunger')>100)then
			westsideSetElementData(player,'hunger',100)
		end
		takePlayerSaveMoney ( player, 75 )
		setElementFrozen(player,true)
		setPedAnimation ( player, "FOOD", "EAT_Chicken")
		setTimer(function()
			setPedAnimation(player,false)
			setElementFrozen(player,false)
		end,10000,1)
	else
		infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
	end
end
addEvent("GrosesChickenMenue",true)
addEventHandler("GrosesChickenMenue",getRootElement(),GrosesChickenMenue_func)

function BigChickenMenue_func(player)
	if westsideGetElementData ( player, "money" ) >= 100 then
		infobox(player,"Menü gekauft!",4000,0,255,0)
		addPlayerHealth(player,100)
		westsideSetElementData(player,'hunger',100)
		takePlayerSaveMoney ( player, 100 )
		setElementFrozen(player,true)
		setPedAnimation ( player, "FOOD", "EAT_Chicken")
		setTimer(function()
			setPedAnimation(player,false)
			setElementFrozen(player,false)
		end,10000,1)
	else
		infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
	end
end
addEvent("BigChickenMenue",true)
addEventHandler("BigChickenMenue",getRootElement(),BigChickenMenue_func)