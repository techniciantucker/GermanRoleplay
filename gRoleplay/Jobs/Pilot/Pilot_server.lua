local PMarker = createPickup (1642.4000244141,-2237.8000488281,13.5, 3, 1274, 500);
local pX, pY, pZ = 1460.4000244141, -2481, 22.200000762939

addEventHandler('onPickupHit', PMarker, function(player, dim)
	if isPedInVehicle (player) == false then
		if tonumber ( westsideGetElementData ( player, "carlicense" ) ) == 1 then
			if tonumber(westsideGetElementData ( player, "perso" )) == 1 then
				if tonumber(westsideGetElementData ( player, "worklicense" )) == 1 then
					if getElementData(player,"amJobben") == false then
						if tonumber(westsideGetElementData(player,"hartzseven")) == 0 then
							if getElementData(player,"level") > 4 then
								if getElementType(player) == 'player' then
									triggerClientEvent(player, 'gLoadPilotGUI', player);
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

addEvent('gPilotCreate', true);
addEventHandler('gPilotCreate', root, function(player, veh_id)
	_G['Pilot'..getPlayerName(player)] = createVehicle(veh_id, pX, pY, pZ);
	setElementRotation(_G['Pilot'..getPlayerName(player)], 0, 0, 270);
	warpPedIntoVehicle(player, _G['Pilot'..getPlayerName(player)]);
	if(westsideGetElementData(player,'playingtime')<=600)then
		outputChatBox('Das erarbeitete Geld erhältst du erst beim Payday!',player)
	end
	westsideSetElementData(player, "job", "Pilot" )
	outputLog("[JOB]: "..getPlayerName(player).." hat den Flugjob gestartet!","Jobsystem")
	
	setTimer(function()
		activeCarGhostMode ( player, 10000 )
	end,3000,1)
	
	setElementData(player,"amJobben",true)
end);

addEvent('gPilotEnd', true);
addEventHandler('gPilotEnd', root, function(player)
	if _G['Pilot'..getPlayerName(player)] then
		destroyElement(_G['Pilot'..getPlayerName(player)]);
		spawnPlayer(player, 1640, -2238.6000976563, 13.5);
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
	outputLog("[JOB]: "..getPlayerName(player).." hat den Flugjob abgebrochen!","Jobsystem")
end);

addEvent('gPilotGiveMoney', true);
addEventHandler('gPilotGiveMoney', root, function(player, money)
	westsideSetElementData(player,'jobgehalt',tonumber(westsideGetElementData(player,'jobgehalt'))+money)
	westsideSetElementData(player,'Punkte_Pilot',tonumber(westsideGetElementData(player,'Punkte_Pilot'))+1)
	if(westsideGetElementData(player,'Punkte_Pilot')>499)then
		if(westsideGetElementData(player,'Erfolg_Pilot')==0)then
			triggerClientEvent(player,'erfolgWindow',player,'Ein echter Flieger')
			westsideSetElementData(player,'Erfolg_Pilot',1)
			westsideSetElementData(player,'pokale',tonumber(westsideGetElementData(player,'pokale'))+1)
			outputLog(getPlayerName(player)..' hat den Erfolg Ein echter Flieger freigeschalten','Erfolge')
		end
	end
end)

addEventHandler('onPlayerQuit', root, function()
	if _G['Pilot'..getPlayerName(source)] then
		destroyElement(_G['Pilot'..getPlayerName(source)]);
	end
end)

addEvent('gPilotFinish', true)
addEventHandler('gPilotFinish', root, function(player)
	if _G['Pilot'..getPlayerName(player)] then
		destroyElement(_G['Pilot'..getPlayerName(player)]);
		spawnPlayer(player, 1640, -2238.6000976563, 13.5);
		
		setElementData(player,"amJobben",false)
	end
	triggerClientEvent ( player, "infobox_start", getRootElement(), "Passagiere transportiert.", 2500, 0,125,0 )
	outputLog("[JOB]: "..getPlayerName(player).." hat den Flugjob beendet.","Jobsystem")
end)