function JOB_BUS_GUI()
	BusGUI = guiCreateStaticImage(0.38, 0.01, 0.24, 0.14, "Images/Background.png", true)

	BusButtonEnter = guiCreateButton(0.20, 0.26, 0.59, 0.25, "Job starten", true, BusGUI)
	guiSetAlpha(BusButtonEnter, 1)
	BusButtonClose = guiCreateButton(0.20, 0.65, 0.59, 0.25, "Schließen", true, BusGUI)
	guiSetAlpha(BusButtonClose, 1)

	addEventHandler('onClientGUIClick', BusButtonClose, function()
		closeBusWindow()
	end, false)

	addEventHandler('onClientGUIClick', BusButtonEnter, function()
		closeBusWindow();
		createServerAuto(localPlayer, 431);
		
		local data = BusMarkerSpawns[1];
		
		BusMarker[1] = createMarker(data.x, data.y, data.z, 'checkpoint', 1.5, 255, 0, 0, 125);
		BusBlip[1] = createBlip(data.x, data.y, data.z, 41, 2);
		
		addEventHandler('onClientMarkerHit', root, function(player, dim)
			if player == localPlayer then
				if isPedInVehicle(player) and getElementModel(getPedOccupiedVehicle(player)) == 431 then
					for i = 1, #BusMarkerSpawns do 
						if BusMarker[i] == source then
							if i >= #BusMarkerSpawns then
								destroyElement(BusMarker[i]);
								destroyElement(BusBlip[i]);
								gBusFinish(player);
								
								triggerServerEvent('gBusGiveMoney', player, player, 150)
							else
								local player = player
								local veh = getPedOccupiedVehicle(player);
								
								setElementFrozen(veh, true);
								setTimer(function()
									setElementFrozen(veh, false);
								end, 5000, 1);
								destroyElement(BusMarker[i]);
								destroyElement(BusBlip[i]);
								
								if getElementData(lp,"level") > 4 and getElementData(lp,"level") < 11 then
									triggerServerEvent('gBusGiveMoney', player, player, 250)
								elseif getElementData(lp,"level") > 10 and getElementData(lp,"level") < 21 then
									triggerServerEvent('gBusGiveMoney', player, player, 400)
								elseif getElementData(lp,"level") > 20 and getElementData(lp,"level") < 26 then
									triggerServerEvent('gBusGiveMoney', player, player, 500)
								end
								
								local id = i + 1;
								local data = BusMarkerSpawns[id];
								BusMarker[id] = createMarker(data.x, data.y, data.z, 'checkpoint', 1.5, 255, 0, 0, 125);
								BusBlip[id] = createBlip(data.x, data.y, data.z, 41, 2);
							end
							break
						end
					end
				end
			end
		end);
	end,false)

end

BusBlip = {}
BusMarker = {} 
BusMarkerSpawns = {
[1]  = { x = 1824.1999511719, y = -1878.6999511719, z = 13.39999961853 },
[2]  = { x = 1824.1999511719, y = -1660.1999511719, z = 13.39999961853},
[3]  = { x = 1927.0999755859, y = -1615, z = 13.39999961853},
[4]  = { x = 1959.4000244141, y = -1816.6999511719, z = 13.39999961853},
[5]  = { x = 1959, y = -1994.5, z = 13.39999961853},
[6]  = { x = 1959.3000488281, y = -2148.1999511719, z = 13.39999961853},
[7]  = { x = 2181.1000976563, y = -2186.6999511719, z = 13.300000190735},
[8]  = { x = 2295.8999023438, y = -2071.6999511719, z = 13.39999961853},
[9]  = { x = 2678.3999023438, y = -1929.8000488281, z = 13.300000190735},
[10] = { x = 2428.6000976563, y = -1930.0999755859, z = 13.39999961853},
[11] = { x = 2220.8999023438, y = -1872.5, z = 13.39999961853},
[12] = { x = 1819.4000244141, y = -1869.9000244141, z = 13.39999961853},
}

local id = #BusMarkerSpawns

addEvent('gLoadBusGUI', true);
addEventHandler('gLoadBusGUI', localPlayer, function()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true);
		setElementData(lp,'ElementClicked',true)
		JOB_BUS_GUI()
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)

function closeBusWindow()
	showCursor(false);
	setElementData(lp,'ElementClicked',false)
	destroyElement(BusGUI)
end

function createServerAuto(player, id)
	triggerServerEvent('gBusCreate', player, player, id);
end

function gBusFinish(player)
	triggerServerEvent('gBusFinish', player, player);
end

addEventHandler('onClientVehicleExit', root, function(player, seat)
	if player == localPlayer then
		if getElementModel(source) == 431 then
			for i = 1, #BusMarkerSpawns do 
				if BusMarker[i] then
					if(BusBlip[i])then
						destroyElement(BusBlip[i]);
					end
					if(BusMarker[i])then
						destroyElement(BusMarker[i]);
					end
				end
			end
			triggerServerEvent('gBusEnd', player, player)
		end
	end
end)