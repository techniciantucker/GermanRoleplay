local TMarker = createPickup (2281.55200, -2369.11450, 13.54688, 3, 1274, 500);
local tX, tY, tZ = 2280.5,-2362.3999023438,13.800000190735

addEventHandler('onPickupHit', TMarker, function(player, dim)
	if isPedInVehicle (player) == false then
		if tonumber ( westsideGetElementData ( player, "carlicense" ) ) == 1 then
			if tonumber(westsideGetElementData ( player, "perso" )) == 1 then
				if tonumber(westsideGetElementData ( player, "worklicense" )) == 1 then
					if getElementData(player,"amJobben") == false then
						if tonumber(westsideGetElementData(player,"hartzseven")) == 0 then
							if getElementData(player,"level") > 4 then
								if getElementType(player) == 'player' then
									triggerClientEvent(player, 'gLoadTruckerGUI', player);
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

addEvent('gTruckerCreate', true);
addEventHandler('gTruckerCreate', root, function(player, veh_id)
	_G['Trucker'..getPlayerName(player)] = createVehicle(veh_id, tX, tY, tZ);
	setElementRotation(_G['Trucker'..getPlayerName(player)], 0, 0, 225.25);
	warpPedIntoVehicle(player, _G['Trucker'..getPlayerName(player)]);
	if(westsideGetElementData(player,'playingtime')<=600)then
		outputChatBox('Das erarbeitete Geld erhältst du erst beim Payday!',player)
	end
	westsideSetElementData(player, "job", "Trucker" )
	outputLog("[JOB]: "..getPlayerName(player).." hat den Truckerjob gestartet!","Jobsystem")
	
	setElementData(player,"amJobben",true)
end);

addEvent('gTruckerEnd', true);
addEventHandler('gTruckerEnd', root, function(player)
	if _G['Trucker'..getPlayerName(player)] then
		destroyElement(_G['Trucker'..getPlayerName(player)]);
		spawnPlayer(player, 2281.55200, -2369.11450, 13.54688);
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
	outputLog("[JOB]: "..getPlayerName(player).." hat den Truckerjob abgebrochen!","Jobsystem")
end);

addEvent('gTruckerGiveMoney', true);
addEventHandler('gTruckerGiveMoney', root, function(player, money)
	westsideSetElementData(player,'jobgehalt',tonumber(westsideGetElementData(player,'jobgehalt'))+money)
	westsideSetElementData(player,'Punkte_Trucker',tonumber(westsideGetElementData(player,'Punkte_Trucker'))+1)
	if(westsideGetElementData(player,'Punkte_Trucker')>499)then
		if(westsideGetElementData(player,'Erfolg_Trucker')==0)then
			triggerClientEvent(player,'erfolgWindow',player,'Lieferant des Jahres')
			westsideSetElementData(player,'Erfolg_Trucker',1)
			westsideSetElementData(player,'pokale',tonumber(westsideGetElementData(player,'pokale'))+1)
			outputLog(getPlayerName(player)..' hat den Erfolg Lieferant des Jahres freigeschalten','Erfolge')
		end
	end
end)

addEventHandler('onPlayerQuit', root, function()
	if _G['Trucker'..getPlayerName(source)] then
		destroyElement(_G['Trucker'..getPlayerName(source)]);
	end
end)

addEvent('gTruckerFinish', true)
addEventHandler('gTruckerFinish', root, function(player)
	if _G['Trucker'..getPlayerName(player)] then
		destroyElement(_G['Trucker'..getPlayerName(player)]);
		spawnPlayer(player, 2281.55200, -2369.11450, 13.54688);
		
		setElementData(player,"amJobben",false)
	end
	triggerClientEvent ( player, "infobox_start", getRootElement(), "Lebensmittel verliefert!", 4000, 0,255,0 )
	westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 100)
	outputLog("[JOB]: "..getPlayerName(player).." hat den Truckerjob beendet!","Jobsystem")
end)