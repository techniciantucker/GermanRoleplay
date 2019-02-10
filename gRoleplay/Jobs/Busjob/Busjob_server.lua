local Marker = createPickup (1807.05286, -1899.88110, 13.57954, 3, 1274, 500);
local bX, bY, bZ = 1791.6999511719, -1922.5, 13.60000038147

addEventHandler('onPickupHit', Marker, function(player, dim)
	if isPedInVehicle (player) == false then
		if tonumber ( westsideGetElementData ( player, "carlicense" ) ) == 1 then
			if tonumber(westsideGetElementData ( player, "perso" )) == 1 then
				if tonumber(westsideGetElementData ( player, "worklicense" )) == 1 then
					if getElementData(player,"amJobben") == false then
						if tonumber(westsideGetElementData(player,"hartzseven")) == 0 then
							if getElementData(player,"level") > 4 then
								if getElementType(player) == 'player' then
									triggerClientEvent(player, 'gLoadBusGUI', player);
								end
							else
								infobox(player,"Für diesen Job benötigst du\nLevel 5 oder höher!")
							end
						else
							infobox(player,'Mit Hartz 7 nicht möglich!')
						end
					else
						infobox(player,"Du führst bereits\neinen anderen Job aus!")
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

addEvent('gBusCreate', true);
addEventHandler('gBusCreate', root, function(player, veh_id)
	_G['Bus'..getPlayerName(player)] = createVehicle(veh_id, bX, bY, bZ);
	setElementRotation(_G['Bus'..getPlayerName(player)], 0, 0, 0);
	warpPedIntoVehicle(player, _G['Bus'..getPlayerName(player)]);
	westsideSetElementData(player, "job", "Bus-Fahrer" )
	outputLog("[JOB]: "..getPlayerName(player).." hat den Busjob gestartet!","Jobsystem")
	if(westsideGetElementData(player,'playingtime')<=600)then
		outputChatBox('Das erarbeitete Geld erhältst du erst beim Payday!',player)
	end
	setElementData(player,"amJobben",true)
end);

addEvent('gBusEnd', true);
addEventHandler('gBusEnd', root, function(player)
	if _G['Bus'..getPlayerName(player)] then
		destroyElement(_G['Bus'..getPlayerName(player)]);
		spawnPlayer(player, 1807.05286, -1899.88110, 13.57954);
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
	outputLog("[JOB]: "..getPlayerName(player).." hat den Busjob abgebrochen!","Jobsystem")
end);

addEvent('gBusGiveMoney', true);
addEventHandler('gBusGiveMoney', root, function(player, money)
	westsideSetElementData(player,'jobgehalt',tonumber(westsideGetElementData(player,'jobgehalt'))+money)
	westsideSetElementData(player,'Punkte_Busfahrer',tonumber(westsideGetElementData(player,'Punkte_Busfahrer'))+1)
	if(westsideGetElementData(player,'Punkte_Busfahrer')>999)then
		if(westsideGetElementData(player,'Erfolg_Busfahrer')==0)then
			triggerClientEvent(player,'erfolgWindow',player,'Haltestellensammler')
			westsideSetElementData(player,'Erfolg_Busfahrer',1)
			westsideSetElementData(player,'pokale',tonumber(westsideGetElementData(player,'pokale'))+1)
			outputLog(getPlayerName(player)..' hat den Erfolg Haltestellensammler freigeschalten','Erfolge')
		end
	end
end)

addEventHandler('onPlayerQuit', root, function()
	if _G['Bus'..getPlayerName(source)] then
		destroyElement(_G['Bus'..getPlayerName(source)]);
	end
end)

addEvent('gBusFinish', true)
addEventHandler('gBusFinish', root, function(player)
	if _G['Bus'..getPlayerName(player)] then
		destroyElement(_G['Bus'..getPlayerName(player)]);
		spawnPlayer(player, 1807.05286, -1899.88110, 13.57954);
		
		setElementData(player,"amJobben",false)
	end
	triggerClientEvent ( player, "infobox_start", getRootElement(), "Alle Personen sind am\nZiel angekommen!", 4000, 0,255,0)
	westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 100)
	outputLog("[JOB]: "..getPlayerName(player).." hat den Busjob beendet!","Jobsystem")
end)