function carbuy ( player, carprice, vehid, spawnx, spawny, spawnz, rx, ry, rz, c1, c2, c3, c4, p, ec, Tuning )

	carprice = MySQL_Save ( carprice )
	vehid = MySQL_Save ( vehid )
	spawnx = MySQL_Save ( spawnx )
	spawny = MySQL_Save ( spawny )
	spawnz = MySQL_Save ( spawnz )
	rx = MySQL_Save ( rx )
	ry = MySQL_Save ( ry )
	rz = MySQL_Save ( rz )
	vehid = tonumber ( vehid )
	local pname = getPlayerName ( player )
	local differenz
	
	hasCamper = false
	local id
	for i = 1, 10 do
		id = tonumber ( MySQL_GetString ( "vehicles", "Typ", "Besitzer LIKE '"..pname.."' AND Slot LIKE '"..i.."'" ) )
		if id then
			if camper[id] then
				hasCamper = true
				break
			end
		end
	end
	if camper[vehid] and hasCamper then
		infobox(player,"Du hast bereits\neinen Wohnwagen!",4000,255,0,0)
	else
		if carprices[vehid] or westsideGetElementData ( player, "everyCarBuyableForFree" ) then
			if westsideGetElementData ( player, "maxcars" ) > westsideGetElementData ( player, "curcars" ) then
				local i = true
				westsideSetElementData ( player, "carbuyslot", 0 )
				carslotnr = 1
				sucesfull = false
				for i = 1, tonumber(westsideGetElementData ( player, "maxcars" )) do
					carslotzahl = "carslot"..carslotnr
					if tonumber(westsideGetElementData ( player, carslotzahl )) == 0 then
						westsideSetElementData ( player, "carbuyslot", carslotnr )
						sucesfull = true
						break
					else
						y = carslotnr
						carslotnr = ( y + 1 )
					end
				end
				if not sucesfull then
					infobox(player,"Du hast keinen\nfreien Slot mehr!",4000,255,0,0)
				else
					if (not westsideGetElementData ( player, "everyCarBuyableForFree" )) then
						if carprices[tonumber(vehid)] then
							carprice = carprices[tonumber(vehid)]
						end
						if ec then
							differenz = westsideGetElementData ( player, "bankmoney" ) - carprice
						else
							differenz = westsideGetElementData ( player, "money" ) - carprice
						end
					end
					if westsideGetElementData(player,"money") >= carprice or getElementData(player,"gutschein") == true then
						if hasPlayerLicense ( player, tonumber(vehid) ) then
							
							triggerClientEvent(player,"newloadscreen",player)
							
							setTimer(function()
							
							setElementDimension ( player, 0 )
							setElementInterior ( player, 0 )
							fadeCamera( player, true)
							setCameraTarget( player, player )
							
							local x = getPlayerName ( player )
							local y = westsideGetElementData ( player, "carbuyslot" )
							xy = x..y
							
							spawnX = tonumber ( spawnx )
							spawnY = tonumber ( spawny )
							spawnZ = tonumber ( spawnz )
							
							_G[getPrivVehString ( x, y )] = createVehicle ( vehid, spawnX, spawnY, spawnZ, 0, 0, 0, getPlayerName ( player ) )
							westsideSetElementData ( _G[getPrivVehString ( x, y )], "owner", pname )
							westsideSetElementData ( _G[getPrivVehString ( x, y )], "name", "privVeh"..x..y )
							westsideSetElementData ( _G[getPrivVehString ( x, y )], "carslotnr_owner", y )
							westsideSetElementData ( _G[getPrivVehString ( x, y )], "locked", true )
							westsideSetElementData ( _G[getPrivVehString ( x, y )], "fuelstate", 100 )
							westsideSetElementData ( _G[getPrivVehString ( x, y )], "Gang", 0 )
							
							setVehicleLocked ( _G[getPrivVehString ( x, y )], true )
							local z = westsideGetElementData ( player, "carbuyslot" )
							westsideSetElementData ( player, "carslot"..z, 1 )
							westsideSetElementData ( player, "curcars", westsideGetElementData ( player, "curcars" )+1 )
							
							local Besitzer = westsideGetElementData ( _G[getPrivVehString ( x, y )], "owner" )
							if not Tuning then
								Tuning = "|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|"
							end
							local Spawnpos_X, Spawnpos_Y, Spawnpos_Z = getElementPosition ( _G[getPrivVehString ( x, y )] )
							local Slot = westsideGetElementData ( _G[getPrivVehString ( x, y )], "carslotnr_owner" )
							setVehicleRotation ( _G[getPrivVehString ( x, y )], rx, ry, rz )
							local Spawnrot_X, Spawnrot_Y, Spawnrot_Z = getVehicleRotation ( _G[getPrivVehString ( x, y )] )
							
							local Farbe1, Farbe2, Farbe3, Farbe4
							local Paintjob
							
							if not c1 or not c2 or not c3 or not c4 then
								Farbe1, Farbe2, Farbe3, Farbe4 = getVehicleColor ( _G[getPrivVehString ( x, y )] )
							else
								Farbe1, Farbe2, Farbe3, Farbe4 = c1, c2, c3, c4
								setVehicleColor ( _G[getPrivVehString ( x, y )], c1, c2, c3, c4 )
							end
							if not p then
								Paintjob = getVehiclePaintjob ( _G[getPrivVehString ( x, y )] )
							else
								Paintjob = p
								setVehiclePaintjob ( _G[getPrivVehString ( x, y )], p )
							end
							local Benzin = westsideGetElementData ( _G[getPrivVehString ( x, y )], "fuelstate" )
							westsideSetElementData ( _G[getPrivVehString ( x, y )], "stuning", "0|0|0|0|0|0|" )
							
							local color = "|"..Farbe1.."|"..Farbe2.."|"..Farbe3.."|"..Farbe4.."|"
							westsideSetElementData ( _G[getPrivVehString ( x, y )], "color", color )
							westsideSetElementData ( _G[getPrivVehString ( x, y )], "NewTuningTL", 0 )
							westsideSetElementData ( _G[getPrivVehString ( x, y )], "NewTuningMU", 0 )
							westsideSetElementData ( _G[getPrivVehString ( x, y )], "lcolor", "|255|255|255|" )
							
							specPimpVeh ( _G[getPrivVehString ( x, y )] )
							SaveCarData ( player )
							
                            outputChatBox("Herzlichen Glückwunsch, du hast erfolgreich ein Fahrzeug erworben!",player)
							outputChatBox("Unter /vehhelp erhälst du weitere Informationen zu deinen Fahrzeugen.",player)
							
							if(westsideGetElementData(player,'Erfolg_MeinErstesFahrzeug')==0)then
								westsideSetElementData(player,"Erfolg_MeinErstesFahrzeug",1)
								triggerClientEvent(player,'erfolgWindow',player,'Mein erstes Fahrzeug')
								westsideSetElementData(player,'pokale',tonumber(westsideGetElementData(player,'pokale'))+1)
								outputLog(getPlayerName(player)..' hat den Erfolg Mein erstes Fahrzeug freigeschalten!','Erfolge')
							end
							
							westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 100)

							outputLog("[FAHRZUGE]: "..getPlayerName(player).." hat sich folgendes Fahrzeug gekauft: "..vehid.."!","Fahrzeugsystem")
							
							if getElementData(player,"gutschein") == true then
								setElementData(player,"gutschein",false)
								westsideSetElementData(player,"fgutschein",tonumber(westsideGetElementData(player,"fgutschein")) - 1)
							else
								takePlayerSaveMoney(player,carprice)
							end
							
							warpPedIntoVehicle ( player, _G[getPrivVehString ( x, y )], 0 )
							
							local result = mysql_query(handler, "INSERT INTO vehicles (Besitzer, Typ, Tuning, Spawnpos_X, Spawnpos_Y, Spawnpos_Z, Spawnrot_X, Spawnrot_Y, Spawnrot_Z, Farbe, Paintjob, Benzin, Slot) VALUES ('"..Besitzer.."', "..vehid..", '"..Tuning.."', '"..Spawnpos_X.."', '"..Spawnpos_Y.."', '"..Spawnpos_Z.."', '"..Spawnrot_X.."', '"..Spawnrot_Y.."', '"..Spawnrot_Z.."', '"..color.."', '"..Paintjob.."', '"..Benzin.."', '"..Slot.."')")
							if ( not result ) then
								outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
								destroyElement ( _G[getPrivVehString ( x, y )] )
							else
								mysql_free_result(result)
							end
							activeCarGhostMode ( player, 10000 )
							
							setElementPosition ( _G[getPrivVehString ( x, y )], spawnx, spawny, spawnz )
							westsideSetElementData ( player, "everyCarBuyableForFree", false )
							
								if(westsideGetElementData(player,"curcars")==10)then
									if(westsideGetElementData(player,'Erfolg_Fahrzeugsammler')==0)then
										westsideSetElementData(player,'Erfolg_Fahrzeugsammler',1)
										triggerClientEvent(player,'erfolgWindow',player,'Fahrzeugsammler')
										westsideSetElementData(player,'pokale',tonumber(westsideGetElementData(player,'pokale'))+1)
											outputLog(getPlayerName(player)..' hat den Erfolg Fahrzeugsammler freigeschalten!','Erfolge')
									end
								end
							
							return true
							end,3000,1)
						else
							infobox(player,"Du hast nicht die\nerforderlichen Scheine!",4000,255,0,0)
						end
					else
						infobox(player,"Du hast nicht genug Geld, oder\nkeinen aktiven Gutschein!",4000,255,0,0)
					end
				end
			else
				infobox(player,"Du hast keinen\nfreien Slot mehr!",4000,255,0,0)
			end
		end
	end
	return false
end

function getFreeCarSlot ( player )

	if westsideGetElementData ( player, "maxcars" ) > westsideGetElementData ( player, "curcars" ) then
		local cars = 0
		for i = 1, 10 do
			if westsideGetElementData ( player, "carslot"..i ) == 0 then
				return i
			end
		end
	else
		return false
	end
end

addCommandHandler("fgutschein",function(player)
	if tonumber(westsideGetElementData(player,"fgutschein")) >= 1 then
		setElementData(player,"gutschein",true)
		outputChatBox("Du kannst dir nun ein Fahrzeug kaufen, was dich nichts kosten wird!",player,0,200,200)
	else
		infobox(player,"Du hast keine(n) Gutschein(e)!")
	end
end)