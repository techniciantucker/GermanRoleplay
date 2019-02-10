local matstruckCash=5000
local matstruckAktiv=false
local copsOnlineforMT=2
local matsBelohnung=1000

local matstruckPickup=createPickup(-2616.06030, 204.62637, 4.76853,3,1239,50)

addEventHandler('onPickupHit',matstruckPickup,function(player)
	if(isEvil(player))then
		if(matstruckAktiv==false)then
			triggerClientEvent(player,'matstruckWindow',player)
		else
			infobox(player,'Du musst noch warten!')
		end
	end
end)

addEvent('matstruckStarten',true)
addEventHandler('matstruckStarten',root,function(player)
	if(isEvil(player))then
		if(getStateFactionMembersOnline()>=copsOnlineforMT)then
			if(westsideGetElementData(player,'money')>=matstruckCash)then
				takePlayerSaveMoney(player,matstruckCash)
				matstruckAktiv=true
				resetMT=setTimer(function()
					matstruckAktiv=false
				end,3600000,1)
				setElementData(player,'mtFahrer',true)
				sendMSGForFaction('Ein Matstruck wurde beladen!',1,125,0,0)
				sendMSGForFaction('Ein Matstruck wurde beladen!',2,125,0,0)
				sendMSGForFaction('Ein Matstruck wurde beladen!',3,125,0,0)
				sendMSGForFaction('Ein Matstruck wurde beladen!',4,125,0,0)
				sendMSGForFaction('Ein Matstruck wurde beladen!',6,125,0,0)
				sendMSGForFaction('Ein Matstruck wurde beladen!',7,125,0,0)
				sendMSGForFaction('Ein Matstruck wurde beladen!',8,125,0,0)
				sendMSGForFaction('Ein Matstruck wurde beladen!',9,125,0,0)
				matstruckVehicle=createVehicle(414,-2613.6999511719,195.80000305176,4.6999998092651,0,0,0)
				warpPedIntoVehicle(player,matstruckVehicle)
				matstruckMarker=createMarker(2513.1999511719,-1531.6999511719,23.799999237061,'checkpoint',3,200,0,0)
				matstruckBlip=createBlip(2513.1999511719,-1531.6999511719,23.799999237061,19)
				setElementVisibleTo(matstruckMarker,root,false)
				setElementVisibleTo(matstruckBlip,root,false)
				setElementVisibleTo(matstruckMarker,player,true)
				setElementVisibleTo(matstruckBlip,player,true)
				addEventHandler('onVehicleExit',matstruckVehicle,function()
					if(getElementData(player,'mtFahrer')==true)then
						setElementData(player,'mtFahrer',false)
						setElementVisibleTo(matstruckBlip,player,false)
						setElementVisibleTo(matstruckMarker,player,false)
					end
				end)
				addEventHandler('onVehicleEnter',matstruckVehicle,function()
					if(getPedOccupiedVehicleSeat(player)==0)then
						setElementData(player,'mtFahrer',true)
						setElementVisibleTo(matstruckBlip,player,true)
						setElementVisibleTo(matstruckMarker,player,true)
					end
				end)
				addEventHandler('onVehicleExplode',matstruckVehicle,function()
					if(matstruckVehicle)then destroyElement(matstruckVehicle)end
					if(matstruckMarker)then destroyElement(matstruckMarker)end
					if(matstruckBlip)then destroyElement(matstruckBlip)end
					sendMSGForFaction('Der Matstruck ist explodiert!',1,125,0,0)
					sendMSGForFaction('Der Matstruck ist explodiert!',2,125,0,0)
					sendMSGForFaction('Der Matstruck ist explodiert!',3,125,0,0)
					sendMSGForFaction('Der Matstruck ist explodiert!',4,125,0,0)
					sendMSGForFaction('Der Matstruck ist explodiert!',5,125,0,0)
					sendMSGForFaction('Der Matstruck ist explodiert!',6,125,0,0)
					sendMSGForFaction('Der Matstruck ist explodiert!',7,125,0,0)
					sendMSGForFaction('Der Matstruck ist explodiert!',8,125,0,0)
				end)
				addEventHandler('onMarkerHit',matstruckMarker,function()
					local veh=getPedOccupiedVehicle(player)
					if(veh==matstruckVehicle)then
						if(matstruckVehicle)then destroyElement(matstruckVehicle)end
						if(matstruckMarker)then destroyElement(matstruckMarker)end
						if(matstruckBlip)then destroyElement(matstruckBlip)end
						infobox(player,'Du erhälst '..matsBelohnung..' Mats!')
						westsideSetElementData(player,'mats',westsideGetElementData(player,'mats')+1000)
						sendMSGForFaction('Der Matstruck wurde abgegeben!',1,125,0,0)
						sendMSGForFaction('Der Matstruck wurde abgegeben!',2,125,0,0)
						sendMSGForFaction('Der Matstruck wurde abgegeben!',3,125,0,0)
						sendMSGForFaction('Der Matstruck wurde abgegeben!',4,125,0,0)
						sendMSGForFaction('Der Matstruck wurde abgegeben!',5,125,0,0)
						sendMSGForFaction('Der Matstruck wurde abgegeben!',6,125,0,0)
						sendMSGForFaction('Der Matstruck wurde abgegeben!',7,125,0,0)
						sendMSGForFaction('Der Matstruck wurde abgegeben!',8,125,0,0)
					end
				end)
			else
				infobox(player,'Du benötigst 5000$!')
			end
		else
			infobox(player,'Es müssen 2 Cops online sein!')
		end
	end
end)