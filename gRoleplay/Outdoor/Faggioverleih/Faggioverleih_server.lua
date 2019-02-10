faggiostand = createObject(3861,1563.0999755859,-1880.8000488281,13.699999809265,0,0,180)
faggioMarker = createPickup(1563.20642, -1879.06799, 13.54688,3,1239,500)

addEventHandler("onPickupHit",faggioMarker,function(player)
	if isPedInVehicle (player) == false then
		triggerClientEvent(player,"openfaggio",player)
	end
end,false)

addEvent("buyfaggio",true)
addEventHandler("buyfaggio",root,function(player)
	if westsideGetElementData(player,"playingtime") < 600 then
		infobox(player,"Da du unter 10 Spielstunden hast,\nzahlt der Staats das Faggio.")
		_G["faggio"..getPlayerName(player)] = createVehicle(462,1559.3000488281,-1880.3000488281,13.199999809265)
		warpPedIntoVehicle(player,_G["faggio"..getPlayerName(player)])
		setTimer(function()
			destroyElement(_G["faggio"..getPlayerName(player)])
		end,1800000,1)
	else
		if westsideGetElementData(player,"money") >= 100 then
			takePlayerSaveMoney(player,100)
			infobox(player,"Du hast dir ein Faggio ausgeliehen,\nwas dich 100$ gekostet hat.")
			_G["faggio"..getPlayerName(player)] = createVehicle(462,1559.3000488281,-1880.3000488281,13.199999809265)
			warpPedIntoVehicle(player,_G["faggio"..getPlayerName(player)])
			setTimer(function()
				destroyElement(_G["faggio"..getPlayerName(player)])
			end,1800000,1)
		else
			infobox(player,"Du hast nicht genug Geld!")
		end
	end
end)