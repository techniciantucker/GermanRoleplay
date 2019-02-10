local zugPickup=createPickup(1751.17639, -1943.75940, 13.56912,3,1274,50)

addEventHandler('onPickupHit',zugPickup,function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(isPedInVehicle(player)==false)then
			if(westsideGetElementData(player,'carlicense')==1)then
				if(westsideGetElementData(player,'perso')==1)then
					if(westsideGetElementData(player,'worklicense')==1)then
						if tonumber(westsideGetElementData(player,"hartzseven")) == 0 then
							if(getElementData(player,'amJobben')==false)then
								triggerClientEvent(player,'ZugjobWindow',player)
							else
								infobox(player,'Du führst bereits\neinen anderen Job aus!')
							end
						else
							infobox(player,'Mit Hartz 7 nicht möglich!')
						end
					else
						infobox(player,'Du hast keine Arbeitslizenz!')
					end
				else
					infobox(player,'Du hast keinen Personalausweis!')
				end
			else
				infobox(player,'Du hast keinen Führerschein!')
			end
		end
	end
end)

addEvent('zugJobAnnehmen',true)
addEventHandler('zugJobAnnehmen',root,function(player)
	if(not(westsideGetElementData(player,'job'))=='Zugführer')then
		westsideSetElementData(player,'job','Zugführer')
	end
	zug=createVehicle(538,1850.599609375,-1931.2998046875,14.89999961853,0,0,90)
	warpPedIntoVehicle(player,zug)
	setElementData(player,'zugJobAktiv',true)
	setElementData(player,'amJobben',true)
	addEventHandler('onVehicleStartExit',zug,function()
		cancelEvent()
		infobox(player,'Tippe /stopZug, um den Job\nzu beenden!')
	end)
	outputChatBox('Bring den Zug zur markierten Stelle auf der Karte.',player)
	triggerClientEvent(player,'zugMarker',player)
end)

addEvent('zugJobBelohnung',true)
addEventHandler('zugJobBelohnung',root,function(player)
	if(getElementData(player,'level')<11)then
		belohnung=math.random(300,500)
	elseif(getElementData(player,'level')>10 and getElementData(player,'level')<21)then
		belohnung=math.random(600,800)
	elseif(getElementData(player,'level')>20 and getElementData(player,'level')<26)then
		belohnung=math.random(900,1200)
	end
	local veh=getPedOccupiedVehicle(player)
	local money=westsideGetElementData(player,'money')
	if(veh)then
		destroyElement(veh)
	end
	setElementData(player,'zugJobAktiv',false)
	setElementData(player,'amJobben',false)
	outputChatBox('Du erhälst '..belohnung..'$ für die Fahrt.',player,0,200,0)
	if(westsideGetElementData(player,'playingtime')<=600)then
		outputChatBox('Das erarbeitete Geld erhältst du erst beim Payday!',player)
	end
	westsideSetElementData(player,'jobgehalt',tonumber(westsideGetElementData(player,'jobgehalt'))+belohnung)
	westsideSetElementData(player,'Punkte_Zugjob',tonumber(westsideGetElementData(player,'Punkte_Zugjob'))+1)
	if(westsideGetElementData(player,'Erfolg_Zugjob')==0)then
		if(westsideGetElementData(player,'Punkte_Zugjob')>=750)then
			westsideSetElementData(player,'Erfolg_Zugjob',1)
			triggerClientEvent(player,'erfolgWindow',player,'Schienenmeister')
			westsideSetElementData(player,'pokale',tonumber(westsideGetElementData(player,'pokale'))+1)
			outputLog(getPlayerName(player)..' hat den Erfolg Schienenmeister freigeschalten!','Erfolge')
		end
	end
	spawnPlayer(player,1751.17639, -1943.75940, 13.56912)
end)

addCommandHandler('stopZug',function(player)
	if(getElementData(player,'zugJobAktiv')==true)then
		local veh=getPedOccupiedVehicle(player)
		local money=westsideGetElementData(player,'money')
		if(veh)then
			destroyElement(veh)
		end
		setElementData(player,'zugJobAktiv',false)
		setElementData(player,'amJobben',false)
		if(money>=500)then
			outputChatBox('Du hast den Job abgebrochen und musst 500$ Strafe zahlen!',player,125,0,0)
			takePlayerSaveMoney(player,500)
		else
			outputChatBox('Du hast den Job abgebrochen und musst '..money..'$ Strafe zahlen!',player,125,0,0)
			takePlayerSaveMoney(player,money)
		end
		spawnPlayer(player,1751.17639, -1943.75940, 13.56912)
		triggerClientEvent(player,'destroyZugMarker',player)
	end
end)