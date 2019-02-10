function createHouse ( player, cmd, preis, int )

	local Preis = tonumber ( preis ) 
	local CurrentInterior = tonumber ( int )
	if westsideGetElementData ( player, "adminlvl" ) >= 3 then
		if Preis ~= nil then
			if CurrentInterior ~= nil then
				for i = 1, 9999 do
					local exist = MySQL_DatasetExist("houses", "ID LIKE '"..i.."'")
					if exist == true then
					else
						local ID = i
						local SymbolX, SymbolY, SymbolZ = getElementPosition ( player )
						local Besitzer = "none"
						local Preis = tonumber ( preis )
						local CurrentInterior = tonumber ( int )
						local result = mysql_query(handler, "INSERT INTO houses (ID, SymbolX, SymbolY, SymbolZ, Besitzer, Preis, CurrentInterior, Kasse, Miete) VALUES ('"..ID.."', '"..SymbolX.."', '"..SymbolY.."', '"..SymbolZ.."', '"..Besitzer.."', '"..Preis.."', '"..CurrentInterior.."', '0', '0')")
						if( not result) then
							outputDebugString("Error executing the query: ("		.. mysql_errno(handler) .. ") " .. mysql_error(handler))
						else
							mysql_free_result(result)
							infobox(player,"Du hast ein Haus mit der ID:\n"..i.." angelegt!")
							createHouse ( ID, SymbolX, SymbolY, SymbolZ, Besitzer, Preis, Mindestzeit, CurrentInterior, 0, 0 )
							break
						end
					end
				end
			else
				infobox(player,"Tippe /newhouse [Preis], [Interior]!")
			end
		else
			infobox(player,"Tippe /newhouse [Preis], [Interior]!")
		end
	end
end
addCommandHandler ( "newhouse", createHouse )

function iraeume ( player, cmd, i )

	if westsideGetElementData ( player, "adminlvl" ) >= 3 then
		local int, intx, inty, intz = getInteriorData ( i )
		setElementInterior ( player, int, intx, inty, intz )
	end
end
addCommandHandler ( "iraum", iraeume )

function in_func ( player )

	local house = westsideGetElementData ( player, "house" )
	local px, py, pz = getElementPosition ( player )
	local hx, hy, hz = getElementPosition ( house )
	if getDistanceBetweenPoints3D ( px, py, pz, hx, hy, hz ) <= 5 then
		if ( getElementModel ( house ) == 1273 or getElementModel ( house ) == 1272 ) and westsideGetElementData ( house, "curint" ) > 0 then
			if not westsideGetElementData ( house, "locked" ) or math.abs ( westsideGetElementData ( player, "housekey" ) ) == westsideGetElementData ( house, "id" ) then
				local i = westsideGetElementData ( house, "curint" )
				westsideSetElementData ( player, "curIntIn", i )
				local int, intx, inty, intz = getInteriorData ( i )
				local dim = westsideGetElementData ( house, "id" )
				if i == 0 then
					dim = 0
				end
				setElementDimension ( player, dim )
				fadeElementInterior ( player, int, intx, inty, intz )
				bindKey ( player, "F4", "down", house_func )
			end
		end
	end
end
addCommandHandler ( "in", in_func )

function excuteEnter(player)
	executeCommandHandler('in', player)
end
addEvent('onHouseEnter', true)
addEventHandler('onHouseEnter', root, excuteEnter)

function out_func ( player )

	local dim = getElementDimension ( player )
	local haus = westsideGetElementData ( player, "house" )
	if not isElement ( haus ) then
		haus = houses["pickup"][getElementDimension ( player )]
	end
	if isElement ( haus ) then
		local i = westsideGetElementData ( haus, "curint" )
		local int, intx, inty, intz = getInteriorData ( i )
		local px, py, pz = getElementPosition ( player )
		if getDistanceBetweenPoints3D ( px, py, pz, intx, inty, intz ) <= 10 then
			westsideGetElementData ( player, "curIntIn", 0 )
			local dim = getElementDimension ( player )
			local sx, sy, sz = getElementPosition ( haus )
			fadeElementInterior ( player, 0, sx, sy, sz )
			setElementDimension ( player, 0 )
			unbindKey ( player, "F2", "down", house_func )
		end
	end
end
addCommandHandler ( "out", out_func )

addEvent('onRentOut', true)
addEventHandler('onRentOut', root, function(player)
	executeCommandHandler('unrent', player)
end)

function rent_func ( player )

	local haus = westsideGetElementData ( player, "house" )
	local x1, y1, z1 = getElementPosition ( player )
	local x2, y2, z2 = getElementPosition ( haus )
	local pname = getPlayerName ( player )
	local distance = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 )
	local miete = tonumber ( westsideGetElementData ( haus, "miete" ) )
	local kasse = tonumber ( westsideGetElementData ( haus, "kasse" ) )
	if distance < 5 then
		if westsideGetElementData ( haus, "miete" ) >= 1 and westsideGetElementData ( haus, "owner" ) ~= "none" then
			if westsideGetElementData ( player, "housekey" ) == 0 then
				if westsideGetElementData ( player, "money" ) >= miete then
					westsideSetElementData ( player, "housekey", tonumber ( westsideGetElementData ( haus, "id" ) ) * -1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast dich erfolgreich eingemietet!", 4000, 0, 255, 0 )
					moneychange ( player, miete*-1 )
					kasse = MySQL_GetString ( "houses", "Kasse", "ID LIKE '" ..getElementDimension ( player ).."'" )
					MySQL_SetString("houses", "Kasse", kasse + miete, "ID LIKE '"..westsideGetElementData ( haus, "id" ).."'")
					westsideSetElementData ( haus, "kasse", kasse + miete )
					
					outputLog("[HAUS]: "..getPlayerName(player).." hat sich in einem Haus eingemietet!","Haussystem")
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast zu wenig Geld!", 4000, 255, 0, 0 )
				end
			elseif westsideGetElementData ( player, "housekey" ) < 0 then
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist bereits in\neinem Haus eingemietet!", 4000, 255, 0, 0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Dir gehört bereits ein Haus!", 4000, 255, 0, 0 )
			end
		else
			infobox(player,'Dieser Besitzer möchte keine Mieter!')
		end
	end
end
addCommandHandler ( "rent", rent_func )

function excuteEnterRent(player)
	executeCommandHandler('rent', player)
end
addEvent('onRentHouse', true)
addEventHandler('onRentHouse', root, excuteEnterRent)

function sellhouse_func ( player )

	local ID = tonumber ( westsideGetElementData ( player, "housekey" ) )
	if ID > 0 then
		local haus = houses["pickup"][ID]
		local pname = getPlayerName ( player )
		if not MySQL_DatasetExist ( "buyit", "Anbieter LIKE '"..pname.."' AND Typ LIKE 'Houses'" ) then
			outputLog ( pname.." hat sein Haus verkauft.", "house" )
			westsideSetElementData ( player, "spawnpos_x", -2458.288085 )
			westsideSetElementData ( player, "spawnpos_y", 774.354492 )
			westsideSetElementData ( player, "spawnpos_z", 35.171875 )
			westsideSetElementData ( player, "spawnrot_x", 52 )
			westsideSetElementData ( player, "spawnint", 0 )
			westsideSetElementData ( player, "spawndim", 0 )
			westsideSetElementData ( player, "housekey", 0 )
			local owner = westsideGetElementData ( haus, "owner" )
			westsideSetElementData ( haus, "owner", "none" )
			setElementModel ( haus, 1273 )
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast soeben dein Haus verkauft!", 4000, 0, 255, 0 )
			MySQL_SetString("houses", "Besitzer", "none", "Besitzer LIKE '"..getPlayerName(player).."'")
			MySQL_SetString("userdata", "Hausschluessel", 0, "Name LIKE '"..getPlayerName(player).."'")
			local hauswert = tonumber ( westsideGetElementData ( haus, "preis" ) )
			moneychange ( player, hauswert )
			datasave_remote(player)
			
			outputLog("[HAUS]: "..getPlayerName(player).." hat sein Haus verkauft!","Haussystem")
		end
	end
end
addCommandHandler ( "sellhouse", sellhouse_func )

function sellHouseExcute(player)
	executeCommandHandler('sellhouse', player)
end
addEvent('onHouseSellGUI', true)
addEventHandler('onHouseSellGUI', root, sellHouseExcute)

function unrent_func ( player )

	local ID = westsideGetElementData ( player, "housekey" )
	if ID < 0 then
		westsideSetElementData ( player, "spawnpos_x", -2458.288085 )
		westsideSetElementData ( player, "spawnpos_y", 774.354492 )
		westsideSetElementData ( player, "spawnpos_z", 35.171875 )
		westsideSetElementData ( player, "spawnrot_x", 52 )
		westsideSetElementData ( player, "spawnint", 0 )
		westsideSetElementData ( player, "spawndim", 0 )
		westsideSetElementData ( player, "housekey", 0 )
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast dich ausgemietet!", 7500, 0, 125, 0 )
		
		outputLog("[HAUS]: "..getPlayerName(player).." hat sich ausgemietet!","Haussystem")
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nirgendswo eingemietet!", 7500, 125, 0, 0 )
	end
end
addCommandHandler ( "unrent", unrent_func )

function setrent_func ( player, cmd, preis )

	local ID = westsideGetElementData ( player, "housekey" )
	local haus = houses["pickup"][ID]
	local preis = math.abs(math.floor(preis))
	if ID > 0 then
		local miete =  math.abs ( tonumber ( preis ) )
		if miete and miete <= 500 then
			westsideSetElementData ( haus, "miete", miete )
			MySQL_SetString("houses", "Miete", miete, "ID LIKE '"..westsideGetElementData ( haus, "id" ).."'")
			if miete == 0 then
			end
		end
	end
end
addCommandHandler ( "setrent", setrent_func )

function excuteRent(player, rent)
	executeCommandHandler('setrent', player, rent)
end
addEvent('onHouseSetRent', true)
addEventHandler('onHouseSetRent', root, excuteRent)

function house_func ( player, key, state )

	if isInUserHouse ( player ) then
		local amount = MySQL_GetString ( "houses", "Kasse", "ID LIKE '" ..getElementDimension ( player ).."'" )
		if amount then
			if not getElementData ( player, "ElementClicked" ) then
				setElementData ( player, "ElementClicked", true )
				showCursor ( player, true )
				local id = getElementDimension ( player )
				triggerClientEvent ( player, "showHouseGui", player, amount )
			end
		end
	end
end

function hlock_func ( player )

	local hkey = westsideGetElementData ( player, "housekey" )
	if hkey > 0 then
		westsideSetElementData ( houses["pickup"][hkey], "locked", not westsideGetElementData ( houses["pickup"][hkey], "locked" ) )
		if westsideGetElementData ( houses["pickup"][hkey], "locked" ) then fix = "ab" else fix = "auf" end
		outputChatBox ( "Haus "..fix.."geschlossen!", player, 0,150,0)
		triggerClientEvent(player, 'onSetHouseState', player)
	end
end
addCommandHandler ( "hlock", hlock_func )

function excuteHLock(player)
	executeCommandHandler('hlock', player)
end
addEvent('onHouseSetState', true)
addEventHandler('onHouseSetState', root, excuteHLock)

function houseClickServer_func ( player, cmd, amount )

	playSoundFrontEnd ( player, 20 )

	if cmd == "heal" then
		setElementHealth ( player, 100 )
	elseif cmd == "take" or cmd == "give" then
		if amount then
			amount = math.abs(math.floor(amount))
			if getElementDimension ( player ) == westsideGetElementData ( player, "housekey" ) then
				local houseAmount = tonumber ( MySQL_GetString ( "houses", "Kasse", "ID LIKE '" ..westsideGetElementData ( player, "housekey" ).."'" ) )
				if cmd == "take" then
					if houseAmount >= amount then
						givePlayerSaveMoney ( player, amount )
						MySQL_SetString("houses", "Kasse", houseAmount - amount, "ID LIKE '"..westsideGetElementData ( player, "housekey" ).."'")
						triggerClientEvent ( "showHouseGui", player, houseAmount - amount )
					else
						infobox(player,"Du hast nicht genug\nGeld in der Kasse!",4000,255,0,0)
					end
				elseif cmd == "give" then
					if westsideGetElementData ( player, "money" ) >= amount then
						takePlayerSaveMoney ( player, amount )
						MySQL_SetString("houses", "Kasse", houseAmount + amount, "ID LIKE '"..westsideGetElementData ( player, "housekey" ).."'")
						triggerClientEvent ( "showHouseGui", player, houseAmount + amount )
					else
                       infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
					end
				end
			else
				infobox(player,"Du bist nicht befugt!",4000,255,0,0)
			end
		else
			infobox(player,"Ungültiger Wert!",4000,255,0,0)
		end
	end
end
addEvent ( "houseClickServer", true )
addEventHandler ( "houseClickServer", getRootElement(), houseClickServer_func )