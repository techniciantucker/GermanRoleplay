addEvent('eisWindow',true)
addEventHandler('eisWindow',root,function()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,'ElementClicked',true)
	
		eisWindow = guiCreateStaticImage(0.38, 0.01, 0.24, 0.14, "Images/Background.png", true)

		eisButtonEnter = guiCreateButton(0.20, 0.26, 0.59, 0.25, "Job starten", true, eisWindow)
		guiSetAlpha(eisButtonEnter, 1)
		eisButtonClose = guiCreateButton(0.20, 0.65, 0.59, 0.25, "Schließen", true, eisWindow)
		guiSetAlpha(eisButtonClose, 1)

		addEventHandler('onClientGUIClick', eisButtonClose, function()
			destroyElement(eisWindow)
			showCursor(false)
			setElementData(lp,'ElementClicked',false)
		end, false)

		addEventHandler('onClientGUIClick', eisButtonEnter, function()
			destroyElement(eisWindow)
			showCursor(false)
			setElementData(lp,'ElementClicked',false)
			triggerServerEvent('eisJobAnnehmen',getLocalPlayer(),getLocalPlayer())
		end,false)
	else
		infobox('Es ist nicht möglich, mehrere\nFenser gleichzeitig zu öffnen!')
	end
end)