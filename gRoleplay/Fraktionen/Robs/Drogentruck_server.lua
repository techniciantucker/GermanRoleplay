local FraktionsMarker = {
	[2] = {x = 257.70001220703, y = -1324.9000244141, z = 53.099998474121},
	[3] = {x = 2775.1000976563, y = 1313.3000488281, z = 10.89999961853},
	[4] = {x = 2066.6000976563, y = 1699.5999755859, z = 10.699999809265 },
	[7] = {x = 2459, y = -1658.9000244141, z = 13.300000190735},
	[9] = {x = 662.29998779297, y = -485.70001220703, z = 16.200000762939}
}

local dx, dy, dz = -1096.0999755859, -1627.5, 76.400001525879
local gDrugMarker = createPickup(dx, dy, dz, 3, 1239, 50, 0 )

local gTruckID   = 455
local tx, ty, tz = -1091.22290, -1636.05090, 76.36719

local drugActiv = false

function gDrugsHit(player)
	if(getElementType(player) == "player")then
		if isPedInVehicle (player) == false then
			if(isEvil(player))then
				if (getStateFactionMembersOnline() >= 2) then
					if(drugActiv == false)then
						triggerClientEvent(player, 'gDrugWindow', player)
					else
						infobox(player,"Du musst noch warten!",4000,255,0,0)
					end	
				else
					infobox(player,"Hierfür müssen mindestens\n2 Cops online sein!", 4000,255,0,0)	
				end
			end
		end
	end
end
addEventHandler("onPickupHit", gDrugMarker, gDrugsHit)

function clearDrugsTruck()
	if isElement(_G['DrugsBlip']) then destroyElement(_G['DrugsBlip']) end
	if isElement(_G['DrugsTruck']) then destroyElement(_G['DrugsTruck']) end
	if isElement(_G['DrugsMarker']) then destroyElement(_G['DrugsMarker']) end
end

function reactivTruck()
	drugActiv = false
end

addEvent('onStartDrugs', true)
addEventHandler('onStartDrugs', root, function(player)
    if westsideGetElementData ( player, "money" ) >= 5000 then
	takePlayerSaveMoney ( player, 5000 )
		
	    drugActiv = true
	    _G['DrugsTruck'] = createVehicle(gTruckID, tx, ty, tz);
	    warpPedIntoVehicle(player, _G['DrugsTruck'])
	
	    local data = FraktionsMarker[tonumber(westsideGetElementData(player, 'fraktion'))]
	    _G["DrugUsers"..tonumber(westsideGetElementData(player, 'fraktion'))] = true
	    _G['DrugsBlip'] = createBlip(data.x, data.y, data.z, 0, 2, 255, 0, 0);
	    _G['DrugsMarker'] = createMarker(data.x, data.y, data.z, 'checkpoint', 5.0, 255, 0, 0, 255)
	
		outputChatBox("[INFO]: Liefere den Truck an deiner Basis ab!",player,0,100,150)
		
		westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 25)
	
	    drogentruckReset = setTimer(reactivTruck, 3600000, 1) 
	    clearDrugsTruckTimer = setTimer(clearDrugsTruck, 1200000, 1) 
		
		sendMSGForFaction('[ILLEGAL]: Ein Drogentruck wurde gestartet!',1,255,0,0)
		sendMSGForFaction('[ILLEGAL]: Ein Drogentruck wurde gestartet!',2,255,0,0)
		sendMSGForFaction('[ILLEGAL]: Ein Drogentruck wurde gestartet!',3,255,0,0)
		sendMSGForFaction('[ILLEGAL]: Ein Drogentruck wurde gestartet!',4,255,0,0)
		sendMSGForFaction('[ILLEGAL]: Ein Drogentruck wurde gestartet!',6,255,0,0)
		sendMSGForFaction('[ILLEGAL]: Ein Drogentruck wurde gestartet!',7,255,0,0)
		sendMSGForFaction('[ILLEGAL]: Ein Drogentruck wurde gestartet!',8,255,0,0)
		sendMSGForFaction('[ILLEGAL]: Ein Drogentruck wurde gestartet!',9,255,0,0)
		
	    outputLog( "[DT]: Ein Drogentruck wurde von "..getPlayerName(player).." gestartet!", "Robs")
	    addEventHandler('onMarkerHit', _G['DrugsMarker'], function(player)
		    if(getElementType(player) == "player")then
			    if isPedInVehicle(player) then
			    local veh = getPedOccupiedVehicle(player);
				    if(getElementModel(veh) == gTruckID)then
					    if(isEvil(player))then
						    if(_G["DrugUsers"..tonumber(westsideGetElementData(player, 'fraktion'))])then
							    clearDrugsTruck()
							    if(isTimer(clearDrugsTruckTimer))then
								    killTimer(clearDrugsTruckTimer)
							    end
                                westsideSetElementData(player, "drugs", westsideGetElementData(player, "drugs") + 3500)
							    outputChatBox("[INFO]: Drogentruck erfolgreich abgegeben! Du erhälst 3500g Weed.", player, 0,100,150)
								
								sendMSGForFaction('[ILLEGAL]: Der Drogentruck wurde erfolgreich abgegeben!',1,200,0,0)
								sendMSGForFaction('[ILLEGAL]: Der Drogentruck wurde erfolgreich abgegeben!',2,200,0,0)
								sendMSGForFaction('[ILLEGAL]: Der Drogentruck wurde erfolgreich abgegeben!',3,200,0,0)
								sendMSGForFaction('[ILLEGAL]: Der Drogentruck wurde erfolgreich abgegeben!',4,200,0,0)
								sendMSGForFaction('[ILLEGAL]: Der Drogentruck wurde erfolgreich abgegeben!',6,200,0,0)
								sendMSGForFaction('[ILLEGAL]: Der Drogentruck wurde erfolgreich abgegeben!',7,200,0,0)
								sendMSGForFaction('[ILLEGAL]: Der Drogentruck wurde erfolgreich abgegeben!',8,200,0,0)
								sendMSGForFaction('[ILLEGAL]: Der Drogentruck wurde erfolgreich abgegeben!',9,200,0,0)
								
								westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 250)
								
							    outputLog( "[DT]: Der Drogentruck wurde von "..getPlayerName(player).." abgegeben!", "Robs")
						    end
					    end
				    end
			    end
		    end
	    end)
		
		addEventHandler('onVehicleExplode',_G['DrugsTruck'],function()
			clearDrugsTruck()
			if(isTimer(clearDrugsTruckTimer))then
				killTimer(clearDrugsTruckTimer)
			end
			
			sendMSGForFaction('[ILLEGAL]: Der Drogentruck ist explodiert!',1,200,0,0)
			sendMSGForFaction('[ILLEGAL]: Der Drogentruck ist explodiert!',2,200,0,0)
			sendMSGForFaction('[ILLEGAL]: Der Drogentruck ist explodiert!',3,200,0,0)
			sendMSGForFaction('[ILLEGAL]: Der Drogentruck ist explodiert!',4,200,0,0)
			sendMSGForFaction('[ILLEGAL]: Der Drogentruck ist explodiert!',6,200,0,0)
			sendMSGForFaction('[ILLEGAL]: Der Drogentruck ist explodiert!',7,200,0,0)
			sendMSGForFaction('[ILLEGAL]: Der Drogentruck ist explodiert!',8,200,0,0)
			sendMSGForFaction('[ILLEGAL]: Der Drogentruck ist explodiert!',9,200,0,0)
		end)
	else
		outputChatBox('Du benötigst 5000$!',player,125,0,0)
	end
end)

function destroytimer(player,cmd)
    if westsideGetElementData ( player, "adminlvl" ) >= 5 then
		if(isTimer(clearDrugsTruckTimer)) then
			killTimer(clearDrugsTruckTimer)
		end
		if(isTimer(drogentruckReset))then
			killTimer(drogentruckReset)
		end
		outputChatBox("Der Drogentruck Timer wurde von "..getPlayerName(player).." zurückgesetzt!",getRootElement(),200,0,0)
		outputLog( "[DT]: Der Timer wurde von "..getPlayerName(player).." zurückgesetzt!", "Adminsystem")
	end
end
addCommandHandler("resetdt",destroytimer)