FBIDutyIcon = createPickup ( 1217.74255, -1823.87695, 13.67292, 3, 1239, 50 )

function FBIDutyIconHit ( player )
	if isFBI(player) then
		triggerClientEvent(player,"openDuty",player)
		infobox(player,"Tippe /fumkleide, um die Fraktions\nUmkleide zu betreten!")
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end
addEventHandler ( "onPickupHit", FBIDutyIcon, FBIDutyIconHit )

function sendMSGToBoxville ( msg )
	if getVehicleOccupant ( FederalBoxville, 0 ) then
		outputChatBox ( msg, getVehicleOccupant ( FederalBoxville, 0 ), 125, 125, 0 )
	elseif getVehicleOccupant ( FederalBoxville, 1 ) then
		outputChatBox ( msg, getVehicleOccupant ( FederalBoxville, 1 ), 125, 125, 0 )
	elseif getVehicleOccupant ( FederalBoxville, 2 ) then
		outputChatBox ( msg, getVehicleOccupant ( FederalBoxville, 2 ), 125, 125, 0 )
	elseif getVehicleOccupant ( FederalBoxville, 3 ) then
		outputChatBox ( msg, getVehicleOccupant ( FederalBoxville, 3 ), 125, 125, 0 )
	end
end

function ram_func ( player )
	if getElementData(player,"onDuty") == true and westsideGetElementData ( player, "rang" ) >= 3 then
		local house = westsideGetElementData ( player, "house" )
		local px, py, pz = getElementPosition ( player )
		local hx, hy, hz = getElementPosition ( house )
		if getDistanceBetweenPoints3D ( px, py, pz, hx, hy, hz ) <= 5 then
			if ( getElementModel ( house ) == 1273 or getElementModel ( house ) == 1272 ) and westsideGetElementData ( house, "curint" ) > 0 then
				local i = westsideGetElementData ( house, "curint" )
				westsideSetElementData ( player, "curIntIn", i )
				local int, intx, inty, intz = getInteriorData ( i )
				local dim = westsideGetElementData ( house, "id" )
				if i == 0 then
					dim = 0
				end
				setElementDimension ( player, dim )
				fadeElementInterior ( player, int, intx, inty, intz )
				outputChatBox("[INFO]: Tippe /out, um das Haus zu verlassen und F2 für das Hausmenü.",player,0,100,150)
				bindKey ( player, "F2", "down", house_func )
			end
		end
	end
end
addCommandHandler ( "ram", ram_func )

function killawanze_func ( player, _, wich )
	if isFBI(player) and westsideGetElementData ( player, "rang" ) >= 2 then
		wich = tonumber(wich)
		local bool = false
		if wich == 1 and isElement( _G["Wanze"..wich] ) then
			killWanze ( wich )
			bool = true
		end
		if wich == 2 and isElement( _G["Wanze"..wich] ) then
			killWanze ( wich )
			bool = true
		end
		if wich == 3 and isElement( _G["Wanze"..wich] ) then
			killWanze ( wich )
			bool = true
		end
		if bool == false then
			infobox(player,"Keine Wanze mit dieser\nNummer vorhanden!",4000,255,0,0)
		end
	end
end
addCommandHandler ( "killwanze", killawanze_func )

function refreshBlipsForBoxville ( veh )
	if veh == FederalBoxville then
		for i = 1, 3 do
			if _G["Wanze"..i.."Blip"] then
				setElementVisibleTo ( _G["Wanze"..i.."Blip"], getRootElement(), false )
			end
		end
		if getVehicleOccupant ( FederalBoxville, 0 ) then
			for i = 1, 3 do
				if _G["Wanze"..i.."Blip"] then
					setElementVisibleTo ( _G["Wanze"..i.."Blip"], getVehicleOccupant ( FederalBoxville, 0 ), true )
				end
			end
		elseif getVehicleOccupant ( FederalBoxville, 1 ) then
			for i = 1, 3 do
				if _G["Wanze"..i.."Blip"] then
					setElementVisibleTo ( _G["Wanze"..i.."Blip"], getVehicleOccupant ( FederalBoxville, 1 ), true )
				end
			end
		elseif getVehicleOccupant ( FederalBoxville, 2 ) then
			for i = 1, 3 do
				if _G["Wanze"..i.."Blip"] then
					setElementVisibleTo ( _G["Wanze"..i.."Blip"], getVehicleOccupant ( FederalBoxville, 2 ), true )
				end
			end
		elseif getVehicleOccupant ( FederalBoxville, 3 ) then
			for i = 1, 3 do
				if _G["Wanze"..i.."Blip"] then
					setElementVisibleTo ( _G["Wanze"..i.."Blip"], getVehicleOccupant ( FederalBoxville, 3 ), true )
				end
			end
		end
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), refreshBlipsForBoxville )

function refreshBlipsForBoxvilleExit ( veh )
	if veh == FederalBoxville then
		for i = 1, 3 do
			if _G["Wanze"..i.."Blip"] then
				setElementVisibleTo ( _G["Wanze"..i.."Blip"], source, false )
			end
		end
	end
end
addEventHandler ( "onPlayerVehicleExit", getRootElement(), refreshBlipsForBoxvilleExit )

function wanze_func ( player )
	if isFBI ( player ) then
		outputChatBox ( "[INFO]: Wanze bereit! Tippe auf ein Fahrzeug in deiner Nähe.", player, 0,100,150)
		westsideSetElementData ( player, "wanzen", true )
	end
end
addCommandHandler ( "wanze", wanze_func )

function createWanze ( player, clickedElement, x, y, z )
	if not x then
		x, y, z = getElementPosition ( clickedElement )
	end
	local px, py, pz = getElementPosition ( player )
	if getDistanceBetweenPoints3D ( px, py, pz, x, y, z ) < 5 then
		if westsideGetElementData ( player, "rang" ) >= 2 then
			if wanzen <= 2 then
				local c
				for i = 1, 3 do
					if not _G["Wanze"..i] then
						c = i
						break
					end
				end
				if not clickedElement then
					infobox(player,"Wanze plaziert!",4000,0,255,0)
					westsideSetElementData ( player, "wanzen", false )
					showCursor ( player, false )
					_G["Wanze"..c] = createObject ( 1317, x, y, z )
					setTimer ( killWanze, 60*60*1000, 1, c )
					_G["Wanze"..c.."Blip"] = createBlip ( x, y, z, 0, 2, 255, 0, 0, 255, 0, wanzenrange, nil )
					wanzen = wanzen + 1
					setElementAlpha ( _G["Wanze"..c], 0 )
				elseif getElementType ( clickedElement ) == "vehicle" then
					infobox(player,"Wanze plaziert!",4000,0,255,0)
					westsideSetElementData ( player, "wanzen", false )
					showCursor ( player, false )
					_G["Wanze"..c] = createObject ( 1317, x, y, z )
					setTimer ( killWanze, 60*60*1000, 1, c )
					_G["Wanze"..c.."Blip"] = createBlip ( x, y, z, 0, 2, 255, 0, 0, 255, 0, wanzenrange, nil )
					attachElements ( _G["Wanze"..c], clickedElement )
					attachElements ( _G["Wanze"..c.."Blip"], _G["Wanze"..c] )
					wanzen = wanzen + 1
					setElementAlpha ( _G["Wanze"..c], 0 )
				end
				refreshBlipsForBoxville ( FederalBoxville )
			else
				infobox(player,"Es sind bereits zu\nviele Wanzen plaziert!",4000,255,0,0)
			end
		else
			infobox(player,"Du bist nicht befugt!",4000,255,0,0)
		end
	else
		infobox(player,"Du bist zu weit weg!",4000,255,0,0)
	end
	westsideSetElementData ( player, "wanzen", false )
end

function killWanze ( count )
	destroyElement ( _G["Wanze"..count] )
	destroyElement ( _G["Wanze"..count.."Blip"] )
	sendMSGForFaction ( "[INFO]: Wanze Nr. "..count.." hat sich verabschiedet!", 6, 200,200,0 )
	refreshBlipsForBoxville ( veh )
	wanzen = wanzen - 1
	_G["Wanze"..count] = false
end