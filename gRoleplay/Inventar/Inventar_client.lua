validItems = { ["Zeitung"]=true, ["Kanister"]=true, ["Drogen"]=true, ["Materialien"]=true, ["Wuerfel"]=true, ["Zigaretten"]=true, ["Hanfsamen"]=true,["Arbeitsgenehmigung"]=true,["Personalausweis"]=true,["Pizzadienst"]=true,["Schwarzpulver"]=true,["Bombe"]=true,["Coins"]=true,["Gutschein"]=true,['Hotdog']=true,['Eis']=true,['Pokal']=true }

itemTexts = {
 ["Zeitung"]="Die Westside News hält dich mit täglichen Zeitungen auf dem neusten Stand.",
 ["Kanister"]="Mittels dem Befehl /fill kannst du deinen Benzinkanister benutzen und dein Auto mit ein wenig Benin füllen.",
 ["Drogen"]="Drogen kannst du an andere Spieler oder an den ´Gartenclub´ verkaufen.",
 ["Materialien"]="Materialien bilden den Grundstoff für Waffen, sie sind ebenso wie Drogen illegal.", 
 ["Wuerfel"]="Mit einem Würfel kannst eine Beliebige Zahl zwischen 1 und 6 erzeugen, wenn du /dice eingibst.", 
 ["Zigaretten"]="Zigaretten kannst du mit dem Befehl /smoke rauchen. Sie füllen ein Teil deines Lebens wieder auf. Pass aber auf, dass du nicht süchtig wirst!",
 ["Hanfsamen"]="Pflanze mittels dem Befehl /grow weed Drogen an.",
 ["Arbeitsgenehmigung"]="Die Arbeitsgenehmigung erlaubt dir das Ausführen von Jobs.",
 ["Personalausweis"]="Verschafft dir eine Identität!",
 ["Pizzadienst"]="Bestelle dir eine Pizza. Zu jeder Zeit, egal wo du bist!",
 ["Schwarzpulver"]="Wird benötigt, um eine Bombe herzustellen...",
 ["Bombe"]="Lege eine Bombe...",
 ["Coins"]="Mit Coins kannst du dir tolle Premien kaufen.",
 ["Gutschein"]="Ermöglicht dir ein kostenlos Fahrzeug!",
 ['Hotdog']='Können als Hotdog-Verkäufer verkauft werden.',
 ['Eis']='Können als Eismann verkauft werden.',
 ['Pokal']='Erhälst du beim sammeln von Erfolgen, verschaffen dir einen Paydaybonus.'
 }

itemNames = { 
 ["Zeitung"]="Zeitung",
 ["Kanister"]="Benzinkannister",
 ["Drogen"]="Drogen", 
 ["Materialien"]="Materialien", 
 ["Wuerfel"]="Wuerfel",
 ["Zigaretten"]="Zigaretten",
 ["Arbeitsgenehmigung"]="Arbeitsgenehmigung",
 ["Personalausweis"]="Personalausweis",
 ["Pizzadienst"]="Pizzadienst",
 ["Schwarzpulver"]="Schwarzpulver",
 ["Bombe"]="Bombe",
 ["Coins"]="Coins",
 ["Gutschein"]="Gutschein",
 ['Hotdog']='Hotdog',
 ['Eis']='Eis',
 ['Pokal']='Pokal'
 }
 
itemImage = {
 ["Zeitung"]="ZEITUNG.png",
 ["Kanister"]="BENZIN.png",
 ["Drogen"]="DROGEN.png", 
 ["Materialien"]="MATS.png", 
 ["Wuerfel"]="WUERFEL.png",
 ["Zigaretten"]="ZIGARETTE.png",
 ["Hanfsamen"]="DROGEN.png",
 ["Arbeitsgenehmigung"]="Worklicense.png",
 ["Personalausweis"]="Personalausweis.png",
 ["Pizzadienst"]="Pizza.png",
 ["Schwarzpulver"]="Schwarzpulver.png",
 ["Bombe"]="Bombe.png",
 ["Coins"]="Coins.png",
 ["Gutschein"]="fgutschein.png",
 ['Hotdog']='hotdog.png',
 ['Eis']='eis.png',
 ['Pokal']='Award.png'
 }
 
itemCommand = {
 ["Zeitung"]="readnewspaper",
 ["Kanister"]="fill",
 ["Drogen"]="usedrugs", 
 ["Materialien"]="mats", 
 ["Wuerfel"]="dice",
 ["Zigaretten"]="smoke",
 ["Hanfsamen"]="grow",
 ["Pizzadienst"]="pizza",
 ["Bombe"]="bombe",
 ["Gutschein"]="fgutschein"
 }

itemType = {
 ["Kanister"]="fuel",
 ["Drogen"]="drugs", 
 ["Wuerfel"]="dice",
 ["Zigaretten"]="zigaretten",
 ["Materialien"]="mats",
 ["Hanfsamen"]="grow",
 ["Pizzadienst"]="pizza",
 ["Bombe"]="bombe",
 ["Gutschein"]="fgutschein"
 }

InventarOpen = false
 
function showInventory_func ()

	if not tutorial and not isPedDead ( lp ) then
	
		if InventarOpen == false then
			if(getElementData(lp,"ElementClicked")==false)then
				setElementData ( lp, "ElementClicked", true, true )
				showCursor ( true )
			
				gWindow["inventory"] = guiCreateStaticImage(0.31, 0.01, 0.39, 0.42, "Images/Background.png", true)   
				
				gGrid["itemList"] = guiCreateGridList(0.02, 0.08, 0.61, 0.89, true,gWindow["inventory"])
				guiGridListSetSortingEnabled ( gGrid["itemList"], false )
				guiGridListSetSelectionMode(gGrid["itemList"],0)
				gColumn["itemName"] = guiGridListAddColumn(gGrid["itemList"],"Item",0.55)
				gColumn["itemCount"] = guiGridListAddColumn(gGrid["itemList"],"Anzahl",0.25)
				guiSetAlpha(gGrid["itemList"],1)
				
				addEventHandler ( "onClientGUIClick", gGrid["itemList"], newSelection )
				
				gLabel["itemInfo"] = guiCreateLabel(0.66, 0.68, 0.32, 0.29, "Klicke ein Item an, um Informationen über dieses zu erhalten.", true,gWindow["inventory"])
				guiSetFont(gLabel["itemInfo"], "clear-normal")
				guiLabelSetHorizontalAlign(gLabel["itemInfo"], "left", true)
				
				gButton["itemUse"] = guiCreateButton(0.66, 0.56, 0.31, 0.09, "Benutzen", true,gWindow["inventory"])
				guiSetAlpha(gButton["itemUse"],1)
				gButton["itemThrow"] = guiCreateButton(0.66, 0.44, 0.31, 0.09, "Wegwerfen", true,gWindow["inventory"])
				guiSetAlpha(gButton["itemThrow"],1)
				
				InventarOpen = true
				
				addEventHandler("onClientGUIClick", gButton["itemThrow"],function ()
					throwCurrentItem()
				end,false )
				
				addEventHandler("onClientGUIClick", gButton["itemUse"],function ( btn, state )
					if state == "up" then
						useCurrentItem()
					end
				end, false )
				fillInventoryList()
			else
				infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
			end
		else
			setElementData ( lp, "ElementClicked", false, true )
			guiSetVisible ( gWindow["inventory"], false )
			showCursor ( false )
			InventarOpen = false
		end
	end
end
bindKey ( "i", "down", showInventory_func )

function useCurrentItem ()

	local rowindex, columnindex = guiGridListGetSelectedItem ( gGrid["itemList"] )
	local selectedText = guiGridListGetItemText ( gGrid["itemList"], rowindex, gColumn["itemName"] )
	
	if itemCommand[selectedText] then
		triggerServerEvent ( "executeCommand", getRootElement(), lp, itemCommand[selectedText] )
	end
end

function throwCurrentItem ()
	local rowindex, columnindex = guiGridListGetSelectedItem ( gGrid["itemList"] )
	local selectedText = guiGridListGetItemText ( gGrid["itemList"], rowindex, gColumn["itemName"] )
	
	triggerServerEvent ( "throw", getRootElement(), lp, "", itemType[selectedText] )
end

function newSelection ()

	local rowindex, columnindex = guiGridListGetSelectedItem ( gGrid["itemList"] )
	local selectedText = guiGridListGetItemText ( gGrid["itemList"], rowindex, gColumn["itemName"] )
	if selectedText then
		if validItems[selectedText] then
			guiSetText ( gLabel["itemInfo"], itemTexts[selectedText] )
			if gImage["itemImage"] then
				destroyElement ( gImage["itemImage"] )
			end
			gImage["itemImage"] = guiCreateStaticImage(0.66, 0.08, 0.31, 0.33,"Inventar/Images/"..itemImage[selectedText],true,gWindow["inventory"])
			guiSetAlpha ( gImage["itemImage"], 1 )
		end
	end
end

function fillInventoryList ()

	guiSetText ( gLabel["itemInfo"], "Wähle ein Item aus deinem Inventar aus, um Informationen über dieses zu erhalten." )
	
	fillWithItems ( gGrid["itemList"], gColumn["itemName"], gColumn["itemCount"] )
end
addEvent ( "refreshItems", true )
addEventHandler ( "refreshItems", getRootElement(), fillInventoryList )

function fillWithItems ( grid, columnName, columnCount )

	local value
	guiGridListClear ( grid )
	-- Benzin Kanister
	local Kanister = tonumber ( getElementData ( lp, "benzinkannister" ) )
	if Kanister >= 1 then
		local row = guiGridListAddRow ( grid )
		guiGridListSetItemText ( grid, row, columnName, "Kanister", false, false )
		guiGridListSetItemText ( grid, row, columnCount, tostring ( Kanister ), false, false )
	end
	-- Drogen
	local drogen = tonumber ( getElementData ( lp, "drugs" ) )
	if drogen >= 1 then
		local row = guiGridListAddRow ( grid )
		guiGridListSetItemText ( grid, row, columnName, "Drogen", false, false )
		guiGridListSetItemText ( grid, row, columnCount, tostring ( drogen ).." g", false, false )
	end
	-- Hanfsamen
	local weed = tonumber ( getElementData ( lp, "flowerseeds" ) )
	if weed >= 1 then
		local row = guiGridListAddRow ( grid )
		guiGridListSetItemText ( grid, row, columnName, "Hanfsamen", false, false )
		guiGridListSetItemText ( grid, row, columnCount, tostring ( weed ), false, false )
	end
	-- Mats
	local mats = tonumber ( getElementData ( lp, "mats" ) )
	if mats >= 1 then
		local row = guiGridListAddRow ( grid )
		guiGridListSetItemText ( grid, row, columnName, "Materialien", false, false )
		guiGridListSetItemText ( grid, row, columnCount, tostring ( mats ), false, false )
	end
	-- Würfel
	local dice = tonumber ( getElementData ( lp, "dice" ) )
	if dice >= 1 then
		local row = guiGridListAddRow ( grid )
		guiGridListSetItemText ( grid, row, columnName, "Wuerfel", false, false )
		guiGridListSetItemText ( grid, row, columnCount, "", false, false )
	end
	-- Zigarretten
	local zigaretten = tonumber ( getElementData ( lp, "zigaretten" ) )
	if zigaretten >= 1 then
		local row = guiGridListAddRow ( grid )
		guiGridListSetItemText ( grid, row, columnName, "Zigaretten", false, false )
		guiGridListSetItemText ( grid, row, columnCount, tostring ( zigaretten ), false, false )
	end
	-- Arbeitsgenehmigung
	local arbeitspass = tonumber(getElementData(lp,"worklicense"))
	if arbeitspass == 1 then
		local row = guiGridListAddRow ( grid )
		guiGridListSetItemText ( grid, row, columnName, "Arbeitsgenehmigung", false, false )
		guiGridListSetItemText ( grid, row, columnCount, tostring ( arbeitspass ), false, false )
	end
	-- Personalausweis
	local perso = tonumber(getElementData(lp,"perso"))
	if perso == 1 then
		local row = guiGridListAddRow ( grid )
		guiGridListSetItemText ( grid, row, columnName, "Personalausweis", false, false )
		guiGridListSetItemText ( grid, row, columnCount, tostring ( perso ), false, false )
	end
	-- Pizzadienst
	local pizza = tonumber(getElementData(lp,"pizzadienst"))
	if pizza == 1 then
		local row = guiGridListAddRow ( grid )
		guiGridListSetItemText ( grid, row, columnName, "Pizzadienst", false, false )
		guiGridListSetItemText ( grid, row, columnCount, tostring ( pizza ), false, false )
	end
	-- Bombe
	local bombe = tonumber(getElementData(lp,"bomben"))
	if bombe >= 1 then
		local row = guiGridListAddRow ( grid )
		guiGridListSetItemText ( grid, row, columnName, "Bombe", false, false )
		guiGridListSetItemText ( grid, row, columnCount, tostring ( bombe ), false, false )
	end
	-- Schwarzpulver
	local spulver = tonumber(getElementData(lp,"schwarzpulver"))
	if spulver >= 1 then
		local row = guiGridListAddRow ( grid )
		guiGridListSetItemText ( grid, row, columnName, "Schwarzpulver", false, false )
		guiGridListSetItemText ( grid, row, columnCount, tostring ( spulver ), false, false )
	end
	-- Coins
	local coins = tonumber(getElementData(lp,"coins"))
	if coins >= 1 then
		local row = guiGridListAddRow(grid)
		guiGridListSetItemText(grid,row,columnName,"Coins",false,false)
		guiGridListSetItemText(grid,row,columnCount,tostring(coins),false,false)
	end
	-- Gutschein
	local fschein = tonumber(getElementData(lp,"fgutschein"))
	if fschein >= 1 then
		local row = guiGridListAddRow(grid)
		guiGridListSetItemText(grid,row,columnName,"Gutschein",false,false)
		guiGridListSetItemText(grid,row,columnCount,tostring(fschein),false,false)
	end
	----- Hotdogs -----
	local hotdogs=tonumber(getElementData(lp,'hotdogs'))
	if(hotdogs>=1)then
		local row=guiGridListAddRow(grid)
		guiGridListSetItemText(grid,row,columnName,'Hotdog',false,false)
		guiGridListSetItemText(grid,row,columnCount,tostring(hotdogs),false,false)
	end
	----- Eis -----
	local eis=tonumber(getElementData(lp,'eis'))
	if(eis>=1)then
		local row=guiGridListAddRow(grid)
		guiGridListSetItemText(grid,row,columnName,'Eis',false,false)
		guiGridListSetItemText(grid,row,columnCount,tostring(eis),false,false)
	end
	----- Pokal -----
	local pokal=tonumber(getElementData(lp,'pokale'))
	if(pokal>=1)then
		local row=guiGridListAddRow(grid)
		guiGridListSetItemText(grid,row,columnName,'Pokal',false,false)
		guiGridListSetItemText(grid,row,columnCount,tostring(pokal),false,false)
	end
end