function CarbuyWindow_GUI()
CarbuyWindow = guiCreateStaticImage(0.37, 0.01, 0.25, 0.21, "Images/Background.png", true)
guiSetAlpha(CarbuyWindow,0.80)
 
gVehicleNameLabel = guiCreateLabel(0.03, 0.14, 0.94, 0.12, "Model:", true, CarbuyWindow)
guiSetFont(gVehicleNameLabel, "default-bold-small")
guiLabelSetHorizontalAlign(gVehicleNameLabel, "center", false)
guiLabelSetVerticalAlign(gVehicleNameLabel, "center")
gVehiclePriceLabel = guiCreateLabel(0.03, 0.32, 0.94, 0.14, "Preis:", true, CarbuyWindow)
guiSetFont(gVehiclePriceLabel, "default-bold-small")
guiLabelSetHorizontalAlign(gVehiclePriceLabel, "center", false)
guiLabelSetVerticalAlign(gVehiclePriceLabel, "center")
gVehicleBuyButton = guiCreateButton(0.28, 0.52, 0.43, 0.18, "Fahrzeug erwerben", true, CarbuyWindow)
guiSetAlpha(gVehicleBuyButton,1)
guiSetFont(gVehicleBuyButton, "default-bold-small")
gVehicleCloseButton = guiCreateButton(0.28, 0.76, 0.43, 0.18, "Schließen", true, CarbuyWindow)
guiSetFont(gVehicleCloseButton, "default-bold-small")
guiSetAlpha(gVehicleCloseButton,1)

addEventHandler('onClientGUIClick', gVehicleBuyButton, buyVehicleButton, false)
addEventHandler('onClientGUIClick', gVehicleCloseButton, unloadVehicleBuyWindow, false)
end

function openVehicleBuyWindow(vehicleID, vehiclePrice, carhouse_ID)
	if(getElementData(lp,"ElementClicked")==false)then
		setElementData ( lp, "ElementClicked", true, true )
		showCursor(true);
		CarbuyWindow_GUI()
		guiSetText(gVehicleNameLabel, 'Auto: '..getVehicleNameFromModel(vehicleID));
		guiSetText(gVehiclePriceLabel, 'Preis: '..vehiclePrice..'$');
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end
addEvent('onLoadClientVehicleWindow', true)
addEventHandler('onLoadClientVehicleWindow', localPlayer, openVehicleBuyWindow);


function unloadVehicleBuyWindow()
	setElementData ( lp, "ElementClicked", false, true )
	showCursor(false);
	destroyElement(CarbuyWindow)
end

function buyVehicleButton()
	setElementData ( lp, "ElementClicked", false, true )
	unloadVehicleBuyWindow()
	triggerServerEvent('doBuyVehicle', localPlayer, localPlayer);
end