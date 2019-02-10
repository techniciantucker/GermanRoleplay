function showHouseGui_func ( amount )
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,"ElementClicked",true,true)
	
		gWindow["houseMenue"] = guiCreateStaticImage(0.37, 0.01, 0.27, 0.27, "Images/Background.png", true)
		gLabel["houseAmount"] = guiCreateLabel(0.50, 0.30, 0.04, 0.09, "$", true,gWindow["houseMenue"])
		gLabel["houseInfo"] = guiCreateLabel(0.03, 0.13, 0.95, 0.12, "Aktuell in der Hauskasse befinden sich: "..amount.."$", true,gWindow["houseMenue"])
		gMemo["houseAmount"] = guiCreateEdit(0.03, 0.27, 0.46, 0.13, "", true,gWindow["houseMenue"])
		gButton["houseGive"] = guiCreateButton(0.58, 0.45, 0.40, 0.13, "Einzahlen", true,gWindow["houseMenue"])
		gButton["houseTake"] = guiCreateButton(0.58, 0.27, 0.40, 0.13, "Auszahlen", true,gWindow["houseMenue"])
		gButton["houseHeal"] = guiCreateButton(0.58, 0.63, 0.40, 0.13, "Heilen", true,gWindow["houseMenue"])
		gButton["houseClose"] = guiCreateButton(0.58, 0.81, 0.40, 0.13, "Schließen", true,gWindow["houseMenue"])
			
		houseButtson = {
		[gButton["houseClose"]]=true,
		[gButton["houseGive"]]=true,
		[gButton["houseTake"]]=true,
		[gButton["houseHeal"]]=true
		}
			
		addEventHandler( "onClientGUIClick", gButton["houseClose"],function ()
			if houseButtson[source] then
				destroyElement(gWindow["houseMenue"])
				setElementData ( lp, "ElementClicked", false, true )
				showCursor ( false )
			end
		end)
			
		addEventHandler( "onClientGUIClick", gButton["houseGive"],function ()
			if houseButtson[source] then
				triggerServerEvent ( "houseClickServer", lp, lp, "give", tonumber ( guiGetText ( gMemo["houseAmount"] ) ) )
				destroyElement(gWindow["houseMenue"])
				showCursor(false)
				setElementData(lp,"ElementClicked",false)
			end
		end)
		addEventHandler( "onClientGUIClick", gButton["houseTake"],function ()
			if houseButtson[source] then
				triggerServerEvent ( "houseClickServer", lp, lp, "take", tonumber ( guiGetText ( gMemo["houseAmount"] ) ) )
				destroyElement(gWindow["houseMenue"])
				showCursor(false)
				setElementData(lp,"ElementClicked",false)
			end
		end)
		addEventHandler( "onClientGUIClick", gButton["houseHeal"],function ()
			if houseButtson[source] then
				triggerServerEvent ( "houseClickServer", lp, lp, "heal" )
			end
		end)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end
addEvent ( "showHouseGui", true )
addEventHandler ( "showHouseGui", getRootElement(), showHouseGui_func )