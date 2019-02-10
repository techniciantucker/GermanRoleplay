local GeldTruckState = false
local AuMarker = createPickup(-2056.38501, 455.00464, 35.17188, 3,1239,500)

function Geldtruckhit_func(player)
	if isCop(player) or isFBI(player) or isArmy(player) then
		outputChatBox("[INFO]: Tippe /geldtransport, um einen Geldtransport zu starten.",player,0,255,0)
	end
end
addEventHandler("onPickupHit",AuMarker,Geldtruckhit_func)

function startTheTransport_func(player,cmd)
	if isCop(player) or isFBI(player) or isArmy(player) then
		if getDistanceBetweenPoints3D(-2056.8000488281,454.79998779297,36.5,getElementPosition(player)) < 5 then
			if (getEvilFactionMembersOnline() >= 2) then
				if GeldTruckState == false then
					GeldTruckState = true
					
					sendMSGForFaction('[STAAT]: Ein Geldtransporter wurde in San Fierro beladen!',1,0,200,0)
					sendMSGForFaction('[STAAT]: Ein Geldtransporter wurde in San Fierro beladen!',2,0,200,0)
					sendMSGForFaction('[STAAT]: Ein Geldtransporter wurde in San Fierro beladen!',3,0,200,0)
					sendMSGForFaction('[STAAT]: Ein Geldtransporter wurde in San Fierro beladen!',4,0,200,0)
					sendMSGForFaction('[STAAT]: Ein Geldtransporter wurde in San Fierro beladen!',6,0,200,0)
					sendMSGForFaction('[STAAT]: Ein Geldtransporter wurde in San Fierro beladen!',7,0,200,0)
					sendMSGForFaction('[STAAT]: Ein Geldtransporter wurde in San Fierro beladen!',8,0,200,0)
					sendMSGForFaction('[STAAT]: Ein Geldtransporter wurde in San Fierro beladen!',9,0,200,0)
					
					outputLog("[GT]: Ein Geldtransporter wurde von "..getPlayerName(player).." gestartet.","Robs")
					
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 25)
					
					local Sec_Veh = createVehicle(getVehicleModelFromName("Securicar"), -2038.9000244141,452.89999389648,35.400001525879,0,0,0, "Bank")
					warpPedIntoVehicle(player, Sec_Veh)
					setElementDimension(player, 0)
					setElementInterior(player, 0)
					outputChatBox("[INFO]: Bringe den Transporter zur Bank in Los Santos!",player,0,100,150)
					setElementData(Sec_Veh, "truck", true)
					local finishMarker = createMarker(1450.0361328125,-1031.7841796875,23.65625, "checkpoint", 3, 0, 0, 255, 255, player)
					local finishBlip = createBlip(1450.0361328125,-1031.7841796875,23.65625, 0, 2, 255, 0, 0, 255, 0)
				
					addEventHandler("onMarkerHit", finishMarker, function(hit)
					if hit == Sec_Veh then 
						local player = getVehicleOccupant(Sec_Veh)
						if isCop(player) then
							destroyElement(Sec_Veh)
							destroyElement(finishMarker)
							destroyElement(finishBlip)
							westsideSetElementData(player, "money", westsideGetElementData(player, "money") + 10000 )
							infobox(player,"Transporter abgegeben, du erhälst 10.000$!",7500,0,255,0)
							
							westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 250)
							
							sendMSGForFaction('[STAAT]: Der Geldtransporter wurde abgegeben!',1,0,200,0)
							sendMSGForFaction('[STAAT]: Der Geldtransporter wurde abgegeben!',2,0,200,0)
							sendMSGForFaction('[STAAT]: Der Geldtransporter wurde abgegeben!',3,0,200,0)
							sendMSGForFaction('[STAAT]: Der Geldtransporter wurde abgegeben!',4,0,200,0)
							sendMSGForFaction('[STAAT]: Der Geldtransporter wurde abgegeben!',6,0,200,0)
							sendMSGForFaction('[STAAT]: Der Geldtransporter wurde abgegeben!',7,0,200,0)
							sendMSGForFaction('[STAAT]: Der Geldtransporter wurde abgegeben!',8,0,200,0)
							sendMSGForFaction('[STAAT]: Der Geldtransporter wurde abgegeben!',9,0,200,0)
							
							outputLog("[GT]: Der Geldtransporter wurde von "..getPlayerName(player).." abgegeben.","Robs")
							setTimer(refreshGeldTruckState, 3600000, 1)
						end
					end
					end)
				
					addEventHandler("onVehicleExplode", Sec_Veh, function()
						local x, y, z = getElementPosition(Sec_Veh)
						
						sendMSGForFaction('[STAAT]: Der Geldtransporter ist explodiert!',1,200,0,0)
						sendMSGForFaction('[STAAT]: Der Geldtransporter ist explodiert!',2,200,0,0)
						sendMSGForFaction('[STAAT]: Der Geldtransporter ist explodiert!',3,200,0,0)
						sendMSGForFaction('[STAAT]: Der Geldtransporter ist explodiert!',4,200,0,0)
						sendMSGForFaction('[STAAT]: Der Geldtransporter ist explodiert!',6,200,0,0)
						sendMSGForFaction('[STAAT]: Der Geldtransporter ist explodiert!',7,200,0,0)
						sendMSGForFaction('[STAAT]: Der Geldtransporter ist explodiert!',8,200,0,0)
						sendMSGForFaction('[STAAT]: Der Geldtransporter ist explodiert!',9,200,0,0)
						
						outputLog("[GT]: Der Geldtransporter ist explodiert.","Robs")
						setTimer(refreshGeldTruckState, 3600000, 1)
						createSack (x, y, z)
						destroyElement(Sec_Veh)
						destroyElement(finishMarker)
						destroyElement(finishBlip)
					end)
				else
					infobox(player,"Du musst noch warten!",4000,255,0,0)
				end
			else
				infobox(player,"Hierfür müssen mindestens\n2 Gangler online sein!", 4000,255,0,0)	
			end
		end
	end
end
addCommandHandler("geldtransport",startTheTransport_func)

function createSack (x, y, z)
	local Sack = {
	[1] = createObject(1550, x + 1, y + 2, z),
	[2] = createObject(1550, x + 2, y + 1, z),
	[3] = createObject(1550, x + 4, y, z),
	[4] = createObject(1550, x + 6, y + 3, z),
	[5] = createObject(1550, x + 3, y + 7, z),
	[6] = createObject(1550, x + 7, y + 1, z),
	[7] = createObject(1550, x, y + 2, z)
	}
	
	addEventHandler("onPlayerClick", getRootElement(), function(mouse, GeldTruckState, element)
	  if isEvil(source) then
		for i=0, 7 do
			if element == Sack[i] then
				if Sack[i] then
					if GeldTruckState == "down" then
						local money = math.random(250, 900)
						westsideSetElementData(source, "money", westsideGetElementData(source, "money") + money )
						outputChatBox("[INFO]: Du hast einen Geldbeutel mit "..money.."$ eingesammelt!", source, 0,100,150)
						outputLog( "[GT]: "..getPlayerName(source).." hat einen Geldsack mit "..money.."$ eingesammelt!", "Robs")
						destroyElement(Sack[i])
					end
				end
			end
		end
	  end
	end)
end

function refreshGeldTruckState ()
	GeldTruckState = false
end

function destroytimer(player,cmd)
    if westsideGetElementData ( player, "adminlvl" ) >= 5 then
		if(isTimer(refreshGeldTruckState)) then
			killTimer(refreshGeldTruckState)
		end
		GeldTruckState = false
		outputChatBox("Der Geldtruck Timer wurde von "..getPlayerName(player).." zurückgesetzt!",getRootElement(),200,0,0)
		outputLog( "[GT]: Der Timer wurde von "..getPlayerName(player).." zurückgesetzt!", "Adminsystem")
	end
end
addCommandHandler("resetgt",destroytimer)