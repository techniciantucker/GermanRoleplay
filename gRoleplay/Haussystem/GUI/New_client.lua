local gLabel  = {}
local gButton = {}
local gWindow = {}

function new_client_window()
	gWindow["House_New"] = guiCreateStaticImage(0.36, 0.02, 0.27, 0.25, "Images/Background.png", true)

	gLabel["Zone"] = guiCreateLabel(0.03, 0.12, 0.94, 0.12, "Standort:", true, gWindow["House_New"])
	guiSetFont(gLabel["Zone"], "default-bold-small")
	gLabel["Prize"] = guiCreateLabel(0.03, 0.24, 0.94, 0.12, "Preis:", true, gWindow["House_New"])
	guiSetFont(gLabel["Prize"], "default-bold-small")
	--[[ gLabel["Time"] = guiCreateLabel(0.02, 0.49, 0.96, 0.04, "Mindestspielzeit: 100000", true, gWindow["House_New"])
	guiSetFont(gLabel["Time"], "default-bold-small") ]]--
	gLabel["State"] = guiCreateLabel(0.03, 0.36, 0.94, 0.12, "Status", true, gWindow["House_New"])
	guiSetFont(gLabel["State"], "default-bold-small")
	gButton["BuyBar"]  = guiCreateButton(0.05, 0.54, 0.41, 0.16, "Haus Kaufen (Bargeld)", true, gWindow["House_New"])
	gButton["BuyBank"] = guiCreateButton(0.53, 0.54, 0.41, 0.16, "Haus Kaufen (Bankgeld)", true, gWindow["House_New"])
	gButton["Close"]   = guiCreateButton(0.29, 0.75, 0.41, 0.16, "Schließen", true, gWindow["House_New"])

	addEventHandler('onClientGUIClick', gButton["BuyBar"], systemHouseBuyBar, false)
	addEventHandler('onClientGUIClick', gButton["BuyBank"], systemHouseBuyBank, false)
	addEventHandler('onClientGUIClick', gButton["Close"], systemHouseUnload, false)
end

function systemHouseNew()
	if(getElementData(lp,"ElementClicked")==false)then
		local house = getElementData(localPlayer, 'house')
		local prize = getElementData(house, 'preis')
		--local mintime = getElementData(house, 'mintime')
		local zone = getZoneName(getElementPosition(localPlayer))
		
		showCursor(true)
		new_client_window()
		setElementData ( lp, "ElementClicked", true, true )
		
		guiSetText(gLabel["Zone"], 'Haus Standort: '..zone)
		guiSetText(gLabel['Prize'], 'Preis: '..prize)
		--guiSetText(gLabel['Time'], 'Mindestspielzeit: '..mintime..' Stunden')
		guiSetText(gLabel['State'], 'Status: Abgeschloßen')
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end
addEvent('onCreateNewHouseGUI', true)
addEventHandler('onCreateNewHouseGUI', localPlayer, systemHouseNew)

function systemHouseBuyBar()
	systemHouseUnload()
	triggerServerEvent('onHouseBuyGUI', localPlayer, localPlayer, 'bar')
end

function systemHouseBuyBank()
	systemHouseUnload()
	triggerServerEvent('onHouseBuyGUI', localPlayer, localPlayer, 'bank')
end

function systemHouseUnload()
	showCursor(false)
	destroyElement(gWindow['House_New'])
	setElementData ( lp, "ElementClicked", false, true )
end