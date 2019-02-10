function SubmitFahrzeugAbbrechenBtn(button)
	if button == "left" then
		guiSetInputEnabled ( true )
		destroyElement(gWindow["vehinteraktion"])
		if gWindow["adminvehinteraktion"] then
			destroyElement(gWindow["adminvehinteraktion"])
		end
		showCursor(false)
		setElementData(lp,"ElementClicked",false)
	end
end

function _createCarmenue_func ( veh )
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,"ElementClicked",true)
		
		if getElementData ( lp, "adminlvl" ) > 0 then

			gWindow["adminvehinteraktion"] = guiCreateStaticImage(0.38, 0.18, 0.24, 0.32, "Images/Background.png", true)

			gButton["vehCarUnsp"] = guiCreateButton(0.03, 0.27, 0.44, 0.13, "Unspawnen", true, gWindow["adminvehinteraktion"])

			gButton["vehCarOwnerChange"] = guiCreateButton(0.53, 0.78, 0.44, 0.13, "Besitzer ändern", true, gWindow["adminvehinteraktion"])

			gButton["vehCarResp"] = guiCreateButton(0.53, 0.09, 0.44, 0.13, "Respawnen", true, gWindow["adminvehinteraktion"])

			gButton["vehCarPark"] = guiCreateButton(0.03, 0.09, 0.44, 0.13, "Umparken", true, gWindow["adminvehinteraktion"])

			gButton["vehCarDel"] = guiCreateButton(0.53, 0.44, 0.44, 0.13, "Löschen", true, gWindow["adminvehinteraktion"])

			gButton["vehCarUnbreak"] = guiCreateButton(0.53, 0.27, 0.44, 0.13, "Handbremse betätigen", true, gWindow["adminvehinteraktion"])

			gButton["vehCarLock"] = guiCreateButton(0.53, 0.62, 0.44, 0.13, "Auf/Abschließen", true, gWindow["adminvehinteraktion"])

			gButton["vehCarMotor"] = guiCreateButton(0.03, 0.44, 0.44, 0.13, "Motor an/aus", true, gWindow["adminvehinteraktion"])

			gMemo["vehCarReason"] = guiCreateEdit(0.03, 0.62, 0.44, 0.12, "Löschgrund", true, gWindow["adminvehinteraktion"])
			
			gEdit[1] = guiCreateEdit(0.03, 0.78, 0.44, 0.12, "Neuer Besitzer", true, gWindow["adminvehinteraktion"])    

			addEventHandler("onClientGUIClick", gButton["vehCarResp"], function()
				if source ~= gButton["vehCarResp"] then
					return
				end
				local veh = getElementData ( lp, "clickedVehicle" )
				local towcar = getElementData ( veh, "carslotnr_owner" )
				local pname = getElementData ( veh, "owner" )
				triggerServerEvent ( "respawnVeh", lp, towcar, pname, veh )
				SubmitFahrzeugAbbrechenBtn("left")
			end)
			
			addEventHandler("onClientGUIClick", gButton["vehCarDel"], function()
				if source ~= gButton["vehCarDel"] then
					return
				end
				local veh = getElementData ( lp, "clickedVehicle" )
				local towcar = getElementData ( veh, "carslotnr_owner" )
				local pname = getElementData ( veh, "owner" )
				if not pname then
					triggerServerEvent ( "moveVehicleAway", lp, veh )
				else
					triggerServerEvent ( "deleteVeh", lp, towcar, pname, veh, guiGetText ( gMemo["vehCarReason"] ) )
				end
				SubmitFahrzeugAbbrechenBtn("left")
			end,false)
			
			addEventHandler("onClientGUIClick", gButton["vehCarMotor"], function()
				if source ~= gButton["vehCarMotor"] then
					return
				end
				local veh = getElementData ( lp, "clickedVehicle" )
					triggerServerEvent ( "AdmincmdToogleMotor", lp, veh )
				SubmitFahrzeugAbbrechenBtn("left")
			end,false)
			
			addEventHandler("onClientGUIClick", gButton["vehCarPark"],function()
				if source ~= gButton["vehCarPark"] then
					return
				end
				local veh = getElementData ( lp, "clickedVehicle" )
				local towcar = getElementData ( veh, "carslotnr_owner" )
				local pname = getElementData ( veh, "owner" )
					triggerServerEvent ( "AdmincmdParkVeh", lp, towcar, pname, veh, guiGetText ( gMemo["vehCarReason"] ) )
				SubmitFahrzeugAbbrechenBtn("left")
			end,false)
			
			addEventHandler("onClientGUIClick", gButton["vehCarUnbreak"],function()
				if source ~= gButton["vehCarUnbreak"] then
					return
				end
				local veh = getElementData ( lp, "clickedVehicle" )
				triggerServerEvent ( "AdmincmdUnbreakVeh", lp, veh )
				SubmitFahrzeugAbbrechenBtn("left")
			end,false)
			
			addEventHandler("onClientGUIClick", gButton["vehCarOwnerChange"], function()
				if source ~= gButton["vehCarOwnerChange"] then
					return
				end
				local veh = getElementData ( lp, "clickedVehicle" )
				local towcar = getElementData ( veh, "carslotnr_owner" )
				local pname = getElementData ( veh, "owner" )
				triggerServerEvent ( "AdmincmdOwnerChangeVeh", lp, veh, towcar, pname, guiGetText(gEdit[1]) )
				SubmitFahrzeugAbbrechenBtn("left")
			end,false)
			
			addEventHandler("onClientGUIClick", gButton["vehCarLock"], function()
				if source ~= gButton["vehCarLock"] then
					return
				end
				local veh = getElementData ( lp, "clickedVehicle" )
					triggerServerEvent ( "AdmincmdLockVeh", lp, veh )
				SubmitFahrzeugAbbrechenBtn("left")
			end,false)
			
			addEventHandler("onClientGUIClick", gButton["vehCarUnsp"], function()
				if source ~= gButton["vehCarUnsp"] then
					return
				end
				local veh = getElementData ( lp, "clickedVehicle" )
					triggerServerEvent ( "moveVehicleAway", lp, veh )
				SubmitFahrzeugAbbrechenBtn("left")
			end,false)
			
		end

        gWindow["vehinteraktion"] = guiCreateStaticImage(0.38, 0.01, 0.24, 0.15, "Images/Background.png", true)

        gButton["vehabschliessen"] = guiCreateButton(0.03, 0.21, 0.44, 0.31, "Auf/Abschließen", true, gWindow["vehinteraktion"])
        gButton["vehrespawn"] = guiCreateButton(0.53, 0.21, 0.44, 0.31, "Respawnen", true, gWindow["vehinteraktion"])
        gButton["vehinfos"] = guiCreateButton(0.03, 0.60, 0.44, 0.31, "Informationen", true, gWindow["vehinteraktion"])
        gButton["vehcancel"] = guiCreateButton(0.53, 0.60, 0.44, 0.31, "Schließen", true, gWindow["vehinteraktion"])

		local occupants = getVehicleOccupants(veh)
		for seat, occupant in pairs(occupants) do
            guiSetAlpha(gButton["vehrespawn"], 1)
        end
		addEventHandler("onClientGUIClick", gButton["vehcancel"], SubmitFahrzeugAbbrechenBtn, false)
		
		addEventHandler("onClientGUIClick", gButton["vehrespawn"], function ()
			if source ~= gButton["vehrespawn"] then
				return
			end
			local veh = getElementData ( lp, "clickedVehicle" )
			if veh then
				if getElementData ( veh, "owner" ) == getPlayerName ( lp ) then
					triggerServerEvent ( "respawnPrivVehClick", lp, lp, "lock", tonumber ( getElementData ( veh, "carslotnr_owner" ) ) )
					SubmitFahrzeugAbbrechenBtn("left")
				else
					infobox("Dieses Fahrzeug gehört dir nicht!")
				end
			end
		end,false)
		
		addEventHandler("onClientGUIClick",gButton["vehinfos"],function()
			local owner = getElementData(veh,"owner")
			infobox("Dieses Fahrzeug gehört: "..owner)
		end,false)
		
		addEventHandler("onClientGUIClick", gButton["vehabschliessen"], function ()
			if source ~= gButton["vehabschliessen"] then
				return
			end
			local veh = getElementData ( lp, "clickedVehicle" )
			if veh then
				if getElementData ( veh, "owner" ) == getPlayerName ( lp ) then
					triggerServerEvent ( "lockPrivVehClick", lp, lp, "lock", tonumber ( getElementData ( veh, "carslotnr_owner" ) ) )
				else
					infobox("Dieses Fahrzeug gehört dir nicht!")
				end
			end
		end,false)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end
addEvent ( "_createCarmenue", true )
addEventHandler ( "_createCarmenue", getRootElement(), _createCarmenue_func )

----- Kofferraum -----
function showTrunkGui_func(drugs,mats)
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,'ElementClicked',true)
	
		gWindow["trunkClick"] = guiCreateStaticImage(0.35, 0.01, 0.26, 0.28,'Images/Background.png',true)
		guiSetAlpha(gWindow["trunkClick"],1)
		
		gLabel['trunkName']  = guiCreateLabel(0.03, 0.09, 0.95, 0.09, "Kofferraum von: "..getPlayerName(localPlayer), true, gWindow["trunkClick"])
		
		gLabel["trunkDrugs"] = guiCreateLabel(0.03, 0.25, 0.45, 0.08, "Drogen: 1000000g", true,gWindow["trunkClick"])
		gLabel['trunkMats']  = guiCreateLabel(0.52, 0.25, 0.45, 0.08, "Materielien: 100000 Stk.", true,gWindow["trunkClick"])
		
		guiLabelSetColor(gLabel["trunkDrugs"], 0, 254, 17)
		guiLabelSetColor(gLabel['trunkMats'], 0, 254, 17)
		
		gButton["trunkClose"] = guiCreateButton(0.03, 0.87, 0.45, 0.09, "[ X ]", true,gWindow["trunkClick"])
		guiSetAlpha(gButton["trunkClose"],1)
		
		addEventHandler ( "onClientGUIClick", gButton["trunkClose"],function ( btn, state )
			if state == "up" then
				showCursor ( false )
				destroyElement(gWindow['trunkClick'])
				setElementData ( lp, "ElementClicked", false )
			end
		end,false )
		
        gEdit["trunkDrugs"] = guiCreateEdit(0.03, 0.37, 0.45, 0.10, "", true, gWindow["trunkClick"])
        gEdit["trunkMats"]  = guiCreateEdit(0.52, 0.37, 0.45, 0.10, "", true, gWindow["trunkClick"])
		
		gButton["trunkTakeDrugs"] = guiCreateButton(0.03, 0.51, 0.45, 0.09, "Nehmen", true,gWindow["trunkClick"])
		guiSetAlpha(gButton["trunkTakeDrugs"],1)
		gButton["trunkStoreDrugs"] = guiCreateButton(0.03, 0.64, 0.45, 0.09, "Lagern", true,gWindow["trunkClick"])
		guiSetAlpha(gButton["trunkStoreDrugs"],1)
		
		gButton["trunkTakeMats"] = guiCreateButton(0.53, 0.51, 0.45, 0.09, "Nehmen", true,gWindow["trunkClick"])
		guiSetAlpha(gButton["trunkTakeMats"],1)
		gButton["trunkStoreMats"] = guiCreateButton(0.52, 0.64, 0.45, 0.09, "Lagern", true,gWindow["trunkClick"])
		guiSetAlpha(gButton["trunkStoreMats"],1)
		
		trunkButtons = {
		[gButton["trunkTakeDrugs"]]  = true,
		[gButton["trunkStoreDrugs"]] = true,
		[gButton["trunkTakeMats"]]   = true,
		[gButton["trunkStoreMats"]]  = true
		}
		
		for key, index in pairs ( trunkButtons ) do
			addEventHandler ( "onClientGUIClick", key, trunkClick, false )
		end
		
		guiSetText ( gLabel["trunkDrugs"], "Drogen: "..drugs.." g" )
		guiSetText ( gLabel["trunkMats"], "Materielien: "..mats.." Stk." )
	
		guiSetText ( gEdit["trunkDrugs"], "0" )
		guiSetText ( gEdit["trunkMats"], "0" )
	else
		infobox('Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!')
	end
end
addEvent ( "showTrunkGui", true )
addEventHandler ( "showTrunkGui", getRootElement(), showTrunkGui_func )

function trunkClick ( btn, state )
	if state == "up" then
		if trunkButtons[source] then
			local drugs = guiGetText ( gLabel["trunkDrugs"] )
			drugs = tonumber ( string.sub ( drugs, 1, ( #drugs ) - 2 ) )
			
			local mats = guiGetText ( gLabel["trunkMats"] )
			mats = tonumber ( string.sub (mats, 1, ( #mats ) - 5 ) )
			
			local drugsValue = tonumber ( guiGetText ( gEdit["trunkDrugs"] ) )
			local matsValue = tonumber ( guiGetText ( gEdit["trunkMats"] ) )
			
			if source == gButton["trunkTakeDrugs"] or source == gButton["trunkTakeMats"] then
				if source == gButton["trunkTakeDrugs"] then
					if drugs >= drugsValue then
						triggerServerEvent ( "trunkStorageServer", lp, "drugs", drugsValue, true )
						guiSetText ( gLabel["trunkDrugs"], ( drugs - drugsValue ).." g" )
					else
						infobox('So viele Drogen sind nicht\nin deinem Kofferraum!')
					end
				else
					if mats >= matsValue then
						triggerServerEvent ( "trunkStorageServer", lp, "mats", matsValue, true )
						guiSetText ( gLabel["trunkMats"], ( mats - matsValue ).." Stk." )
					else
						infobox('So viele Mats sind nicht\nin deinem Kofferraum!')
					end
				end
			else
				if source == gButton["trunkStoreDrugs"] then
					if getElementData ( lp, "drugs" ) >= drugsValue then
						triggerServerEvent ( "trunkStorageServer", lp, "drugs", drugsValue, false )
						guiSetText ( gLabel["trunkDrugs"], ( drugs + drugsValue ).." g" )
					else
						infobox('So viele Drogen hast du nicht!')
					end
				else
					if getElementData ( lp, "mats" ) >= matsValue then
						triggerServerEvent ( "trunkStorageServer", lp, "mats", matsValue, false )
						guiSetText ( gLabel["trunkMats"], ( mats + matsValue ).." Stk." )
					else
						infobox('So viele Mats hast du nicht!')
					end
				end
			end
		end
	end
end