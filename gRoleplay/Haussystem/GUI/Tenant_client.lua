local gLabel  = {}
local gButton = {}
local gWindow = {}

function tenant_client_window()
	gWindow["Rent"] = guiCreateStaticImage(0.36, 0.02, 0.27, 0.19, "Images/Background.png", true)

	gLabel["Owner"] = guiCreateLabel(0.03, 0.16, 0.95, 0.16, "Besitzer:", true, gWindow["Rent"])
	guiSetFont(gLabel["Owner"], "default-bold-small")
	--[[ gLabel["Time"] = guiCreateLabel(0.02, 0.41, 0.96, 0.04, "Mindestspielzeit:", true, gWindow["Rent"])
	guiSetFont(gLabel["Time"], "default-bold-small") ]]--
	gLabel["Miete"] = guiCreateLabel(0.03, 0.32, 0.95, 0.16, "Miete:", true, gWindow["Rent"])
	guiSetFont(gLabel["Miete"], "default-bold-small")
	--[[ gButton["Enter"] = guiCreateButton(0.05, 0.71, 0.42, 0.20, "Betreten", true, gWindow["Rent"])
	guiSetFont(gButton["Enter"], "default-bold-small") ]]--
	gLabel["State"] = guiCreateLabel(0.03, 0.47, 0.95, 0.16, "Status:", true, gWindow["Rent"])
	guiSetFont(gLabel["State"], "default-bold-small")
	gButton["Close"] = guiCreateButton(0.53, 0.71, 0.42, 0.20, "Schließen", true, gWindow["Rent"])
	guiSetFont(gButton["Close"], "default-bold-small")
	if(getElementData(lp,'housekey')==1)then
		gButton["OutRent"] = guiCreateButton(0.05, 0.71, 0.42, 0.20, "Ausmieten", true, gWindow["Rent"])
	else
		gButton["OutRent"] = guiCreateButton(0.05, 0.71, 0.42, 0.20, "Einmieten", true, gWindow["Rent"])
	end
	guiSetFont(gButton["OutRent"], "default-bold-small")

	addEventHandler('onClientGUIClick', gButton["OutRent"], systemRent, false)
	addEventHandler('onClientGUIClick', gButton["Close"], systemMieterUnload, false)
end

function gData(element, data)
	return getElementData(element, data)
end

function systemMieterHouse()
	if(getElementData(lp,"ElementClicked")==false)then
		showChat(true)
		showCursor(true)
		tenant_client_window()
		setElementData ( lp, "ElementClicked", true, true )
		
		local house = getElementData(localPlayer, 'house')
		--prize = gData(house, 'preis')
		rent = gData(house, 'miete')
		owner = gData(house, 'owner')
		state = gData(house, 'locked')
		--mintime = getElementData(house, 'mintime')
		
		if state then state = 'Abgeschloßen' else state = 'Aufgeschloßen' end
		
		guiSetText(gLabel["State"], 'Status: '..state)
		guiSetText(gLabel["Owner"], 'Besitzer: '..owner)
		guiSetText(gLabel["Miete"], 'Miete: '..rent..'$')
		--guiSetText(gLabel["Rent"], 'Preis: '..prize..'$')
		--guiSetText(gLabel["Time"], 'Mindestspielzeit: '..mintime);
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end
addEvent('onLoadMieterhouse', true)
addEventHandler('onLoadMieterhouse', localPlayer, systemMieterHouse)

function systemRent()
	systemMieterUnload()
	if(getElementData(lp,'housekey')==1)then
		triggerServerEvent('onRentOut', localPlayer, localPlayer)
	else
		triggerServerEvent('onRentHouse', localPlayer, localPlayer)
	end
end

--[[ function systemHouseMieterEnter()
	systemMieterUnload()
	triggerServerEvent('onHouseEnter', localPlayer, localPlayer)
end
addEventHandler('onClientGUIClick', gButton["Enter"], systemHouseMieterEnter, false) ]]--

function systemMieterUnload()
	showCursor(false)
	destroyElement(gWindow['Rent'])
	setElementData ( lp, "ElementClicked", false, true )
end