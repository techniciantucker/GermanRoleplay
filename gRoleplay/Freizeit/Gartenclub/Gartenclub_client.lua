function showGardenCenterMenue_func ()

	if(getElementData(lp,"ElementClicked")==false)then

		if gWindow["gardenclub"] then
			if isElement ( gWindow["gardenclub"] ) then
				destroyElement ( gWindow["gardenclub"] )
			end
		end
		showCursor ( true )
		setElementData ( lp, "ElementClicked", true )

		gWindow["gardenclub"] = guiCreateStaticImage(0.32, 0.01, 0.35, 0.36, "Images/Background.png", true) 
		
		gGrid["gardenclub"] = guiCreateGridList(0.02, 0.09, 0.45, 0.88, true,gWindow["gardenclub"])
		guiGridListSetSelectionMode(gGrid["gardenclub"],0)
		
        GartenclubInfo = guiCreateLabel(0.49, 0.09, 0.50, 0.18, "Hier im Gartenclub kannst du Hanfsamen erwerben, und dein daraus gewachsenes Gras verkaufen.", true, gWindow["gardenclub"])
        guiSetFont(GartenclubInfo, "clear-normal")
        guiLabelSetHorizontalAlign(GartenclubInfo, "left", true)
		
        GartenclubGramm = guiCreateLabel(0.48, 0.32, 0.10, 0.06, "Gramm:", true, gWindow["gardenclub"])
        guiSetFont(GartenclubGramm, "clear-normal")
        guiLabelSetHorizontalAlign(GartenclubGramm, "left", true)

		gColumn["gardenclubObject"] = guiGridListAddColumn(gGrid["gardenclub"],"Objekt",0.55)
		gColumn["gardenclubPrice"] = guiGridListAddColumn(gGrid["gardenclub"],"Preis",0.25)

		gButton["gardenclubBuy"] = guiCreateButton(0.55, 0.57, 0.37, 0.10, "Kaufen", true,gWindow["gardenclub"])
		gButton["gardenclubClose"] = guiCreateButton(0.55, 0.70, 0.37, 0.10, "Schließen", true,gWindow["gardenclub"])
		gButton["gardenclubSell"] = guiCreateButton(0.55, 0.44, 0.37, 0.10, "Verkaufen", true,gWindow["gardenclub"])

		addEventHandler ( "onClientGUIClick", gButton["gardenclubClose"],function ()
			showCursor ( false )
			setElementData ( lp, "ElementClicked", false )
			destroyElement ( gWindow["gardenclub"] )
		end,false )

		addEventHandler ( "onClientGUIClick", gButton["gardenclubSell"],function ()
			triggerServerEvent ( "drugsSellHobby", lp, tonumber ( guiGetText ( gNumberField["drugCount"] ) ) )
			guiSetText ( gNumberField["drugCount"], 0 )
		end,false )
		
		addEventHandler("onClientGUIClick",gButton["gardenclubBuy"],function()
			local row, column = guiGridListGetSelectedItem ( gGrid["gardenclub"] )
			local value = guiGridListGetItemText ( gGrid["gardenclub"], row, gColumn["gardenclubObject"] )
			
			if value == "Hanfsamen" then
				triggerServerEvent("BuyFlowersServer",lp)
			end
		end,false)

		local row = guiGridListAddRow ( gGrid["gardenclub"] )
		guiGridListSetItemText ( gGrid["gardenclub"], row, gColumn["gardenclubObject"], "Hanfsamen", false, false )
		guiGridListSetItemText ( gGrid["gardenclub"], row, gColumn["gardenclubPrice"], "100 $", false, false )

		gNumberField["drugCount"] = guiCreateEdit(0.58, 0.30, 0.30, 0.10, "", true, gWindow["gardenclub"], true, true )
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end
addEvent ( "showGardenCenterMenue", true )
addEventHandler ( "showGardenCenterMenue", getRootElement(), showGardenCenterMenue_func )

function closeGardenClubWindow ()

	showCursor ( false )
	setElementData ( lp, "ElementClicked", false )
	destroyElement ( gWindow["gardenclub"] )
end

-- // Pickup
gartenvereinPickup = createPickup ( 416.60000610352, 2538.5, 10, 3, 1239, 50, 0 )
setElementInterior (gartenvereinPickup, 10)

addEventHandler("onClientPickupHit",gartenvereinPickup,function(hit)
	if hit == lp then
		showGardenCenterMenue_func()
	end
end)