itemShopItems = {
 ["Blumen"]=flowers_price,
 ["Kamera"]=cam_price,
 ["Kamera Film"]=camammo_price,
 ["Nachtsichtgeraet"]=nvgoogles_price,
 ["Infrarotsichtgeraet"]=tgoogles_price,
 ["Wuerfel"]=wuerfel_price,
 ["Rubbellos"]=rubbellos_price,
 ["Zigaretten"]=zigarett_price,
 
 ["Pizzadienst"]=5000
 }
 
itemShopIDs = {
 ["Blumen"]="flowers",
 ["Kamera"]="cam",
 ["Kamera Film"]="camammo",
 ["Nachtsichtgeraet"]="nv",
 ["Infrarotsichtgeraet"]="t",
 ["Wuerfel"]="dice",
 ["Rubbellos"]="los",
 ["Zigaretten"]="cig",
 ["50 $ Guthaben"]="sim-50",
 ["100 $ Guthaben"]="sim-100",
 ["250 $ Guthaben"]="sim-250",
 ["Pizzadienst"]="pizzadienst"
 }

function create24_7Shop_func ()
	if(getElementData(lp,'ElementClicked')==false)then
	
		showCursor ( true )
		if gWindow["24-7"] then
			guiSetVisible ( gWindow["24-7"], true )
		else
			setElementData ( lp, "ElementClicked", true, true )

			gWindow["24-7"] = guiCreateStaticImage(0.34, 0.01, 0.33, 0.46, "Images/Background.png", true)
			
			gGrid["24-7Items"] = guiCreateGridList(0.02, 0.07, 0.48, 0.90, true,gWindow["24-7"])
			guiGridListSetSelectionMode(gGrid["24-7Items"],0)
			gColumn["24-7Names"] = guiGridListAddColumn(gGrid["24-7Items"],"Artikel",0.6)
			gColumn["24-7Prices"] = guiGridListAddColumn(gGrid["24-7Items"],"Preis",0.2)
			
			local row
			for key, index in pairs ( itemShopItems ) do
				row = guiGridListAddRow ( gGrid["24-7Items"] )
				guiGridListSetItemText ( gGrid["24-7Items"], row, gColumn["24-7Names"], key, false, false )
				guiGridListSetItemText ( gGrid["24-7Items"], row, gColumn["24-7Prices"], tostring ( index ).." $", false, false )
			end
			row = guiGridListAddRow ( gGrid["24-7Items"] )
			
			row = guiGridListAddRow ( gGrid["24-7Items"] )
			guiGridListSetItemText ( gGrid["24-7Items"], row, gColumn["24-7Names"], "Handy", true, false )
			
			
			
			row = guiGridListAddRow ( gGrid["24-7Items"] )
			guiGridListSetItemText ( gGrid["24-7Items"], row, gColumn["24-7Names"], "50 $ Guthaben", false, false )
			guiGridListSetItemText ( gGrid["24-7Items"], row, gColumn["24-7Prices"], tostring ( prePaidPrices["low"] ).." $", false, false )
			
			row = guiGridListAddRow ( gGrid["24-7Items"] )
			guiGridListSetItemText ( gGrid["24-7Items"], row, gColumn["24-7Names"], "100 $ Guthaben", false, false )
			guiGridListSetItemText ( gGrid["24-7Items"], row, gColumn["24-7Prices"], tostring ( prePaidPrices["middle"] ).." $", false, false )
			
			row = guiGridListAddRow ( gGrid["24-7Items"] )
			guiGridListSetItemText ( gGrid["24-7Items"], row, gColumn["24-7Names"], "250 $ Guthaben", false, false )
			guiGridListSetItemText ( gGrid["24-7Items"], row, gColumn["24-7Prices"], tostring ( prePaidPrices["large"] ).." $", false, false )
			
			gRadio["vertrag"] = guiCreateRadioButton(0.55, 0.59, 0.42, 0.06, "Vertrag", true,gWindow["24-7"])
			guiSetFont(gRadio["vertrag"],"default-bold-small")
			gRadio["prepayed"] = guiCreateRadioButton(0.55, 0.68, 0.42, 0.06, "Prepayed", true,gWindow["24-7"])
			guiSetFont(gRadio["prepayed"],"default-bold-small")
			gRadio["flatrate"] = guiCreateRadioButton(0.55, 0.77, 0.42, 0.06, "Flatrate", true,gWindow["24-7"])
			guiRadioButtonSetSelected(gRadio["flatrate"],true)
			
			guiSetToolTip ( gRadio["flatrate"], "Test" )
			
			guiSetFont(gRadio["flatrate"],"default-bold-small")
			
			gButton["close24-7Window"] = guiCreateButton(0.55, 0.18, 0.43, 0.08, "Verlassen", true,gWindow["24-7"])
			guiSetFont(gButton["close24-7Window"],"default-bold-small")
			addEventHandler ( "onClientGUIClick", gButton["close24-7Window"],
				function ()
					showCursor ( false )
					guiSetVisible ( gWindow["24-7"], false )
					
					setElementData ( lp, "ElementClicked", false, true )
					
					GermanRoleplayWindowOpen = false
				end,
			false )
			gButton["buy24-7Item"] = guiCreateButton(0.55, 0.07, 0.43, 0.08, "Kaufen", true,gWindow["24-7"])
			guiSetFont(gButton["buy24-7Item"],"default-bold-small")
			addEventHandler ( "onClientGUIClick", gButton["buy24-7Item"],
				function ( btn, state )
					if state == "up" then
						local rowindex, columnindex = guiGridListGetSelectedItem ( gGrid["24-7Items"] )
						local text = guiGridListGetItemText ( gGrid["24-7Items"], rowindex, gColumn["24-7Names"] )

						triggerServerEvent ( "itemBuy", lp, lp, itemShopIDs[text] )
					end
				end,
			false )
			gButton["changeMobile24-7"] = guiCreateButton(0.55, 0.86, 0.43, 0.08, "Tarif wechseln", true,gWindow["24-7"])
			addEventHandler ( "onClientGUIClick", gButton["changeMobile24-7"],
				function ( btn, state )
					if state == "up" then
						local val
						if guiRadioButtonGetSelected(gRadio["flatrate"]) then
							val = 3
						elseif guiRadioButtonGetSelected(gRadio["prepayed"]) then
							val = 2
						elseif guiRadioButtonGetSelected(gRadio["vertrag"]) then
							val = 1
						end
						
						triggerServerEvent ( "changeTarif", lp, val )
					end
				end,
			false )
			guiSetFont(gButton["changeMobile24-7"],"default-bold-small")
		end
	else
		outputChatBox("[INFO]: Schließe zuerst dein jetziges Fenster, um ein neues öffnen zu können!",0,100,150)
	end
end
addEvent ( "create24_7Shop", true )
addEventHandler ( "create24_7Shop", getRootElement(), create24_7Shop_func )