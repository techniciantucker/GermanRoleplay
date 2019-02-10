addEvent('BerkwerkWindow',true)
addEventHandler('BerkwerkWindow',root,function()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,'ElementClicked',true)
	
		BerkwerkWindow = guiCreateStaticImage(0.38, 0.01, 0.24, 0.14, "Images/Background.png", true)

		BerkwerkButtonEnter = guiCreateButton(0.20, 0.26, 0.59, 0.25, "Job starten", true, BerkwerkWindow)
		guiSetAlpha(BerkwerkButtonEnter, 1)
		BerkwerkButtonClose = guiCreateButton(0.20, 0.65, 0.59, 0.25, "Schließen", true, BerkwerkWindow)
		guiSetAlpha(BerkwerkButtonClose, 1)

		addEventHandler('onClientGUIClick', BerkwerkButtonClose, function()
			destroyElement(BerkwerkWindow)
			showCursor(false)
			setElementData(lp,'ElementClicked',false)
		end, false)

		addEventHandler('onClientGUIClick', BerkwerkButtonEnter, function()
			destroyElement(BerkwerkWindow)
			showCursor(false)
			setElementData(lp,'ElementClicked',false)
			triggerServerEvent('bergwerkArbeiterAnnehmen',getLocalPlayer(),getLocalPlayer())
		end,false)
	else
		infobox('Es ist nicht möglich, mehrere\nFenser gleichzeitig zu öffnen!')
	end
end)