function PIZZA_JOB_GUI()
	PizzaGUI = guiCreateStaticImage(0.38, 0.01, 0.24, 0.14, "Images/Background.png", true)

	PizzaButtonEnter = guiCreateButton(0.20, 0.26, 0.59, 0.25, "Job starten", true, PizzaGUI)
	guiSetAlpha(PizzaButtonEnter, 1)
	PizzaButtonClose = guiCreateButton(0.20, 0.65, 0.59, 0.25, "Schließen", true, PizzaGUI)
	guiSetAlpha(PizzaButtonClose, 1)

	addEventHandler('onClientGUIClick', PizzaButtonClose, function()
		closePizzaWindow()
	end, false)

	addEventHandler('onClientGUIClick', PizzaButtonEnter, function()
		closePizzaWindow();
		createPizzaCar(localPlayer, 448);
		
		local data = PizzaSMarkerSpawns[1];
		
		PizzaSMarker[1] = createMarker(data.x, data.y, data.z, 'checkpoint', 1, 255, 0, 0, 125);
		PizzaBlip[1] = createBlip(data.x, data.y, data.z, 41, 2);
		
				addEventHandler('onClientMarkerHit', root, function(player, dim)
				if player == localPlayer then
					if isPedInVehicle(player) and getElementModel(getPedOccupiedVehicle(player)) == 448 then
						for i = 1, #PizzaSMarkerSpawns do 
							if PizzaSMarker[i] == source then
								if i >= #PizzaSMarkerSpawns then
									destroyElement(PizzaSMarker[i]);
									destroyElement(PizzaBlip[i]);
									gPizzaFinish(player);
									
									if getElementData(lp,"level") == 0 then
										triggerServerEvent('gPizzaGiveMoney', player, player, 50)
									elseif getElementData(lp,"level") > 0 and getElementData(lp,"level") < 11 then
										triggerServerEvent('gPizzaGiveMoney', player, player, 50)
									elseif getElementData(lp,"level") > 10 and getElementData(lp,"level") < 21 then
										triggerServerEvent('gPizzaGiveMoney', player, player, 100)
									elseif getElementData(lp,"level") > 20 and getElementData(lp,"level") < 26 then
										triggerServerEvent('gPizzaGiveMoney', player, player, 150)
									end
								else
									local player = player
									local veh = getPedOccupiedVehicle(player);
									
									destroyElement(PizzaSMarker[i]);
									destroyElement(PizzaBlip[i]);
									
									if getElementData(lp,"level") == 0 then
										triggerServerEvent('gPizzaGiveMoney', player, player, 50)
									elseif getElementData(lp,"level") > 0 and getElementData(lp,"level") < 11 then
										triggerServerEvent('gPizzaGiveMoney', player, player, 50)
									elseif getElementData(lp,"level") > 10 and getElementData(lp,"level") < 21 then
										triggerServerEvent('gPizzaGiveMoney', player, player, 100)
									elseif getElementData(lp,"level") > 20 and getElementData(lp,"level") < 26 then
										triggerServerEvent('gPizzaGiveMoney', player, player, 150)
									end
									
									local id = i + 1;
									local data = PizzaSMarkerSpawns[id];
									PizzaSMarker[id] = createMarker(data.x, data.y, data.z, 'checkpoint', 1, 255, 0, 0, 125);
									PizzaBlip[id] = createBlip(data.x, data.y, data.z, 41, 2);
								end
								break
							end
						end
					end
				end
			end);
	end,false)
end

PizzaBlip = {}
PizzaSMarker = {} 
PizzaSMarkerSpawns = {
[1] = { x = 2074.09033, y = -1732.97876, z = 13.54688 },
[2] = { x = 2073.55786, y = -1701.77808, z = 13.55468},
[3] = { x = 2073.60352, y = -1645.82825, z = 13.54688},
[4] = { x = 2008.82678, y = -1633.23523, z = 13.54688},
[5] = { x = 2009.53333, y = -1698.60742, z = 13.55468},
[6] = { x = 2009.27612, y = -1732.68372, z = 13.54688},
[7] = { x = 1948.68677, y = -1712.65405, z = 13.54688},
[8] = { x = 1949.04761, y = -1676.23096, z = 13.54688},
					
[9] = { x = 1911.34961, y = -1604.69751, z = 13.54688},
[10] = { x = 1864.48523, y = -1604.46985, z = 13.53908},
[11] = { x = 1813.94653, y = -1746.61450, z = 13.54688},
[12] = { x = 1885.39197, y = -1759.63184, z = 13.54688},
[13] = { x = 1982.42712, y = -1760.02698, z = 13.54688},
[14] = { x = 2033.11475, y = -1760.00842, z = 13.54688},
[15] = { x = 2074.73462, y = -1789.82507, z = 13.5468},
}

local id = #PizzaSMarkerSpawns

function pos()
	id = id + 1
	local x, y, z = getElementPosition(localPlayer)
	local text = '['..id..'] = { x = '..x..', y = '..y..', z = '..z..'},';
	outputChatBox(text)
	setClipboard(text)
end
addCommandHandler('pos', pos)

addEvent('gLoadPizzaGUI', true);
addEventHandler('gLoadPizzaGUI', localPlayer, function()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true);
		PIZZA_JOB_GUI()
		setElementData(lp,'ElementClicked',true)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)

function closePizzaWindow()
	showCursor(false);
	destroyElement(PizzaGUI)
	setElementData(lp,'ElementClicked',false)
end

function createPizzaCar(player, id)
	triggerServerEvent('gPizzaCreate', player, player, id);
end

function gPizzaFinish(player)
	triggerServerEvent('gPizzaFinish', player, player);
end

addEventHandler('onClientVehicleExit', root, function(player, seat)
	if player == localPlayer then
		if getElementModel(source) == 448 then
			for i = 1, #PizzaSMarkerSpawns do 
				if PizzaSMarker[i] then
					if(PizzaBlip[i])then
						destroyElement(PizzaBlip[i]);
					end
					if(PizzaSMarker[i])then
						destroyElement(PizzaSMarker[i]);
					end
				end
			end
			triggerServerEvent('gPizzaEnd', player, player);
		end
	end
end)