local Werbung     = {button = {},window = {},label = {},edit = {}}
local ad 		  = 2
local grund 	  = 4

addEvent("openWerbung",true)
addEventHandler("openWerbung",root,function(text)
	if(getElementData(lp,'ElementClicked')==false)then
		setElementData(lp,'ElementClicked',true)
		showCursor(true)
	
        Werbung.window[1] = guiCreateStaticImage(0.35, 0.01, 0.30, 0.22, "Images/Background.png", true)

        Werbung.edit[1] = guiCreateEdit(0.02, 0.57, 0.96, 0.18, "", true, Werbung.window[1])
        Werbung.label[1] = guiCreateLabel(0.02, 0.14, 0.95, 0.35, "Hier kannst du eine Werbung schalten. Tippe den gewünschten Text in das untere Feld und klicke anschließend auf 'Absenden'. Kosten: 2$ pro Buchstabe + 4$ Bearbeitungskosten.", true, Werbung.window[1])
        guiSetFont(Werbung.label[1], "default-bold-small")
        guiLabelSetHorizontalAlign(Werbung.label[1], "center", true)
        guiLabelSetVerticalAlign(Werbung.label[1], "center")
        Werbung.button[1] = guiCreateButton(0.02, 0.81, 0.25, 0.14, "Absenden", true, Werbung.window[1])
        Werbung.button[2] = guiCreateButton(0.29, 0.81, 0.25, 0.14, "Schließen", true, Werbung.window[1])
		
		addEventHandler("onClientGUIClick",Werbung.button[1],function()
			local text=guiGetText(Werbung.edit[1])
			local lenght=#text
			
			if(not(text==""))then
				if(#text>=10)and(#text<=70)then
					local cash=#text*ad+grund
				
					if(getElementData(getLocalPlayer(),"money")>=cash)then
						triggerServerEvent("werbung",getLocalPlayer(),text,cash)
					else
						infobox("Du hast nicht genug Geld! ("..cash.."$)")
					end
				else
					infobox("Mindestens 10 und\nmaximal 70 Zeichen!")
				end
			else
				infobox("Keine Werbung eingetragen!")
			end
		end,false)
		addEventHandler("onClientGUIClick",Werbung.button[2],function()
			destroyElement(Werbung.window[1])
			showCursor(false)
			setElementData(lp,'ElementClicked',false)
		end,false)
	else
		infobox('Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!')
    end
end)