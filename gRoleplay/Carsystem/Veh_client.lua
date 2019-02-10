function vehicleWINDOW()
	VehicleWindow = guiCreateStaticImage(0.22, 0.19, 0.19, 0.47, "Images/Background.png", true)

	VehicleGridlist = guiCreateGridList(0.04, 0.05, 0.93, 0.52, true, VehicleWindow)
	VehicleSlot = guiGridListAddColumn(VehicleGridlist, "Slot", 0.5)
	VehicleName = guiGridListAddColumn(VehicleGridlist, "Name", 0.5)

	SellCarButton = guiCreateButton(0.04, 0.74, 0.92, 0.06, "Verkaufen", true, VehicleWindow)

	RespawnenCarButton = guiCreateButton(0.04, 0.82, 0.92, 0.06, "Respawnen", true, VehicleWindow)

	LocateCarButton = guiCreateButton(0.04, 0.66, 0.92, 0.06, "Orten", true, VehicleWindow)

	LockCarButton = guiCreateButton(0.04, 0.90, 0.92, 0.06, "Auf/Abschließen", true, VehicleWindow)

	addEventHandler('onClientGUIClick', LockCarButton, lockUnlockVehicle, false)
	addEventHandler('onClientGUIClick', LocateCarButton, locateVehicle, false)
	addEventHandler('onClientGUIClick', RespawnenCarButton, respawnVehicleCar, false)
	addEventHandler('onClientGUIClick', SellCarButton, sellVehicleCar, false)
end

function showVehicleWindow(vehList)
	showCursor(true)
	vehicleWINDOW()
	guiGridListClear(VehicleGridlist);
	if(#vehList > 0)then
		for _, data in pairs(vehList) do 
			local row = guiGridListAddRow(VehicleGridlist);
			guiGridListSetItemText(VehicleGridlist, row, VehicleSlot, data[1], false, false);
			guiGridListSetItemText(VehicleGridlist, row, VehicleName, data[2], false, false);
		end
	end
end
addEvent('onLoadVehicleList', true)
addEventHandler('onLoadVehicleList', localPlayer, showVehicleWindow)

function sellVehicleCar()
	local slot = guiGridListGetItemText(VehicleGridlist, guiGridListGetSelectedItem(VehicleGridlist), 1);
	if(slot ~= -1)then
		triggerServerEvent('onSellCarClient', localPlayer, localPlayer, nil, tonumber(slot));
	else
		infobox("Bitte wähle ein Fahrzeug aus!")
	end
end

function respawnVehicleCar()
	local slot = guiGridListGetItemText(VehicleGridlist, guiGridListGetSelectedItem(VehicleGridlist), 1);
	if(slot ~= -1)then
		triggerServerEvent('respawnPrivVehClick', localPlayer, localPlayer, tonumber(slot));
	else
		infobox("Bitte wähle ein Fahrzeug aus!")
	end
end

function locateVehicle()
	local slot = guiGridListGetItemText(VehicleGridlist, guiGridListGetSelectedItem(VehicleGridlist), 1);
	if(slot ~= -1)then
		triggerServerEvent('onVehicleLocate', localPlayer, localPlayer, tonumber(slot));
	else
		infobox("Bitte wähle ein Fahrzeug aus!")
	end
end

function disableVehicleWindow()
	destroyElement(VehicleWindow)
	--guiGridListClear(VehicleGridlist);
end

function lockUnlockVehicle()
	local slot = guiGridListGetItemText(VehicleGridlist, guiGridListGetSelectedItem(VehicleGridlist), 1);
	if(slot ~= -1)then
		triggerServerEvent('lockPrivVehClick', localPlayer, localPlayer, tonumber(slot));
	else
		infobox("Bitte wähle ein Fahrzeug aus!")
	end
end

function refreshVehicleWindow(vehList)
	if(guiGetVisible(VehicleWindow))then
		guiGridListClear(VehicleGridlist);
		if(#vehList > 0)then
			for _, data in pairs(vehList) do 
				local row = guiGridListAddRow(VehicleGridlist);
				guiGridListSetItemText(VehicleGridlist, row, VehicleSlot, data[2], false, false);
				guiGridListSetItemText(VehicleGridlist, row, VehicleName, data[3], false, false);
			end
		end
	end
end
addEvent('refreshVehiclePanel', true)
addEventHandler('refreshVehiclePanel', localPlayer, refreshVehicleWindow)