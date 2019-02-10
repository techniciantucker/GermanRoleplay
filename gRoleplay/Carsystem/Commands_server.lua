vehBlipColor = {}
	vehBlipColor["r"] = {}
	vehBlipColor["g"] = {}
	vehBlipColor["b"] = {}
		color = 1
		vehBlipColor["r"][color] = 255
		vehBlipColor["g"][color] = 0
		vehBlipColor["b"][color] = 0
		color = color + 1
		vehBlipColor["r"][color] = 0
		vehBlipColor["g"][color] = 255
		vehBlipColor["b"][color] = 0
		color = color + 1
		vehBlipColor["r"][color] = 0
		vehBlipColor["g"][color] = 0
		vehBlipColor["b"][color] = 255
		color = color + 1
		vehBlipColor["r"][color] = 0
		vehBlipColor["g"][color] = 0
		vehBlipColor["b"][color] = 0
		color = color + 1
		vehBlipColor["r"][color] = 255
		vehBlipColor["g"][color] = 255
		vehBlipColor["b"][color] = 255
		color = color + 1
		vehBlipColor["r"][color] = 255
		vehBlipColor["g"][color] = 255
		vehBlipColor["b"][color] = 0
		color = color + 1
		vehBlipColor["r"][color] = 255
		vehBlipColor["g"][color] = 0
		vehBlipColor["b"][color] = 255
		color = color + 1
		vehBlipColor["r"][color] = 0
		vehBlipColor["g"][color] = 255
		vehBlipColor["b"][color] = 255
		color = color + 1
		vehBlipColor["r"][color] = 125
		vehBlipColor["g"][color] = 125
		vehBlipColor["b"][color] = 125
		color = color + 1
		vehBlipColor["r"][color] = 255
		vehBlipColor["g"][color] = 125
		vehBlipColor["b"][color] = 0
		color = color + 1
		color = nil
		
function isNotCarTowing(name, slot)
	local tQuery = mysql_query(handler, "SELECT * FROM towing WHERE `Slot` = '"..slot.."' AND Name = '"..tostring(name).."'");
	local rows 	 = mysql_num_rows(tQuery);
	if(rows == 0)then
		return true
	else
		return false
	end
end

----- Kofferraum -----
addCommandHandler('kofferraum',function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		local veh = getPedOccupiedVehicle(player)
		
		if(getPedOccupiedVehicleSeat(player)==0)then
			if(westsideGetElementData(veh,'owner'))then
				if(westsideGetElementData(veh,'stuning1'))then
					infobox(player,'Kofferraum geöffnet!')
					
					local data = MySQL_GetString( "vehicles", "Kofferraum", "Besitzer LIKE '"..westsideGetElementData ( veh, "owner" ).."' AND Slot LIKE '"..westsideGetElementData ( veh, "carslotnr_owner" ).."'" )
					
					local drugs = tonumber ( gettok ( data, 1, string.byte ( '|' ) ) )
					local mats  = tonumber ( gettok ( data, 2, string.byte ( '|' ) ) )
					local gun   = tonumber ( gettok ( data, 3, string.byte ( '|' ) ) )
					local ammo  = tonumber ( gettok ( data, 4, string.byte ( '|' ) ) )
					
					triggerClientEvent ( player, "showTrunkGui", getRootElement(), drugs, mats, gun, ammo )
					
					westsideSetElementData ( player, "clickedVehicle", clickedElement )
					setElementData ( player, "ElementClicked", true )
					showCursor ( player, true )
				else
					infobox(player,'Dieses Fahrzeug hat keinen\nKofferraum!')
				end
			end
		else
			infobox(player,'Du sitzt in keinem Fahrzeug!')
		end
	end
end)

function respawncar_func ( player, command, towcar )
	if towcar == nil then
		infobox(player,"Nutze /respawnen [Slot]!",4000,0,100,150)
	else
	if tonumber(westsideGetElementData ( player, "carslot"..towcar )) >= 1 then
	    if isNotCarTowing(getPlayerName(player), towcar) then 
			local pname = MySQL_Save ( getPlayerName ( player ) )
			if westsideGetElementData ( player, "money" ) >= 250 then
				if respawnPrivVeh ( towcar, pname ) then
					westsideSetElementData ( player, "money", tonumber(westsideGetElementData ( player, "money" )) - 250 )
					takePlayerMoney ( player, 250)
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Fahrzeug respawnt!", 4000,0,255,0)
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Das Fahrzeug ist nicht leer!", 4000,255,0,0)
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Hierfür benötigst du 250$!", 4000,255,0,0)
			end
		else
			infobox(player,"Dieses Fahrzeug wurde abgeschleppt!",4000,255,0,0)
		end
	end
end
end
addEvent ( "respawnPrivVehClick", true )
addEventHandler ( "respawnPrivVehClick", getRootElement(), respawncar_func )
addCommandHandler ( "respawnen", respawncar_func )

function runningRespawn(player, slot)
	executeCommandHandler('respawncar', player, tonumber(slot))
end
addEvent ( "respawnVehicleFromPanel", true )
addEventHandler ( "respawnVehicleFromPanel", getRootElement(), runningRespawn)

function sellcarto_func ( player, cmd, target, price, pSlot )
	if target and pSlot and getPlayerFromName ( target ) and tonumber ( pSlot ) then
	    if isNotCarTowing(getPlayerName(player), towcar) then 
		pSlot = MySQL_Save ( pSlot )
		tSlot = getFreeCarSlot ( getPlayerFromName ( target ) )
		local pname = getPlayerName ( player )
		local target = getPlayerFromName ( target )
			if tSlot and westsideGetElementData ( target, "carslot"..tSlot ) == 0 and westsideGetElementData ( player, "carslot"..pSlot ) > 0 then
				local veh = _G[getPrivVehString ( pname, pSlot )]
				if tonumber ( price ) then
					price = math.abs ( math.floor ( tonumber ( price ) ) )
					if isElement ( veh ) then
						--if getElementModel (veh) == 549 or getElementModel (veh) == 415 or getElementModel (veh) == 411 or getElementModel (veh) == 560 or getElementModel (veh) == 429 or getElementModel (veh) == 402 or getElementModel (veh) == 506 or getElementModel (veh) == 522 or getElementModel (veh) == 461 or getElementModel (veh) == 463 or getElementModel (veh) == 468 or getElementModel (veh) == 521 or getElementModel (veh) == 586 or getElementModel (veh) == 462 or getElementModel (veh) == 487 or getElementModel (veh) == 469 or getElementModel (veh) == 513 or getElementModel (veh) == 519 or getElementModel (veh) == 549 or getElementModel (veh) == 439 or getElementModel (veh) == 542 or getElementModel (veh) == 534 or getElementModel (veh) == 518 or getElementModel (veh) == 567 or getElementModel (veh) == 576 or getElementModel (veh) == 405 or getElementModel (veh) == 565 or getElementModel (veh) == 587 or getElementModel (veh) == 603 or getElementModel (veh) == 401 or getElementModel (veh) == 484 or getElementModel (veh) == 545 or getElementModel (veh) == 473 or getElementModel (veh) == 472 or getElementModel (veh) == 493 or getElementModel (veh) == 446 or getElementModel (veh) == 452 then
							if westsideGetElementData ( target, "curcars" ) < westsideGetElementData ( target, "maxcars" ) then
								local model = getElementModel ( veh )
								outputChatBox ( "[INFO]: "..getPlayerName ( player ).." bietet dir folgendes Fahrzeug für "..price.."$ an: "..getVehicleName ( veh ), target, 0,100,150 )
								outputChatBox ( "Tippe /buy car, um das Fahrzeug zu kaufen.", target, 0,100,150 )
								outputChatBox ( "[INFO]: Du hast "..getPlayerName ( target ).." dein Fahrzeug aus Slot "..pSlot.." angeboten!", player, 0,100,150 )
									
								westsideSetElementData ( target, "carToBuyFrom", player )
								westsideSetElementData ( target, "carToBuySlot", tonumber ( pSlot ) )
								westsideSetElementData ( target, "carToBuyPrice", price )
								westsideSetElementData ( target, "carToBuyModel", getElementModel ( veh ) )
							else
								triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Spieler hat keinen freien Fahrzeugslot mehr!", 4000,255,0,0)
							end
						--[[ else
							infobox(player,"Vip Fahrzeuge können\nnicht verkauft werden!",0,255,0)
						end ]]--
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Nutze /sellcarto [Name],\n[Preis], [Eigener Slot]!", 4000,0,100,150)
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Nutze /sellcarto [Name],\n[Preis], [Eigener Slot]!", 4000,0,100,150)
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Nutze /sellcarto [Name],\n[Preis], [Eigener Slot]!", 4000,0,100,150)
			end
		else
			infobox(player,"Dieses Fahrzeug wurde abgeschleppt!",4000,255,0,0)
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Nutze /sellcarto [Name],\n[Preis], [Eigener Slot]!", 4000,0,100,150)
	end
end
addCommandHandler ( "sellcarto", sellcarto_func )

function respawnPrivVeh ( carslot, pname )
	if not isElement ( _G[getPrivVehString ( pname, carslot )] ) or ( not getVehicleOccupant ( _G[getPrivVehString ( pname, carslot )] ) and not getVehicleOccupant ( _G[getPrivVehString ( pname, carslot )], 1 ) and not getVehicleOccupant ( _G[getPrivVehString ( pname, carslot )], 2 ) and not getVehicleOccupant ( _G[getPrivVehString ( pname, carslot )], 3 ) ) then
		if tonumber ( MySQL_GetString("vehicles", "AuktionsID", "Besitzer LIKE '"..pname.."' AND Slot LIKE '"..carslot.."'") ) == 0 then
			local dsatz
			local result = mysql_query ( handler, "SELECT * from vehicles WHERE Besitzer LIKE '"..pname.."' AND Slot LIKE '"..carslot.."'" )
			if result then
				if ( mysql_num_rows ( result ) > 0 ) then
					dsatz = mysql_fetch_assoc ( result )
				end
				mysql_free_result ( result )
			end
			local Besitzer = pname
			local Slot = carslot
			MySQL_SetString("vehicles", "Benzin", westsideGetElementData(_G[getPrivVehString ( pname, carslot )],"fuelstate"), "Besitzer LIKE '"..pname.."' AND Slot LIKE '"..carslot.."'")
			
			destroyElement ( _G[getPrivVehString ( pname, carslot )] )
			
			local Typ = dsatz["Typ"]
			local Last_Login_Besitzer_Tag = MySQL_GetString("players", "Last_login", "Name LIKE '" ..pname.."'")
			local Tuning = dsatz["Tuning"]
			local Spawnpos_X = dsatz["Spawnpos_X"]
			local Spawnpos_Y = dsatz["Spawnpos_Y"]
			local Spawnpos_Z = dsatz["Spawnpos_Z"]
			local Spawnrot_X = dsatz["Spawnrot_X"]
			local Spawnrot_Y = dsatz["Spawnrot_Y"]
			local Spawnrot_Z = dsatz["Spawnrot_Z"]
			local Farbe = dsatz["Farbe"]
			local Tieferlegung = dsatz["NewTuningTL"]
			local MotorUpgrade = dsatz["NewTuningMU"]
			local LFarbe = dsatz["Lights"]
			local Paintjob = dsatz["Paintjob"]
			local Benzin = dsatz["Benzin"]
			local Distanz = dsatz["Distance"]
			local STuning = dsatz["STuning"]
			local Gang = dsatz["Gang"]
			_G[getPrivVehString ( pname, carslot )] = createVehicle ( Typ, Spawnpos_X, Spawnpos_Y, Spawnpos_Z, 0, 0, 0, Besitzer )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "owner", Besitzer )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "name", _G[getPrivVehString ( pname, carslot )] )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "carslotnr_owner", Slot )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "locked", true )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "color", Farbe )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "NewTuningTL", tonumber(Tieferlegung) )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "NewTuningMU", tonumber(MotorUpgrade) )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "lcolor", LFarbe )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "spawnpos_x", Spawnpos_X )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "spawnpos_y", Spawnpos_Y )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "spawnpos_z", Spawnpos_Z )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "spawnrot_x", Spawnrot_X )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "spawnrot_y", Spawnrot_Y )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "spawnrot_z", Spawnrot_Z )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "distance", Distanz )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "stuning", STuning )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "rcVehicle", tonumber ( dsatz["rc"] ) )
			setVehicleLocked ( _G[getPrivVehString ( pname, carslot )], true )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "fuelstate", tonumber(Benzin) )
			westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "Gang", tonumber ( Gang ) )
			setElementFrozen ( _G[getPrivVehString ( pname, carslot )], true )
			if westsideGetElementData ( _G[getPrivVehString ( pname, carslot )], "Gang" ) ~= 0 then
				setElementFrozen ( _G[getPrivVehString ( pname, carslot )], false )
				setVehicleLocked ( _G[getPrivVehString ( pname, carslot )], false )
				westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "locked", false )
				westsideSetElementData ( _G[getPrivVehString ( pname, carslot )], "owner", getGangName ( westsideGetElementData ( _G[getPrivVehString ( pname, carslot )], "Gang" ) ) )
			end
			setPrivVehCorrectColor ( _G[getPrivVehString ( pname, carslot )] )
			setPrivVehCorrectLightColor ( _G[getPrivVehString ( pname, carslot )] )
			setVehiclePaintjob ( _G[getPrivVehString ( pname, carslot )], Paintjob )
			if special == 2 then
				local both = Besitzer..Slot
				_G["ObjYacht"..both] = createObject ( 1337, 0, 0, 0 )
				attachElements ( _G["ObjYacht"..Besitzer..Slot], _G[getPrivVehString ( pname, carslot )], 0, 2, 1.55 )
				setElementDimension ( _G["ObjYacht"..both], 1 )
			end
			setVehicleRotation ( _G[getPrivVehString ( pname, carslot )], Spawnrot_X, Spawnrot_Y, Spawnrot_Z )
			pimpVeh ( _G[getPrivVehString ( pname, carslot )], Tuning )

			return true
		end
	end
	return false
end

function respawnVeh_func ( towcar, pname, veh )
	if westsideGetElementData ( source, "adminlvl" ) >= 3 then
		if towcar then
			respawnPrivVeh ( towcar, pname )
		else
			if not getVehicleOccupant ( veh ) then
				respawnVehicle ( veh )
				setElementDimension ( veh, 0 )
				setElementInterior ( veh, 0 )
			end
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht befugt!", 4000,255,0,0)
	end
end
addEvent ( "respawnVeh", true )
addEventHandler ( "respawnVeh", getRootElement(), respawnVeh_func )

function AdmincmdLockVeh_func ( veh )
	local admin = getPlayerName ( source )
	if westsideGetElementData ( source, "adminlvl" ) >= 3 or isMechaniker(source) then
		outputLog("[ADMIN]: Ein Fahrzeug wurde von "..admin.." aufgeschlossen!","Adminsystem")
		if westsideGetElementData ( veh, "locked" ) then
			westsideSetElementData ( veh, "locked", false )
			setVehicleLocked ( veh, false )
			triggerClientEvent ( source, "infobox_start", getRootElement(), "Fahrzeug aufgeschlossen!", 4000,0,255,0)
		else
			westsideSetElementData ( veh, "locked", true )
			setVehicleLocked ( veh, true )
			triggerClientEvent ( source, "infobox_start", getRootElement(), "Fahrzeug abgeschlossen", 4000,255,0,0)
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht befugt!", 4000,255,0,0)
	end
end
addEvent ( "AdmincmdLockVeh", true )
addEventHandler ( "AdmincmdLockVeh", getRootElement(), AdmincmdLockVeh_func )

function AdmincmdUnbreakVeh_func ( veh )
	local admin = getPlayerName ( source )
	if westsideGetElementData ( source, "adminlvl" ) >= 1 or isMechaniker(source) then
		if getVehicleOccupant ( veh ) or getVehicleOccupant ( veh, 1 ) or getVehicleOccupant ( veh, 2 ) or getVehicleOccupant ( veh, 3 ) then
			if getVehicleOccupant ( veh ) ~= source then
				triggerClientEvent ( source, "infobox_start", getRootElement(), "Das Fahrzeug ist nicht leer!", 4000,255,0,0)
				return
			end
		end
		if isElementFrozen ( veh ) then
			setElementFrozen ( veh, false )
			triggerClientEvent ( source, "infobox_start", getRootElement(), "Handbremse gelöst!", 4000,255,0,0)
		else
			setElementFrozen ( veh, true )
			triggerClientEvent ( source, "infobox_start", getRootElement(), "Handbremse angezogen!", 4000,0,255,0)
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht befugt!", 4000,255,0,0)
	end
end
addEvent ( "AdmincmdUnbreakVeh", true )
addEventHandler ( "AdmincmdUnbreakVeh", getRootElement(), AdmincmdUnbreakVeh_func )

function AdmincmdOwnerChangeVeh_func ( veh, towcar, pname, newuser )
	local admin = getPlayerName ( source )
	if westsideGetElementData ( source, "adminlvl" ) >= 3 then
		local newplayer = getPlayerFromName(newuser)
		local opfer = getPlayerFromName(pname)
		local slotalt = towcar
		if not(isElement(newplayer)) then
			triggerClientEvent ( source, "infobox_start", getRootElement(), "Der Empfänger ist offline!", 4000,255,0,0)
			return
		end
		if isElement(opfer) then
			triggerClientEvent ( source, "infobox_start", getRootElement(), "Der Besitze ist online!", 4000,255,0,0)
			return
		end
		local tSlot = getFreeCarSlot ( newplayer )
		if tSlot and westsideGetElementData ( newplayer, "curcars" ) < westsideGetElementData ( newplayer, "maxcars" ) then
			local id = MySQL_GetString("vehicles", "ID", "Besitzer LIKE '"..pname.."' AND Slot LIKE '"..tonumber(towcar).."'")
			outputChatBox ( "Du hast das Fahrzeug an "..newuser.." übergeben!", source, 0,125,0 )
			outputChatBox ( "Du hast ein Fahrzeug in Slot "..tSlot.." erhalten!", newplayer, 0,125,0 )
			MySQL_SetString("vehicles", "Besitzer", newuser, "ID LIKE '"..id.."'")
			MySQL_SetString("vehicles", "Slot", tonumber ( tSlot ), "ID LIKE '"..id.."'")
			westsideSetElementData ( newplayer, "carslot"..tSlot, 1 )
			westsideSetElementData ( newplayer, "curcars", westsideGetElementData ( newplayer, "curcars" ) + 1 )
			westsideSetElementData ( veh, "owner", newuser )
			westsideSetElementData ( veh, "name", "privVeh"..newuser..tSlot )
			westsideSetElementData ( veh, "carslotnr_owner", tSlot )
			_G[getPrivVehString ( newuser, tSlot )] = veh
			_G[getPrivVehString ( pname, pSlot )] = nil
			SaveCarData ( newplayer )
		else
			triggerClientEvent ( source, "infobox_start", getRootElement(), "Der Empfänger hat keinen\nfreien Fahrzeugslot mehr!", 4000,255,0,0)
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht befugt!", 4000,255,0,0)
	end
end
addEvent ( "AdmincmdOwnerChangeVeh", true )
addEventHandler ( "AdmincmdOwnerChangeVeh", getRootElement(), AdmincmdOwnerChangeVeh_func )

function deleteVeh_func ( towcar, pname, veh, reason )
	local admin = getPlayerName ( source )
	if westsideGetElementData ( source, "adminlvl" ) >= 3 then
		local player = getPlayerFromName ( pname )
		if getVehicleOccupant ( veh ) or getVehicleOccupant ( veh, 1 ) or getVehicleOccupant ( veh, 2 ) or getVehicleOccupant ( veh, 3 ) then
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Das Fahrzeug ist nicht leer!", 4000,255,0,0)
			return
		end
		if player then
			outputChatBox ( "[INFO]: Dein Fahrzeug in Slot "..towcar.." wurde von "..admin.." gelöscht ("..reason..")!", player, 0,100,150)
			westsideSetElementData ( player, "carslot"..towcar, 0 )
		else
			offlinemsg ( "[INFO]: Dein Fahrzeug in Slot "..towcar.." wurde von "..admin.." gelöscht("..reason..")!", "Server", pname )
		end
		destroyElement ( veh )
		MySQL_DelRow("vehicles", "Besitzer LIKE '"..pname.."' AND Slot LIKE '"..towcar.."'")
		
		outputLog("[ADMIN]: Das Fahrzeug von "..pname.."("..towcar..") wurde von "..admin.." gelöscht. Model: "..getElementModel(veh)..".","Adminsystem")
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht befugt!", 2500, 125,0,0)
	end
end
addEvent ( "deleteVeh", true )
addEventHandler ( "deleteVeh", getRootElement(), deleteVeh_func )

function AdmincmdParkVeh_func ( towcar, pname, veh, reason )
	local admin = getPlayerName ( source )
	if westsideGetElementData ( source, "adminlvl" ) >= 1 or isMechaniker(source) then 
		if getVehicleOccupant(veh, 0) == source then
			local player = getPlayerFromName ( pname )

			if player then
				outputChatBox ( "[INFO]: Dein Fahrzeug in Slot "..towcar.." wurde von "..admin.." umgeparkt("..reason..")!", player, 0,100,150)
			else
				offlinemsg ( "[INFO]: Dein Fahrzeug in Slot "..towcar.." wurde von "..admin.." umgeparkt("..reason..")!", "Server", pname )
			end
			local x, y, z = getElementPosition ( veh )
			local rx, ry, rz = getVehicleRotation ( veh )
			local c1, c2, c3, c4 = getVehicleColor ( veh )
			westsideSetElementData ( veh, "spawnposx", x )
			westsideSetElementData ( veh, "spawnposy", y )
			westsideSetElementData ( veh, "spawnposz", z )
			westsideSetElementData ( veh, "spawnrotx", rx )
			westsideSetElementData ( veh, "spawnroty", ry )
			westsideSetElementData ( veh, "spawnrotz", rz )
			westsideSetElementData ( veh, "color1", c1 )
			westsideSetElementData ( veh, "color2", c2 )
			westsideSetElementData ( veh, "color3", c3 )
			westsideSetElementData ( veh, "color4", c4 )
				
			triggerClientEvent ( source, "infobox_start", getRootElement(), "Fahrzeug umgeparkt.", 4000,0,255,0)
			
			local Spawnpos_X, Spawnpos_Y, Spawnpos_Z = getElementPosition ( veh )
			local Spawnrot_X, Spawnrot_Y, Spawnrot_Z = getVehicleRotation ( veh )
			local Farbe1, Farbe2, Farbe3, Farbe4 =  getVehicleColor ( veh )
			local color = "|"..Farbe1.."|"..Farbe2.."|"..Farbe3.."|"..Farbe4.."|"
			local Paintjob = getVehiclePaintjob ( veh )
			local Benzin = westsideGetElementData ( veh, "fuelstate" )
			local pname = westsideGetElementData ( veh, "owner" )
			local Distance = westsideGetElementData ( veh, "distance" )
			local slot = westsideGetElementData ( veh, "carslotnr_owner" )
			MySQL_SetString("vehicles", "Spawnpos_X", Spawnpos_X, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Spawnpos_Y", Spawnpos_Y, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Spawnpos_Z", Spawnpos_Z, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Spawnrot_X", Spawnrot_X, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Spawnrot_Y", Spawnrot_Y, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Spawnrot_Z", Spawnrot_Z, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Paintjob", Paintjob, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Benzin", Benzin, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Distance", Distance, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
		else
			triggerClientEvent ( source, "infobox_start", getRootElement(), "Du musst im jeweiligen\nFahrzeug sitzen!", 4000,255,0,0)
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht befugt!", 4000,255,0,0 )
	end
end
addEvent ( "AdmincmdParkVeh", true )
addEventHandler ( "AdmincmdParkVeh", getRootElement(), AdmincmdParkVeh_func )

function AdmincmdToogleMotor_func ( veh )
	local admin = getPlayerName ( source )
	if westsideGetElementData ( source, "adminlvl" ) >= 3 then
		if getVehicleOccupant(veh, 0) == source then
			if getVehicleEngineState ( veh ) then
				setVehicleEngineState ( veh, false )
				westsideSetElementData ( veh, "engine", false )
				triggerClientEvent ( source, "infobox_start", getRootElement(), "Motor ausgeschaltet!", 4000,255,0,0)
				return		
			end
			setVehicleEngineState ( veh, true )
			westsideSetElementData ( veh, "engine", true )
			triggerClientEvent ( source, "infobox_start", getRootElement(), "Motor angeschaltet!", 4000,0,255,0)
			if not westsideGetElementData ( veh, "timerrunning" ) then
				setVehicleNewFuelState ( veh )
				westsideSetElementData ( veh, "timerrunning", true )
			end	
		else
			triggerClientEvent ( source, "infobox_start", getRootElement(), "Du musst im jeweiligen\nFahrzeug sitzen!", 4000,255,0,0)
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht befugt!", 4000,255,0,0)
	end
end
addEvent ( "AdmincmdToogleMotor", true )
addEventHandler ( "AdmincmdToogleMotor", getRootElement(), AdmincmdToogleMotor_func )

function park_func ( player, command )
	if getPedOccupiedVehicleSeat ( player ) == 0 then
		local veh = getPedOccupiedVehicle ( player )
		if westsideGetElementData ( veh, "owner" ) == getPlayerName ( player ) then
			if isVehicleOnGround(veh) then
				if getElementData(player,"inTiefgarage") == true then
					takePlayerSaveMoney(player,25)
					infobox(player,"Das parken hat dich 25$ gekostet,\nda du dich in der Tiefgarage befindest!")
					local x, y, z = getElementPosition ( veh )
					local rx, ry, rz = getVehicleRotation ( veh )
					local c1, c2, c3, c4 = getVehicleColor ( veh )
					westsideSetElementData ( veh, "spawnposx", x )
					westsideSetElementData ( veh, "spawnposy", y )
					westsideSetElementData ( veh, "spawnposz", z )
					westsideSetElementData ( veh, "spawnrotx", rx )
					westsideSetElementData ( veh, "spawnroty", ry )
					westsideSetElementData ( veh, "spawnrotz", rz )
					westsideSetElementData ( veh, "color1", c1 )
					westsideSetElementData ( veh, "color2", c2 )
					westsideSetElementData ( veh, "color3", c3 )
					westsideSetElementData ( veh, "color4", c4 )
					local Spawnpos_X, Spawnpos_Y, Spawnpos_Z = getElementPosition ( veh )
					local Spawnrot_X, Spawnrot_Y, Spawnrot_Z = getVehicleRotation ( veh )
					local Farbe1, Farbe2, Farbe3, Farbe4 =  getVehicleColor ( veh )
					local color = "|"..Farbe1.."|"..Farbe2.."|"..Farbe3.."|"..Farbe4.."|"
					local Paintjob = getVehiclePaintjob ( veh )
					local Benzin = westsideGetElementData ( veh, "fuelstate" )
					local pname = westsideGetElementData ( veh, "owner" )
					local Distance = westsideGetElementData ( veh, "distance" )
					local slot = westsideGetElementData ( veh, "carslotnr_owner" )
					MySQL_SetString("vehicles", "Spawnpos_X", Spawnpos_X, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
					MySQL_SetString("vehicles", "Spawnpos_Y", Spawnpos_Y, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
					MySQL_SetString("vehicles", "Spawnpos_Z", Spawnpos_Z, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
					MySQL_SetString("vehicles", "Spawnrot_X", Spawnrot_X, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
					MySQL_SetString("vehicles", "Spawnrot_Y", Spawnrot_Y, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
					MySQL_SetString("vehicles", "Spawnrot_Z", Spawnrot_Z, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
					MySQL_SetString("vehicles", "Paintjob", Paintjob, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
					MySQL_SetString("vehicles", "Benzin", Benzin, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
					MySQL_SetString("vehicles", "Distance", Distance, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
				else
					local x, y, z = getElementPosition ( veh )
					local rx, ry, rz = getVehicleRotation ( veh )
					local c1, c2, c3, c4 = getVehicleColor ( veh )
					westsideSetElementData ( veh, "spawnposx", x )
					westsideSetElementData ( veh, "spawnposy", y )
					westsideSetElementData ( veh, "spawnposz", z )
					westsideSetElementData ( veh, "spawnrotx", rx )
					westsideSetElementData ( veh, "spawnroty", ry )
					westsideSetElementData ( veh, "spawnrotz", rz )
					westsideSetElementData ( veh, "color1", c1 )
					westsideSetElementData ( veh, "color2", c2 )
					westsideSetElementData ( veh, "color3", c3 )
					westsideSetElementData ( veh, "color4", c4 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Fahrzeug geparkt.", 2500, 0,125,0)
					local Spawnpos_X, Spawnpos_Y, Spawnpos_Z = getElementPosition ( veh )
					local Spawnrot_X, Spawnrot_Y, Spawnrot_Z = getVehicleRotation ( veh )
					local Farbe1, Farbe2, Farbe3, Farbe4 =  getVehicleColor ( veh )
					local color = "|"..Farbe1.."|"..Farbe2.."|"..Farbe3.."|"..Farbe4.."|"
					local Paintjob = getVehiclePaintjob ( veh )
					local Benzin = westsideGetElementData ( veh, "fuelstate" )
					local pname = westsideGetElementData ( veh, "owner" )
					local Distance = westsideGetElementData ( veh, "distance" )
					local slot = westsideGetElementData ( veh, "carslotnr_owner" )
					MySQL_SetString("vehicles", "Spawnpos_X", Spawnpos_X, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
					MySQL_SetString("vehicles", "Spawnpos_Y", Spawnpos_Y, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
					MySQL_SetString("vehicles", "Spawnpos_Z", Spawnpos_Z, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
					MySQL_SetString("vehicles", "Spawnrot_X", Spawnrot_X, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
					MySQL_SetString("vehicles", "Spawnrot_Y", Spawnrot_Y, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
					MySQL_SetString("vehicles", "Spawnrot_Z", Spawnrot_Z, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
					MySQL_SetString("vehicles", "Paintjob", Paintjob, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
					MySQL_SetString("vehicles", "Benzin", Benzin, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
					MySQL_SetString("vehicles", "Distance", Distance, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
				end
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Dieses Fahrzeug gehört dir nicht!", 4000,255,0,0)
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du musst in einem Fahrzeug sitzen!", 4000,255,0,0)
	end
end
addCommandHandler ( "park", park_func )

function lock_func ( player, command, locknr )
	if locknr == nil then
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Nutze /lock [Slot]!", 4000,0,100,150)
	else
		if tonumber(westsideGetElementData ( player, "carslot"..locknr )) >= 1 then
			local pname = getPlayerName ( player )
			local veh = _G[getPrivVehString ( pname, locknr )]
			if isElement ( veh ) then
				if westsideGetElementData ( veh, "locked" ) then
					westsideSetElementData ( veh, "locked", false )
					setVehicleLocked ( veh, false )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Fahrzeug aufgeschlossen!", 4000,0,255,0)
				elseif not westsideGetElementData ( veh, "locked" ) then
					westsideSetElementData ( veh, "locked", true )
					setVehicleLocked ( veh, true )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Fahrzeug abgeschlossen!", 4000,255,0,0)
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Respawne dein Fahrzeug zuerst!", 4000,255,0,0)
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Du besitz kein Fahrzeug\nmit diesem Slot!", 4000,255,0,0)
		end
	end
end
addEvent ( "lockPrivVehClick", true )
addEventHandler ( "lockPrivVehClick", getRootElement(), lock_func )
addCommandHandler ( "lock", lock_func )

function runningLocked(player, slot)
	executeCommandHandler('lock', player, slot)
end
addEvent('onVehicleSetLocked', true)
addEventHandler('onVehicleSetLocked', root, runningLocked)

function vehinfos_func ( player )
	local curcars = westsideGetElementData ( player, "curcars" )
	local maxcars = westsideGetElementData ( player, "maxcars" ) or 10
	outputChatBox ( "Du bist momentan im Besitz von "..curcars.." Fahrzeugen von maximal "..maxcars, player, 0,200,200)
	if(westsideGetElementData(player,'maxcars')<10)then
		outputChatBox ( "Du kannst dir 7 weitere Fahrzeugslots im Levelshop (/levelshop) kaufen.",player,0,150,150)
	end
	local pname = getPlayerName ( player )
	color = 0
	for i = 1, 12 do
		carslotname = "carslot"..i
		if westsideGetElementData ( player, carslotname ) ~= 0 then
			local veh = _G[getPrivVehString ( pname, i )]
			if isElement ( veh ) then
				local x, y, z = getElementPosition( veh )
				outputChatBox ( "Slot "..i..": "..getVehicleName ( veh )..", steht momentan in "..getZoneName( x,y,z )..", "..getZoneName( x,y,z, true ), player,0,200,0 )
			else
				outputChatBox ( "Dein Fahrzeug in Slot "..i.." muss zuerst mit /respawnen "..i.." respawnt werden!", player, 0,200,0)
			end
		end
	end
end
addCommandHandler ( "vehinfos", vehinfos_func )

function vehhelp_func ( player )
	outputChatBox ( "Fahrzeughilfe", player, 0,100,150 )
	outputChatBox("════════════════════════════════════════",player,255,255,255)
	outputChatBox ( "/respawnen [Slot] - Respawnen, /lock [Slot] - Auf/Abschließen,",player, 0,100,150 )
	outputChatBox ( "/park - Parken, /vehinfos - Anzeigen aktueller Fahrzeuge,", player, 0,100,150 )
	outputChatBox ( "/givecar [Spieler], [Slot] - Auto weitergeben, /sellcarto -", player, 0,100,150 )
	outputChatBox ( "Auto an andere Spieler weiterverkaufen - Weitere Optionen im /self Menü!", player, 0,100,150 )
	outputChatBox("════════════════════════════════════════",player,255,255,255)
end
addCommandHandler ( "vehhelp", vehhelp_func )

function sellcar_func ( player, cmd, slot )
	local slot = tonumber(slot)
	if isNotCarTowing(getPlayerName(player), slot) then
	    if westsideGetElementData ( player, "carslot"..slot ) > 0 then
		    local pname = MySQL_Save ( getPlayerName(player) )
		    if tonumber ( MySQL_GetString("vehicles", "AuktionsID", "Besitzer LIKE '"..pname.."' AND Slot LIKE '"..slot.."'") ) == 0 then
			    local veh = _G[getPrivVehString ( pname, slot )]
			    if veh then
				    local model = getElementModel ( veh )
				    local price = carprices[model]
				    if not price then
					    price = 0
				    end
				    westsideSetElementData ( player, "carslot"..slot, 0 )
				    local spawnx = westsideGetElementData ( player, "spawnpos_x" )
				    if spawnx == "marquis" or spawnx == "tropic" then
					westsideSetElementData ( player, "spawnpos_x", -2458.288085 )
					westsideSetElementData ( player, "spawnpos_y", 774.354492 )
					westsideSetElementData ( player, "spawnpos_z", 35.171875 )
					westsideSetElementData ( player, "spawnrot_x", 52 )
					westsideSetElementData ( player, "spawnint", 0 )
					westsideSetElementData ( player, "spawndim", 0 )
				    end
				    MySQL_DelRow("vehicles", "Besitzer LIKE '"..pname.."' AND Slot LIKE '"..westsideGetElementData(veh, "carslotnr_owner" ).."'")
				    westsideSetElementData(player,"curcars",tonumber(westsideGetElementData ( player, "curcars" ))-1)
				    destroyElement ( veh )
				    westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" )+price/100*75 )
				    givePlayerMoney ( player, price/100*75 )
				    SaveCarData ( player )
			    else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Respawne dein Fahrzeug zuerst!", 4000, 0,255,0)
			    end
		    else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Respawnen nicht möglich!", 4000, 255,0,0)
		    end
	    else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Ungültiger Slot!", 4000, 255,0,0)
	    end
	else
		infobox(player,"Dieses Fahrzeug wurde abgeschleppt!",4000, 255,0,0)
	end
end
addCommandHandler ( "sellcar", sellcar_func )
addEvent('onSellCarClient', true)
addEventHandler('onSellCarClient', root, sellcar_func);

function onVehicleLocate(player, slot)
	if(_G[getPrivVehString(getPlayerName(player), slot)])then
		local veh = _G[getPrivVehString(getPlayerName(player), slot)];
		local x, y, z = getElementPosition(veh);
		local zone = getZoneName(x, y, z)
		outputChatBox('[INFO]: Dein Auto in Slot '..slot..' steht in ('..zone..') - Es wurde auf der Karte markiert!', player, 0,100,150)
		
		local blip = createBlip ( x, y, z, 0, 2, vehBlipColor["r"][color], vehBlipColor["g"][color], vehBlipColor["b"][color], 255, 0, 99999.0, player )
		setTimer ( destroyElement, 10000, 1, blip )
	end
end
addEvent('onVehicleLocate', true)
addEventHandler('onVehicleLocate', root, onVehicleLocate)

function accept_sellcarto ( accepter, _, cmd )
	if cmd == "car" then
		local target = accepter
		local pSlot = westsideGetElementData ( accepter, "carToBuySlot" )
		player = westsideGetElementData ( accepter, "carToBuyFrom" )
		price = westsideGetElementData ( accepter, "carToBuyPrice" )
		model = westsideGetElementData ( accepter, "carToBuyModel" )
		if isElement ( player ) then
			local money = westsideGetElementData ( target, "bankmoney" )
			local tSlot = getFreeCarSlot ( target )
			if price <= money then
				if tonumber ( pSlot ) and tSlot then
					pSlot = tonumber ( pSlot )
					local pname = getPlayerName ( player )
					if tonumber ( MySQL_GetString("vehicles", "AuktionsID", "Besitzer LIKE '"..pname.."' AND Slot LIKE '"..tonumber(pSlot).."'") ) == 0 then
						if westsideGetElementData ( player, "carslot"..pSlot ) > 0 then
							local veh = _G[getPrivVehString ( pname, pSlot )]
							if isElement ( veh ) then
								if model == getElementModel ( veh ) then
									if ( premiumBuyCars[getElementModel(veh)] and westsideGetElementData ( target, "premium" ) ) or not premiumBuyCars[getElementModel(veh)] then
										if westsideGetElementData ( target, "curcars" ) < westsideGetElementData ( target, "maxcars" ) then
											local id = MySQL_GetString("vehicles", "ID", "Besitzer LIKE '"..getPlayerName(player).."' AND Slot LIKE '"..tonumber(pSlot).."'")
											outputChatBox ( "Du hast dein Fahrzeug in Slot "..pSlot.." an "..getPlayerName ( target ).." gegeben!", player,0,125,0 )
											outputChatBox ( "Du hast ein Fahrzeug in Slot "..tSlot.." von "..getPlayerName ( player ).." erhalten!", target, 0,125,0 )
											MySQL_SetString("vehicles", "Besitzer", getPlayerName(target), "ID LIKE '"..id.."'")
											MySQL_SetString("vehicles", "Slot", tonumber ( tSlot ), "ID LIKE '"..id.."'")
											westsideSetElementData ( target, "carslot"..tSlot, westsideGetElementData ( player, "carslot"..pSlot ) )
											westsideSetElementData ( player, "carslot"..pSlot, 0 )
											westsideSetElementData ( target, "curcars", westsideGetElementData ( target, "curcars" ) + 1 )
											westsideSetElementData ( player, "curcars", westsideGetElementData ( player, "curcars" ) - 1 )
											westsideSetElementData ( veh, "lcolor", "|255|255|255|" )
											MySQL_SetString("vehicles", "Lights", "|255|255|255|", "ID LIKE '"..id.."'")
											setPrivVehCorrectLightColor ( veh )
											westsideSetElementData ( veh, "owner", getPlayerName ( target ) )
											westsideSetElementData ( veh, "name", "privVeh"..getPlayerName(target)..tSlot )
											westsideSetElementData ( veh, "carslotnr_owner", tSlot )
											_G[getPrivVehString ( getPlayerName(target), tSlot )] = veh
											_G[getPrivVehString ( pname, pSlot )] = nil
											SaveCarData ( player )
											SaveCarData ( target )
											westsideSetElementData ( target, "bankmoney", money - price )
											westsideSetElementData ( player, "bankmoney", westsideGetElementData ( player, "bankmoney" ) + price )
											casinoMoneySave ( target )
											casinoMoneySave ( player )
											
											outputLog ( "[FAHRZUGE] "..getPlayerName(accepter).." hat von "..getPlayerName(player).." ein Fahrzeug für "..price.."$ ( Model: "..model.." ) gekauft!","Fahrzeugsystem")
										else
											triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast keinen freien\nFahrzeugslot mehr!", 4000, 255,0,0)
										end
									end
								else
									triggerClientEvent ( player, "infobox_start", getRootElement(), "Lass dir das Angebot\nerneut schicken!", 4000,255,0,0)
								end
							else
								triggerClientEvent ( player, "infobox_start", getRootElement(), "Lass dir das Angebot\nerneut schicken!", 4000,255,0,0)
							end
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Verkäufer hat das\nFahrzeug nicht mehr!", 4000,255,0,0)
						end
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Lass dir das Angebot\nerneut schicken!", 4000,255,0,0)
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000,255,0,0)
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Anbieter des Fahrzeugs\nist offline!", 4000,255,0,0)
		end
	end
end
addCommandHandler ( "buy", accept_sellcarto )

function getPrivVehString ( pname, carslot )
	return string.lower ( "privVeh"..pname..carslot )
end

function handbremsen ( player )
	local vehicle = getPedOccupiedVehicle ( player )
	if vehicle then
		local sitz = getPedOccupiedVehicleSeat ( player )
		if sitz == 0 then
			local vx, vy, vz = getElementVelocity ( getPedOccupiedVehicle ( player ) )
			local speed = math.sqrt ( vx ^ 2 + vy ^ 2 + vz ^ 2 )
			if speed < 5 * 0.00464 then
			else
				return
			end
			if westsideGetElementData ( vehicle, "owner" ) == getPlayerName ( player )  then
				if isElementFrozen ( vehicle ) then
					setElementFrozen ( vehicle, false )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Handbremse gelöst!", 4000, 255,0,0)
				else
					setElementFrozen ( vehicle, true )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Handbremse angezogen!", 4000, 0,255,0)
				end
			end
		end
	end
end
addCommandHandler ( "break", handbremsen )