Ammunation = {button = {},window = {},staticimage = {},label = {}}

function AmmuWindow()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,'ElementClicked',true)
	
        Ammunation.window[1] = guiCreateStaticImage(0.32, 0.01, 0.34, 0.41, "Images/Background.png", true)

        Ammunation.label[1] = guiCreateLabel(0.02, 0.07, 0.96, 0.15, "Willkommen an einer von vielen Waffenläden in ganz San Andreas. Hier kannst du dir, je nachdem welche Waffenscheine du besitzt, Waffen kaufen.", true, Ammunation.window[1])
        guiSetFont(Ammunation.label[1], "default-bold-small")
        guiLabelSetHorizontalAlign(Ammunation.label[1], "center", true)
        guiLabelSetVerticalAlign(Ammunation.label[1], "center")
        Ammunation.label[2] = guiCreateLabel(0.02, 0.26, 0.96, 0.04, "----------------------------------- Waffen der Klasse A -----------------------------------", true, Ammunation.window[1])
        guiSetFont(Ammunation.label[2], "default-bold-small")
        guiLabelSetHorizontalAlign(Ammunation.label[2], "center", true)
        guiLabelSetVerticalAlign(Ammunation.label[2], "center")
        Ammunation.button[1] = guiCreateButton(0.02, 0.32, 0.39, 0.08, "Deagle | 21 Schuss | 150$", true, Ammunation.window[1])
        Ammunation.button[2] = guiCreateButton(0.59, 0.33, 0.39, 0.08, "Colt | 34 Schuss | 75$", true, Ammunation.window[1])
        Ammunation.button[3] = guiCreateButton(0.02, 0.43, 0.39, 0.08, "Shotgun | 10 Schuss | 240$", true, Ammunation.window[1])
        --Ammunation.button[4] = guiCreateButton(0.59, 0.43, 0.39, 0.08, "Colt | 34 Schuss | 75$", true, Ammunation.window[1])
        Ammunation.label[3] = guiCreateLabel(0.02, 0.53, 0.96, 0.04, "------------------------------------ Waffen der Klasse B ---------------------------------", true, Ammunation.window[1])
        guiSetFont(Ammunation.label[3], "default-bold-small")
        guiLabelSetHorizontalAlign(Ammunation.label[3], "center", true)
        guiLabelSetVerticalAlign(Ammunation.label[3], "center")
        Ammunation.button[5] = guiCreateButton(0.02, 0.60, 0.39, 0.08, "Sawn-Off | 16 Schuss | 230$", true, Ammunation.window[1])
        Ammunation.button[6] = guiCreateButton(0.59, 0.60, 0.39, 0.08, "Combat | 16 Schuss | 250$", true, Ammunation.window[1])
        Ammunation.button[7] = guiCreateButton(0.02, 0.70, 0.39, 0.08, "Mp5 | 120 Schuss | 1125$", true, Ammunation.window[1])
        Ammunation.button[8] = guiCreateButton(0.59, 0.70, 0.39, 0.08, "M4 | 200 Schuss | 1250$", true, Ammunation.window[1])
        Ammunation.label[4] = guiCreateLabel(0.02, 0.80, 0.96, 0.04, "------------------------------------ Waffen der Klasse C ---------------------------------", true, Ammunation.window[1])
        guiSetFont(Ammunation.label[4], "default-bold-small")
        guiLabelSetHorizontalAlign(Ammunation.label[4], "center", true)
        guiLabelSetVerticalAlign(Ammunation.label[4], "center")
        Ammunation.button[9] = guiCreateButton(0.02, 0.87, 0.39, 0.08, "Rifle | 15 Schuss | 1350$", true, Ammunation.window[1])
		
		addEventHandler('onClientGUIClick',Ammunation.button[1],function()
			triggerServerEvent('ammuDeagle',getLocalPlayer(),getLocalPlayer())
		end,false)
		addEventHandler('onClientGUIClick',Ammunation.button[2],function()
			triggerServerEvent('ammuColt',getLocalPlayer(),getLocalPlayer())
		end,false)
		addEventHandler('onClientGUIClick',Ammunation.button[3],function()
			triggerServerEvent('ammuShotgun',getLocalPlayer(),getLocalPlayer())
		end,false)
		addEventHandler('onClientGUIClick',Ammunation.button[5],function()
			triggerServerEvent('ammuSawnoff',getLocalPlayer(),getLocalPlayer())
		end,false)
		addEventHandler('onClientGUIClick',Ammunation.button[6],function()
			triggerServerEvent('ammuCombat',getLocalPlayer(),getLocalPlayer())
		end,false)
		addEventHandler('onClientGUIClick',Ammunation.button[7],function()
			triggerServerEvent('ammuMp5',getLocalPlayer(),getLocalPlayer())
		end,false)
		addEventHandler('onClientGUIClick',Ammunation.button[8],function()
			triggerServerEvent('ammuM4',getLocalPlayer(),getLocalPlayer())
		end,false)
		addEventHandler('onClientGUIClick',Ammunation.button[9],function()
			triggerServerEvent('ammuRifle',getLocalPlayer(),getLocalPlayer())
		end,false)
		
		if(getElementData(lp,'gunlicenseB')==0)then
			guiSetEnabled(Ammunation.button[5],false)
			guiSetEnabled(Ammunation.button[6],false)
			guiSetEnabled(Ammunation.button[7],false)
			guiSetEnabled(Ammunation.button[8],false)
		else
			guiSetEnabled(Ammunation.button[5],true)
			guiSetEnabled(Ammunation.button[6],true)
			guiSetEnabled(Ammunation.button[7],true)
			guiSetEnabled(Ammunation.button[8],true)
		end
		
		if(getElementData(lp,'gunlicenseC')==0)then
			guiSetEnabled(Ammunation.button[9],false)
		else
			guiSetEnabled(Ammunation.button[9],true)
		end

        Ammunation.window[2] = guiCreateStaticImage(0.32, 0.43, 0.34, 0.13, "Images/Background.png", true)

        Ammunation.button[10] = guiCreateButton(0.02, 0.66, 0.41, 0.25, "Schutzweste | 30$", true, Ammunation.window[2])
        Ammunation.button[11] = guiCreateButton(0.02, 0.29, 0.41, 0.27, "Messer | 10$", true, Ammunation.window[2])
        Ammunation.button[12] = guiCreateButton(0.57, 0.29, 0.41, 0.27, "Schließen", true, Ammunation.window[2])
		
		addEventHandler('onClientGUIClick',Ammunation.button[10],function()
			triggerServerEvent('ammuWeste',getLocalPlayer(),getLocalPlayer())
		end,false)
		addEventHandler('onClientGUIClick',Ammunation.button[11],function()
			triggerServerEvent('ammuMesser',getLocalPlayer(),getLocalPlayer())
		end,false)
		
		addEventHandler('onClientGUIClick',Ammunation.button[12],function()
			destroyElement(Ammunation.window[1])
			destroyElement(Ammunation.window[2])
			showCursor(false)
			setElementData(lp,'ElementClicked',false)
		end,false)
	else
		infobox('Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!')
	end
end

addEvent("ammunationMarkerHit", true)
addEventHandler("ammunationMarkerHit", getRootElement(), function()
	AmmuWindow()
end)