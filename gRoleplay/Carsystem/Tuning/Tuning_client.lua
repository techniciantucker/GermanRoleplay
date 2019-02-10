function SubmitLeaveTuningBtn (btn)
	if btn == "left" then
	
		setElementData(lp,"ElementClicked",false)
	
		setElementCollisionsEnabled ( getPedOccupiedVehicle(lp), true )
		setElementFrozen ( getPedOccupiedVehicle(lp), false )
		destroyElement ( clientGarage )
		guiSetVisible ( gWindow["tuningMenue"], false )
		if gWindow["tuningPremium"] then
			guiSetVisible ( gWindow["tuningPremium"], false )
		end
		showCursor ( false )
		showChat (true)
		triggerServerEvent ( "cancel_gui_server", lp )
		showPlayerHudComponent ( "money", false )
		local veh = getPedOccupiedVehicle ( lp )
		for i = 0, 16 do
			removeVehicleUpgrade ( veh, getVehicleUpgradeOnSlot ( veh, i ) )
		end
		for i = 0, 16 do
			_G["t"..i] = _G["upgradeSlot"..i.."MountedID"]
		end
		local c1, c2, c3, c4 = getVehicleColor ( veh )
		triggerServerEvent ( "CancelTuning", lp, lp, veh, c1, c2, c3, c4, curpainting, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16 )
	end
end
addEvent ( "SubmitLeaveTuningBtnAbbrechen", true)
addEventHandler ( "SubmitLeaveTuningBtnAbbrechen", getRootElement(), SubmitLeaveTuningBtn)

function SubmitBuyTuningBtn (btn)
	if btn == "left" then
		local veh = getPedOccupiedVehicle ( lp )
		local rowindex, columnindex = guiGridListGetSelectedItem ( gGrid["tuningSelect"] )
		local selectedText = guiGridListGetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningPart"] )
		local mounted = guiGridListGetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningIn"] )
		local part = tonumber ( selectedText )
		local tdata = _G["tdata"..rowindex]
		if tdata then
			local data1 = tonumber(gettok ( tdata, 1, string.byte('|') ) ) 			-- // Upgrade
			local data2 = tonumber(gettok ( tdata, 2, string.byte('|') ) )			-- // Preis
			local data3 = gettok ( tdata, 3, string.byte('|') )						-- // Fix
			local data4 = tonumber(gettok ( tdata, 4, string.byte('|') ) )	
			if data2 <= getElementData ( lp, "money" ) then
				if mounted == "✘" then
					triggerServerEvent ( "buyTuningPart", lp, lp, veh, part, data2 )
					guiGridListClear ( gGrid["tuningSelect"] )
					listfix (getElementModel(veh))
					guiGridListSetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningIn"], "✔", true, false )
					_G["upgradeSlot"..data4.."MountedID"] = data1
					guiGridListSetSelectedItem ( gGrid["tuningSelect"], 0, 0 )
				else
					infobox("Dieses Teil hast du bereits!")
				end
			else
				infobox("Du hast nicht genug Geld!")
			end
		else
			local price = guiGridListGetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningPrice"] )
			local price = tonumber ( gettok ( price, 1, string.byte('$') ) )
			if price then
				local text = guiGridListGetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningPart"] )
				for i = 1, specialUpgrades do
					if specialUpgrade[i] == text then
						local upgrade = specialUpgrade[i]
						if getElementData ( lp, "money" ) >= price then
							local fix = guiGridListGetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningIn"] )
							if fix == "✘" then
								triggerServerEvent ( "addSpecialTuning", lp, i )
								guiGridListSetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningIn"], "✔", false, false )
							else
								infobox("Diesen Teil hast du bereits!")
							end
						end
						break
					end
				end
			else
				infobox("Du hast nicht genug Geld!")
			end
		end
	end
end
addEvent ( "SubmitBuyTuningBtnAbbrechen", true)
addEventHandler ( "SubmitBuyTuningBtnAbbrechen", getRootElement(), SubmitBuyTuningBtn)

function createTuningMenue ()
	if(getElementData(lp,"ElementClicked")==false)then
		showCursor ( true )
		showChat (false)
		setElementData(lp,"ElementClicked",false)
		clientGarage = createObject ( 14798, -2052.3671875, 143.50421142578, 29.126596450806, 0, 0, 0 )
		setElementCollisionsEnabled ( getPedOccupiedVehicle(lp), false )
		setElementFrozen ( getPedOccupiedVehicle(lp), true )
		if gWindow["tuningMenue"] then
			guiSetVisible ( gWindow["tuningMenue"], true )
		else
			local screenwidth, screenheight = guiGetScreenSize ()
			showChat (false)
			gWindow["tuningMenue"] = guiCreateStaticImage(0.29, 0.01, 0.42, 0.35, "Images/Background.png", true)
			gGrid["tuningSelect"] = guiCreateGridList(0.02, 0.09, 0.52, 0.88, true,gWindow["tuningMenue"])
			guiGridListSetSelectionMode(gGrid["tuningSelect"],0)
			Tuninginfo = guiCreateLabel(0.55, 0.09, 0.43, 0.35, "Du möchtest deinem Fahrzeug eine andere Farbe verpassen? Dann fahre zum Spezialtuningshop, welcher sich unten Rechts in Los Santos befindet, und mit einem weißen S gekennzeichnet wurde.", true, gWindow["tuningMenue"])
			guiSetFont(Tuninginfo, "clear-normal")
			guiLabelSetHorizontalAlign(Tuninginfo, "left", true)
			gColumn["tuningPart"] = guiGridListAddColumn(gGrid["tuningSelect"],"Tuningteil",0.43)
			gColumn["tuningPrice"] = guiGridListAddColumn(gGrid["tuningSelect"],"Preis",0.2)
			gColumn["tuningIn"] = guiGridListAddColumn(gGrid["tuningSelect"],"Eingebaut",0.17)
			guiSetAlpha(gGrid["tuningSelect"],1)
			local add = 0.1
			gButton["buyUpgrade"] = guiCreateButton(0.67, 0.47, 0.20, 0.08, "Kaufen", true,gWindow["tuningMenue"])
			guiSetAlpha(gButton["buyUpgrade"],1)
			gButton["delUpgrade"] = guiCreateButton(0.67, 0.59, 0.20, 0.08, "Löschen", true,gWindow["tuningMenue"])
			guiSetAlpha(gButton["delUpgrade"],1)
			addEventHandler ( "onClientGUIClick", gButton["delUpgrade"], 
				function ()
					local rowindex, columnindex = guiGridListGetSelectedItem ( gGrid["tuningSelect"] )
					local selectedText = guiGridListGetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningPart"] )
					local mounted = guiGridListGetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningIn"] )
					local part = tonumber ( selectedText )
					local tdata = _G["tdata"..rowindex]
					local data1 = tonumber(gettok ( tdata, 1, string.byte('|') ) ) 			-- // Upgrade
					local data2 = tonumber(gettok ( tdata, 2, string.byte('|') ) )			-- // Preis
					local data3 = gettok ( tdata, 3, string.byte('|') )						-- // Fix
					local data4 = tonumber(gettok ( tdata, 4, string.byte('|') ) )			-- // Slot
					if mounted == "✔" and tdata then
						triggerServerEvent ( "buyTuningPart", lp, lp, veh, part, data2 )
						guiGridListClear ( gGrid["tuningSelect"] )
						listfix (getElementModel(veh))
						guiGridListSetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningIn"], "    [ ]", true, false )
						_G["upgradeSlot"..data4.."MountedID"] = false
						removeVehicleUpgrade ( veh, data1 )
						guiGridListSetSelectedItem ( gGrid["tuningSelect"], 0, 0 )
						triggerServerEvent ( "removeTuningPart", lp, lp, veh, part, data2 )
					end
				end,
			false )
			gButton["closeUpgradeStore"] = guiCreateButton(0.67, 0.71, 0.20, 0.08, "Schließen", true,gWindow["tuningMenue"])
			guiSetAlpha(gButton["closeUpgradeStore"],1)
			addEventHandler("onClientGUIClick", gButton["closeUpgradeStore"], SubmitLeaveTuningBtn, false)
			addEventHandler("onClientGUIClick", gButton["buyUpgrade"], SubmitBuyTuningBtn, false)
		end
		local veh = getPedOccupiedVehicle ( lp )
		local c1, c2, c3, c4 = getVehicleColor ( veh )
		guiGridListClear ( gGrid["tuningSelect"] )
		local vehID = getElementModel ( getPedOccupiedVehicle ( lp ) )
		for i = 0, 16 do
			_G["upgradeSlot"..i.."MountedID"] = false
		end
		listfix (vehID)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end
addEvent ( "createTuningMenue", true )
addEventHandler ( "createTuningMenue", getRootElement(), createTuningMenue )

function listfix(vehID)
	local row = guiGridListAddRow ( gGrid["tuningSelect"] )
	guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPart"], "Spezial", true, false )
	guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningIn"], "", true, false )
	--guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningID"], "", true, false )
	for i = 1, specialUpgrades do
		local row = guiGridListAddRow ( gGrid["tuningSelect"] )
		local fix = getElementData ( getPedOccupiedVehicle ( lp ), "stuning"..i )
		if fix then fix = "✔" else fix = "✘" end
		guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPart"], specialUpgrade[i], false, false )
		guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPrice"], specialUpgradePrice[i].." $", false, false )
		guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningIn"], fix, false, false )
		--guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningID"], "", false, false )
	end
	local row = guiGridListAddRow ( gGrid["tuningSelect"] )
	guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPart"], "", false, false )
	guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPrice"], "", false, false )
	guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningIn"], "", false, false )
	--guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningID"], "", false, false )
	for upgradeSlot=0,16 do
		upin = 0
		local compatList = compatibleUpgrades[vehID][upgradeSlot]
		if compatList then
			for i, upgradeID in ipairs(compatList) do				
				upin = 1
			end
		end
		if upin == 1 then
			local row = guiGridListAddRow ( gGrid["tuningSelect"] )
			guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPart"], slotNames[upgradeSlot], true, false )
			guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPrice"], "", true, false )
			guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningIn"], "", true, false )
			--guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningID"], "", true, false )
			for i, upgradeID in ipairs(compatList) do				
				local row = guiGridListAddRow ( gGrid["tuningSelect"] )
				guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPart"], "  "..UpgradeNames[upgradeID], false, false )
				local data1 = tostring ( upgradeID )
				if upgradeSlot == 8 then
					if upgradeID == 1008 then price = 5*nitroprice end
					if upgradeID == 1009 then price = 2*nitroprice end
					if upgradeID == 1010 then price = 10*nitroprice end
				else
					price = tuningpartprice
				end
				local data2 = tostring ( price )
				guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPrice"], price.." $", false, false )
				if getVehicleUpgradeOnSlot ( getPedOccupiedVehicle ( lp ), upgradeSlot ) == upgradeID then 
					fix = "✔"
					_G["upgradeSlot"..upgradeSlot.."MountedID"] = upgradeID
				else
					fix = "✘" 
				end
				local data3 = fix
				local data4 = upgradeSlot
				local tdata = data1.."|"..data2.."|"..data3.."|"..data4.."|"
				_G["tdata"..row] = tdata
				guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningIn"], fix, false, false )
			end
			local row = guiGridListAddRow ( gGrid["tuningSelect"] )
			guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPart"], "", true, false )
			guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPrice"], "", true, false )
			guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningIn"], "", true, false )
			--guiGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningID"], "", true, false )
		end
	end
end

function partChange (veh)
	if gWindow["tuningMenue"] then
		local rowindex, columnindex = guiGridListGetSelectedItem ( gGrid["tuningSelect"] )
		local selectedText = guiGridListGetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningPart"] )
		if selectedText then
			for i = 0, 16 do
			end
			for i = 0, 16 do
				if ( _G["upgradeSlot"..i.."MountedID"] == false ) then
				end
			end
			local tdata = _G["tdata"..rowindex]
			if tdata then
				local data1 = tonumber(gettok ( tdata, 1, string.byte('|') ) ) 				-- // Upgrade
				if data1 then
					local data2 = tonumber(gettok ( tdata, 2, string.byte('|') ) )			-- // Preis
					local data3 = gettok ( tdata, 3, string.byte('|') )						-- // Fix
					local data4 = tonumber(gettok ( tdata, 4, string.byte('|') ))			-- // Slot
					local veh = getPedOccupiedVehicle ( lp )
					if getVehicleUpgradeOnSlot ( veh, data4 ) ~= data1 then
						addVehicleUpgrade ( veh, data1 )
					end
				end
			end
		end
	end
end
addEventHandler ( "onClientGUIClick", getRootElement(), partChange )