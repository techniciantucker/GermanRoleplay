----- Fahrzeuge -----
local broadwayPreis = 50
local mesaPreis     = 50
local picadorPreis  = 50
local hustlerPreis  = 75
local sandkindPreis = 100
local patriotPreis  = 150

local coinshopFahrzeuge = {

[1] = createVehicle(575,275.0234375,-246.7001953125,1.8999999761581,340.24658203125,0,26.03759765625), 					-- Broadway
[2] = createVehicle(500,267.7001953125,-247.099609375,2.7000000476837,340.24658203125,0,25.7958984375),					-- Mesa
[3] = createVehicle(600,260,-247,2.2999999523163,342.44384765625,0,24.23583984375), 									-- Picador
[4] = createVehicle(545,248.0556640625,-245.7626953125,2.2421300411224,341.5869140625,8.5198974609375,335.18188476563), -- Hustler
[5] = createVehicle(495,248.0556640625,-237.15625,2.9301700592041,341.5869140625,8.5198974609375,335.18188476563), 	    -- Sandking
[6] = createVehicle(470,248.400390625,-228,2.3924400806427,340.71899414063,0.142822265625,306.72729492188), 			-- Patriot

}

for i=1,#coinshopFahrzeuge do
	setVehiclePlateText(coinshopFahrzeuge[i],'Coinshop'..i)
	setVehicleColor(coinshopFahrzeuge[i],255,255,255)
	setElementFrozen(coinshopFahrzeuge[i],true)
	setVehicleLocked(coinshopFahrzeuge[i],true)
end

----- Marker -----
local coinshopPickup = createPickup(278.54120, -233.56131, 1.55080,3,1239,50)

addEventHandler('onPickupHit',coinshopPickup,function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		triggerClientEvent(player,'coinshopWindow',player)
	end
end)

----- Tür -----
local coinshoptuerunten = false
local coinshopmarker  	= createMarker(302.60000610352,-240.60000610352,0.60000002384186,'cylinder',2,0,0,0)
setElementAlpha(coinshopmarker,0)
local coinshopTuer   	= createObject(1522,302.39999389648,-241.30000305176,0.5,0,0,90)

addEventHandler('onMarkerHit',coinshopmarker,function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(coinshoptuerunten==false)then
			coinshoptuerunten=true
			moveObject(coinshopTuer,3000,302.39999389648,-241.30000305176,-2)
			setTimer(function()
				moveObject(coinshopTuer,3000,302.39999389648,-241.30000305176,0.5)
				setTimer(function()
					coinshoptuerunten=false
				end,3000,1)
			end,10000,1)
		end
	end
end)

----- Kaufen -----
addEvent('broadway',true)
addEvent('mesa',true)
addEvent('picador',true)
addEvent('hustler',true)
addEvent('sandking',true)
addEvent('patriot',true)

addEventHandler('broadway',root,function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(getElementData(player,'coins')>=broadwayPreis)then
			if westsideGetElementData ( player, "maxcars" ) > westsideGetElementData ( player, "curcars" ) then
				carbuy(player,0,575,318.60000610352,-228.80000305176,1.5,0,0,90)
				westsideSetElementData(player,'coins',tonumber(westsideGetElementData(player,'coins'))-broadwayPreis)
			else
				infobox(player,'Du hast keinen freien Slot mehr!')
			end
		else
			infobox(player,'Du hast nicht genug Coins!')
		end
	end
end)
addEventHandler('mesa',root,function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(getElementData(player,'coins')>=mesaPreis)then
			if westsideGetElementData ( player, "maxcars" ) > westsideGetElementData ( player, "curcars" ) then
				carbuy(player,0,500,318.60000610352,-228.80000305176,1.5,0,0,90)
				westsideSetElementData(player,'coins',tonumber(westsideGetElementData(player,'coins'))-mesaPreis)
			else
				infobox(player,'Du hast keinen freien Slot mehr!')
			end
		else
			infobox(player,'Du hast nicht genug Coins!')
		end
	end
end)
addEventHandler('picador',root,function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(getElementData(player,'coins')>=picadorPreis)then
			if westsideGetElementData ( player, "maxcars" ) > westsideGetElementData ( player, "curcars" ) then
				carbuy(player,0,600,318.60000610352,-228.80000305176,1.5,0,0,90)
				westsideSetElementData(player,'coins',tonumber(westsideGetElementData(player,'coins'))-picadorPreis)
			else
				infobox(player,'Du hast keinen freien Slot mehr!')
			end
		else
			infobox(player,'Du hast nicht genug Coins!')
		end
	end
end)
addEventHandler('hustler',root,function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(getElementData(player,'coins')>=hustlerPreis)then
			if westsideGetElementData ( player, "maxcars" ) > westsideGetElementData ( player, "curcars" ) then
				carbuy(player,0,545,318.60000610352,-228.80000305176,1.5,0,0,90)
				westsideSetElementData(player,'coins',tonumber(westsideGetElementData(player,'coins'))-hustlerPreis)
			else
				infobox(player,'Du hast keinen freien Slot mehr!')
			end
		else
			infobox(player,'Du hast nicht genug Coins!')
		end
	end
end)
addEventHandler('sandking',root,function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(getElementData(player,'coins')>=sandkindPreis)then
			if westsideGetElementData ( player, "maxcars" ) > westsideGetElementData ( player, "curcars" ) then
				carbuy(player,0,495,318.60000610352,-228.80000305176,1.5,0,0,90)
				westsideSetElementData(player,'coins',tonumber(westsideGetElementData(player,'coins'))-sandkindPreis)
			else
				infobox(player,'Du hast keinen freien Slot mehr!')
			end
		else
			infobox(player,'Du hast nicht genug Coins!')
		end
	end
end)
addEventHandler('patriot',root,function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(getElementData(player,'coins')>=patriotPreis)then
			if westsideGetElementData ( player, "maxcars" ) > westsideGetElementData ( player, "curcars" ) then
				carbuy(player,0,470,318.60000610352,-228.80000305176,1.5,0,0,90)
				westsideSetElementData(player,'coins',tonumber(westsideGetElementData(player,'coins'))-patriotPreis)
			else
				infobox(player,'Du hast keinen freien Slot mehr!')
			end
		else
			infobox(player,'Du hast nicht genug Coins!')
		end
	end
end)