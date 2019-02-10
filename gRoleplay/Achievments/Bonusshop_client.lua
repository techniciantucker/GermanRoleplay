levelshop_create = {gridlist = {},window = {},button = {}}

addCommandHandler("levelshop",function()
	if(getElementData(lp,"ElementClicked")==false)then
		if getElementData(lp,"level") > 4 then
			setElementData(lp,"ElementClicked",true,true)
			showCursor(true)
		
			levelshop_create.window[1] = guiCreateStaticImage(0.37, 0.01, 0.26, 0.50, "Images/Background.png", true)

			levelshop_create.gridlist[1] = guiCreateGridList(0.03, 0.06, 0.95, 0.77, true, levelshop_create.window[1])
			guiGridListAddColumn(levelshop_create.gridlist[1], "Artikel", 0.4)
			guiGridListAddColumn(levelshop_create.gridlist[1], "Preis", 0.3)
			guiGridListAddColumn(levelshop_create.gridlist[1], "Laufzeit", 0.3)
			for i = 1, 10 do
				guiGridListAddRow(levelshop_create.gridlist[1])
			end
			guiGridListSetItemText(levelshop_create.gridlist[1], 0, 1, "Weste", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 0, 2, "50 EXP", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 0, 3, "Einmalig", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 1, 1, "Leben", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 1, 2, "50 EXP", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 1, 3, "Einmalig", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 2, 1, "M4", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 2, 2, "250 EXP", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 2, 3, "Einmalig", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 3, 1, "Deagle", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 3, 2, "250 EXP", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 3, 3, "Einmalig", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 4, 1, "Mp5", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 4, 2, "250 EXP", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 4, 3, "Einmalig", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 5, 1, "Rifle", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 5, 2, "250 EXP", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 5, 3, "Einmalig", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 6, 1, "Fahrzeugslots", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 6, 2, "25000 EXP", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 6, 3, "Permanent", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 7, 1, "Knastzeit(-2 Min)", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 7, 2, "500 EXP", false, false)
			guiGridListSetItemText(levelshop_create.gridlist[1], 7, 3, "Einmalig", false, false)
			levelshop_create.button[1] = guiCreateButton(0.03, 0.88, 0.34, 0.07, "Kaufen", true, levelshop_create.window[1])
			guiSetProperty(levelshop_create.button[1], "NormalTextColour", "FFAAAAAA")
			levelshop_create.button[2] = guiCreateButton(0.63, 0.88, 0.34, 0.07, "Schließen", true, levelshop_create.window[1])
			guiSetProperty(levelshop_create.button[2], "NormalTextColour", "FFAAAAAA")    
			
			-- Kaufen
			addEventHandler("onClientGUIClick",levelshop_create.button[1],function()
				selectedText = guiGridListGetItemText ( levelshop_create.gridlist[1],  guiGridListGetSelectedItem ( levelshop_create.gridlist[1] ),1 )
				
				if selectedText == "Weste" then
					triggerServerEvent("weste",getLocalPlayer(),getLocalPlayer())
				elseif selectedText == "Leben" then
					triggerServerEvent("leben",getLocalPlayer(),getLocalPlayer())
				elseif selectedText == "M4" then
					triggerServerEvent("m4",getLocalPlayer(),getLocalPlayer())
				elseif selectedText == "Deagle" then
					triggerServerEvent("deagle",getLocalPlayer(),getLocalPlayer())
				elseif selectedText == "Mp5" then
					triggerServerEvent("mp5",getLocalPlayer(),getLocalPlayer())
				elseif selectedText == "Rifle" then
					triggerServerEvent("rifle",getLocalPlayer(),getLocalPlayer())
				elseif selectedText == "Fahrzeugslots" then
					triggerServerEvent("fahrzeugslots",getLocalPlayer(),getLocalPlayer())
				elseif selectedText == "Knastzeit(-2 Min)" then
					triggerServerEvent("knastzeit",getLocalPlayer(),getLocalPlayer())
				else
					infobox("Es wurde kein Artikel ausgewählt!")
				end
			end,false)
			
			-- Schließen
			addEventHandler("onClientGUIClick",levelshop_create.button[2],function()
				destroyElement(levelshop_create.window[1])
				setElementData(lp,"ElementClicked",false)
				showCursor(false)
			end,false)
		else
			infobox("Hierfür benötigst du Level 5 oder höher!")
		end
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)