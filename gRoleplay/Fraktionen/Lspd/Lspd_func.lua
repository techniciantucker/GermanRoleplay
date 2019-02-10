-- Duty & Swat

LSPD = createBlip ( 1552.89233,-1675.49280,16.19531,30,2,255,0,0,255,0,200,getRootElement())

LSPDDutyPickup = createPickup(257.00317, 70.26176, 1003.64063,3,1242,500)
setElementInterior(LSPDDutyPickup,6)

function SAPDDutyHit(player)
	if isCop(player) then
		triggerClientEvent(player,"openDuty",player)
		infobox(player,"Tippe /fumkleide, um die Fraktions\nUmkleide zu betreten!")
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end
addEventHandler("onPickupHit",LSPDDutyPickup,SAPDDutyHit)

addEvent("duty",true)
addEventHandler("duty",getRootElement(),function(player,skin)
	if getElementData(player,"onDuty") == false then
		if isCop(player) then
			takeAllWeapons(player)		 -- Waffen abnehmen
				
			setElementModel(player,math.random(281,284))
			giveWeapon(player,3,1,true)   -- Schlagstock
			giveWeapon(player,24,21,true) -- Desert Eagle
					
			setElementData(player,"onDuty",true)
					
			if westsideGetElementData(player,"rang") >= 1 and westsideGetElementData(player,"rang") <= 5 then
				giveWeapon(player,29,100,true) -- Mp5
				giveWeapon(player,31,100,true) -- M4
			end
		elseif isFBI(player) then
			local curskin = getElementModel(player)
			if getElementData(player,"onDuty") == false then
				takeAllWeapons(player)		 -- Waffen abnehmen
					
				setElementData(player,"onDuty",true)
				
				if skin == "2" then
					setElementModel(player,165)
				elseif skin == "3" then
					setElementModel(player,164)
				elseif skin == "4" then
					setElementModel(player,163)
				else
					setElementModel(player,286)
				end
				if westsideGetElementData(player,"rang") < 1 then
					giveWeapon(player,3,1,true)   -- Schlagstock
					giveWeapon(player,24,21,true) -- Desert Eagle
				elseif westsideGetElementData(player,"rang") > 1 and westsideGetElementData(player,"rang") < 3 then
					giveWeapon(player,3,1,true)    -- Schlagstock
					giveWeapon(player,24,21,true)  -- Desert Eagle
					giveWeapon(player,29,100,true) -- Mp5
					giveWeapon(player,31,100,true) -- M4
				else
					giveWeapon(player,3,1,true)    -- Schlagstock
					giveWeapon(player,24,21,true)  -- Desert Eagle
					giveWeapon(player,29,100,true) -- Mp5
					giveWeapon(player,31,100,true) -- M4
				end
			else
				infobox(player,"Du bist bereits im Dienst!",4000,255,0,0)
			end
		elseif isArmy(player) then
			takeAllWeapons(player)		 -- Waffen abnehmen
					
			setElementData(player,"onDuty",true)
			
			giveWeapon(player,3,1,true)    -- Schlagstock
			giveWeapon(player,24,21,true)  -- Desert Eagle
			giveWeapon(player,29,100,true) -- Mp5
			giveWeapon(player,31,100,true) -- M4
			
			if westsideGetElementData(player,"rang") == 0 then
				setElementModel(player,73)
			else
				setElementModel(player,312)
			end
		elseif isMechaniker(player) then
			takeAllWeapons(player)		 -- Waffen abnehmen
					
			setElementData(player,"onDuty",true)
		
		    setPlayerSkin(player,50) 		-- Mechaniker Skin
		    setElementHealth(player,100)	-- Leben auffüllen
		    setPedArmor(player,100)			-- Weste auffüllen
		    giveWeapon(player,41,9999,true)	-- Spraydose zum Wehren
		end
		setElementHealth(player,100) -- Leben
		setPedArmor(player,100)		 -- Weste
	else
		infobox(player,"Du bist bereits im Dienst!",4000,255,0,0)
	end
end)

addEvent("swat",true)
addEventHandler("swat",getRootElement(),function(player,skin)
	if isCop(player) or isFBI(player) then

		local curskin = getElementModel ( player )
		if getElementData(player,"onDuty") == false then
			if curskin ~= 285 then
				if westsideGetElementData(player,"rang") > 2 then
					setElementData(player,"onDuty",true)
					takeAllWeapons(player)		 -- Waffen abnehmen
					
					setElementModel(player,285)
					giveWeapon(player,3,1,true)    -- Schlagstock
					giveWeapon(player,24,21,true)  -- Desert Eagle
					giveWeapon(player,29,100,true) -- Mp5
					giveWeapon(player,31,100,true) -- M4
					giveWeapon(player,34,15,true)  -- Sniper
				else
					infobox(player,"Erst ab Rang 3!",4000,255,0,0)
				end
			else
				infobox(player,"Du bist bereits im Dienst!",4000,255,0,0)
			end
		else
			infobox(player,"Du bist bereits im Dienst!",4000,255,0,0)
		end
	end
end)

addEvent("offduty",true)
addEventHandler("offduty",getRootElement(),function(player)
	if getElementData(player,"onDuty") == true then
		if isPedInVehicle(player) == false then
			setPedSkin(player,westsideGetElementData(player,"skinid"))
			setElementData(player,"onDuty",false)
			
			takeAllWeapons(player) -- Waffen abnehmen
		else
			infobox(player,"Verlasse dein Fahrzeug",4000,255,0,0)
		end
	else
		outputChatBox("Du bist nicht im Dienst!",player,255,0,0)
	end
end)

----- Alkoholtest / Drogentest -----
addCommandHandler('pTest',function(player,cmd,target)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(isCop(player))or(isFBI(player))or(isArmy(player))and(getElementData(player,'onDuty')==true)then
			if(target)then
				local tplayer=getPlayerFromName(target)
				local tx,ty,tz=getElementPosition(tplayer)
				local x,y,z=getElementPosition(player)
				if(getDistanceBetweenPoints3D(tx,ty,tz,x,y,z)<=10)then
					outputChatBox('[INFO]: Officer '..getPlayerName(player)..' fordert dich zu einem Alkohol/Drogentest auf!',tplayer,0,200,0)
					outputChatBox('Tippe /testAccept, um diesem zuzustimmen.',tplayer,0,200,0)
					infobox(player,'Du hast den Spiele zu einem\nTest aufgefordert!')
					setElementData(tplayer,'tester',getPlayerName(player))
				else
					infobox(player,'Du bist zu weit weg!')
				end
			else
				infobox(player,'Kein Spieler angegeben!')
			end
		end
	end
end)

addCommandHandler('testAccept',function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(not(getElementData(player,'tester')==nil))then
			local tester=getPlayerFromName(getElementData(player,'tester'))
			local tx,ty,tz=getElementPosition(tester)
			local x,y,z=getElementPosition(player)
			if(getDistanceBetweenPoints3D(tx,ty,tz,x,y,z)<=10)then
				infobox(player,'Du hast dem Test zugestimmt!')
				if(westsideGetElementData(player,'drogenPegel')>0)then
					outputChatBox('Bei '..getPlayerName(player)..' konnten Anzeichen von Drogen festgestellt werden!',tester,150,0,0)
				else
					outputChatBox('Bei '..getPlayerName(player)..' konnten keine Anzeichen von Drogen festgestellt werden!',tester,0,150,0)
				end
				if(westsideGetElementData(player,'alkoholPegel')>0)then
					outputChatBox('Bei '..getPlayerName(player)..' konnten Anzeichen von Alkohol festgestellt werden!',tester,150,0,0)
				else
					outputChatBox('Bei '..getPlayerName(player)..' konnten keine Anzeichen von Alkohol festgestellt werden!',tester,0,150,0)
				end
			else
				infobox(player,'Du bist zu weit weg!')
			end
		end
	end
end)

----- Durchsuchen & abnehmen -----
addCommandHandler('frisk',function(player,cmd,target)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(isCop(player))or(isFBI(player))or(isArmy(player))and(getElementData(player,'onDuty')==true)then
			if(target)then
				local tplayer=getPlayerFromName(target)
				local tx,ty,tz=getElementPosition(tplayer)
				local x,y,z=getElementPosition(player)
				local mats=westsideGetElementData(tplayer,'mats')
				local drugs=westsideGetElementData(tplayer,'drugs')
				if(getDistanceBetweenPoints3D(tx,ty,tz,x,y,z)<=10)then
					outputChatBox('[INFO]: Gegenstände von '..getPlayerName(tplayer)..':',player,0,100,150)
					outputChatBox('Mats: '..mats..' Stk, Drogen: '..drugs..'g',player,0,100,150)
					infobox(tplayer,getPlayerName(player)..' hat dich durchsucht!')
				else
					infobox(player,'Du bist zu weit weg!')
				end
			else
				infobox(player,'Kein Spieler angegeben!')
			end
		end
	end
end)

addCommandHandler('takeIllegal',function(player,cmd,target)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(isCop(player))or(isFBI(player))or(isArmy(player))and(getElementData(player,'onDuty')==true)then
			if(target)then
				local tplayer=getPlayerFromName(target)
				outputChatBox('[INFO]: Du hast '..getPlayerName(tplayer)..' seine illegalen Gegenstände abgenommen!',player,0,100,150)
				westsideSetElementData(tplayer,'drugs',0)
				westsideSetElementData(tplayer,'mats',0)
				outputChatBox('[INFO]: '..getPlayerName(player)..' hat dir deine illegalen Gegenstände abgenommen!',tplayer,0,100,150)
			else
				infobox(player,'Kein Spieler angegeben!')
			end
		end
	end
end)

----- Fußfesseln anlegen -----
addCommandHandler('cuff',function(player,cmd,target)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(isCop(player))or(isFBI(player))or(isArmy(player))and(getElementData(player,'onDuty')==true)then
			if(target)then
				local tplayer=getPlayerFromName(target)
				outputChatBox('Dir wurden Fußfesseln angelegt!',tplayer,150,0,0)
				outputChatBox('Du hast '..getPlayerName(tplayer)..' Fußfesseln angelegt!',player,0,150,0)
				toggleControl(tplayer,"sprint",false)
				toggleControl(tplayer,"walk",false)
				setControlState(tplayer,"walk",true)
				setTimer(function()
					toggleControl(tplayer,"sprint",true)
					toggleControl(tplayer,"walk",true)
					setControlState(tplayer,"walk",false)
					outputChatBox('Du kannst nun wieder rennen!',tplayer,0,150,0)
				end,30000,1)
			else
				infobox(player,'Kein Spieler angegeben!')
			end
		end
	end
end)

-- Waffenschein abnehmen

function takegunlicenseGUI_func ( pname )
	takegunlicense_func ( client, "takegunlicense", pname )
end
addEvent ( "takegunlicenseGUI", true )
addEventHandler ( "takegunlicenseGUI", getRootElement(), takegunlicenseGUI_func )

function takegunlicense_func ( player, cmd, targetName )
	if isCop(player) or isFBI(player) or isArmy(player) and getElementData(player,"onDuty") == true and westsideGetElementData ( player, "rang" ) >= 3 then
		if getElementData(player,"onDuty") == true then
			local target = findPlayerByName( targetName )
			if isElement ( target ) then
				if westsideGetElementData ( target, "gunlicense" ) > 0 then
					westsideSetElementData ( target, "gunlicense", 0 )
					mysql_vio_query ( "UPDATE userdata SET Waffenschein = '0' WHERE Name LIKE '"..targetName.."'" )
					outputChatBox("[INFO]: Du hast "..targetName.." den Waffenschein abgenommen!",player,0,100,150)
					outputChatBox("[INFO]: "..getPlayerName(player).." hat dir den Waffenschein abgenommen!",target,0,100,150)
				else
					outputChatBox("Der Spieler hat\nkeinen Waffenschein!",player,125,0,0)
				end
			else
				infobox(player,"Ungültiger Spieler!",4000,255,0,0)
			end
		end
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end
addCommandHandler ( "takegunlicense", takegunlicense_func )

-- Wanteds & StVo Punkte setzen

function pdComputerSetWanted_func ( wanteds, name, reason )

	if wanteds >= 0 and wanteds <= 6 then
		local player = getPlayerFromName ( name )
		if player then
			if isStateFaction ( client ) then
				if westsideGetElementData(player,"wanteds") <= 6 then
					westsideSetElementData(player,"wanteds",tonumber(westsideGetElementData(player,"wanteds") + wanteds))
					setPlayerWantedLevel ( player, wanteds )
				
					outputChatBox(getPlayerName(client).." hat dein Fahndungslevel um "..wanteds.." erhöht! ("..reason..")",player,200,0,0)

					sendMSGForFaction (getPlayerName ( client ).." hat "..name.." sein Fahndungslevel auf "..wanteds.." erhöht ( "..reason.." )!", 1, 0,150,150)
					sendMSGForFaction (getPlayerName ( client ).." hat "..name.." sein Fahndungslevel auf "..wanteds.." erhöht ( "..reason.." )!", 6, 0,150,150)
					sendMSGForFaction (getPlayerName ( client ).." hat "..name.." sein Fahndungslevel auf "..wanteds.." erhöht ( "..reason.." )!", 8, 0,150,150)
				else
					infobox(client,"Der Spieler hat bereits das\nhöchst mögliche Fahndungslevel!")
				end
			end
		else
			infobox(client,"Ungültiger Spieler!",4000,255,0,0)
		end
	end
end
addEvent ( "pdComputerSetWanted", true )
addEventHandler ( "pdComputerSetWanted", getRootElement(), pdComputerSetWanted_func )

function pdComputerAddSTVO_func ( name, reason )

	local player = getPlayerFromName ( name )
	if player then
		if westsideGetElementData(player,"stvo_punkte") <= 15 then
			westsideSetElementData ( player, "stvo_punkte", tonumber ( westsideGetElementData ( player, "stvo_punkte" ) + 1) )
			
			outputChatBox("Du hast "..name.." einen StVo Punkt gegeben! ("..reason..")",client,0,150,150)
			outputChatBox(getPlayerName(client).." hat dir einen StVo Punkt gegeben! ("..reason..")",player,200,0,0)
		else
			infobox(client,"Der Spieler hat bereits die\nhöchst mögliche Anzahl von\nStVo Punkten!")
		end
	else
		infobox(client,"Ungültiger Spieler!",4000,255,0,0)
	end
end
addEvent ( "pdComputerAddSTVO", true )
addEventHandler ( "pdComputerAddSTVO", getRootElement(), pdComputerAddSTVO_func )

-- Ticket

function ticket_func ( player, cmd, target, price )
	local target = findPlayerByName( target )
	local price = tonumber ( price )
	
	if isCop(player) or isFBI(player) or isArmy(player) and getElementData(player,"onDuty") == true then
		if target then
			if price then
				price = math.floor ( math.abs ( price ) )
				if westsideGetElementData ( target, "wanteds" ) == 1 and 2 then
					if westsideGetElementData ( target, "money" ) >= price then
						outputChatBox ( "[INFO]: "..getPlayerName ( player ).." bietet dir ein Ticket an: "..price.." $ für Straferlass!", target, 0,100,150 )
						outputChatBox ( "Tippe /accept ticket, um zuzustimmen.", target, 0, 125, 0 )
						westsideSetElementData ( target, "ticketprice", price )
						outputChatBox("[INFO]: Du hast "..getPlayerName(target).." ein Ticket angeboten!",player,0,100,150)
					else
						infobox(player,"Der Spieler hat\nnicht genug Geld!",4000,255,0,0)
					end
				else
					infobox(player,"Der Spieler hat\nkeinen Wanted!",4000,255,0,0)
				end
			end
		else
			infobox(player,"Nutze: /ticket [Name],\n[Preis]!",4000,0,100,150)
		end
	else
		infobox(player,"Nutze: /ticket [Name],\n[Preis]!",4000,0,100,150)
	end
end
addCommandHandler ( "ticket", ticket_func )

function accept_ticket_func ( player, cmd, after )
	if after == "ticket" then
		local price = westsideGetElementData ( player, "ticketprice" )
		local money = westsideGetElementData ( player, "money" )
		if price then
			if money >= price then
				if westsideGetElementData ( player, "wanteds" ) == 1 then
					westsideSetElementData ( player, "wanteds", 0 )
					setPlayerWantedLevel ( player, 0 )
					takePlayerSaveMoney ( player, price )
					westsideSetElementData ( player, "ticketprice", nil )
					infobox(player,"Deine Strafe wurde\ndir erlassen!",4000,255,0,0)
				else
					infobox(player,"Du hast keine Wanteds!",4000,255,0,0)
				end
			else
				infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
			end
		else
			infobox(player,"Dir wurde kein\nTicket angeboten!",4000,255,0,0)
		end
	end
end
addCommandHandler ( "accept", accept_ticket_func )

-- Graben

function grab_func ( player, cmd, targetName )
	if not client or client == player then
		local target = findPlayerByName( targetName )
		if isCop(player) or isFBI(player) or isArmy(player) and getElementData(player,"onDuty") == true then
			if isElement ( target ) then
				if westsideGetElementData ( target, "tazered" ) then
					local x1, y1, z1 = getElementPosition ( player )
					local x2, y2, z2 = getElementPosition ( target )
					if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) < 10 then
						local veh = getPedOccupiedVehicle ( player )
						local model = getElementModel ( veh )
						local validSeats = {}
						if copcars[model] or model == 497 or model == 427 or model == 490 or model == 609 or model == 470 then
							for i = 2, 3 do
								if not getVehicleOccupant ( veh, i ) then
								validSeats[i] = true
								end
							end
						elseif copbikes[model] or model == 415 or model == 601 or model == 433 or model == 548 or 563 then
							if not getVehicleOccupant ( veh, 1 ) then
								validSeats[1] = true
							end
						else
							outputChatBox("Du sitzt in keinem Fahrzeug!",player,125,0,0)
							return
						end
						for key, index in pairs ( validSeats ) do
							warpPedIntoVehicle ( target, veh, key )
							executeCommandHandler ( "tie", player, targetName )
							return
						end
						infobox(player,"Du hast keinen\nfreien Sitz mehr!",4000,255,0,0)
					else
						infobox(player,"Das Ziel ist\nzu weit weg!",4000,255,0,0)
					end
				else
					infobox(player,"Der Spieler muss\ngetazert sein!",4000,255,0,0)
				end
			else
				infobox(player,"Ungültiger Spieler!",4000,255,0,0)
			end
		end
	end
end
addCommandHandler ( "grab", grab_func )
addEvent ( "grab", true )
addEventHandler ( "grab", getRootElement(), grab_func )

-- Megafon

function m_func ( player, cmd, ... )
	local veh = getPedOccupiedVehicle ( player )
	if veh then
		if isFederalCar( veh ) and getElementData(player,"onDuty") == true then
			local parametersTable = {...}
			local stringWithAllParameters = table.concat( parametersTable, " " )
			local posX, posY, posZ = getElementPosition ( player )
			local chatSphere = createColSphere( posX, posY, posZ, 30 )
			local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
			destroyElement( chatSphere )
			for index, nearbyPlayer in ipairs( nearbyPlayers ) do
				local x1, y1, z1 = getElementPosition ( player )
				local x2, y2, z2 = getElementPosition ( nearbyPlayer)
				local distance = getDistanceBetweenPoints3D ( x1,y1,z1,x2,y2,z2 )
				local pname = getPlayerName ( player )
				if getElementDimension ( player ) == getElementDimension ( nearbyPlayer ) then
					outputChatBox ( "["..getPlayerRankName ( player ).." "..pname.."]: " ..stringWithAllParameters, nearbyPlayer, 255, 255, 20 )
				end
			end
		end
	else
		infobox(player,"Du sitzt in keinem Fahrzeug!",4000,255,0,0)
	end
end
addCommandHandler ( "m", m_func )

function mm_func ( player, cmd, ... )
	local veh = getPedOccupiedVehicle ( player )
	if veh then
		if isFederalCar( veh ) then
			local parametersTable = {...}
			local stringWithAllParameters = table.concat( parametersTable, " " )
			local posX, posY, posZ = getElementPosition ( player )
			local chatSphere = createColSphere( posX, posY, posZ, 30 )
			local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
			destroyElement( chatSphere )
			for index, nearbyPlayer in ipairs( nearbyPlayers ) do
				local x1, y1, z1 = getElementPosition ( player )
				local x2, y2, z2 = getElementPosition ( nearbyPlayer)
				local distance = getDistanceBetweenPoints3D ( x1,y1,z1,x2,y2,z2 )
				local pname = getPlayerName ( player )
				if getElementDimension ( player ) == getElementDimension ( nearbyPlayer ) then
					outputChatBox ( "["..getPlayerRankName ( player ).." "..pname.."]: " ..stringWithAllParameters, nearbyPlayer, 237, 7, 7)
				end
			end
		end
	else
		infobox(player,"Du sitzt in keinem Fahrzeug!",4000,255,0,0)
	end
end
addCommandHandler ( "mm", mm_func )

-- Wanted per Kurzbefehl

function suspect_func ( player, cmd, target, r1, r2, r3, r4 )

	if player == client or not client then
		if r1 == nil then
			infobox(player,"Du hast keinen Grund angegeben!",4000,255,0,0)
		else
			if isCop(player) or isFBI(player) or isArmy(player) and getElementData(player,"onDuty") == true then
				local target = findPlayerByName( target )
				if not r2 then r2 = "" end
				if not r3 then r3 = "" end
				if not r4 then r4 = "" end
				local reason = r1..r2..r3..r4
				if getElementType ( target ) == "player" and westsideGetElementData ( target, "loggedin" ) == 1 then
					local model = getElementModel ( getPedOccupiedVehicle ( player ) )
					if copcars[model] or model == 497 or model == 427 or model == 490 or model == 609 or model == 470 or copbikes[model] or model == 415 or model == 601 or model == 433 or model == 548 or 563 then
						if westsideGetElementData ( target, "wanteds" ) <= 5 then
							westsideSetElementData ( target, "wanteds", westsideGetElementData ( target, "wanteds" ) + 1 )
							setPlayerWantedLevel ( target, westsideGetElementData ( target, "wanteds" ) )
						end
						outputChatBox ( "[INFO]: Du hast ein Verbrechen begangen: "..reason.."! Gemeldet von: "..getPlayerName(player), target, 0,100,150 )
						local msg = "[INFO]: "..getPlayerName(player).." hat "..getPlayerName(target).." ein Wanted wegen "..reason.." gegeben!"
						sendMSGForFaction ( msg, 1, 200,200,0)
						sendMSGForFaction ( msg, 6, 200,0,0)
					end
				else
					infobox(player,"Ungültiger Spieler!",4000,255,0,0)
				end
			end
		end
	end
end
addCommandHandler("su",suspect_func)
addCommandHandler("suspect", suspect_func)
addEvent ("suspect", true )
addEventHandler ("suspect", getRootElement(), suspect_func )

-- Akten säubern

function clear_func ( player, cmd, target )
	if player == client or not client then
		if isCop(player) or isFBI(player) or isArmy(player) and getElementData(player,"onDuty") == true then
			local target = findPlayerByName( target )
			if getElementType ( target ) == "player" and westsideGetElementData ( target, "loggedin" ) == 1 then
				westsideSetElementData ( target, "wanteds", 0 )
				setPlayerWantedLevel ( target, 0 )
				outputChatBox ( "[INFO]: Du hast die Akte von "..getPlayerName(target).." gelöscht!", player,0,100,150 )
				outputChatBox ( "[INFO]: "..getPlayerName(player).." hat deine Akten gelöscht!", target, 0,100,150 )
				local msg = "[INFO]: "..getPlayerName(player).." hat "..getPlayerName(target).." die Akten gelöscht!"
				sendMSGForFaction ( msg, 1, 200,200,0 )
				sendMSGForFaction ( msg, 6, 200,200,0 )
			else
				infobox(player,"Ungültiger Spieler!",4000,255,0,0)
			end
		end
	end
end
addCommandHandler("clear", clear_func)
addEvent ("clear", true )
addEventHandler ("clear", getRootElement(), clear_func )

function stvopunkte_func ( player, cmd, target, r1, r2, r3, r4 )
	if player == client or not client then
		if r1 == nil then
			infobox(player,"Du hast keinen Grund angegeben!",4000,255,0,0)
		else
			if isCop(player) or isFBI(player) or isArmy(player) and getElementData(player,"onDuty") == true then
				local target = findPlayerByName( target )
				if not r2 then r2 = "" end
				if not r3 then r3 = "" end
				if not r4 then r4 = "" end
				local reason = r1..r2..r3..r4
				if getElementType ( target ) == "player" and westsideGetElementData ( target, "loggedin" ) == 1 then
					westsideSetElementData ( target, "stvo_punkte", tonumber(westsideGetElementData ( target, "stvo_punkte" ) + 1) )
					outputChatBox ( "[INFO]: Du hast "..getPlayerName(target).." einen Stvo-Punkt wegen: "..reason.." gegeben!", player,0,100,150 )
					outputChatBox ( "[INFO]: Du hast einen Stvo-Punkt erhalten! Grund: "..reason.."! Gemeldet von: "..getPlayerName(player), target, 0,100,150 )
				else
					infobox(player,"Ungültiger Spieler!",4000,255,0,0)
				end
			end
		end
	end
end
addCommandHandler("stvo",stvopunkte_func)
addCommandHandler("stvopunkte", stvopunkte_func)
addEvent ("stvopunkte", true )
addEventHandler ("stvopunkte", getRootElement(), stvopunkte_func )

-- Waffen abnehmen

function takeweapons_func ( player, cmd, target )
	if player == client or not client then
		if isCop(player) or isFBI(player) or isArmy(player) and getElementData(player,"onDuty") == true then
			if findPlayerByName( target ) then
				local target = findPlayerByName( target )
				local x, y, z = getElementPosition ( player )
				local tx, ty, tz = getElementPosition ( target )
				if getDistanceBetweenPoints3D ( x, y, z, tx, ty, tz ) < 5 then
					takeAllWeapons ( target )
					outputChatBox ( "[INFO]: Du hast "..getPlayerName(target).." entwaffnet!", player, 0,100,150 )
					outputChatBox ( "[INFO]: Du wurdest von "..getPlayerName(player).." entwaffnet!", target, 0,100,150 )
				else
					infobox(player,"Der Spieler ist\nzu weit entfernt!",4000,255,0,0)
				end
			else
				infobox(player,"Ungültiger Name!",4000,255,0,0)
			end
		end
	end
end
addCommandHandler("takeweapons", takeweapons_func)
addEvent ("takeweapons", true )
addEventHandler ("takeweapons", getRootElement(), takeweapons_func )

-- Datenbank

function getDatabaseFile ( name )
	local player = client
	local name = MySQL_Save ( name )
	if MySQL_DatasetExist ( "players", "Name LIKE '"..name.."'" ) or MySQL_DatasetOldExist ( "players", "Name LIKE '"..name.."'" ) then
		local data = MySQL_GetStringDataset ( "state_files", "text, editor, faction", "name LIKE '"..name.."'" )
		if data then
			triggerClientEvent ( player, "recieveDatabaseFile", player, name, data["text"], data["editor"], tonumber ( data[faction] ) )
		else
			triggerClientEvent ( player, "recieveDatabaseFile", player, name, "[Leerer Eintrag]", "", 0 )
		end
	else
		infobox(player,"Ungültiger Name!",4000,255,0,0)
	end
end
addEvent ( "getDatabaseFile", true )
addEventHandler ( "getDatabaseFile", getRootElement (), getDatabaseFile )

function saveDatabaseFile ( name, text )
	local player = client
	name = MySQL_Save ( name )
	text = MySQL_Save ( text )
	if #text <= 1000 then
		if MySQL_DatasetExist ( "players", "Name LIKE '"..name.."'" ) or MySQL_DatasetOldExist ( "players", "Name LIKE '"..name.."'" ) then
			mysql_vio_query ( "DELETE FROM state_files WHERE name = '"..name.."' LIMIT 1" )
			mysql_vio_query ( "INSERT INTO state_files ( name, text, editor, faction ) VALUES ( '"..name.."', '"..text.."', '"..factionRankNames[westsideGetElementData ( player, "fraktion" )][westsideGetElementData ( player, "rang" )]..getPlayerName ( player ).."', '"..westsideGetElementData ( player, "fraktion" ).."' )" )
			infobox(player,"Akte gespeichert!",4000,0,255,0)
		else
			infobox(player,"Ungültiger Name!",4000,255,0,0)
		end
	else
		infobox(player,"Der Text ist zu lang!",4000,255,0,0)
	end
end
addEvent ( "saveDatabaseFile", true )
addEventHandler ( "saveDatabaseFile", getRootElement (), saveDatabaseFile )

-- Needhelp

addCommandHandler("sos",function(player,cmd)
    if isCop(player) or isFBI(player) or isArmy(player) then
		if getElementData(player,"onDuty") == true then
			local table = getElementsByType("player")
			for k,v in pairs(table) do
			if player ~= v then
				if(isStateFaction(v)) then
					local blip  = createBlipAttachedTo(player, 0,4,255,0,0,255,0,65535, v)
						outputChatBox("[INFO:]: "..getPlayerName(player).." benötigt Unterstützung! Der Standort wird für 1 Minute markiert!",v,200,200,0)
						setTimer(destroyElement, 1*60000, 1, blip)
					end
				end
			end
		else
			infobox(player,"Du bist nicht im Dienst!",4000,255,0,0)
		end
	end
end)

-- Regierungsnachrichten
regierungsnachricht = false

addCommandHandler("rtext",function(player,cmd,...)
	local parametersTable = {...}
	local text = table.concat(parametersTable," ")
	
	if isCop(player) or isFBI(player) or isArmy(player) then
		if getElementData(player,"onDuty") == true then
			if westsideGetElementData(player,"rang") > 2 then
				if regierungsnachricht == false then
					if text == "" then
						infobox(player,"Du musst einen Text angeben!",4000,255,0,0)
					else
						regierungsnachricht = true
						setTimer(function()
							regierungsnachricht = false
						end,30000,1)
						outputChatBox("[Regierung]: "..text,root,200,0,0)
					end
				else
					infobox(player,"Nur alle 30 Sek. möglich!",4000,255,0,0)
				end
			else
				infobox(player,"Erst ab Rang 3 möglich!",4000,255,0,0)
			end
		else
			infobox(player,"Du bist nicht im Dienst!",4000,255,0,0)
		end
	end
end)