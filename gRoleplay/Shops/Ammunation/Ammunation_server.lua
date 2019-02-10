-- Blips --
createBlip ( 2400.5, -1981.8000488281, 12.60000038147, 6, 2, 255, 0, 0, 255, 0, 200, getRootElement() )	                     -- Kleine Ammunation in Los Santos
createBlip ( 1364.57654, -1280.88635, 13.54688, 6, 2, 255, 0, 0, 255, 0, 200, getRootElement() )	         				 -- Große Ammunation in Los Santos
createBlip ( -2625.8999023438, 209.19999694824, 3.7000000476837, 6, 2, 255, 0, 0, 255, 0, 200, getRootElement() )	         -- Ammunation in San Fierro
createBlip ( 2159.3000488281, 943.20001220703, 9.8999996185303, 6, 2, 255, 0, 0, 255, 0, 200, getRootElement() )	         -- Ammunation in Las Venturas nähe Autobahn
createBlip ( 2539.1000976563, 2084, 9.8999996185303, 6, 2, 255, 0, 0, 255, 0, 200, getRootElement() )	                     -- Ammunation in Las Venturas nähe Baustelle
createBlip ( 777.09997558594, 1871.4000244141, 4, 6, 2, 255, 0, 0, 255, 0, 200, getRootElement() )	                         -- Ammunation in der Wüste nähe Striplokal
createBlip ( -315.79998779297, 829.79998779297, 13.300000190735, 6, 2, 255, 0, 0, 255, 0, 200, getRootElement() )	         -- Ammunation in der Wüste nähe Vio Mafia Base
createBlip ( -1508.9000244141, 2610.5, 54.900001525879, 6, 2, 255, 0, 0, 255, 0, 200, getRootElement() )	                 -- Ammunation im Dorf nähe Bayside
createBlip ( 243, -178.39999389648, 0.69999998807907, 6, 2, 255, 0, 0, 255, 0, 200, getRootElement() )	                     -- Ammunation im Dorf nähe eXo Gabelstaplerjob

ammunationmarkers = {
[1] = createMarker(2400.5, -1981.8000488281, 12.60000038147, "cylinder", 1, 200, 0, 0),                 -- Kleine Ammunation in Los Santos
[2] = createMarker(1364.57654, -1280.88635, 13.54688, "corona", 1, 200, 0, 0),        					-- Große Ammunation in Los Santos
[3] = createMarker(-2625.8999023438, 209.19999694824, 3.7000000476837, "cylinder", 1, 200, 0, 0),       -- Ammunation in San Fierro
[4] = createMarker(2159.3000488281, 943.20001220703, 9.8999996185303, "cylinder", 1, 200, 0, 0),        -- Ammunation in Las Venturas nähe Autobahn
[5] = createMarker(2539.1000976563, 2084, 9.8999996185303, "cylinder", 1, 200, 0, 0),                   -- Ammunation in Las Venturas nähe Baustelle
[6] = createMarker(777.09997558594, 1871.4000244141, 4, "cylinder", 1, 200, 0, 0),                      -- Ammuntion in der Wüste nähe Striplokal
[7] = createMarker(-315.79998779297, 829.79998779297, 13.300000190735, "cylinder", 1, 200, 0, 0),       -- Ammunation in der Wüste nähe Vio Mafia Base
[8] = createMarker(-1508.9000244141, 2610.5, 54.900001525879, "cylinder", 1, 200, 0, 0),                -- Ammunation im Dorf nähe Bayside
[9] = createMarker(243, -178.39999389648, 0.69999998807907, "cylinder", 1, 200, 0, 0),                  -- Ammunation im Dorf nähe eXo Gabelstaplerjob
}

local minmarker, maxmarker = 2

for i, Ammumarker in pairs(ammunationmarkers) do
    addEventHandler("onMarkerHit", Ammumarker, function(player)
	    if isPedInVehicle(player) == false then
			local x,y,z = getElementPosition(player)
			setElementData(player, "saveposx", x)
			setElementData(player, "saveposy", y)
			setElementData(player, "saveposz", z)
			fadeElementInterior(player,6, 296.89999389648,-110.30000305176,1001.5)
			setElementDimension(player, i)
			
			ammurausgehmarker = createMarker(296.89999389648,-112,1002.700012207, "arrow",2,255,255,0)
			addEventHandler("onMarkerHit", ammurausgehmarker,Ammuraus_func)
			setElementInterior(ammurausgehmarker, 6)
			setElementDimension(ammurausgehmarker, i)
			
			ammuMarker1 = createMarker ( 287.39999389648, -109.59999847412, 1000.5999755859, "cylinder", 1, 0, 0, 255, 170, getRootElement() ) -- Große Ammunation (Los Santos)
			setElementInterior(ammuMarker1, 6)
			setElementDimension(ammuMarker1, i)

			ammuMarker2 = createMarker ( 287.39999389648, -106.30000305176, 1000.5999755859, "cylinder", 1, 0, 0, 255, 170, getRootElement() ) -- Große Ammunation (Los Santos)
			setElementInterior(ammuMarker2, 6)
			setElementDimension(ammuMarker2, i)
		
			addEventHandler("onMarkerHit", ammuMarker1, ammuMarkerHit)
			addEventHandler("onMarkerHit", ammuMarker2, ammuMarkerHit)
		end
	end)
end

function Ammuraus_func(player)
    setElementPosition(player, getElementData(player, "saveposx"), getElementData(player, "saveposy"), getElementData(player, "saveposz"))
    setElementInterior(player, 0)
	setElementDimension(player, 0)
end

function ammuMarkerHit(hitElement)
	if tonumber(westsideGetElementData(hitElement,"gunlicense")) == 1 then
		triggerClientEvent( hitElement, "ammunationMarkerHit", resourceRoot )
	else
		infobox(hitElement,"Du hast keinen Waffenschein!")
	end
end

----- Waffen -----
addEvent('ammuDeagle',true)
addEventHandler('ammuDeagle',root,function(player)
	if(westsideGetElementData(player,'money')>=150)then
		takePlayerSaveMoney(player,150)
		giveWeapon(player,24,21,true)
	else
		infobox(player,'Du hast nicht genug Geld!')
	end
end)

addEvent('ammuColt',true)
addEventHandler('ammuColt',root,function(player)
	if(westsideGetElementData(player,'money')>=75)then
		takePlayerSaveMoney(player,75)
		giveWeapon(player,22,34,true)
	else
		infobox(player,'Du hast nicht genug Geld!')
	end
end)

addEvent('ammuShotgun',true)
addEventHandler('ammuShotgun',root,function(player)
	if(westsideGetElementData(player,'money')>=240)then
		takePlayerSaveMoney(player,240)
		giveWeapon(player,25,10,true)
	else
		infobox(player,'Du hast nicht genug Geld!')
	end
end)

addEvent('ammuSawnoff',true)
addEventHandler('ammuSawnoff',root,function(player)
	if(westsideGetElementData(player,'money')>=230)then
		takePlayerSaveMoney(player,230)
		giveWeapon(player,26,16,true)
	else
		infobox(player,'Du hast nicht genug Geld!')
	end
end)

addEvent('ammuCombat',true)
addEventHandler('ammuCombat',root,function(player)
	if(westsideGetElementData(player,'money')>=250)then
		takePlayerSaveMoney(player,250)
		giveWeapon(player,27,16,true)
	else
		infobox(player,'Du hast nicht genug Geld!')
	end
end)

addEvent('ammuMp5',true)
addEventHandler('ammuMp5',root,function(player)
	if(westsideGetElementData(player,'money')>=1125)then
		takePlayerSaveMoney(player,1125)
		giveWeapon(player,29,120,true)
	else
		infobox(player,'Du hast nicht genug Geld!')
	end
end)

addEvent('ammuM4',true)
addEventHandler('ammuM4',root,function(player)
	if(westsideGetElementData(player,'money')>=1250)then
		takePlayerSaveMoney(player,1250)
		giveWeapon(player,31,200,true)
	else
		infobox(player,'Du hast nicht genug Geld!')
	end
end)

addEvent('ammuRifle',true)
addEventHandler('ammuRifle',root,function(player)
	if(westsideGetElementData(player,'money')>=1350)then
		takePlayerSaveMoney(player,1350)
		giveWeapon(player,33,15,true)
	else
		infobox(player,'Du hast nicht genug Geld!')
	end
end)

addEvent('ammuWeste',true)
addEventHandler('ammuWeste',root,function(player)
	if(westsideGetElementData(player,'money')>=30)then
		takePlayerSaveMoney(player,30)
		setPedArmor(player,100)
	else
		infobox(player,'Du hast nicht genug Geld!')
	end
end)

addEvent('ammuMesser',true)
addEventHandler('ammuMesser',root,function(player)
	if(westsideGetElementData(player,'money')>=10)then
		takePlayerSaveMoney(player,10)
		giveWeapon(player,4,1,true)
	else
		infobox(player,'Du hast nicht genug Geld!')
	end
end)