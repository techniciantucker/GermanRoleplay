local SMarker = createPickup (2105.10352, -1802.85693, 13.55469, 3, 1274, 500);
local sX, sY, sZ = 2092.6999511719,-1802.8000488281,13.199999809265

addEventHandler('onPickupHit', SMarker, function(player, dim)
	if isPedInVehicle (player) == false then
		if tonumber ( westsideGetElementData ( player, "carlicense" ) ) == 1 then
			if tonumber(westsideGetElementData ( player, "perso" )) == 1 then
				if tonumber(westsideGetElementData ( player, "worklicense" )) == 1 then
					if tonumber(westsideGetElementData(player,"hartzseven")) == 0 then
						if tonumber(westsideGetElementData(player,"hartzseven")) == 0 then
							if getElementData(player,"amJobben") == false then
								if getElementType(player) == 'player' then
									triggerClientEvent(player, 'gLoadPizzaGUI', player);
								end
							else
								infobox(player,"Du führst bereits\neinen anderen Job aus!")
							end
						else
							infobox(player,'Mit Hartz 7 nicht möglich!')
						end
					else
						infobox(player,'Mit Hartz 7 nicht möglich!')
					end
				else
					infobox(player,"Du hast keine Arbeitsgenehmigung!")
				end
			else
				infobox(player,"Du hast keinen Personalausweis!")
			end
		else
			infobox(player,"Du hast keinen Führerschein!")
		end
	end
end)

addEvent('gPizzaCreate', true);
addEventHandler('gPizzaCreate', root, function(player, veh_id)
	_G['Pizza'..getPlayerName(player)] = createVehicle(veh_id, sX, sY, sZ);
	setElementRotation(_G['Pizza'..getPlayerName(player)], 0, 0, 90);
	warpPedIntoVehicle(player, _G['Pizza'..getPlayerName(player)]);
	if(westsideGetElementData(player,'playingtime')<=600)then
		outputChatBox('Das erarbeitete Geld erhältst du erst beim Payday!',player)
	end
	westsideSetElementData(player, "job", "Pizzabote" )
	setPedSkin(player,155)
	outputLog("[JOB]: "..getPlayerName(player).." hat den Pizzajob gestartet!","Jobsystem")
	
	setElementData(player,"amJobben",true)
end);

addEvent('gPizzaEnd', true);
addEventHandler('gPizzaEnd', root, function(player)
	if _G['Pizza'..getPlayerName(player)] then
		destroyElement(_G['Pizza'..getPlayerName(player)]);
		spawnPlayer(player, 2100.50854, -1802.75903, 13.55469);
		setPedSkin ( player,  westsideGetElementData ( player, "skinid" ) )
		if(westsideGetElementData(player,'money')>=500)then
			takePlayerSaveMoney(player,500)
			strafe=500
		else
			strafemoney=westsideGetElementData(player,'money')
			takePlayerSaveMoney(player,strafemoney)
			strafe=strafemoney
		end
		
		setElementData(player,"amJobben",false)
	end
	infobox(player,"Job abgebrochen!\nStrafe: "..strafe.."$")
	outputLog("[JOB]: " ..getPlayerName(player).." hat den Pizzajob abgebrochen.","Jobsystem")
end);

addEvent('gPizzaGiveMoney', true);
addEventHandler('gPizzaGiveMoney', root, function(player,money)
	westsideSetElementData(player,'jobgehalt',tonumber(westsideGetElementData(player,'jobgehalt'))+money)
	westsideSetElementData(player,'Punkte_Pizzalieferant',tonumber(westsideGetElementData(player,'Punkte_Pizzalieferant'))+1)
	if(westsideGetElementData(player,'Punkte_Pizzalieferant')>2999)then
		if(westsideGetElementData(player,'Erfolg_Pizzalieferant')==0)then
			triggerClientEvent(player,'erfolgWindow',player,'Gesund? Kenne ich nicht')
			westsideSetElementData(player,'Erfolg_Pizzalieferant',1)
			westsideSetElementData(player,'pokale',tonumber(westsideGetElementData(player,'pokale'))+1)
			outputLog(getPlayerName(player)..' hat den Erfolg Gesund? Kenne ich nicht freigeschalten','Erfolge')
		end
	end
end)

addEventHandler('onPlayerQuit', root, function()
	if _G['Pizza'..getPlayerName(source)] then
		destroyElement(_G['Pizza'..getPlayerName(source)]);
	end
end)

addEvent('gPizzaFinish', true)
addEventHandler('gPizzaFinish', root, function(player)
	if _G['Pizza'..getPlayerName(player)] then
		destroyElement(_G['Pizza'..getPlayerName(player)]);
		spawnPlayer(player, 2100.50854, -1802.75903, 13.55469);
		setPedSkin ( player,  westsideGetElementData ( player, "skinid" ) )
		
		setElementData(player,"amJobben",false)
	end
	triggerClientEvent ( player, "infobox_start", getRootElement(), "Pizza verliefert!", 4000, 0,255,0)
	westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 100)
	outputLog("[JOB]: "..getPlayerName(player).." hat den Pizzajob beendet!","Jobsystem")
end)