local blocked = { ["t"]=true }

function showPDComputer ()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,"ElementClicked",true,true)
	
		gWindow["policeComputer"] = guiCreateStaticImage(0.35, 0.01, 0.30, 0.51, "Images/Background.png", true)
		
		gGrid["pdPlayers"] = guiCreateGridList(0.02, 0.07, 0.54, 0.91, true,gWindow["policeComputer"])
		guiGridListSetSelectionMode(gGrid["pdPlayers"],0)
		gColumn["pdPlayer"] = guiGridListAddColumn(gGrid["pdPlayers"],"Spieler",0.425)
		gColumn["plWanted"] = guiGridListAddColumn(gGrid["pdPlayers"],"Wanteds",0.425)
		
		gEdit["pdReason"] = guiCreateEdit(0.59, 0.12, 0.38, 0.07, "", true,gWindow["policeComputer"])
		gLabel[2] = guiCreateLabel(0.59, 0.07, 0.38, 0.05, "Grund:", true,gWindow["policeComputer"])
		
		gEdit["pdCount"] = guiCreateEdit(0.59, 0.26, 0.38, 0.07, "", true,gWindow["policeComputer"],true,true)
		gLabel[1] = guiCreateLabel(0.59, 0.21, 0.38, 0.05, "Anzahl:", true,gWindow["policeComputer"])
		
		gButton["setWanteds"] = guiCreateButton(0.59, 0.37, 0.38, 0.08, "Wanteds geben", true,gWindow["policeComputer"])
		gButton["setStvo"] = guiCreateButton(0.59, 0.47, 0.38, 0.08, "Stvo Punkte geben", true,gWindow["policeComputer"])
		gButton["pdClose"] = guiCreateButton(0.59, 0.68, 0.38, 0.08, "Schließen", true,gWindow["policeComputer"])
		gButton["pdTrace"] = guiCreateButton(0.59, 0.58, 0.38, 0.08, "Orten", true,gWindow["policeComputer"])
		
		addEventHandler ( "onClientGUIClick", gButton["setWanteds"],function ()
			local wanteds = tonumber ( guiGetText ( gEdit["pdCount"] ) )
			local reason = guiGetText ( gEdit["pdReason"] )
			if wanteds >= 0 and wanteds <= 6 then
				local row, column = guiGridListGetSelectedItem ( gGrid["pdPlayers"] )
				local name
				
				name = guiGridListGetItemText ( gGrid["pdPlayers"], row, gColumn["pdPlayer"] )
				
				if reason == "" then
					reason = "Keine Angabe"
				end

				triggerServerEvent ( "pdComputerSetWanted", lp, wanteds, name, reason )
			else
				infobox("Trage eine Zahl zwischen 1-6 ein!")
			end
		end,false )
		
		addEventHandler ( "onClientGUIClick", gButton["setStvo"],function ()
			local row, column = guiGridListGetSelectedItem ( gGrid["pdPlayers"] )
			local reason = guiGetText ( gEdit["pdReason"] )

			local name
			
			if reason == "" then
				reason = "Keine Angabe"
			end

			name = guiGridListGetItemText ( gGrid["pdPlayers"], row, gColumn["pdPlayer"] )

			triggerServerEvent ( "pdComputerAddSTVO", lp, name, reason )
		end,false )
		
		addEventHandler ( "onClientGUIClick", gButton["pdClose"],function ()
			showCursor ( false )
			setElementData ( lp, "ElementClicked", false )
			destroyElement(gWindow["policeComputer"])
		end,false )
		
		addEventHandler ( "onClientGUIClick", gButton["pdTrace"],function ()
			SFPDTraceCitizen ()
		end,false )
		
		guiSetFont ( gGrid["pdPlayers"], "default-bold-small" )
		
		guiGridListClear ( gGrid["pdPlayers"] )
		for id, player in ipairs ( getElementsByType ( "player" ) ) do 
			if getElementData ( player, "loggedin" ) == 1 then
				local row = guiGridListAddRow ( gGrid["pdPlayers"] )
				guiGridListSetItemText ( gGrid["pdPlayers"], row, gColumn["pdPlayer"], getPlayerName(player), false, false )
				guiGridListSetItemText ( gGrid["pdPlayers"], row, gColumn["plWanted"], getElementData(player,'wanteds'), false, false )
			end
		end
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end
addEvent ( "showPDComputer", true)
addEventHandler ( "showPDComputer", getRootElement(), showPDComputer )

function SFPDTraceCitizen ()
	local name

	local row, column = guiGridListGetSelectedItem ( gGrid["pdPlayers"] )
	name = guiGridListGetItemText ( gGrid["pdPlayers"], row, gColumn["pdPlayer"] )
	
	local target = getPlayerFromName ( name )
	if tonumber(getElementData ( lp, "rang" )) >= 2 then
		if getElementData ( target, "handystate" ) == "off" then
			infobox("Das Handy des Bürgers ist aus!")
		else
			if(getElementData(lp,'handyAbgenommen')==false)then
				local x, y, z = getElementPosition ( target )
				if tonumber ( getElementInterior ( target ) ) ~= 0 or tonumber ( getElementDimension ( target ) ) ~= 0 then
					infobox("Die Ortung ist nicht möglich,\nda der Spieler sich in einem\nGebäude befindet!")
				else
					if wantedBlip then
						destroyElement ( wantedBlip )
						wantedBlip = nil
						if deletetWantedBlipTimer then
							killTimer ( deletetWantedBlipTimer )
						end
						wantedBlip = createBlip ( x, y, z, 0, 2, 255, 0, 0, 255, 0, 99999.0 )
						deletetWantedBlipTimer = setTimer ( deletetWantedBlip, 10000, 1 )
					else
						wantedBlip = createBlip ( x, y, z, 0, 2, 255, 0, 0, 255, 0, 99999.0 )
						deletetWantedBlipTimer = setTimer ( deletetWantedBlip, 10000, 1 )
					end
				end
			else
				infobox('Der Spieler hat kein Handy!')
			end
		end
	else
		infobox("Du bist nicht befugt!")
	end
end

function deletetWantedBlip ()
	destroyElement ( wantedBlip )
	wantedBlip = nil
end