local xxxShopMarker = createMarker ( -104.79, -10.79, 999.61, "cylinder", 1, 125, 0, 0, 150 )
setElementInterior ( xxxShopMarker, 3 )

function xxxShopMarker_hit ( player, dim )
	if(getElementData(lp,'ElementClicked')==false)then
	
		if player == lp and dim then
			showCursor ( true )
			setElementData ( lp, "ElementClicked", true )
			gWindow["sexShop"] = guiCreateStaticImage(0.40, 0.01, 0.21, 0.39, "Images/Background.png", true)
			gGrid["sexShop"] = guiCreateGridList(0.03, 0.08, 0.93, 0.55, true,gWindow["sexShop"])
			guiGridListSetSelectionMode(gGrid["sexShop"],0)
			gColumn["sexShopItem"] = guiGridListAddColumn(gGrid["sexShop"],"Item",0.6)
			gColumn["sexShopPrice"] = guiGridListAddColumn(gGrid["sexShop"],"Preis",0.2)
			guiSetAlpha(gGrid["sexShop"],1)
			gButton["sexShopBuy"] = guiCreateButton(0.26, 0.66, 0.47, 0.09, "Kaufen", true,gWindow["sexShop"])
			guiSetAlpha(gButton["sexShopBuy"],1)
			gButton["sexShopClose"] = guiCreateButton(0.26, 0.78, 0.47, 0.09, "Schließen", true,gWindow["sexShop"])
			guiSetAlpha(gButton["sexShopClose"],1)
			
			local row
			for key, index in pairs ( sexShopItems ) do
				row = guiGridListAddRow ( gGrid["sexShop"] )
				guiGridListSetItemText ( gGrid["sexShop"], row, gColumn["sexShopItem"], index, false, false )
				guiGridListSetItemText ( gGrid["sexShop"], row, gColumn["sexShopPrice"], sexShopItemPrices[key].." $", false, false )
			end
			
			addEventHandler ( "onClientGUIClick", gButton["sexShopBuy"],
				function ()
					local row, column = guiGridListGetSelectedItem ( gGrid["sexShop"] )
					local item = guiGridListGetItemText ( gGrid["sexShop"], row, gColumn["sexShopItem"] )
					if item then
						for key, index in pairs ( sexShopItems ) do
							if sexShopItems[key] == item then
								item = key
								hideSexShopGUI ()
								triggerServerEvent ( "xxxShopBuy", lp, item )
								
								GermanRoleplayWindowOpen = false
								break
							end
						end
					end
				end,
			false )
			addEventHandler ( "onClientGUIClick", gButton["sexShopClose"], hideSexShopGUI, false )
		end
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end
addEventHandler ( "onClientMarkerHit", xxxShopMarker, xxxShopMarker_hit )

function hideSexShopGUI ()

	destroyElement ( gWindow["sexShop"] )
	showCursor ( false )
	setElementData ( lp, "ElementClicked", false )
	GermanRoleplayWindowOpen = false
end