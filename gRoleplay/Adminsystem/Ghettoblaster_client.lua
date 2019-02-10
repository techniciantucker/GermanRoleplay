local gWindow = {}
local gLabel  = {}
local gEdit	  = {}
local gButton = {}

function ghettoBlaster()
	gWindow["Music"] = guiCreateStaticImage(0.37, 0.02, 0.27, 0.35, "Images/Background.png", true)
	guiSetAlpha(gWindow["Music"],0.80)

	gLabel["info"] = guiCreateLabel(0.03, 0.08, 0.95, 0.21, "Trage den gewünschten Stream Link unten ein, und klicke anschließend auf \"Starten\". Alle Spieler in deinem Umfeld hören nun deine Musik.", true, gWindow["Music"])
	guiSetFont(gLabel["info"], "clear-normal")
	guiLabelSetHorizontalAlign(gLabel["info"], "left", true)

	gEdit["KiwiLink"] = guiCreateEdit(0.03, 0.31, 0.95, 0.11, "", true, gWindow["Music"])
	gButton["Play"] = guiCreateButton(0.29, 0.47, 0.43, 0.08, "Starten", true, gWindow["Music"])
	gButton["Pause"] = guiCreateButton(0.29, 0.59, 0.43, 0.08, "Stoppen", true, gWindow["Music"])
	gButton["Close"] = guiCreateButton(0.29, 0.70, 0.43, 0.08, "Schließen", true, gWindow["Music"])
	
	addEventHandler('onClientGUIClick',gButton['Play'],function()
		local edit = guiGetText(gEdit["KiwiLink"])
		if(#edit > 0)then
			triggerServerEvent('newPlaySound', localPlayer, localPlayer, tostring(edit))
		else
			infobox("Der Link ist zu kurz!")
		end
	end,false)
	
	addEventHandler("onClientGUIClick", gButton["Close"],function()
		destroyElement(gWindow['Music'])
		showCursor(false)
		setElementData(lp,'ElementClicked',false)
	end,false)
	
	addEventHandler("onClientGUIClick", gButton["Pause"],function()
		triggerServerEvent('deleteBlaster', localPlayer, localPlayer)
	end,false)
end

local Client = {}
function gWindowStart()
	if(getElementData(localPlayer,"vip")>=3)then
		if(getElementData(lp,"ElementClicked")==false)then
			ghettoBlaster()
			showCursor(true)
			setElementData ( lp, "ElementClicked", true, true )
		else
			infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
		end
	end
end
bindKey("f2", "down", gWindowStart)

addEvent('deleteMusic', true)
addEventHandler('deleteMusic', root, function(player)
	if(isElement(Client[player]))then
		destroyElement(Client[player])
	end
end)

addEvent('createNewMusik', true)
addEventHandler('createNewMusik', root, function(player, link)
	local x, y, z = getElementPosition(player);
	if(isElement(Client[player]))then
		destroyElement(Client[player])
	end
	Client[player]=playSound3D(link, x, y, z);
	attachElements(Client[player], player)
end)