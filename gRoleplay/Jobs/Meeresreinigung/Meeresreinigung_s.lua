local meeresReinigungPickup = createPickup(2494.30542, -2258.43457, 3.00000,3,1274,50)

addEventHandler('onPickupHit',meeresReinigungPickup,function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(isPedInVehicle(player)==false)then
			if(westsideGetElementData(player,'motorbootlicense')==1)then
				if(westsideGetElementData(player,'perso')==1)then
					if(westsideGetElementData(player,'worklicense')==1)then
						if tonumber(westsideGetElementData(player,"hartzseven")) == 0 then
							if(getElementData(player,'amJobben')==false)then
								triggerClientEvent(player,'MeeresreinigungWindow',player)
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
				infobox(player,'Du hast keinen Motorbootschein!')
			end
		end
	end
end)

addEvent('meeresReinigungStart',true)
addEventHandler('meeresReinigungStart',root,function(player)
	if(not(isPedInVehicle(player)))then
		if(not(isPedDead(player)))then
			local x,y,z = getElementPosition(player)
			
			westsideSetElementData(player,'job','Meeresreinigung')
			
			if(getDistanceBetweenPoints3D(x,y,z,2494.30542, -2258.43457, 3.00000)<=10)then
				local vehicle = createVehicle(453,2499.8017578125,-2268.44140625,-0.16085433959961,3.4661865234375,355.9130859375,272.99377441406)
				warpPedIntoVehicle(player,vehicle)
				if(westsideGetElementData(player,'playingtime')<=600)then
					outputChatBox('Das erarbeitete Geld erhältst du erst beim Payday!',player)
				end
				addEventHandler('onVehicleStartExit',vehicle,function()
					cancelEvent()
					outputChatBox('Kehre zur Anlegestelle zurück und Tippe /stopBoot, um auszusteigen!',player,255,0,0)
				end)
				
				outputLog(getPlayerName(player)..' hat den Meeresreinigung Job gestartet!','Jobsystem')
				
				triggerClientEvent(player,'startMeeresJob',player)
			end
		end
	end
end)

addCommandHandler('stopBoot',function(player)
	local x,y,z    = getElementPosition(player)
	local distance = getDistanceBetweenPoints3D(2494.30542, -2258.43457, 3.00000,x,y,z)
	
	if(distance<20)then
		destroyElement(getPedOccupiedVehicle(player))
		removePedFromVehicle(player)
		setElementPosition(player,2500.166015625,-2259.4609375,3)
		triggerClientEvent(player,'stopMeeresJob',player)
		
		outputLog(getPlayerName(player)..' hat den Meeresreinigung Job beendet!','Jobsystem')
	else
		outputChatBox('Du bist nicht nah genug an der Anlegestelle!',player,255,0,0)
	end
end)

addEvent('payForCleanMeer',true)
addEventHandler('payForCleanMeer',root,function(menge)
	if(getElementData(source,'level')<11)then
		menge = (menge)
	elseif(getElementData(source,'level')>10 and getElementData(source,'level')<21)then
		menge = (menge*1.5)
	elseif(getElementData(source,'level')>20 and getElementData(source,'level')<26)then
		menge = (menge*2)
	end
	
	outputChatBox('Du erhälst '..math.floor(menge)..'$.',source,0,200,0)
	westsideSetElementData(source,'jobgehalt',tonumber(westsideGetElementData(source,'jobgehalt'))+math.floor(menge))
	
	westsideSetElementData(source,'Punkte_Meeresreiniger',tonumber(westsideGetElementData(source,'Punkte_Meeresreiniger'))+math.floor(menge))
	if(westsideGetElementData(source,'Punkte_Meeresreiniger')>999999)then
		if(westsideGetElementData(source,'Erfolg_Meeresreiniger')==0)then
			triggerClientEvent(source,'erfolgWindow',source,'Umweltfreundlich')
			westsideSetElementData(source,'Erfolg_Meeresreiniger',1)
			westsideSetElementData(source,'pokale',tonumber(westsideGetElementData(source,'pokale'))+1)
			outputLog(getPlayerName(source)..' hat den Erfolg Umweltfreundlich freigeschalten','Erfolge')
		end
	end
	westsideSetElementData(source,'erfahrungspunkte',tonumber(westsideGetElementData(source,'erfahrungspunkte'))+math.floor(menge)/10)
	outputLog(getPlayerName(source)..' hat beim Meeresreinigung Job '..math.floor(menge)..' abgegeben!','Jobsystem')
end)