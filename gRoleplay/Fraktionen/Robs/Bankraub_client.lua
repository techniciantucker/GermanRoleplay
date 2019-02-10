local active = false

addEvent("startBR",true)
addEventHandler("startBR",root,function()
	if active == false then
		addEventHandler("onClientRender",getRootElement(),internRender)
		active = true
		time = 300
		setTimer(function()
			time = time - 1
			if time < 1 then
				active = false
				time = 300
				removeEventHandler("onClientRender",getRootElement(),internRender)
			end
		end,1000,300)
	end
end)

addEvent("stopBR",true)
addEventHandler("stopBR",root,function()
	active = false
	time = 300
	removeEventHandler("onClientRender",getRootElement(),internRender)
end)

local sx,sy = 1440,900

function internRender()
	dxDrawText("Die Bank wird ausgeraubt!\nNoch: "..time.." Sekunden!",0,10,sx,75,tocolor(0,255,0,255),1,"bankgothic","center","center",false,false,true)
end

-- Konto beantragen

kontoanlegen = {button = {},window = {},label = {}}

addEvent("konto",true)
addEventHandler("konto",root,function()
	if(getElementData(lp,'ElementClicked')==false)then
		GermanRoleplayWindowOpen = true
		setElementData(lp,"ElementClicked",true,true)
		showCursor(true)
	
        kontoanlegen.window[1] = guiCreateStaticImage(0.31, 0.01, 0.38, 0.23, "Images/Background.png", true)

        kontoanlegen.label[1] = guiCreateLabel(0.02, 0.13, 0.95, 0.40, "Willkommen an der Bankverwaltung der Los Santos Bank.\nSolltest du noch kein Konto beantragt haben, solltest du dies nun nachholen, da du dein Geld sonst nicht verwalten kannst, und somit auch keine Zinsen erhälst. Das Beantragen eines Kontos sowie das Verwalten deines Geldes ist für dich völlig kostenlos.", true, kontoanlegen.window[1])
        guiLabelSetHorizontalAlign(kontoanlegen.label[1], "left", true)
        kontoanlegen.button[1] = guiCreateButton(0.02, 0.59, 0.36, 0.15, "Konto beantragen", true, kontoanlegen.window[1])
        guiSetProperty(kontoanlegen.button[1], "NormalTextColour", "FFAAAAAA")
        kontoanlegen.button[2] = guiCreateButton(0.61, 0.59, 0.36, 0.15, "Fenster schließen", true, kontoanlegen.window[1])
        guiSetProperty(kontoanlegen.button[2], "NormalTextColour", "FFAAAAAA")
        kontoanlegen.button[3] = guiCreateButton(0.02, 0.79, 0.36, 0.15, "Konto kündigen", true, kontoanlegen.window[1])
        guiSetProperty(kontoanlegen.button[3], "NormalTextColour", "FFAAAAAA")
        kontoanlegen.button[4] = guiCreateButton(0.61, 0.79, 0.36, 0.15, "Nach deinem Pin fragen", true, kontoanlegen.window[1])
        guiSetProperty(kontoanlegen.button[4], "NormalTextColour", "FFAAAAAA")  
		
		addEventHandler("onClientGUIClick",kontoanlegen.button[1],function()
			triggerServerEvent("kontobeantragen",getLocalPlayer(),getLocalPlayer())
		end,false)
		
		addEventHandler("onClientGUIClick",kontoanlegen.button[2],function()
			GermanRoleplayWindowOpen = false
			destroyElement(kontoanlegen.window[1])
			showCursor(false)
			setElementData(lp,"ElementClicked",false)
		end,false)
		
		addEventHandler("onClientGUIClick",kontoanlegen.button[3],function()
			triggerServerEvent("kontoclose",getLocalPlayer(),getLocalPlayer())
		end,false)
		
		addEventHandler("onClientGUIClick",kontoanlegen.button[4],function()
			local yourpin = getElementData(lp,"bankpin")
			
			if yourpin == 0 then
				outputChatBox("Bankangesteller: Sie haben noch kein Konto!",255,255,255)
			else
				outputChatBox("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
				outputChatBox("Dein Pin lautet wie folgt: "..yourpin,0,255,0)
				outputChatBox("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
			end
		end,false)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)