SexshopRein = createPickup (953.7998046875,-1336.7001953125,13.384259223938,3,1318,500)

SexshopRaus = createPickup (-100.2998046875,-25.2001953125,1000.71875,3,1318,500)
setElementInterior (SexshopRaus, 3)

addEventHandler ("onPickupHit", SexshopRein, function (source, dim )
	if isPedInVehicle (source) == false then
		fadeElementInterior (source,3,-100.5,-23.5,1000.700012207)
		setElementRotation (source,0,0,0.00274658)
	end
end)

addEventHandler ("onPickupHit", SexshopRaus, function (source, dim )
	if isPedInVehicle (source) == false then
		fadeElementInterior (source,0,954.09997558594,-1335.1999511719,13.5)
		setElementRotation (source,0,0,44.0036621)
	end
end)

function xxxShopBuy_func ( item )

	local price = sexShopItemPrices[item]
	if price then
		local money = westsideGetElementData ( client, "money" )
		if money >= price then
			giveWeapon ( client, item )
			westsideSetElementData ( client, "money", money - price )
			playSoundFrontEnd ( client, 40 )
			
			infobox ( client, "Gekauft!", 4000,0,255,0)
		else
			infobox ( client, "Du hast nicht genug Geld!", 4000,255,0,0 )
		end
	end
end
addEvent ( "xxxShopBuy", true )
addEventHandler ( "xxxShopBuy", getRootElement(), xxxShopBuy_func )