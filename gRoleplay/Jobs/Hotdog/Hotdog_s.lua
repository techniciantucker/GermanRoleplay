local hotdogvehicle={
[1]=createVehicle(588,1324.8000488281,-872.5,39.5,0,0,0),
[2]=createVehicle(588,1320.6999511719,-872.40002441406,39.5,0,0,0),
[3]=createVehicle(588,1316.5999755859,-872.40002441406,39.5,0,0,0),
[4]=createVehicle(588,1312.3000488281,-872.40002441406,39.5,0,0,0),
[5]=createVehicle(588,1307.9000244141,-872.40002441406,39.5,0,0,0),
}

for i=1,#hotdogvehicle do
	setVehiclePlateText(hotdogvehicle[i],'Hot-Dog'..i)
	addEventHandler('onVehicleStartEnter',hotdogvehicle[i],function(player)
		if(not(westsideGetElementData(player,'job')=='Hotdog-Verkäufer'))then
			cancelEvent()
			infobox(player,'Du bist nicht befugt!')
		end
	end)
	setTimer(function()
		if(getVehicleOccupant(hotdogvehicle[i])==false)then
			respawnVehicle(hotdogvehicle[i])
		end
	end,3600000,0)
end

local hotdogJobPickup=createPickup(1326.7032470703,-878.76916503906,39.578125,3,1274,50)
addEventHandler('onPickupHit',hotdogJobPickup,function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(isPedInVehicle(player)==false)then
			if(westsideGetElementData(player,'carlicense')==1)then
				if(westsideGetElementData(player,'perso')==1)then
					if(westsideGetElementData(player,'worklicense')==1)then
						if tonumber(westsideGetElementData(player,"hartzseven")) == 0 then
							if(getElementData(player,'amJobben')==false)then
								triggerClientEvent(player,'hotdogWindow',player)
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
				infobox(player,'Du hast keinen Fahrzeugschein!')
			end
		end
	end
end)

addEvent('hotdogJobAnnehmen',true)
addEventHandler('hotdogJobAnnehmen',root,function(player)
	if(westsideGetElementData(player,'job')=='Hotdog-Verkäufer')then
		infobox(player,'Du bist bereits Hotdog-Verkäufer!')
		if(westsideGetElementData(player,'playingtime')<=600)then
			outputChatBox('Das erarbeitete Geld erhältst du erst beim Payday!',player)
		end
	else
		infobox(player,'Du bist nun Hotdog-Verkäufer!\nKaufe dir im blauen Marker\nnun ein paar Hotdogs.')
		westsideSetElementData(player,'job','Hotdog-Verkäufer')
	end
end)

local hotdogPreis=1
local buyhotdogsMarker=createMarker(1308.0999755859,-854,38.599998474121,'cylinder',3,0,0,200)

addEventHandler('onMarkerHit',buyhotdogsMarker,function(player)
	if(westsideGetElementData(player,'job')=='Hotdog-Verkäufer')then
		infobox(player,'Tippe /buydogs [Anzahl], um\nfür 1$ pro Stück Hotdogs zu kaufen.')
	end
end)

addCommandHandler('buydogs',function(player,cmd,anzahl)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'job')=='Hotdog-Verkäufer')then
			if(anzahl)then
				if(getDistanceBetweenPoints3D(1308.0999755859,-854,38.59999847412,getElementPosition(player))<=5)then
					hotdogPreis2=anzahl*hotdogPreis
					if(westsideGetElementData(player,'money')>=hotdogPreis2)then
						infobox(player,'Du hast dir für '..hotdogPreis2..'$\n'..anzahl..' Hotdogs gekauft!')
						outputChatBox('~~~~~ Hotdog-Verkäufer ~~~~~',player,255,255,255)
						outputChatBox('Steige nun in einen Hotdog Wagen, um die Schicht',player,0,200,0)
						outputChatBox('zu beginnen. Mittels /selldog [Spieler] [Preis],',player,0,200,0)
						outputChatBox('kannst du nun Hotdogs verkaufen.',player,0,200,0)
						takePlayerSaveMoney(player,hotdogPreis2)
						westsideSetElementData(player,'hotdogs',tonumber(westsideGetElementData(player,'hotdogs'))+anzahl)
						outputLog('[HOTDOG]: '..getPlayerName(player)..' hat sich '..anzahl..'x Hotdog gekauft','Jobsystem')
					else
						infobox(player,'Du hast nicht genug Geld!')
					end
				end
			else
				infobox(player,'Keine Anzahl angegeben!')
			end
		end
	end
end)

addCommandHandler('selldog',function(player,cmd,target,preis)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'job')=='Hotdog-Verkäufer')then
			if(target)then
				local tplayer=getPlayerFromName(target)
				local tx,ty,tz=getElementPosition(tplayer)
				local x,y,z=getElementPosition(player)
				if(preis)then
					if(not(tonumber(preis)>100))then
						if(getDistanceBetweenPoints3D(tx,ty,tz,x,y,z)<=10)then
							local veh=getPedOccupiedVehicle(player)
							if(getElementModel(veh)==588)then
								setElementData(tplayer,'hotdogPrice',preis)
								setElementData(tplayer,'hotdogSeller',getPlayerName(player))
								outputChatBox(getPlayerName(player)..' hat dir für '..preis..'$ einen Hotdog angeboten!',tpayer,0,200,0)
								outputChatBox('Tippe /accepthotdog, um den Hotdog zu kaufen.',tplayer,0,200,0)
							else
								infobox(player,'Du musst in einem Hotdog Wagen sitzen!')
							end
						else
							infobox(player,'Du bist zu weit entfernt!')
						end
					else
						infobox(player,'maximal 100$!')
					end
				else
					infobox(player,'Keinen Preis angegeben!')
				end
			else
				infobox(player,'Keinen Spieler angegeben!')
			end
		end
	end
end)

addCommandHandler('accepthotdog',function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		local preis=getElementData(player,'hotdogPrice')
		local seller=getPlayerFromName(getElementData(player,'hotdogSeller'))
		if(preis)and(seller)then
			local sx,sy,sz=getElementPosition(seller)
			local x,y,z=getElementPosition(player)
			if(getDistanceBetweenPoints3D(sx,sy,sz,x,y,z)<=10)then
				local veh=getPedOccupiedVehicle(seller)
				if(getElementModel(veh)==588)then
					if(westsideGetElementData(player,'money')>=tonumber(preis))then
						if(not(westsideGetElementData(seller,'hotdogs')==0))then
							takePlayerSaveMoney(player,preis)
							westsideSetElementData(seller,'jobgehalt',tonumber(westsideGetElementData(seller,'jobgehalt'))+preis)
							westsideSetElementData(seller,'Punkte_Hotdog',tonumber(westsideGetElementData(seller,'Punkte_Hotdog'))+1)
							if(westsideGetElementData(seller,'Punkte_Hotdog')>99)then
								if(westsideGetElementData(seller,'Erfolg_Hotdog')==0)then
									triggerClientEvent(seller,'erfolgWindow',seller,'Wurst ins Brot')
									westsideSetElementData(seller,'Erfolg_Hotdog',1)
									westsideSetElementData(seller,'pokale',tonumber(westsideGetElementData(seller,'pokale'))+1)
									outputLog(getPlayerName(seller)..' hat den Erfolg Wurst ins Brot freigeschalten','Erfolge')
								end
							end
							setElementData(player,'hotdogPrice',nil)
							setElementData(player,'hotdogSeller',nil)
							outputChatBox('Der Spieler '..getPlayerName(player)..' hat dir für '..preis..'$ einen Hotdog abgekauft.',seller,0,200,0)
							outputChatBox('Du hast dir einen Hotdog gekauft! Dein Leben wurde um 10% erhöht.',player,0,200,0)
							setElementHealth(player,getElementHealth(player)+10)
							westsideSetElementData(seller,'hotdogs',tonumber(westsideGetElementData(seller,'hotdogs'))-1)
							westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))+15)
							if(westsideGetElementData(player,'hunger')>100)then
								westsideSetElementData(player,'hunger',100)
							end
							outputLog('[HOTDOG]: '..getPlayerName(player)..' hat von '..getPlayerName(seller)..' einen Hotdog gekauft','Jobsystem')
						else
							infobox(player,'Der Spieler hat keine Hotdogs mehr!')
						end
					else
						infobox(player,'Du hast nicht genug Geld!')
					end
				else
					infobox(player,'Der Verkäufer ist in keinem\nHotdog Fahrzeug!')
				end
			else
				infobox(player,'Du bist zu weit entfernt!')
			end
		end
	end
end)