TowedWindow = guiCreateStaticImage(0.32, 0.01, 0.35, 0.32, "Images/Background.png", true)

Mechanikerinfo = guiCreateLabel(0.49, 0.09, 0.49, 0.23, "Dein Auto wurde abgeschleppt? Keine Sorge, es ist nicht weg, sondern in der verwalt Zentrale der Mechaniker! Für 3000$ kannst du es freikaufen.", true, TowedWindow)
guiSetFont(Mechanikerinfo, "clear-normal")
guiLabelSetHorizontalAlign(Mechanikerinfo, "left", true)
TowedGridlist = guiCreateGridList(0.02, 0.09, 0.45, 0.87, true, TowedWindow)
TowedSlot = guiGridListAddColumn(TowedGridlist, "Slot", 0.5)
TowedName = guiGridListAddColumn(TowedGridlist, "Name", 0.5)
BuyFreeButton = guiCreateButton(0.60, 0.35, 0.28, 0.12, "Fahrzeug freikaufen", true, TowedWindow)
CloseTowedButton = guiCreateButton(0.60, 0.51, 0.28, 0.12, "Schließen", true, TowedWindow)

guiSetVisible(TowedWindow, false)

function loadingTowingVehicles(vehicleList)
	if not(guiGetVisible(TowedWindow))then
		showCursor(true);
		guiSetVisible(TowedWindow, true);
		setElementData ( lp, "ElementClicked", true, true )
		
		if(#vehicleList > 0)then
			for k, data in pairs(vehicleList) do 
				local row = guiGridListAddRow(TowedGridlist);
				guiGridListSetItemText(TowedGridlist, row, TowedSlot, data[1], false, false);
				guiGridListSetItemText(TowedGridlist, row, TowedName, getVehicleNameFromModel(data[2]), false, false);
			end
		end
	end
end
addEvent('LoadTowingList', true)
addEventHandler('LoadTowingList', localPlayer, loadingTowingVehicles);

function closeTowed()
	showCursor(false);
	guiSetVisible(TowedWindow, false);
	guiGridListClear(TowedGridlist);
	setElementData ( lp, "ElementClicked", false, true )
end
addEventHandler('onClientGUIClick', CloseTowedButton, closeTowed,false);

function freeBuyTowedVehicle()
	local gridlistSelect = guiGridListGetItemText(TowedGridlist, guiGridListGetSelectedItem(TowedGridlist), 1);
	if(gridlistSelect ~= -1)then
		triggerServerEvent('onTowedVehicleBuyFree', localPlayer, localPlayer, tonumber(gridlistSelect));
	end
end
addEventHandler('onClientGUIClick', BuyFreeButton, freeBuyTowedVehicle, false)

function closeTowed_Server()
	closeTowed()
end
addEvent('closeTowedWindow', true)
addEventHandler('closeTowedWindow', localPlayer, closeTowed_Server)