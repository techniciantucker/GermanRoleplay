----- Waffenschein A -----
addEvent('waffenscheina',true)
addEventHandler('waffenscheina',root,function(player)
	local pname=getPlayerName(player)
	
	if(westsideGetElementData(player,'gunlicense')==0)then
		if(westsideGetElementData(player,'money')>=10000)then
			if(westsideGetElementData(player,'wanteds')==0)then
				takePlayerSaveMoney(player,10000)
				infobox(player,'Waffenschein A erhalten!')
				westsideSetElementData(player,'gunlicense',1)
				MySQL_SetString("userdata", "Waffenschein", westsideGetElementData ( player, "gunlicense" ), "Name LIKE '"..pname.."'")
				
				westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 500)
			else
				infobox(player,'Du darfst keine Wanteds haben!')
			end
		else
			infobox(player,'Du hast nicht genug Geld!')
		end
	else
		infobox(player,'Du hast bereits einen Waffenschein A!')
	end
end)

addEvent("waffenscheinb",true)
addEventHandler("waffenscheinb",root,function(player)
	local pname = getPlayerName ( player )

	if(westsideGetElementData(player,"gunlicenseB")== 0)then
		if(westsideGetElementData(player,'money')>=30000)then
			if(westsideGetElementData(player,"gunlicense")==1)then
				if(westsideGetElementData(player,'wanteds')==0)then
					takePlayerSaveMoney(player,30000)
					infobox(player,'Waffenschein B erhalten!')
					westsideSetElementData(player,'gunlicenseB',1)
					westsideSetElementData(player,'erfahrungspunkte',westsideGetElementData(player,'erfahrungspunkte')+1000)
					MySQL_SetString("userdata", "WaffenscheinB", westsideGetElementData(player,"gunlicenseB"), "Name LIKE '"..pname.."'")
				else
					infobox(player,'Du darfst keine Wanteds haben!')
				end
			else
				infobox(player,'Du benötigst erst Waffenschein A!')
			end
		else
			infobox(player,'Du hast nicht genug Geld!')
		end
	else
		infobox(player,"Du hast bereits einen\nWaffenschein B!")
	end
end)

addEvent("waffenscheinc",true)
addEventHandler("waffenscheinc",root,function(player)
	local pname = getPlayerName ( player )

	if(westsideGetElementData(player,"gunlicenseC")== 0)then
		if(westsideGetElementData(player,'money')>=50000)then
			if(westsideGetElementData(player,"gunlicense")==1)and(westsideGetElementData(player,'gunlicenseB')==1)then
				if(westsideGetElementData(player,'wanteds')==0)then
					takePlayerSaveMoney(player,50000)
					infobox(player,'Waffenschein C erhalten!')
					westsideSetElementData(player,'gunlicenseC',1)
					westsideSetElementData(player,'erfahrungspunkte',westsideGetElementData(player,'erfahrungspunkte')+1000)
					MySQL_SetString("userdata", "WaffenscheinC", westsideGetElementData(player,"gunlicenseC"), "Name LIKE '"..pname.."'")
				else
					infobox(player,'Du darfst keine Wanteds haben!')
				end
			else
				infobox(player,'Du benötigst erst Waffenschein A und B!')
			end
		else
			infobox(player,'Du hast nicht genug Geld!')
		end
	else
		infobox(player,"Du hast bereits einen\nWaffenschein C!")
	end
end)

Waffenschein = createPickup(1363.7078857422,-1283.8206787109,13.546875,3,1239,500)

addEventHandler("onPickupHit",Waffenschein,function(player)
	if isPedInVehicle (player) == false then
		triggerClientEvent(player,"WaffenscheinWindow",player)
	end
end)