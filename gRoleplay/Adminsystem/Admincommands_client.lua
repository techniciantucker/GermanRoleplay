function nodamage()
	if getElementData(lp,"amode") == true or getElementData(lp,"AFK") == true then
		cancelEvent()
	end
end
addEventHandler("onClientPlayerDamage",getLocalPlayer(),nodamage)

admincommands = {label = {},window = {}}

----- Adminliste -----
addCommandHandler("admins",function()
	if(getElementData(lp,"ElementClicked")==false)then
		setElementData(lp,"ElementClicked",true,true)
		showCursor(true)
	
		teamliste = guiCreateStaticImage(0.39, 0.01, 0.23, 0.43, "Images/Background.png", true)

        teamlisteclose = guiCreateButton(0.27, 0.89, 0.45, 0.08, "Schließen", true, teamliste)
        guiSetProperty(teamlisteclose, "NormalTextColour", "FFAAAAAA")

        teamlistelist = guiCreateGridList(0.03, 0.08, 0.94, 0.78, true,teamliste)
        adminname = guiGridListAddColumn(teamlistelist, "Name", 2)
		
		addEventHandler("onClientGUIClick",teamlisteclose,function()
			destroyElement(teamliste)
			showCursor(false)
			setElementData(lp,"ElementClicked",false)
		end,false)
		
		for id, player in ipairs ( getElementsByType ( "player" ) ) do 
			if getElementData ( player, "loggedin" ) == 1 then
				if getElementData(player,"adminlvl") > 0 then
					local adminlvl = getElementData(player,"adminlvl")
					
					if adminlvl == 1 then
						adminlvlanzeige = "Ticketbeauftragter"
					elseif adminlvl == 2 then
						adminlvlanzeige = "Supporter"
					elseif adminlvl == 3 then
						adminlvlanzeige = "Moderator"
					elseif adminlvl == 4 then
						adminlvlanzeige = "Administrator"
					elseif adminlvl == 5 then
						adminlvlanzeige = "Servermanager"
					elseif adminlvl == 6 then
						adminlvlanzeige = "Stellv. Projektleiter"
					elseif adminlvl == 7 then
						adminlvlanzeige = "Projektleiter"
					end
					
					local row = guiGridListAddRow ( teamlistelist )
					guiGridListSetItemText ( teamlistelist, row, adminname, getPlayerName(player)..", ("..adminlvlanzeige..")", false, false )
				end
			end
		end
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)