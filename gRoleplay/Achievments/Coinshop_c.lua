----- Peds -----
setTimer(function()
	local coinshopPed1=createPed(127,278.5,-231.80000305176,1.6000000238419,180)
	addEventHandler('onClientPedDamage',coinshopPed1,noCoinshoppedsDamage)
end,5000,1)

function noCoinshoppedsDamage()
	cancelEvent()
end

----- Fenster -----

local Coinshop = {gridlist = {},window = {},button = {}}

addEvent('coinshopWindow',true)
addEventHandler('coinshopWindow',root,function()
	if(getElementData(lp,'ElementClicked')==false)then
		setElementData(lp,'ElementClicked',true)
		showCursor(true)
	
        Coinshop.window[1] = guiCreateStaticImage(0.38, 0.01, 0.23, 0.39, "Images/Background.png", true)

        Coinshop.gridlist[1] = guiCreateGridList(0.03, 0.07, 0.94, 0.65, true, Coinshop.window[1])
        guiGridListAddColumn(Coinshop.gridlist[1], "Fahrzeug", 0.5)
        guiGridListAddColumn(Coinshop.gridlist[1], "Preis", 0.5)
        for i = 1, 6 do
            guiGridListAddRow(Coinshop.gridlist[1])
        end
        guiGridListSetItemText(Coinshop.gridlist[1], 0, 1, "Broadway", false, false)
        guiGridListSetItemText(Coinshop.gridlist[1], 0, 2, "50", false, false)
        guiGridListSetItemText(Coinshop.gridlist[1], 1, 1, "Mesa", false, false)
        guiGridListSetItemText(Coinshop.gridlist[1], 1, 2, "50", false, false)
        guiGridListSetItemText(Coinshop.gridlist[1], 2, 1, "Picador", false, false)
        guiGridListSetItemText(Coinshop.gridlist[1], 2, 2, "50", false, false)
        guiGridListSetItemText(Coinshop.gridlist[1], 3, 1, "Hustler", false, false)
        guiGridListSetItemText(Coinshop.gridlist[1], 3, 2, "75", false, false)
        guiGridListSetItemText(Coinshop.gridlist[1], 4, 1, "Sandking", false, false)
        guiGridListSetItemText(Coinshop.gridlist[1], 4, 2, "100", false, false)
        guiGridListSetItemText(Coinshop.gridlist[1], 5, 1, "Patriot", false, false)
        guiGridListSetItemText(Coinshop.gridlist[1], 5, 2, "150", false, false)
        Coinshop.button[1] = guiCreateButton(0.24, 0.75, 0.52, 0.08, "Kaufen", true, Coinshop.window[1])
        guiSetProperty(Coinshop.button[1], "NormalTextColour", "FFAAAAAA")
        Coinshop.button[2] = guiCreateButton(0.24, 0.86, 0.52, 0.08, "Schließen", true, Coinshop.window[1])
        guiSetProperty(Coinshop.button[2], "NormalTextColour", "FFAAAAAA")
		
		addEventHandler('onClientGUIClick',Coinshop.button[1],function()
			selectedText = guiGridListGetItemText(Coinshop.gridlist[1],guiGridListGetSelectedItem(Coinshop.gridlist[1]),1)
			
			if(selectedText=='Broadway')then
				triggerServerEvent('broadway',getLocalPlayer(),getLocalPlayer())
				destroyElement(Coinshop.window[1])
				showCursor(false)
				setElementData(lp,'ElementClicked',false)
			elseif(selectedText=='Mesa')then
				triggerServerEvent('mesa',getLocalPlayer(),getLocalPlayer())
				destroyElement(Coinshop.window[1])
				showCursor(false)
				setElementData(lp,'ElementClicked',false)
			elseif(selectedText=='Picador')then
				triggerServerEvent('picador',getLocalPlayer(),getLocalPlayer())
				destroyElement(Coinshop.window[1])
				showCursor(false)
				setElementData(lp,'ElementClicked',false)
			elseif(selectedText=='Hustler')then
				triggerServerEvent('hustler',getLocalPlayer(),getLocalPlayer())
				destroyElement(Coinshop.window[1])
				showCursor(false)
				setElementData(lp,'ElementClicked',false)
			elseif(selectedText=='Sandking')then
				triggerServerEvent('sandking',getLocalPlayer(),getLocalPlayer())
				destroyElement(Coinshop.window[1])
				showCursor(false)
				setElementData(lp,'ElementClicked',false)
			elseif(selectedText=='Patriot')then
				triggerServerEvent('patriot',getLocalPlayer(),getLocalPlayer())
				destroyElement(Coinshop.window[1])
				showCursor(false)
				setElementData(lp,'ElementClicked',false)
			else
				infobox('Kein Fahrzeug ausgewählt!')
			end
		end,false)
		
		addEventHandler('onClientGUIClick',Coinshop.button[2],function()
			destroyElement(Coinshop.window[1])
			showCursor(false)
			setElementData(lp,'ElementClicked',false)
		end,false)
	else
		infobox('Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!')
    end
end)