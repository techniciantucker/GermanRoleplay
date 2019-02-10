local gWindow = {}
local gLabel  = {}
local gEdit	  = {}
local gButton = {}

function owner_client_window()
	gWindow["Haus_Owner"] = guiCreateStaticImage(0.37, 0.01, 0.27, 0.40, "Images/Background.png", true)

	gLabel["Owner"] = guiCreateLabel(0.03, 0.09, 0.94, 0.07, "Besitzer: "..getPlayerName(localPlayer), true, gWindow["Haus_Owner"])
	guiSetFont(gLabel["Owner"], "default-bold-small")
	--[[ gLabel["Time"] = guiCreateLabel(0.02, 0.35, 0.96, 0.04, "Mindestspielzeit:", true, gWindow["Haus_Owner"])
	guiSetFont(gLabel["Time"], "default-bold-small") ]]--
	gLabel["Prize"] = guiCreateLabel(0.03, 0.16, 0.94, 0.07, "Preis:", true, gWindow["Haus_Owner"])
	guiSetFont(gLabel["Prize"], "default-bold-small")
	gLabel["Status"] = guiCreateLabel(0.03, 0.23, 0.94, 0.07, "Status:", true, gWindow["Haus_Owner"])
	guiSetFont(gLabel["Status"], "default-bold-small")
	gLabel["Rent"] = guiCreateLabel(0.03, 0.30, 0.94, 0.07, "Miete:", true, gWindow["Haus_Owner"])
	guiSetFont(gLabel["Rent"], "default-bold-small")
	gLabel["Zone"] = guiCreateLabel(0.03, 0.37, 0.94, 0.07, "Standort: "..getZoneName(getElementPosition(localPlayer)), true, gWindow["Haus_Owner"])
	guiSetFont(gLabel["Zone"], "default-bold-small")
	gEdit["Rent"] = guiCreateEdit(0.55, 0.73, 0.42, 0.09, "", true, gWindow["Haus_Owner"])
	gButton["Rent"] = guiCreateButton(0.55, 0.86, 0.42, 0.09, "Miete setzen", true, gWindow["Haus_Owner"])
	guiSetFont(gButton["Rent"], "default-bold-small")
	gButton["Sell"] = guiCreateButton(0.03, 0.48, 0.42, 0.09, "Verkaufen", true, gWindow["Haus_Owner"])
	guiSetFont(gButton["Sell"], "default-bold-small")
	gButton["Enter"] = guiCreateButton(0.03, 0.61, 0.42, 0.09, "Betreten", true, gWindow["Haus_Owner"])
	guiSetFont(gButton["Enter"], "default-bold-small")
	gButton["Locked"] = guiCreateButton(0.03, 0.73, 0.42, 0.09, "Abschließen", true, gWindow["Haus_Owner"])
	guiSetFont(gButton["Locked"], "default-bold-small")
	gButton["Close"] = guiCreateButton(0.03, 0.86, 0.42, 0.09, "Schließen", true, gWindow["Haus_Owner"])
	guiSetFont(gButton["Close"], "default-bold-small")
	InfoMiete = guiCreateLabel(0.55, 0.64, 0.42, 0.06, "Miete:", true, gWindow["Haus_Owner"])
	guiSetFont(InfoMiete, "clear-normal")    

	addEventHandler('onClientGUIClick', gButton["Rent"], systemHouseRent, false)
	addEventHandler('onClientGUIClick', gButton["Locked"], systemHouseLocked, false)
	addEventHandler('onClientGUIClick', gButton["Enter"], systemHouseEnter, false)
	addEventHandler('onClientGUIClick', gButton["Sell"], systemHouseSell, false)
	addEventHandler('onClientGUIClick', gButton["Close"], systemHouseOwnerUnload, false)
end

function gData(element, data)
	return getElementData(element, data)
end

function systemHouseOwner()
	if(getElementData(lp,"ElementClicked")==false)then
		showCursor(true)
		owner_client_window()
		setElementData ( lp, "ElementClicked", true, true )
		
		local house = getElementData(localPlayer, 'house')
		prize = gData(house, 'preis')
		mintime = gData(house, 'mintime')
		locked = gData(house, 'locked')
		rent = gData(house, 'miete')
		if(locked == true)then locked = "Abgeschloßen" else locked = "Aufgeschloßen" end 
		
		--guiSetText(gLabel["Time"], 'Mindestspielzeit: '..mintime..' Stunden')
		guiSetText(gLabel["Status"], 'Status: '..locked)
		guiSetText(gLabel["Prize"], 'Preis: '..prize..'$')
		guiSetText(gLabel["Rent"], 'Miete: '..rent..'$')
		guiSetText(gButton['Locked'], locked)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end
addEvent('onCreateOwnerHouseGUI', true)
addEventHandler('onCreateOwnerHouseGUI', localPlayer, systemHouseOwner)

function systemHouseRent()
	local edit = guiGetText(gEdit["Rent"])
	if(#edit > 0)then
		if(tonumber(edit))then
			systemHouseOwnerUnload()
			triggerServerEvent('onHouseSetRent', localPlayer, localPlayer, tonumber(edit))
		else
			infobox("Es sind nur Zahlen erlaubt!")
		end
	else
		infobox("Gib eine Zahl ein!")
	end
end

function systemHouseLocked()
	triggerServerEvent('onHouseSetState', localPlayer, localPlayer)
end

function systemHouseEnter()
	systemHouseOwnerUnload()
	triggerServerEvent('onHouseEnter', localPlayer, localPlayer)
end

function systemHouseSetState()
	local house = getElementData(localPlayer, 'house')
	locked = gData(house, 'locked')
	if(locked == true)then locked = "Abgeschloßen" else locked = "Aufgeschloßen" end 
	guiSetText(gLabel["Status"], 'Status: '..locked)
	guiSetText(gButton['Locked'], locked)
end
addEvent('onSetHouseState', true)
addEventHandler('onSetHouseState', localPlayer, systemHouseSetState)

function systemHouseSell()
	systemHouseOwnerUnload()
	triggerServerEvent('onHouseSellGUI', localPlayer, localPlayer)
end

function systemHouseOwnerUnload()
	showCursor(false)
	destroyElement(gWindow['Haus_Owner'])
	setElementData ( lp, "ElementClicked", false, true )
end