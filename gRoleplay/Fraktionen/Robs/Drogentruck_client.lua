local gWindow = {}
local gButton = {}
local gImage  = {}

gWindow["Drugs"] = guiCreateStaticImage(0.38, 0.01, 0.24, 0.20, "Images/Background.png", true)

DrogentruckInfo = guiCreateLabel(0.03, 0.15, 0.94, 0.34, "Das Beladen eines Drogentrucks kostet dich 5000$! Bei der Abgabe erhälst du 3500g Drogen. Pro Gramm kannst du bis zu 7$ bekommen!",true, gWindow["Drugs"])
guiSetFont(DrogentruckInfo, "clear-normal")
guiLabelSetHorizontalAlign(DrogentruckInfo, "left", true)
gButton["Start"] = guiCreateButton(0.27, 0.54, 0.47, 0.16, "Beladen", true, gWindow["Drugs"])
guiSetProperty(gButton["Start"] , "NormalTextColour", "FFAAAAAA")
gButton["Close"] = guiCreateButton(0.27, 0.75, 0.47, 0.16, "Schließen", true, gWindow["Drugs"])
guiSetProperty(gButton["Close"], "NormalTextColour", "FFAAAAAA")

addEventHandler("onClientGUIClick",gButton["Close"],function()
	guiSetVisible(gWindow["Drugs"], false)
	GermanRoleplayWindowOpen = false
	showCursor(false)
	setElementData(lp,"ElementClicked",false)
end,false)

guiSetVisible(gWindow["Drugs"], false)

function gWindowStart()
	if GermanRoleplayWindowOpen == false then
		GermanRoleplayWindowOpen = true
		showCursor(true)
		setElementData(lp,"ElementClicked",true,true)
		
		guiSetVisible(gWindow["Drugs"],true)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end
addEvent('gDrugWindow', true)
addEventHandler('gDrugWindow', root, gWindowStart)

function gStartDrug()
	showCursor(false)
	guiSetVisible(gWindow["Drugs"], false)
	triggerServerEvent('onStartDrugs', localPlayer, localPlayer)
end
addEventHandler("onClientGUIClick", gButton["Start"], gStartDrug, false)

function gCloseDrug()
	showCursor(false)
	guiSetVisible(gWindow["Drugs"], false)
end
addEventHandler("onClientGUIClick", gButton["Close"], gCloseDrug, false)