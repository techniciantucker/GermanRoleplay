function JOB_TRUCKER_GUI()
	TruckerGUI = guiCreateStaticImage(0.38, 0.01, 0.24, 0.14, "Images/Background.png", true)

	TruckerButtonEnter = guiCreateButton(0.20, 0.26, 0.59, 0.25, "Job starten", true, TruckerGUI)
	guiSetAlpha(TruckerButtonEnter, 1)
	TruckerButtonClose = guiCreateButton(0.20, 0.65, 0.59, 0.25, "Schließen", true, TruckerGUI)
	guiSetAlpha(TruckerButtonClose, 1)

	addEventHandler('onClientGUIClick', TruckerButtonClose, function()
		closeTruckerWindow()
	end, false)

	addEventHandler('onClientGUIClick', TruckerButtonEnter, function()
		closeTruckerWindow();
		createTruckerCar(localPlayer, 456);
		
		local data = TruckerTMarkerSpawns[1];
		
		TruckerTMarker[1] = createMarker(data.x, data.y, data.z, 'checkpoint', 1.5, 255, 0, 0, 125);
		TruckerBlip[1] = createBlip(data.x, data.y, data.z, 41, 2);
		
		addEventHandler('onClientMarkerHit', root, function(player, dim)
			if player == localPlayer then
				if isPedInVehicle(player) and getElementModel(getPedOccupiedVehicle(player)) == 456 then
					for i = 1, #TruckerTMarkerSpawns do 
						if TruckerTMarker[i] == source then
							if i == 1 then
								infobox("Lieferung abgegeben!\nFahre nun wieder zurück.")
							end
							if i >= #TruckerTMarkerSpawns then
								destroyElement(TruckerTMarker[i]);
								destroyElement(TruckerBlip[i]);
								gTruckerFinish(player);
								
								if getElementData(lp,"level") > 4 and getElementData(lp,"level") < 11 then
									triggerServerEvent('gTruckerGiveMoney', player, player, 250)
								elseif getElementData(lp,"level") > 10 and getElementData(lp,"level") < 21 then
									triggerServerEvent('gTruckerGiveMoney', player, player, 400)
								elseif getElementData(lp,"level") > 20 and getElementData(lp,"level") < 26 then
									triggerServerEvent('gTruckerGiveMoney', player, player, 650)
								end
							else
								local player = player
								local veh = getPedOccupiedVehicle(player);
								
								destroyElement(TruckerTMarker[i]);
								destroyElement(TruckerBlip[i]);
								
								if getElementData(lp,"level") > 4 and getElementData(lp,"level") < 11 then
									triggerServerEvent('gTruckerGiveMoney', player, player, 250)
								elseif getElementData(lp,"level") > 10 and getElementData(lp,"level") < 21 then
									triggerServerEvent('gTruckerGiveMoney', player, player, 400)
								elseif getElementData(lp,"level") > 20 and getElementData(lp,"level") < 26 then
									triggerServerEvent('gTruckerGiveMoney', player, player, 650)
								end
								
								local id = i + 1;
								local data = TruckerTMarkerSpawns[id];
								TruckerTMarker[id] = createMarker(data.x, data.y, data.z, 'checkpoint', 1.5, 255, 0, 0, 125);
								TruckerBlip[id] = createBlip(data.x, data.y, data.z, 41, 2);
							end
							break
						end
					end
				end
			end
		end);
	end,false)
end


TruckerBlip = {}
TruckerTMarker = {} 
TruckerTMarkerSpawns = {
[1] = { x = 1339.8000488281, y = -1729.5999755859, z = 13.39999961853 },
[2] = { x = 2295.73169, y = -2363.99536, z = 13.41366},
}

local id = #TruckerTMarkerSpawns

function pos()
	id = id + 1
	local x, y, z = getElementPosition(localPlayer)
	local text = '['..id..'] = { x = '..x..', y = '..y..', z = '..z..'},';
	outputChatBox(text)
	setClipboard(text)
end
addCommandHandler('pos', pos)

addEvent('gLoadTruckerGUI', true);
addEventHandler('gLoadTruckerGUI', localPlayer, function()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true);
		JOB_TRUCKER_GUI()
		setElementData(lp,'ElementClicked',true)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)

function closeTruckerWindow()
	showCursor(false);
	destroyElement(TruckerGUI)
	setElementData(lp,'ElementClicked',false)
end

function createTruckerCar(player, id)
	triggerServerEvent('gTruckerCreate', player, player, id);
end

function gTruckerFinish(player)
	triggerServerEvent('gTruckerFinish', player, player);
end

addEventHandler('onClientVehicleExit', root, function(player, seat)
	if player == localPlayer then
		if getElementModel(source) == 456 then
			for i = 1, #TruckerTMarkerSpawns do 
				if TruckerTMarker[i] then
					if(TruckerBlip[i])then
						destroyElement(TruckerBlip[i]);
					end
					if(TruckerTMarker[i])then
						destroyElement(TruckerTMarker[i]);
					end
				end
			end
			triggerServerEvent('gTruckerEnd', player, player);
		end
	end
end)