local abgabePulver = 300
local copsOnline   = 3
local startTimer   = 60000
local px,py,pz 	   = -2200.3999023438,-2339.3000488281,30.60000038147
local swtAktiv 	   = 0
local schwarzpulverTransport=false

schwarzpulverTransporter = createPickup(px,py,pz,3,1239,500)

addEventHandler("onPickupHit",schwarzpulverTransporter,function(player)
	if isPedInVehicle (player) == false then
		if isEvil(player) then
			triggerClientEvent(player,"schwarzpulverWindow",player)
		else
			infobox(player,"Hau ab!",4000,255,0,0)
		end
	end
end)

addEvent("pulverstart",true)
addEventHandler("pulverstart",root,function(player)
	if isEvil(player) then
		if (getStateFactionMembersOnline() >= copsOnline) then
			if getDistanceBetweenPoints3D(px,py,pz,getElementPosition(player)) < 5 then
				if swtAktiv == 0 then
					if westsideGetElementData(player,"money") >= 5000 then
						takePlayerSaveMoney(player,0)
						
						swtAktiv = 1
						setTimer(function()
							swtAktiv = 0
						end,3600000,1)
					
						schwarzpulverTransporterCar = createVehicle(455,-2205.6999511719,-2345.8000488281,31.200000762939,0,0,232)
						warpPedIntoVehicle(player,schwarzpulverTransporterCar)
						setElementFrozen(schwarzpulverTransporterCar,true)
						schwarzpulverTransport=true
						infobox(player,"Das Fahrzeug wird beladen!\nDies dauert 60 Sekunden.",4000,0,255,0)
						setTimer(function(player)
							infobox(player,"Noch 30 Sekunden...",4000,0,255,0)
							setTimer(function(player)
								infobox(player,"Noch 10 Sekunden...",4000,0,255,0)
							end,20000,1)
						end,30000,1)
						setTimer(function(player)
							setElementFrozen(schwarzpulverTransporterCar,false)
							infobox(player,"Das Fahrzeug wurde beladen!\nBringe es zum Abgabemarker!",4000,0,255,0)
							
							sendMSGForFaction('Ein Schwarzpulvertransport wurde beladen!',1,255,0,0)
							sendMSGForFaction('Ein Schwarzpulvertransport wurde beladen!',2,255,0,0)
							sendMSGForFaction('Ein Schwarzpulvertransport wurde beladen!',3,255,0,0)
							sendMSGForFaction('Ein Schwarzpulvertransport wurde beladen!',4,255,0,0)
							sendMSGForFaction('Ein Schwarzpulvertransport wurde beladen!',6,255,0,0)
							sendMSGForFaction('Ein Schwarzpulvertransport wurde beladen!',7,255,0,0)
							sendMSGForFaction('Ein Schwarzpulvertransport wurde beladen!',8,255,0,0)
							sendMSGForFaction('Ein Schwarzpulvertransport wurde beladen!',9,255,0,0)
							
							schwarzpulverDestroyAbfrage=setTimer(function()
								if(schwarzpulverTransport==true)then
									Schwarzpulvertransport=false
									destroyElement(schwarzpulverTransporterCar)
									destroyElement(abgabemarkerswt)
									destroyElement(abgabeblipswt)
									outputChatBox("Der Schwarzpulvertransport wurde nicht rechtzeitig abgegeben!",root,255,0,0)
								end
							end,1200000,1)
							
							abgabemarkerswt = createMarker(2179.70654, -2634.70850, 13.54688,"checkpoint",3,0,255,0)
							abgabeblipswt = createBlip(2179.70654, -2634.70850, 13.54688,0,2,255,0,0)
							
							addEventHandler("onMarkerHit",abgabemarkerswt,function(player)
								local st = getPedOccupiedVehicle(player)
								
								if st == schwarzpulverTransporterCar then
									if(isTimer(schwarzpulverDestroyAbfrage))then
										killTimer(schwarzpulverDestroyAbfrage)
									end
									destroyElement(schwarzpulverTransporterCar)
									destroyElement(abgabemarkerswt)
									destroyElement(abgabeblipswt)
									outputChatBox("Der Schwarzpulvertransport wurde abgegeben!",root,255,0,0)
									westsideSetElementData(player,"schwarzpulver",tonumber(westsideGetElementData(player,"schwarzpulver")) + 300)
								end
							end)
							
						end,startTimer,1)
					else
						infobox(player,"Du benötigst 10.000$, um\neinen Schwarzpulvertransport\nzu beladen!",4000,255,0,0)
					end
				else
					infobox(player,"Es kann nur alle 60 Minuten\nein Schwarzpulvertransport beladen\nwerden!",4000,255,0,0)
				end
			end
		else
			infobox(player,"Hierfür müssen mindestens\n3 Cops online sein!",4000,255,0,0)
		end
	end
end)

addEvent("createbombe",true)
addEventHandler("createbombe",root,function(player)
	if isEvil(player) then
		if tonumber ( westsideGetElementData ( player, "schwarzpulver" ) ) >= 150 then
			infobox(player,"Du hast eine Bombe erstellt!",4000,0,255,0)
			westsideSetElementData(player,"bomben",tonumber(westsideGetElementData(player,"bomben")) + 1)
			westsideSetElementData(player,"schwarzpulver",tonumber(westsideGetElementData(player,"schwarzpulver")) - 150)
		else
			infobox(player,"Für eine Bombe benötigst\ndu 150 Schwarzpulver!",4000,255,0,0)
		end
	end
end)