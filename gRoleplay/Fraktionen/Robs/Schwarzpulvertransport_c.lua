local swtPed = createPed(144,-2199.7998046875,-2339.7001953125,30.60000038147,54.0018310)

addEventHandler("onClientPedDamage",swtPed,function()
	cancelEvent()
end)


swt_create = {button = {},window = {},label = {}}

addEvent("schwarzpulverWindow",true)
addEventHandler("schwarzpulverWindow",root,function()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,"ElementClicked",true,true)
		
        swt_create.window[1] = guiCreateStaticImage(0.37, 0.01, 0.27, 0.24, "Images/Background.png", true)

        swt_create.label[1] = guiCreateLabel(0.03, 0.14, 0.94, 0.25, "Starte für 10.000$ einen Schwarzpulvertransport. Bei der Abgabe erhälst du Schwarzpulver, welches zum herstellen von Bomben benötigt wird.", true, swt_create.window[1])
        guiSetFont(swt_create.label[1], "clear-normal")
        guiLabelSetHorizontalAlign(swt_create.label[1], "left", true)
        swt_create.button[1] = guiCreateButton(0.21, 0.44, 0.58, 0.16, "Schwarzpulvertransport beladen", true, swt_create.window[1])
        guiSetProperty(swt_create.button[1], "NormalTextColour", "FFAAAAAA")
        swt_create.button[2] = guiCreateButton(0.21, 0.65, 0.58, 0.16, "Bombe herstellen", true, swt_create.window[1])
        guiSetProperty(swt_create.button[2], "NormalTextColour", "FFAAAAAA")
        swt_create.button[3] = guiCreateButton(0.03, 0.82, 0.06, 0.13, "[X]", true, swt_create.window[1])
        guiSetProperty(swt_create.button[3], "NormalTextColour", "FFAAAAAA")
		
		addEventHandler("onClientGUIClick",swt_create.button[1],function()
			triggerServerEvent("pulverstart",getLocalPlayer(),getLocalPlayer())
			showCursor(false)
			setElementData(lp,"ElementClicked",false)
			destroyElement(swt_create.window[1])
		end,false)
		
		addEventHandler("onClientGUIClick",swt_create.button[2],function()
			triggerServerEvent("createbombe",getLocalPlayer(),getLocalPlayer())
			showCursor(false)
			setElementData(lp,"ElementClicked",false)
			destroyElement(swt_create.window[1])
		end,false)
		
		addEventHandler("onClientGUIClick",swt_create.button[3],function()
			showCursor(false)
			setElementData(lp,"ElementClicked",false)
			GermanRoleplayWindowOpen = false
			destroyElement(swt_create.window[1])
		end,false)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)