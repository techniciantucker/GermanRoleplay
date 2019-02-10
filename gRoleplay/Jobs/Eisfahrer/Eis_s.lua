local eisvehicle={
[1]=createVehicle(423,1865.0999755859,-1861.1999511719,13.699999809265,0,0,270),
[2]=createVehicle(423,1865.1999511719,-1857.9000244141,13.699999809265,0,0,270),
[3]=createVehicle(423,1865.1999511719,-1854.5999755859,13.699999809265,0,0,270),
[4]=createVehicle(423,1865.1999511719,-1851.0999755859,13.699999809265,0,0,270),
[5]=createVehicle(423,1865.1999511719,-1847.5999755859,13.699999809265,0,0,270),
}

for i=1,#eisvehicle do
	setVehiclePlateText(eisvehicle[i],'Eis'..i)
	addEventHandler('onVehicleStartEnter',eisvehicle[i],function(player)
		if(not(westsideGetElementData(player,'job')=='Eisverkäufer'))then
			cancelEvent()
			infobox(player,'Du bist nicht befugt!')
		end
	end)
	setTimer(function()
		if(getVehicleOccupant(eisvehicle[i])==false)then
			respawnVehicle(eisvehicle[i])
		end
	end,3600000,0)
end

local eisPickup=createPickup(1861.97351, -1837.80823, 13.57642,3,1274,50)
addEventHandler('onPickupHit',eisPickup,function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(isPedInVehicle(player)==false)then
			if(westsideGetElementData(player,'carlicense')==1)then
				if(westsideGetElementData(player,'perso')==1)then
					if(westsideGetElementData(player,'worklicense')==1)then
						if tonumber(westsideGetElementData(player,"hartzseven")) == 0 then
							if(getElementData(player,'amJobben')==false)then
								triggerClientEvent(player,'eisWindow',player)
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

addEvent('eisJobAnnehmen',true)
addEventHandler('eisJobAnnehmen',root,function(player)
	if(westsideGetElementData(player,'job')=='Eisverkäufer')then
		infobox(player,'Du bist bereits Eisverkäufer!')
		if(westsideGetElementData(player,'playingtime')<=600)then
			outputChatBox('Das erarbeitete Geld erhältst du erst beim Payday!',player)
		end
	else
		infobox(player,'Du bist nun Eiserkäufer!\nKaufe dir im blauen Marker\nnun Eis.')
		westsideSetElementData(player,'job','Eisverkäufer')
	end
end)

local eisPrice=1
local buyeisMarker=createMarker(1863.9000244141,-1842,12.60000038147,'cylinder',3,0,0,200)

addEventHandler('onMarkerHit',buyeisMarker,function(player)
	if(westsideGetElementData(player,'job')=='Eisverkäufer')then
		infobox(player,'Tippe /buyeis [Anzahl], um\nfür 1$ pro Stück Eis zu kaufen.')
	end
end)

addCommandHandler('buyeis',function(player,cmd,anzahl)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'job')=='Eisverkäufer')then
			if(anzahl)then
				if(getDistanceBetweenPoints3D(1863.9000244141,-1842,12.60000038147,getElementPosition(player))<=5)then
					eisPreis2=anzahl*eisPrice
					if(westsideGetElementData(player,'money')>=eisPreis2)then
						infobox(player,'Du hast dir für '..eisPreis2..'$\n'..anzahl..' Eis gekauft!')
						outputChatBox('~~~~~ Eisverkäufer ~~~~~',player,255,255,255)
						outputChatBox('Steige nun in einen Eiswagen, um die Schicht',player,0,200,0)
						outputChatBox('zu beginnen. Mittels /selleis [Spieler] [Preis],',player,0,200,0)
						outputChatBox('kannst du nun Eis verkaufen.',player,0,200,0)
						takePlayerSaveMoney(player,eisPreis2)
						westsideSetElementData(player,'eis',tonumber(westsideGetElementData(player,'eis'))+anzahl)
						outputLog('[EISMANN]: '..getPlayerName(player)..' hat sich '..anzahl..'x Eis gekauft','Jobsystem')
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

addCommandHandler('selleis',function(player,cmd,target,preis)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'job')=='Eisverkäufer')then
			if(target)then
				local tplayer=getPlayerFromName(target)
				local tx,ty,tz=getElementPosition(tplayer)
				local x,y,z=getElementPosition(player)
				if(preis)then
					if(not(tonumber(preis)>100))then
						if(getDistanceBetweenPoints3D(tx,ty,tz,x,y,z)<=10)then
							local veh=getPedOccupiedVehicle(player)
							if(getElementModel(veh)==423)then
								setElementData(tplayer,'eisPrice',preis)
								setElementData(tplayer,'eisSeller',getPlayerName(player))
								outputChatBox(getPlayerName(player)..' hat dir für '..preis..'$ ein Eis angeboten!',tpayer,0,200,0)
								outputChatBox('Tippe /accepteis, um ein Eis zu kaufen.',tplayer,0,200,0)
							else
								infobox(player,'Du musst in einem Eiswagen sitzen!')
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

addCommandHandler('accepteis',function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		local preis=getElementData(player,'eisPrice')
		local seller=getPlayerFromName(getElementData(player,'eisSeller'))
		if(preis)and(seller)then
			local sx,sy,sz=getElementPosition(seller)
			local x,y,z=getElementPosition(player)
			if(getDistanceBetweenPoints3D(sx,sy,sz,x,y,z)<=10)then
				local veh=getPedOccupiedVehicle(seller)
				if(getElementModel(veh)==423)then
					if(westsideGetElementData(player,'money')>=tonumber(preis))then
						if(not(westsideGetElementData(seller,'eis')==0))then
							takePlayerSaveMoney(player,preis)
							westsideSetElementData(seller,'jobgehalt',tonumber(westsideGetElementData(seller,'jobgehalt'))+preis)
							westsideSetElementData(seller,'Punkte_Eisfahrer',tonumber(westsideGetElementData(seller,'Punkte_Eisfahrer'))+1)
							if(westsideGetElementData(seller,'Punkte_Eisfahrer')>99)then
								if(westsideGetElementData(seller,'Erfolg_Eisfahrer')==0)then
									triggerClientEvent(seller,'erfolgWindow',seller,'Schleck ma')
									westsideSetElementData(seller,'Erfolg_Eisfahrer',1)
									westsideSetElementData(seller,'pokale',tonumber(westsideGetElementData(seller,'pokale'))+1)
									outputLog(getPlayerName(seller)..' hat den Erfolg Schleck ma freigeschalten','Erfolge')
								end
							end
							setElementData(player,'eisPrice',nil)
							setElementData(player,'eisSeller',nil)
							outputChatBox('Der Spieler '..getPlayerName(player)..' hat dir für '..preis..'$ ein Eis abgekauft.',seller,0,200,0)
							outputChatBox('Du hast dir ein Eis gekauft! Dein Leben wurde um 10% erhöht.',player,0,200,0)
							setElementHealth(player,getElementHealth(player)+10)
							westsideSetElementData(seller,'eis',tonumber(westsideGetElementData(seller,'eis'))-1)
							westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))+15)
							if(westsideGetElementData(player,'hunger')>100)then
								westsideSetElementData(player,'hunger',100)
							end
							outputLog('[EISMANN]: '..getPlayerName(player)..' hat ein Eis von '..getPlayerName(seller)..' gekauft','Jobsystem')
						else
							infobox(player,'Der Spieler hat kein Eis mehr!')
						end
					else
						infobox(player,'Du hast nicht genug Geld!')
					end
				else
					infobox(player,'Der Verkäufer ist in keinem\nEiswagen!')
				end
			else
				infobox(player,'Du bist zu weit entfernt!')
			end
		end
	end
end)