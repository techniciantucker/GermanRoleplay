local SMarker = createPickup (2137.60107, -1906.95129, 13.54688, 3, 1274, 500);
local sX, sY, sZ = 2131.5,-1909.3000488281,14.10000038147

addEventHandler('onPickupHit', SMarker, function(player, dim)
	if isPedInVehicle (player) == false then
		if tonumber ( westsideGetElementData ( player, "carlicense" ) ) == 1 then
			if tonumber(westsideGetElementData ( player, "perso" )) == 1 then
				if tonumber(westsideGetElementData ( player, "worklicense" )) == 1 then
					if tonumber(westsideGetElementData(player,"hartzseven")) == 0 then
						if getElementData(player,"amJobben") == false then
							if getElementType(player) == 'player' then
								triggerClientEvent(player, 'gLoadSweeperGUI', player);
							end
						else
							infobox(player,"Du führst bereits\neinen anderen Job aus!")
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

addEvent('gSweeperCreate', true);
addEventHandler('gSweeperCreate', root, function(player, veh_id)
	_G['Sweeper'..getPlayerName(player)] = createVehicle(veh_id, sX, sY, sZ);
	setElementRotation(_G['Sweeper'..getPlayerName(player)], 0, 0, 0);
	warpPedIntoVehicle(player, _G['Sweeper'..getPlayerName(player)]);
	if(westsideGetElementData(player,'playingtime')<=600)then
		outputChatBox('Das erarbeitete Geld erhältst du erst beim Payday!',player)
	end
	westsideSetElementData(player, "job", "Straßenreiniger" )
	outputLog("[JOB]: "..getPlayerName(player).." hat den Straßenreinigerjob gestartet!","Jobsystem")
	
	setElementData(player,"amJobben",true)
end);

addEvent('gSweeperEnd', true);
addEventHandler('gSweeperEnd', root, function(player)
	if _G['Sweeper'..getPlayerName(player)] then
		destroyElement(_G['Sweeper'..getPlayerName(player)]);
		spawnPlayer(player, 2136.66382, -1917.16541, 13.54688);
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
	outputLog("[JOB]: "..getPlayerName(player).." hat den Straßenreinigerjob abgebrochen!","Jobsystem")
end);

addEvent('gSweeperGiveMoney', true);
addEventHandler('gSweeperGiveMoney', root, function(player, money)
	westsideSetElementData(player,'jobgehalt',tonumber(westsideGetElementData(player,'jobgehalt'))+money)
	westsideSetElementData(player,'Punkte_Strassenreiniger',tonumber(westsideGetElementData(player,'Punkte_Strassenreiniger'))+1)
	if(westsideGetElementData(player,'Punkte_Strassenreiniger')>999)then
		if(westsideGetElementData(player,'Erfolg_Strassenreiniger')==0)then
			triggerClientEvent(player,'erfolgWindow',player,'Ein echter Müllmann')
			westsideSetElementData(player,'Erfolg_Strassenreiniger',1)
			westsideSetElementData(player,'pokale',tonumber(westsideGetElementData(player,'pokale'))+1)
			outputLog(getPlayerName(player)..' hat den Erfolg Ein echter Müllmann freigeschalten','Erfolge')
		end
	end
end)

addEventHandler('onPlayerQuit', root, function()
	if _G['Sweeper'..getPlayerName(source)] then
		destroyElement(_G['Sweeper'..getPlayerName(source)]);
	end
end)

addEvent('gSweeperFinish', true)
addEventHandler('gSweeperFinish', root, function(player)
	if _G['Sweeper'..getPlayerName(player)] then
		destroyElement(_G['Sweeper'..getPlayerName(player)]);
		spawnPlayer(player, 2136.66382, -1917.16541, 13.54688);
		
		setElementData(player,"amJobben",false)
	end
	triggerClientEvent ( player, "infobox_start", getRootElement(), "Straßen gesäubert!", 4000, 0,255,0 )
	westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 100)
	outputLog("[JOB]: "..getPlayerName(player).." hat den Straßenreinigerjob beendet!","Jobsystem")
end)