function SWEEPER_JOB_GUI()
	SweeperGUI = guiCreateStaticImage(0.38, 0.01, 0.24, 0.14, "Images/Background.png", true)

	SweeperButtonEnter = guiCreateButton(0.20, 0.26, 0.59, 0.25, "Job starten", true, SweeperGUI)
	guiSetAlpha(SweeperButtonEnter, 1)
	SweeperButtonClose = guiCreateButton(0.20, 0.65, 0.59, 0.25, "Schließen", true, SweeperGUI)
	guiSetAlpha(SweeperButtonClose, 1)

	addEventHandler('onClientGUIClick', SweeperButtonClose, function()
		closeSweeperWindow()
	end, false)

	addEventHandler('onClientGUIClick', SweeperButtonEnter, function()
		closeSweeperWindow();
		createSweeperCar(localPlayer, 408);
		
		local data = SweeperSMarkerSpawns[1];
		
		SweeperSMarker[1] = createMarker(data.x, data.y, data.z, 'checkpoint', 1.5, 255, 0, 0, 125);
		SweeperBlip[1] = createBlip(data.x, data.y, data.z, 41, 2);
		
		addEventHandler('onClientMarkerHit', root, function(player, dim)
			if player == localPlayer then
				if isPedInVehicle(player) and getElementModel(getPedOccupiedVehicle(player)) == 408 then
					for i = 1, #SweeperSMarkerSpawns do 
						if SweeperSMarker[i] == source then
							if i >= #SweeperSMarkerSpawns then
								destroyElement(SweeperSMarker[i]);
								destroyElement(SweeperBlip[i]);
								gSweeperFinish(player);
								
								if getElementData(lp,"level") == 0 then
									triggerServerEvent('gSweeperGiveMoney', player, player, 200)
								elseif getElementData(lp,"level") > 0 and getElementData(lp,"level") < 11 then
									triggerServerEvent('gSweeperGiveMoney', player, player, 200)
								elseif getElementData(lp,"level") > 10 and getElementData(lp,"level") < 21 then
									triggerServerEvent('gSweeperGiveMoney', player, player, 350)
								elseif getElementData(lp,"level") > 20 and getElementData(lp,"level") < 26 then
									triggerServerEvent('gSweeperGiveMoney', player, player, 500)
								end
							else
								local player = player
								local veh = getPedOccupiedVehicle(player);
								
								destroyElement(SweeperSMarker[i]);
								destroyElement(SweeperBlip[i]);
								
								if getElementData(lp,"level") == 0 then
									triggerServerEvent('gSweeperGiveMoney', player, player, 200)
								elseif getElementData(lp,"level") > 0 and getElementData(lp,"level") < 11 then
									triggerServerEvent('gSweeperGiveMoney', player, player, 200)
								elseif getElementData(lp,"level") > 10 and getElementData(lp,"level") < 21 then
									triggerServerEvent('gSweeperGiveMoney', player, player, 350)
								elseif getElementData(lp,"level") > 20 and getElementData(lp,"level") < 26 then
									triggerServerEvent('gSweeperGiveMoney', player, player, 500)
								end
								
								local id = i + 1;
								local data = SweeperSMarkerSpawns[id];
								SweeperSMarker[id] = createMarker(data.x, data.y, data.z, 'checkpoint', 1.5, 255, 0, 0, 125);
								SweeperBlip[id] = createBlip(data.x, data.y, data.z, 41, 2);
							end
							break
						end
					end
				end
			end
		end);
	end,false)
end


SweeperBlip = {}
SweeperSMarker = {} 
SweeperSMarkerSpawns = {
[1] = { x = 2311.3000488281, y = -1925.8000488281, z = 13.39999961853 },
[2] = { x = 2219.6999511719, y = -1915.9000244141, z = 13.300000190735},
[3] = { x = 2126.3999023438, y = -1616.6999511719, z = 13.39999961853},
[4] = { x = 1824.4000244141, y = -1596.5999755859, z = 13.39999961853},
[5] = { x = 2079.1000976563, y = -1866.6999511719, z = 13.39999961853},
}

local id = #SweeperSMarkerSpawns

function pos()
	id = id + 1
	local x, y, z = getElementPosition(localPlayer)
	local text = '['..id..'] = { x = '..x..', y = '..y..', z = '..z..'},';
	outputChatBox(text)
	setClipboard(text)
end
addCommandHandler('pos', pos)

addEvent('gLoadSweeperGUI', true);
addEventHandler('gLoadSweeperGUI', localPlayer, function()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true);
		SWEEPER_JOB_GUI()
		setElementData(lp,'ElementClicked',true)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)

function closeSweeperWindow()
	showCursor(false);
	destroyElement(SweeperGUI)
	setElementData(lp,'ElementClicked',false)
end

function createSweeperCar(player, id)
	triggerServerEvent('gSweeperCreate', player, player, id);
end

function gSweeperFinish(player)
	triggerServerEvent('gSweeperFinish', player, player);
end

addEventHandler('onClientVehicleExit', root, function(player, seat)
	if player == localPlayer then
		if getElementModel(source) == 408 then
			for i = 1, #SweeperSMarkerSpawns do 
				if SweeperSMarker[i] then
					if(SweeperBlip[i])then
						destroyElement(SweeperBlip[i]);
					end
					if(SweeperSMarker[i])then
						destroyElement(SweeperSMarker[i]);
					end
				end
			end
			triggerServerEvent('gSweeperEnd', player, player);
		end
	end
end)