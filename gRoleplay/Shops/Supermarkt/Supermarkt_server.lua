--SF1
local x1, y1, z1 = -2442.6064453125, 753.44964599609, 35.136966705322
SF24_7 = createBlip ( x1, y1, z1, 36, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LV1
local x2, y2, z2 = 2194.9331054688, 1991.1153564453, 12.2
LV124_7 = createBlip ( x2, y2, z2, 36, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LV2
local x3, y3, z3 = 2884.728, 2453.8388, 11.06
LV224_7 = createBlip ( x3, y3, z3, 36, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LV3
local x4, y4, z4 = 1937.825, 2307.234, 10.82
LV324_7 = createBlip ( x4, y4, z4, 36, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LV4
local x5, y5, z5 = 2097.69, 2224.582, 11.023
LV424_7 = createBlip ( x5, y5, z5, 36, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LV5
local x6, y6, z6 = 2247.694, 2396.168, 10.82
LV524_7 = createBlip ( x6, y6, z6, 36, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LV6
local x7, y7, z7 = 2452.481, 2065.165, 10.82
LV624_7 = createBlip ( x7, y7, z7, 36, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LV7
local x8, y8, z8 = 2546.466, 1972.659, 10.82
LV724_7 = createBlip ( x8, y8, z8, 36, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LS1
local x9, y9, z9 = 1315.4521484375, -898.7373046875, 39.578125
LS124_7 = createBlip ( x9, y9, z9, 36, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LS2
local x10, y10, z10 = 2423.611328125, -1742.2548828125, 13.546875
LS224_7 = createBlip ( x10, y10, z10, 36, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LS3
local x11, y11, z11 = 999.969, -920.073, 42.328
LS324_7 = createBlip ( x11, y11, z11, 36, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LS4
local x12, y12, z12 = 1352.436, -1759.125, 13.508
LS424_7 = createBlip ( x12, y12, z12, 36, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--Carson
local x13, y13, z13 = -180.742, 1034.869, 19.742
Carson24_7 = createBlip ( x13, y13, z13, 36, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--Whetstone
local x14, y14, z14 = -1562.534, -2732.942, 48.743
Whetstone24_7 = createBlip ( x14, y14, z14, 36, 2, 255, 0, 0, 255, 0, 200, getRootElement() )

------- Reingehen

shopmarkers = {
[1] = createMarker ( x1, y1, z1, "corona", 1.5, 0, 0, 255, 150 ),
[2] = createMarker ( x2, y2, z2, "corona", 1.5, 0, 0, 255, 150 ),
[3] = createMarker ( x3, y3, z3, "corona", 1.5, 0, 0, 255, 150 ),
[4] = createMarker ( x4, y4, z4, "corona", 1.5, 0, 0, 255, 150 ),
[5] = createMarker ( x5, y5, z5, "corona", 1.5, 0, 0, 255, 150 ),
[6] = createMarker ( x6, y6, z6, "corona", 1.5, 0, 0, 255, 150 ),
[7] = createMarker ( x7, y7, z7, "corona", 1.5, 0, 0, 255, 150 ),
[8] = createMarker ( x8, y8, z8, "corona", 1.5, 0, 0, 255, 150 ),
[9] = createMarker ( x9, y9, z9, "corona", 1.5, 0, 0, 255, 150 ),
[10] = createMarker ( x10, y10, z10, "corona", 1.5, 0, 0, 255, 150 ),
[11] = createMarker ( x11, y11, z11, "corona", 1.5, 0, 0, 255, 150 ),
[12] = createMarker ( x12, y12, z12, "corona", 1.5, 0, 0, 255, 150 ),
[13] = createMarker ( x13, y13, z13, "corona", 1.5, 0, 0, 255, 150 ),
[14] = createMarker ( x14, y14, z14, "corona", 1.5, 0, 0, 255, 150 ),
}

for i, Shopmarker in pairs(shopmarkers) do
    addEventHandler("onMarkerHit", Shopmarker, function(player)
	    if isPedInVehicle(player) == false then
			local x,y,z = getElementPosition(player)
			setElementData(player, "saveposx", x)
			setElementData(player, "saveposy", y)
			setElementData(player, "saveposz", z)
			fadeElementInterior(player,6, -27.22, -56.673, 1003.5468)
			setElementDimension(player, i)
			
			shopverlassen = createMarker(-27.28, -58.25, 1003.54, "corona", 1, 255,0,0)
			addEventHandler("onMarkerHit",shopverlassen,shopverlassen_func)
			setElementInterior(shopverlassen,6)
			setElementDimension(shopverlassen,i)
			
			shopkaufen = createMarker(-23.492, -55.331, 1002.9, "cylinder", 1, 0,100,150)
			setElementInterior(shopkaufen,6)
			setElementDimension(shopkaufen,i)
			
			addEventHandler("onMarkerHit",shopkaufen,shopkaufen_func)
		end
	end)
end

function shopkaufen_func(player)
	triggerClientEvent(player,"create24_7Shop",player)
end

function shopverlassen_func(player)
    setElementPosition(player, getElementData(player, "saveposx"), getElementData(player, "saveposy"), getElementData(player, "saveposz"))
    setElementInterior(player, 0)
	setElementDimension(player, 0)
end

function itemBuy_func ( player, item, cam, nvslot )

	if player == client then
		if cam == 43 then cam = true else cam = false end
		local money = westsideGetElementData ( player, "money" )
		if item == "flowers" then
			if westsideGetElementData ( player, "money" ) >= flowers_price then
				westsideSetElementData ( player, "money", money - flowers_price )
				takePlayerMoney ( player, flowers_price )
				giveWeapon ( player, 14, 1, true )
				triggerClientEvent ( player, "sec_gun_give", getRootElement(), 14, 1 )
				playSoundFrontEnd ( player, 40 )
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Gekauft!", 4000,0,255,0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000,255,0,0 )
			end
		elseif item == "cam" then
			if westsideGetElementData ( player, "money" ) >= cam_price then
				if cam then
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast bereits eine Kamera!", 4000,255,0,0 )
				else
					westsideSetElementData ( player, "money", money - cam_price )
					takePlayerMoney ( player, cam_price )
					giveWeapon ( player, 43, 36, true )
					triggerClientEvent ( player, "sec_gun_give", getRootElement(), 43, 36 )
					playSoundFrontEnd ( player, 40 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Gekauft!", 4000,0,255,0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000,255,0,0 )
			end
		elseif item == "camammo" then
			if westsideGetElementData ( player, "money" ) >= camammo_price then
				if cam then
					westsideSetElementData ( player, "money", money - camammo_price )
					takePlayerMoney ( player, camammo_price )
					giveWeapon ( player, 43, 36, true )
					triggerClientEvent ( player, "sec_gun_give", getRootElement(), 43, 36 )
					playSoundFrontEnd ( player, 40 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Gekauft!", 4000,0,255,0 )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast noch keine Kamera!", 4000,255,0,0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000,255,0,0 )
			end
		elseif item == "nv" then
			if westsideGetElementData ( player, "money" ) >= nvgoogles_price then
				westsideSetElementData ( player, "money", money - nvgoogles_price )
				takePlayerMoney ( player, nvgoogles_price )
				giveWeapon ( player, 44, 1, true )
				triggerClientEvent ( player, "sec_gun_give", getRootElement(), 44, 1 )
				playSoundFrontEnd ( player, 40 )
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Gekauft!", 4000,0,255,0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000,255,0,0 )
			end
		elseif item == "t" then
			if westsideGetElementData ( player, "money" ) >= tgoogles_price then
				westsideSetElementData ( player, "money", money - tgoogles_price )
				takePlayerMoney ( player, tgoogles_price )
				giveWeapon ( player, 45, 1, true )
				triggerClientEvent ( player, "sec_gun_give", getRootElement(), 45, 1 )
				playSoundFrontEnd ( player, 40 )
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Gekauft!", 4000,0,255,0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000,255,0,0 )
			end
		elseif item == "dice" then
			if westsideGetElementData ( player, "money" ) >= wuerfel_price then
				if westsideGetElementData ( player, "dice" ) == 0 then
					westsideSetElementData ( player, "money", money - wuerfel_price )
					takePlayerMoney ( player, wuerfel_price )
					westsideSetElementData ( player, "dice", 1 )
					MySQL_SetString("inventar", "Wuerfel", westsideGetElementData ( player, "dice" ), "Name LIKE '"..getPlayerName(player).."'")
					playSoundFrontEnd ( player, 40 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Gekauft!", 4000,0,255,0 )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast bereits einen Würfel!", 4000,255,0,0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000,255,0,0 )
			end
		elseif item == "los" then
			if westsideGetElementData ( player, "money" ) >= rubbellos_price then
				westsideSetElementData ( player, "money", money - rubbellos_price )
				takePlayerMoney ( player, rubbellos_price )
				playSoundFrontEnd ( player, 40 )
				local rnd = math.random ( 1, 100 )
				if rnd <= 60 then
					infobox(player,"Leider nur eine Niete!", 4000,255,0,0)
				elseif rnd <= 80 then
					infobox(player,"Du hast "..(rubbellos_price*1.5).." $ gewonnen!", 4000,0,255,0)
					westsideSetElementData ( player, "money", westsideGetElementData(player,"money") + (rubbellos_price*1.5) )
					givePlayerMoney ( player, (rubbellos_price*1.5) )
				elseif rnd <= 95 then
					infobox(player,"Du hast "..(rubbellos_price*2).." $ gewonnen!", 4000,0,255,0 )
					westsideSetElementData ( player, "money", westsideGetElementData(player,"money") + rubbellos_price*2 )
					givePlayerMoney ( player, rubbellos_price*2 )
				elseif rnd <= 99 then
					infobox(player,"Du hast "..(rubbellos_price*5).." $ gewonnen!", 4000,0,255,0 )
					westsideSetElementData ( player, "money", westsideGetElementData(player,"money") + rubbellos_price*5 )
					givePlayerMoney ( player, rubbellos_price*5 )
				else
					infobox(player,"Du hast "..(rubbellos_price*20).." $ gewonnen!", 4000,0,255,0 )
					westsideSetElementData ( player, "money", westsideGetElementData(player,"money") + rubbellos_price*20 )
					givePlayerMoney ( player, rubbellos_price*20 )
				end
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Gekauft!", 2500, 0, 125, 0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000,255,0,0 )
			end
		elseif item == "cig" then
			if westsideGetElementData ( player, "money" ) >= zigarett_price then
				westsideSetElementData ( player, "money", money - zigarett_price )
				takePlayerMoney ( player, zigarett_price )
				westsideSetElementData ( player, "zigaretten", westsideGetElementData ( player, "zigaretten" ) + 5 )
				playSoundFrontEnd ( player, 40 )
				
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Gekauft!", 4000,0,255,0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 2500, 125,0,0 )
			end
		elseif item == "sim-50" or item == "sim-100" or item == "sim-250" then
			if westsideGetElementData ( player, "handyType" ) == 2 then
				local val = 0
				if item == "sim-50" then
					val = 50
				elseif item == "sim-100" then
					val = 100
				else
					val = 250
				end
				if westsideGetElementData ( player, "money" ) >= val then
					westsideSetElementData ( player, "handyCosts", westsideGetElementData ( player, "handyCosts" ) + val )
					infobox ( player, "Guthaben aufgeladen! Tippe /call *100#,\num dein Guthaben zu überprüfen!", 4000,0,255,0)
					westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - val )
				else
					infobox ( player, "Du hast nicht genug Geld!", 4000,255,0,0 )
				end
			else
				infobox ( player, "Dies ist nur für Prepayed Nutzer!", 250, 125, 0, 0 )
			end
		-- Pizzadienst
		elseif item == "pizzadienst" then
			local pname = getPlayerName(player)
		
			if tonumber(westsideGetElementData ( player, "pizzadienst" )) == 0 then
				if westsideGetElementData(player,"money") >= 5000 then
					infobox(player,"Du hast den Pizzadienst nun\nin deinem Inventar!")
					westsideSetElementData ( player, "pizzadienst", 1 )
					takePlayerSaveMoney ( player, 5000 )
				
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 250)
				
					MySQL_SetString("userdata", "Pizzadienst", westsideGetElementData ( player, "pizzadienst" ), "Name LIKE '"..pname.."'")	
				else
					infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
				end
			else
				infobox(player,"Dieses Item hast du bereits!",4000,255,0,0)
			end
		--- Schutz
		--[[ elseif item == "schutz" then
			if westsideGetElementData(player,"money") >= 500 then
				infobox(player,"Du hast dir einen Schutz gekauft!")
				takePlayerSaveMoney(player,500)
				westsideSetElementData(player,"schutz",tonumber(westsideGetElementData(player,"schutz")) + 1)
				westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 25)
			else
				infobox(player,"Du hast nicht genug Geld!")
			end ]]--
		end
	end
end
addEvent ( "itemBuy", true )
addEventHandler ( "itemBuy", getRootElement(), itemBuy_func )

function changeTarif ( val )

	local player = client
	if val == 1 or val == 2 or val == 3 then
		if val ~= westsideGetElementData ( player, "handyType" ) then
			if westsideGetElementData ( player, "handyType" ) == 1 then
				if westsideGetElementData ( player, "money" ) >= westsideGetElementData ( player, "handyCosts" ) then
					westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - westsideGetElementData ( player, "handyCosts" ) )
					westsideSetElementData ( player, "handyCosts", 0 )
				else
					infobox ( player, "Du hast nicht genug Geld,\num die Kosten für deinen\nVertrag zu decken!", 4000,255,0,0 )
					return false
				end
			elseif westsideGetElementData ( player, "handyType" ) == 2 then
				westsideSetElementData ( player, "handyCosts", 0 )
			end
			if val == 1 then
				if westsideGetElementData ( player, "money" ) >= 10 then
					westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - 10 )
					westsideSetElementData ( player, "handyType", 1 )
					westsideSetElementData ( player, "handyCosts", 0 )
					infobox ( player, "Tarif gewechselt! Tippe /call *100#\nfür mehr Infos!", 4000,0,255,0 )
				else
					infobox ( player, "Du kannst die Einrichtungsgebühr\nnicht bezahlen!", 4000,255,0,0 )
				end
			elseif val == 2 then
				westsideSetElementData ( player, "handyType", 2 )
				westsideSetElementData ( player, "handyCosts", 0 )
				infobox ( player, "Tarif gewechselt! Tippe /call *100# fuer mehr Infos!", 4000,0,255,0 )
			elseif val == 3 then
				westsideSetElementData ( player, "handyType", 3 )
				westsideSetElementData ( player, "handyCosts", 0 )
				infobox ( player, "Tarif gewechselt! Tippe /call *100#\nfür mehr Infos!", 4000,0,255,0 )
			end
		else
			infobox ( player, "Diesen Tarif verwendest\ndu bereits!",4000,255,0,0 )
		end
	end
end
addEvent ( "changeTarif", true )
addEventHandler ( "changeTarif", getRootElement(), changeTarif )