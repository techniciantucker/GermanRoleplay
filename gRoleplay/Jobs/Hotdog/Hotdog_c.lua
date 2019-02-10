addEvent('hotdogWindow',true)
addEventHandler('hotdogWindow',root,function()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,'ElementClicked',true)
	
		hotdogWindow = guiCreateStaticImage(0.38, 0.01, 0.24, 0.14, "Images/Background.png", true)

		hotdogButtonEnter = guiCreateButton(0.20, 0.26, 0.59, 0.25, "Job starten", true, hotdogWindow)
		guiSetAlpha(hotdogButtonEnter, 1)
		hotdogButtonClose = guiCreateButton(0.20, 0.65, 0.59, 0.25, "Schließen", true, hotdogWindow)
		guiSetAlpha(hotdogButtonClose, 1)

		addEventHandler('onClientGUIClick', hotdogButtonClose, function()
			destroyElement(hotdogWindow)
			showCursor(false)
			setElementData(lp,'ElementClicked',false)
		end, false)

		addEventHandler('onClientGUIClick', hotdogButtonEnter, function()
			destroyElement(hotdogWindow)
			showCursor(false)
			setElementData(lp,'ElementClicked',false)
			triggerServerEvent('hotdogJobAnnehmen',getLocalPlayer(),getLocalPlayer())
		end,false)
	else
		infobox('Es ist nicht möglich, mehrere\nFenser gleichzeitig zu öffnen!')
	end
end)