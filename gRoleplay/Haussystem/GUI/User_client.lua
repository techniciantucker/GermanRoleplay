local gLabel  = {}
local gButton = {}
local gWindow = {}

function user_client_window()
	gWindow["Rent"] = guiCreateStaticImage(0.36, 0.02, 0.27, 0.19, "Images/Background.png", true)

	gLabel["Owner"] = guiCreateLabel(0.03, 0.16, 0.95, 0.16, "Besitzer:", true, gWindow["Rent"])
	guiSetFont(gLabel["Owner"], "default-bold-small")
	gLabel["Miete"] = guiCreateLabel(0.03, 0.32, 0.95, 0.16, "Miete:", true, gWindow["Rent"])
	guiSetFont(gLabel["Miete"], "default-bold-small")
	gButton["Rent"] = guiCreateButton(0.05, 0.71, 0.42, 0.20, "Einmieten", true, gWindow["Rent"])
	guiSetFont(gButton["Rent"], "default-bold-small")
	gLabel["State"] = guiCreateLabel(0.03, 0.47, 0.95, 0.16, "Status", true, gWindow["Rent"])
	gButton["Close"] = guiCreateButton(0.53, 0.71, 0.42, 0.20, "Schließen", true, gWindow["Rent"])
	guiSetFont(gButton["Close"], "default-bold-small")

	addEventHandler('onClientGUIClick', gButton["Rent"], systemRent, false)
	addEventHandler('onClientGUIClick',gButton["Close"], systemUserUnload, false)
end

function gData(element, data)
	return getElementData(element, data)
end

function systemUserHouse()
	if(getElementData(lp,"ElementClicked")==false)then
		showChat(true)
		user_client_window()
		setElementData ( lp, "ElementClicked", true, true )
		
		showCursor(true);
		
		local house = getElementData(localPlayer, 'house')
		owner = gData(house, 'owner')
		prize = gData(house, 'preis')
		rent = gData(house, 'miete')
		state = gData(house, 'locked')
		if state then state = 'Abgeschloßen' else state = 'Aufgeschloßen' end
		
		guiSetText(gLabel["State"], 'Status: '..state)
		guiSetText(gLabel["Miete"], 'Miete: '..rent..'$')
		guiSetText(gLabel["Rent"], 'Preis: '..prize..'$')
		guiSetText(gLabel["Owner"], 'Besitzer: '..owner..'$')
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end
addEvent('onLoadUserhouse', true)
addEventHandler('onLoadUserhouse', localPlayer, systemUserHouse)


function systemRent()
	systemUserUnload()
	triggerServerEvent('onRentHouse', localPlayer, localPlayer)
end

function systemUserUnload()
	showChat(false)
	destroyElement(gWindow["Rent"])
	setElementData ( lp, "ElementClicked", false, true )
end