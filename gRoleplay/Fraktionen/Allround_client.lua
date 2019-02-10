GUIEditor = {button = {},window = {}}

addEvent("openumkleide",true)
addEventHandler("openumkleide",root,function()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,"ElementClicked",true,true)
	
        GUIEditor.window[1] = guiCreateStaticImage(0.40, 0.02, 0.21, 0.18, "Images/Background.png", true)

        GUIEditor.button[1] = guiCreateButton(0.12, 0.27, 0.77, 0.25, "Nächster Skin", true, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")
        GUIEditor.button[2] = guiCreateButton(0.12, 0.59, 0.77, 0.25, "Verlassen", true, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFAAAAAA")
		
		addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
			triggerServerEvent("nextumkleide",lp,lp)
		end,false)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
			triggerServerEvent("leaveumkleide",lp,lp)
			showCursor(false)
			setElementData(lp,"ElementClicked",false)
			destroyElement(GUIEditor.window[1])
		end,false)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)