local werbung = false
local werbungPickup = createPickup(785.25079, -1328.98901, 13.54688,3,1239,500)

addEventHandler("onPickupHit",werbungPickup,function(player)
	if(isPedInVehicle(player)==false)then
		triggerClientEvent(player,"openWerbung",player)
	else
		infobox(player,"Steige erst aus deinem\nFahrzeug!",5000,255,0,0)
	end
end)

addEvent("werbung",true)
addEventHandler("werbung",root,function(text,cash)
	if(getDistanceBetweenPoints3D(785.25079, -1328.98901, 13.54688,getElementPosition(source))<=5)then
		if(isPedInVehicle(source)==false)then
			if(werbung==false)then
				werbung=true
				
				setTimer(function()
					werbung=false
				end,30000,1)
			
				outputChatBox("Werbung von "..getPlayerName(source).." | NR: "..westsideGetElementData(source,"telenr"),root,0,150,150)
				outputChatBox(text,root,0,200,150)
				
				takePlayerSaveMoney(source,cash)

				westsideSetElementData(source,"erfahrungspunkte",tonumber(westsideGetElementData(source,"erfahrungspunkte")) + 25)
			else
				infobox(source,"Nur alle 30 Sekunden\nmöglich!",5000,255,0,0)
			end
		end
	end
end)