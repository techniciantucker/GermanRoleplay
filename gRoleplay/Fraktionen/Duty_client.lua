create_duty_system = {button = {},window = {}}

addEvent("openDuty",true)
addEventHandler("openDuty",getRootElement(),function()
	if(getElementData(lp,"ElementClicked")==false)then
		setElementData(lp,"ElementClicked",true,true)
		
		-- Fenster
        create_duty_system.window[1] = guiCreateStaticImage(0.36, 0.01, 0.27, 0.22, "Images/Background.png", true)
		
		DutyLabel = guiCreateLabel(0.03, 0.15, 0.95, 0.09, "Willkommen im Duty Menü! Wähle deinen Dienst.", true, create_duty_system.window[1])
        guiSetFont(DutyLabel, "clear-normal")

		-- Start Fenster
		if getElementData(lp,"fraktion") == 1 or getElementData(lp,"fraktion") == 6 or getElementData(lp,"fraktion") == 8 or getElementData(lp,"fraktion") == 10 then
			if getElementData(lp,"onDuty") == false then
				create_duty_system.button[1] = guiCreateButton(0.29, 0.32, 0.41, 0.17, "Dienst beginnen", true, create_duty_system.window[1])
				guiSetFont(create_duty_system.button[1], "clear-normal")
				guiSetProperty(create_duty_system.button[1], "NormalTextColour", "FFAAAAAA")
				
				addEventHandler("onClientGUIClick",create_duty_system.button[1],function()
					destroyElement(create_duty_system.window[1])
					create_duty_swat()
				end,false)
			else
				create_duty_system.button[7] = guiCreateButton(0.29, 0.32, 0.41, 0.17, "Rearmen", true, create_duty_system.window[1])
				guiSetFont(create_duty_system.button[7], "clear-normal")
				guiSetProperty(create_duty_system.button[7], "NormalTextColour", "FFAAAAAA")
				
				addEventHandler("onClientGUIClick",create_duty_system.button[7],function()
					triggerServerEvent("rearm",getLocalPlayer(),getLocalPlayer())
				end,false)
				
				if getElementData(lp,"fraktion") == 10 then
					guiSetEnabled(create_duty_system.button[7],false)
				else
					guiSetEnabled(create_duty_system.button[7],true)
				end
			end
		end
		
		-- Schließen & Dienst beenden
        create_duty_system.button[2] = guiCreateButton(0.29, 0.78, 0.41, 0.17, "Schließen", true, create_duty_system.window[1])
        guiSetFont(create_duty_system.button[2], "clear-normal")
        guiSetProperty(create_duty_system.button[2], "NormalTextColour", "FFAAAAAA")
		
        create_duty_system.button[3] = guiCreateButton(0.29, 0.55, 0.41, 0.17, "Dienst beenden", true, create_duty_system.window[1])
        guiSetFont(create_duty_system.button[3], "clear-normal")
        guiSetProperty(create_duty_system.button[3], "NormalTextColour", "FFAAAAAA")
		
		if getElementData(lp,"onDuty") == false then
			guiSetEnabled(create_duty_system.button[3],false)
		else
			guiSetEnabled(create_duty_system.button[3],true)
		end
		
		showCursor(true)
		
		addEventHandler("onClientGUIClick",create_duty_system.button[2],function()
			destroyElement(create_duty_system.window[1])
			showCursor(false)
			setElementData(lp,"ElementClicked",false)
		end,false)
		
		addEventHandler("onClientGUIClick",create_duty_system.button[3],function()
			triggerServerEvent("offduty",getLocalPlayer(),getLocalPlayer())
			destroyElement(create_duty_system.window[1])
			showCursor(false)
			setElementData(lp,"ElementClicked",false)
		end,false)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)

function create_duty_swat()
	create_duty_system.window[2] = guiCreateStaticImage(0.36, 0.01, 0.27, 0.22, "Images/Background.png", true)
	
	DutyLabel = guiCreateLabel(0.03, 0.15, 0.95, 0.09, "Willkommen im Duty Menü! Wähle deinen Dienst.", true, create_duty_system.window[2])
    guiSetFont(DutyLabel, "clear-normal")
	
	create_duty_system.button[4] = guiCreateButton(0.29, 0.32, 0.41, 0.17, "Normaler Dienst", true, create_duty_system.window[2])
	guiSetFont(create_duty_system.button[4], "clear-normal")
	guiSetProperty(create_duty_system.button[4], "NormalTextColour", "FFAAAAAA")

	create_duty_system.button[5] = guiCreateButton(0.29, 0.55, 0.41, 0.17, "Swat Dienst", true, create_duty_system.window[2])
	guiSetFont(create_duty_system.button[5], "clear-normal")
	guiSetProperty(create_duty_system.button[5], "NormalTextColour", "FFAAAAAA")
	
    create_duty_system.button[6] = guiCreateButton(0.29, 0.78, 0.41, 0.17, "Schließen", true, create_duty_system.window[2])
    guiSetFont(create_duty_system.button[6], "clear-normal")
    guiSetProperty(create_duty_system.button[6], "NormalTextColour", "FFAAAAAA")
	
	if getElementData(lp,"fraktion") == 1 or getElementData(lp,"fraktion") == 6 then
		if getElementData(lp,"rang") > 2 then
			guiSetEnabled(create_duty_system.button[5],true)
		else
			guiSetEnabled(create_duty_system.button[5],false)
		end
	elseif getElementData(lp,"fraktion") == 8 or getElementData(lp,"fraktion") == 10 then
		guiSetEnabled(create_duty_system.button[5],false)
	end
	
	addEventHandler("onClientGUIClick",create_duty_system.button[4],function()
		triggerServerEvent("duty",getLocalPlayer(),getLocalPlayer())
		destroyElement(create_duty_system.window[2])
		showCursor(false)
		setElementData(lp,"ElementClicked",false)
	end,false)
	
	addEventHandler("onClientGUIClick",create_duty_system.button[5],function()
		triggerServerEvent("swat",getLocalPlayer(),getLocalPlayer())
		destroyElement(create_duty_system.window[2])
		showCursor(false)
		setElementData(lp,"ElementClicked",false)
	end,false)
	
	addEventHandler("onClientGUIClick",create_duty_system.button[6],function()
		destroyElement(create_duty_system.window[2])
		showCursor(false)
		setElementData(lp,"ElementClicked",false)
	end,false)
end