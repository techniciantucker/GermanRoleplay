addEvent('ZugjobWindow',true)
addEventHandler('ZugjobWindow',root,function()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,'ElementClicked',true)
	
		ZugjobWindow = guiCreateStaticImage(0.38, 0.01, 0.24, 0.14, "Images/Background.png", true)

		ZugjobButtonEnter = guiCreateButton(0.20, 0.26, 0.59, 0.25, "Job starten", true, ZugjobWindow)
		guiSetAlpha(ZugjobButtonEnter, 1)
		ZugjobButtonClose = guiCreateButton(0.20, 0.65, 0.59, 0.25, "Schließen", true, ZugjobWindow)
		guiSetAlpha(ZugjobButtonClose, 1)

		addEventHandler('onClientGUIClick', ZugjobButtonClose, function()
			destroyElement(ZugjobWindow)
			showCursor(false)
			setElementData(lp,'ElementClicked',false)
		end, false)

		addEventHandler('onClientGUIClick', ZugjobButtonEnter, function()
			destroyElement(ZugjobWindow)
			showCursor(false)
			setElementData(lp,'ElementClicked',false)
			triggerServerEvent('zugJobAnnehmen',getLocalPlayer(),getLocalPlayer())
		end,false)
	else
		infobox('Es ist nicht möglich, mehrere\nFenser gleichzeitig zu öffnen!')
	end
end)

addEvent('zugMarker',true)
addEventHandler('zugMarker',root,function()
	zugBlip=createBlip(2864.90625, 1281.85193, 10.82031,41,2)
	zugMarker=createMarker(2864.90625, 1281.85193, 10.82031,'checkpoint',2,200,0,0)
	addEventHandler('onClientMarkerHit',zugMarker,function(hitClient)
		if(hitClient==localPlayer)then
			if(zugBlip)then
				destroyElement(zugBlip)
			end
			if(zugMarker)then
				destroyElement(zugMarker)
			end
			triggerServerEvent('zugJobBelohnung',getLocalPlayer(),getLocalPlayer())
		end
	end)
end)

addEvent('destroyZugMarker',true)
addEventHandler('destroyZugMarker',root,function()
	if(zugBlip)then
		destroyElement(zugBlip)
	end
	if(zugMarker)then
		destroyElement(zugMarker)
	end
end)