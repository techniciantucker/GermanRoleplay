function PILOT_JOB_GUI()
	PilotGUI = guiCreateStaticImage(0.38, 0.01, 0.24, 0.14, "Images/Background.png", true)

	PilotButtonEnter = guiCreateButton(0.20, 0.26, 0.59, 0.25, "Job starten", true, PilotGUI)
	guiSetAlpha(PilotButtonEnter, 1)
	PilotButtonClose = guiCreateButton(0.20, 0.65, 0.59, 0.25, "Schließen", true, PilotGUI)
	guiSetAlpha(PilotButtonClose, 1)

	addEventHandler('onClientGUIClick', PilotButtonClose, function()
		closePilotWindow()
	end, false)

	addEventHandler('onClientGUIClick', PilotButtonEnter, function()
		closePilotWindow();
		createPilotCar(localPlayer, 577);
		
		local data = PilotPMarkerSpawns[1];
		
		PilotPMarker[1] = createMarker(data.x, data.y, data.z, 'checkpoint', 10, 255, 0, 0, 125);
		PilotBlip[1] = createBlip(data.x, data.y, data.z, 41, 2);
		
		addEventHandler('onClientMarkerHit', root, function(player, dim)
			if player == localPlayer then
				if isPedInVehicle(player) and getElementModel(getPedOccupiedVehicle(player)) == 577 then
					for i = 1, #PilotPMarkerSpawns do 
						if PilotPMarker[i] == source then
							if i >= #PilotPMarkerSpawns then
								destroyElement(PilotPMarker[i]);
								destroyElement(PilotBlip[i]);
								gPilotFinish(player);
								
								if getElementData(lp,"level") > 4 and getElementData(lp,"level") < 11 then
									triggerServerEvent('gPilotGiveMoney', player, player, 500)
								elseif getElementData(lp,"level") > 10 and getElementData(lp,"level") < 21 then
									triggerServerEvent('gPilotGiveMoney', player, player, 1000)
								elseif getElementData(lp,"level") > 20 and getElementData(lp,"level") < 26 then
									triggerServerEvent('gPilotGiveMoney', player, player, 1500)
								end
							else
								local player = player
								local veh = getPedOccupiedVehicle(player);
								
								destroyElement(PilotSMarker[i]);
								destroyElement(PilotBlip[i]);
								
								if getElementData(lp,"level") > 4 and getElementData(lp,"level") < 11 then
									triggerServerEvent('gPilotGiveMoney', player, player, 500)
								elseif getElementData(lp,"level") > 10 and getElementData(lp,"level") < 21 then
									triggerServerEvent('gPilotGiveMoney', player, player, 1000)
								elseif getElementData(lp,"level") > 20 and getElementData(lp,"level") < 26 then
									triggerServerEvent('gPilotGiveMoney', player, player, 1500)
								end
								
								local id = i + 1;
								local data = PilotPMarkerSpawns[id];
								PilotMarker[id] = createMarker(data.x, data.y, data.z, 'ring', 10, 255, 0, 0, 125);
								PilotBlip[id] = createBlip(data.x, data.y, data.z, 41, 2);
							end
							break
						end
					end
				end
			end
		end);
	end,false)
end


PilotBlip = {}
PilotPMarker = {} 
PilotPMarkerSpawns = {
[1] = { x = 1440.5999755859, y = 1463.1999511719, z = 10.800000190735 },
}

local id = #PilotPMarkerSpawns

--[[ function pos()
	id = id + 1
	local x, y, z = getElementPosition(localPlayer)
	local text = '['..id..'] = { x = '..x..', y = '..y..', z = '..z..'},';
	outputChatBox(text)
	setClipboard(text)
end
addCommandHandler('pos', pos) ]]--

addEvent('gLoadPilotGUI', true);
addEventHandler('gLoadPilotGUI', localPlayer, function()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true);
		PILOT_JOB_GUI()
		
		setElementData(lp,'ElementClicked',true)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)

function closePilotWindow()
	showCursor(false);
	destroyElement(PilotGUI)
	setElementData(lp,'ElementClicked',false)
end

function createPilotCar(player, id)
	triggerServerEvent('gPilotCreate', player, player, id);
end

function gPilotFinish(player)
	triggerServerEvent('gPilotFinish', player, player);
end

addEventHandler('onClientVehicleExit', root, function(player, seat)
	if player == localPlayer then
		if getElementModel(source) == 577 then
			for i = 1, #PilotPMarkerSpawns do 
				if PilotPMarker[i] then
					if(PilotBlip[i])then
						destroyElement(PilotBlip[i]);
					end
					if(PilotPMarker[i])then
						destroyElement(PilotPMarker[i]);
					end
				end
			end
			triggerServerEvent('gPilotEnd', player, player);
		end
	end
end)