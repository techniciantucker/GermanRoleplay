-- Objekte, welche angeklickt werden können:
guiObjectModels = {
[2942]=true -- ATM
}

secondClickTypes = {
["ped"]=true,
["player"]=true,
["vehicle"]=true
}

-- Variablen
local lastTakeBottle = {}

function player_click ( button, state, clickedElement, x, y, z )

	if state == "down" and not getElementData ( source, "ElementClicked" ) then
	
		-- Objekte anklicken Funktion
		if clickedElement and not secondClickTypes[getElementType(clickedElement)] then
			local x1,y1,z1 = getElementPosition(source)
			local x2, y2, z2 = getElementPosition ( clickedElement )
			if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 10 then
				local model = getElementModel ( clickedElement )
				local count = getElementData ( clickedElement, "count" )
				if guiObjectModels[model] then
					-- Bankautomaten --
					if model == 2942 then
						local bankpin = getElementData(source,"bankpin")
						
						if bankpin == 0 then
							outputChatBox("Du hast noch kein Konto! Gehe zur Bank, um eins zu beantragen.",source,255,0,0)
						else
							triggerClientEvent ( source, "showCashPoint", getRootElement() )
							setElementData ( source, "ElementClicked", true )
						end
					end
					-------------------
				elseif westsideGetElementData ( clickedElement, "weed" ) then
					local x1, y1, z1 = getElementPosition ( source )
					local x2, y2, z2 = getElementPosition ( clickedElement )
					if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 3 then
						local id = westsideGetElementData ( clickedElement, "id" )
						local x3, y3, z3 = getElementPosition ( weedPlants[id] )
						local drugs = math.floor ( ( getMinTime () - westsideGetElementData ( clickedElement, "time" ) ) / 2 )
						if drugs > 50 then
							drugs = 50
						end
						destroyElement ( weedPlants[id] )
						mysql_vio_query ( "DELETE FROM weed WHERE id = '"..id.."'" )
						outputChatBox ( "Du hast "..drugs.." Gramm Drogen geerntet!", source, 0,200,0 )
						westsideSetElementData ( source, "drugs", westsideGetElementData ( source, "drugs" ) + drugs )
					end
				end
				return true
			end
		end
		
		if getElementData ( source, "adminEnterVehicle" ) ~= false then
			if getElementType( clickedElement ) == "vehicle" then
				if getVehicleOccupant ( clickedElement ) then
					removePedFromVehicle ( getVehicleOccupant ( clickedElement ) )
				end
				warpPedIntoVehicle ( source, clickedElement )
				return nil
			end
		end
		
		-- Wanzen --
		if westsideGetElementData ( source, "wanzen" ) then
			if clickedElement then
				if getElementType( clickedElement ) == "vehicle" then
					createWanze ( source, clickedElement, x, y, z )
					return true
				else
					outputChatBox ( "[INFO]: Wanzen können nur an Autos oder in der Umgebung platziert werden!", source, 0,100,150)
				end
			else
				createWanze ( source, clickedElement, x, y, z )
				return true
			end
		end
		
		-----------------
		
		if clickedElement then
			if getElementData( clickedElement, "bank_ped" ) == true then
				triggerClientEvent ( source, "showCashPoint", getRootElement() )
				setElementData ( source, "ElementClicked", true )
			end
		end
		
		-- Special Elements - Player --
		if clickedElement then
			if secondClickTypes[getElementType(clickedElement)] then
				if getElementModel ( clickedElement ) == 283 and not getElementType ( clickedElement ) == "player" then
				
				elseif clickedElement == source then

				elseif getElementType ( clickedElement ) == "vehicle" then
					local veh = clickedElement
					if westsideGetElementData ( player, "wanzen" ) then
						createWanze ( player, clickedElement, false, false, false )
					else
						setElementData ( source, "clickedVehicle", clickedElement )
						triggerClientEvent ( source, "_createCarmenue", getRootElement(), clickedElement )
						showCursor ( source, true )
						setElementData ( source, "ElementClicked", true)
					end
					westsideSetElementData ( source, "curclicked", clickedElement )
					setElementData ( source, "ElementClicked", true )
				elseif getElementType ( clickedElement ) == "player" then
					if westsideGetElementData ( clickedElement, "tazered" ) and isOnStateDuty ( source ) then
						grab_func ( source, "grab", getPlayerName ( clickedElement ) )
					end
				end
			end
		end
	end
end
addEventHandler ( "onPlayerClick", getRootElement (), player_click )

function removeRemoteExplosive ( clickedElement )
	destroyElement ( clickedElement )
	setElementFrozen ( source, false )
end

function cancel_gui_server_func ( player )
	if player then source = player end
	setElementData ( source, "ElementClicked", false )
	--if getElementData(source,"nodmzone") == 1 then toggleControl ( source, "fire", false ) end
	--if getElementData(source,"nodmzone") == 1 then toggleControl ( source, "enter_exit", false ) end
	if getElementData(source,"sprint") == 1 then toggleControl ( source, "sprint", false ) end
end
addEvent ("cancel_gui_server", true )
addEventHandler ( "cancel_gui_server", getRootElement (), cancel_gui_server_func )

function showcurser ( player )
	if tonumber(getElementData ( player, "loggedin" )) == 1 then
		if isCursorShowing ( player ) then
			if not getElementData ( player, "ElementClicked" ) then
				showCursor ( player, false )
			end
		else
			showCursor ( player, true )
			setElementData ( player, "ElementClicked", false )
		end
	end
end

function self_func ( player )
	if not getElementData ( player, "ElementClicked" ) then
		triggerClientEvent ( player, "ShowSelfClickMenue", getRootElement() )
		showCursor ( player, true )
		setElementData ( player, "ElementClicked", true )
	end
end
addCommandHandler ( "self", self_func )