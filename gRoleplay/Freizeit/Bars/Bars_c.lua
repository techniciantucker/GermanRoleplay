barPed1 = createPed(181,497.5,-77.599998474121,998.79998779297,0.00274658)
setElementInterior(barPed1,11)

function keinpeddamage()
	cancelEvent()
end
addEventHandler("onClientPedDamage",barPed1,keinpeddamage)

bar = {gridlist = {},window = {},button = {},label = {}}

addEvent("bar",true)
addEventHandler("bar",root,function()
	if(getElementData(lp,"ElementClicked")==false)then
		showCursor(true)
		setElementData(lp,"ElementClicked",true,true)
	
        bar.window[1] = guiCreateStaticImage(0.37, 0.01, 0.25, 0.51, "Images/Background.png", true)

        bar.label[1] = guiCreateLabel(0.03, 0.08, 0.94, 0.09, "Alkoholische Getränke geben dir Energie, und füllen dein Leben auf.", true, bar.window[1])
        guiSetFont(bar.label[1], "clear-normal")
        guiLabelSetHorizontalAlign(bar.label[1], "left", true)
        bar.gridlist[1] = guiCreateGridList(0.03, 0.18, 0.50, 0.79, true, bar.window[1])
        guiGridListAddColumn(bar.gridlist[1], "Getränk", 0.5)
        guiGridListAddColumn(bar.gridlist[1], "Preis", 0.5)
        for i = 1, 3 do
            guiGridListAddRow(bar.gridlist[1])
        end
        guiGridListSetItemText(bar.gridlist[1], 0, 1, "Bier", false, false)
        guiGridListSetItemText(bar.gridlist[1], 0, 2, "2$", false, false)
        guiGridListSetItemText(bar.gridlist[1], 1, 1, "Whiskey", false, false)
        guiGridListSetItemText(bar.gridlist[1], 1, 2, "5$", false, false)
        guiGridListSetItemText(bar.gridlist[1], 2, 1, "Wein", false, false)
        guiGridListSetItemText(bar.gridlist[1], 2, 2, "15$", false, false)
        bar.button[1] = guiCreateButton(0.54, 0.28, 0.43, 0.06, "Kaufen", true, bar.window[1])
        guiSetProperty(bar.button[1], "NormalTextColour", "FFAAAAAA")
        bar.button[2] = guiCreateButton(0.54, 0.37, 0.43, 0.06, "Schließen", true, bar.window[1])
        guiSetProperty(bar.button[2], "NormalTextColour", "FFAAAAAA")
		
		addEventHandler("onClientGUIClick",bar.button[1],function()
			selectedText = guiGridListGetItemText ( bar.gridlist[1],  guiGridListGetSelectedItem ( bar.gridlist[1] ),1 )
			
			if selectedText == "Bier" then
				triggerServerEvent("bier",getLocalPlayer(),getLocalPlayer())
			elseif selectedText == "Whiskey" then
				triggerServerEvent("whiskey",getLocalPlayer(),getLocalPlayer())
			elseif selectedText == "Wein" then
				triggerServerEvent("wein",getLocalPlayer(),getLocalPlayer())
			else
				infobox("Du hast kein Getränk ausgewählt!")
			end
		end,false)
		
		addEventHandler("onClientGUIClick",bar.button[2],function()
			showCursor(false)
			setElementData(lp,"ElementClicked",false)
			destroyElement(bar.window[1])
		end,false)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)