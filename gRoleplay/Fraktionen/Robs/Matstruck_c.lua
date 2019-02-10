local matstruck = {button = {},window = {},label = {}}

addEvent('matstruckWindow',true)
addEventHandler('matstruckWindow',root,function()
	if(getElementData(lp,'ElementClicked')==false)then
		setElementData(lp,'ElementClicked',true)
		showCursor(true)
	
        matstruck.window[1] = guiCreateStaticImage(0.36, 0.01, 0.28, 0.16, "Images/Background.png", true)

        matstruck.label[1] = guiCreateLabel(11, 22, 388, 27, "Hier kannst du für 5000$ einen Matstruck starten.", false, matstruck.window[1])
        guiSetFont(matstruck.label[1], "default-bold-small")
        matstruck.button[1] = guiCreateButton(0.03, 0.41, 0.95, 0.18, "Starten", true, matstruck.window[1])
        matstruck.button[2] = guiCreateButton(0.02, 0.65, 0.95, 0.18, "Schließen", true, matstruck.window[1])
		addEventHandler('onClientGUIClick',matstruck.button[1],function()
			destroyElement(matstruck.window[1])
			showCursor(false)
			setElementData(lp,'ElementClicked',false)
			triggerServerEvent('matstruckStarten',getLocalPlayer(),getLocalPlayer())
		end,false)
		addEventHandler('onClientGUIClick',matstruck.button[2],function()
			destroyElement(matstruck.window[1])
			showCursor(false)
			setElementData(lp,'ElementClicked',false)
		end,false)
	else
		infobox('Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!')
	end
end)