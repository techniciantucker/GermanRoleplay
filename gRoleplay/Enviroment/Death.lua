function playerdeath ( ammo, killer, weapon, part )
	local player = source
	if part then
		if part == 9 then
			setPedHeadless ( player, true )
		end
	end
	
	if isKeyBound ( player, "enter_exit", "down", heliCoSeat ) then
		heliCoSeat ( player )
	end
	
	--[[ if getElementData(player,"inDeagleArena") == true then
		deagleArena_respawn(player)
	else ]]--
			if westsideGetElementData ( player, "callswith" ) then
				if westsideGetElementData ( player, "callswith" ) ~= "none" then
					local caller = getPlayerFromName ( westsideGetElementData ( player, "callswith" ) )
					if caller then
						westsideSetElementData ( caller, "callswith", "none" )
						westsideSetElementData ( caller, "call", false )
						westsideSetElementData ( caller, "calls", "none" )
						westsideSetElementData ( caller, "callswith", "none" )
						westsideSetElementData ( caller, "calledby", "none" )
						infobox(caller,"Dein Gesprächspartner\nist offline gegangen!",4000,255,0,0)
					end
					
					westsideSetElementData ( player, "callswith", "none" )
					westsideSetElementData ( player, "call", false )
					westsideSetElementData ( player, "calls", "none" )
					westsideSetElementData ( player, "callswith", "none" )
					westsideSetElementData ( player, "calledby", "none" )
				end
			end
			
			if westsideGetElementData ( player, "isInDrivingSchool" ) then
				cancelDrivingSchoolPlayer ( player )
			end
			if getPedOccupiedVehicle ( player ) then
				removePedFromVehicle ( player )
			end
			
			if isElement ( killer ) and killer ~= player and getPlayerName ( killer ) and weapon and getElementData(player,"onDuty") == false then
				outputServerLog ( getPlayerName ( killer ).." hat "..getPlayerName(player).." mit Waffe "..weapon.." erledigt!" )
				if westsideGetElementData ( player, "fraktion" ) == 0 then
					local x1, y1, z1 = getElementPosition ( player )
					local x2, y2, z2 = getElementPosition ( killer )
					
					if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) < 7.5 then
						outputChatBox ( "Du hast ein Verbrechen begangen: Mord, gemeldet von: Anonym!", killer, 255,0,0 )
						if westsideGetElementData ( killer, "wanteds" ) <= 5 then
							westsideSetElementData ( killer, "wanteds", westsideGetElementData ( killer, "wanteds" ) + 1 )
							setPlayerWantedLevel ( killer, westsideGetElementData ( killer, "wanteds" ) )
						end
					elseif getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) < 15 then
						if math.random ( 1, 2 ) == 1 then
							outputChatBox ( "Du hast ein Verbrechen begangen: Mord, gemeldet von: Anonym!", killer, 255,0,0 )
							if westsideGetElementData ( killer, "wanteds" ) <= 5 then
								westsideSetElementData ( killer, "wanteds", westsideGetElementData ( killer, "wanteds" ) + 1 )
								setPlayerWantedLevel ( killer, westsideGetElementData ( killer, "wanteds" ) )
							end
						else
							westsideSetElementData ( killer, "lastcrime", "mord" )
						end
					else
						westsideSetElementData ( killer, "lastcrime", "mord" )
					end
				end
			end
			
			setPlayerNametagColor ( player, 200, 200, 200 )
			
			if getElementData(player,"MechanikerDuty") == true then
				setElementData(player,"MechanikerDuty",false)
			end
			
			if getElementData(player,"onDuty") == true then
				setElementData(player,"onDuty",false)
			end
			
			if getElementData(player,"rduty") == true then
				setElementData(player,"rduty",false)
			end
				
			unbindKey ( player, "mouse_wheel_up", "down", weaponsup )
			unbindKey ( player, "mouse_wheel_down", "down", weaponsdown )
			unbindKey ( player, "enter", "down", eject )
			unbindKey ( player, "rshift", "down", helidriveby )
			unbindKey ( player, "1", "down", tazer_func )
			local timeToBeDeath = 60*1000
				
			----- Vip -----
			
			if(getElementData(player,"vip")==1)then
				timeToBeDeath = 30*1000
			elseif(getElementData(player,"vip")==2)then
				timeToBeDeath = 20*1000
			elseif(getElementData(player,"vip")==3)then
				timeToBeDeath = 10*1000
			elseif(getElementData(player,"vip")==4)then
				timeToBeDeath = 5*1000
			end
				
				
			westsideSetElementData ( player, "heaventime", timeToBeDeath )
			setTimer ( endfade, 5000, 1, player, timeToBeDeath )
			if killer and killer ~= player and getElementType ( killer ) == "player" then 
				local kills = tonumber ( westsideGetElementData ( killer, "kills" ) )
				westsideSetElementData ( killer, "kills", kills + 1 )
				blackListKillCheck ( player, killer, weapon )
				if getElementData(killer,"onDuty") == true or isArmy ( killer ) then
					if westsideGetElementData ( player, "wanteds" ) == 0 then
						westsideSetElementData ( killer, "boni", westsideGetElementData ( killer, "boni" )-wantedprice*3 )
						outputChatBox ( "[INFO]: Ein Unschuldiger wurde erschossen! "..(wantedprice*3).."$ Payday Abzug!", killer, 0,100,150 )
					else
						local strafe = westsideGetElementData ( player, "wanteds" ) * wantedprice
						local wanteds = westsideGetElementData ( player, "wanteds" )
						local time = westsideGetElementData ( player, "wanteds" ) * jailtimeperwanted * 0.3
						westsideSetElementData ( player, "wanteds", 0 )
						setPlayerWantedLevel ( player, 0 )
						if tonumber(strafe) > westsideGetElementData ( player, "money" ) then		
							takePlayerMoney ( player, westsideGetElementData ( player, "money" ) )
							westsideSetElementData ( player, "money", 0 )
						else
							westsideSetElementData ( player, "money", tonumber(westsideGetElementData ( player, "money" )) - tonumber(strafe) )
							takePlayerMoney ( player, tonumber(strafe) )	
						end
						
						westsideSetElementData ( player, "jailtime", time )
						westsideSetElementData ( player, "bail", 0 )
						local grammafix  = " ohne Kaution " 
						outputChatBox ( "[INFO]: "..getPlayerName(killer).." hat dich für "..strafe.."$ und "..time.." Minuten eingesperrt!", player, 0,100,150 )
						westsideSetElementData ( killer, "boni", westsideGetElementData ( killer, "boni" )+wanteds*(wantedprice/3) )
						westsideSetElementData(killer,"erfahrungspunkte",tonumber(westsideGetElementData(killer,"erfahrungspunkte")) + 50)
						outputChatBox ( "[INFO]: Du hast "..getPlayerName ( player ).." erledigt! "..wanteds*(wantedprice/3).."$ Payday Bonus!", killer, 0,100,150 )
					end
				end
			end
			
			westsideSetElementData ( player, "deaths", westsideGetElementData ( player, "deaths" ) + 1 )
			setPlayerNametagShowing ( player, true )

			local curdrogen = westsideGetElementData ( player, "drugs" )
			local amount = getDropAmount ( curdrogen )
			if amount > 0 then
				westsideSetElementData ( player, "drugs", curdrogen - amount )
				local x, y, z = getElementPosition ( player )
				pickup = createPickup ( 0, 0, 0, 3, 1210, 1 )
				setElementPosition ( pickup, x, y, z )
				westsideSetElementData ( pickup, "amount", amount )
				setElementDimension ( pickup, getElementDimension ( player ) )
				setElementInterior ( pickup, getElementInterior ( player ) )
				addEventHandler ( "onPickupHit", pickup, drugDropHit )
			end
				
			local curmats = westsideGetElementData ( player, "mats" )
			amount = getDropAmount ( curmats )
				
			if amount > 0 then
				westsideSetElementData ( player, "mats", curmats - amount )
				local x, y, z = getElementPosition ( player )
				pickup = createPickup ( 0, 0, 0, 3, 1210, 1 )
				setElementPosition ( pickup, x + 0.5, y, z )
				westsideSetElementData ( pickup, "amount", amount )
				setElementDimension ( pickup, getElementDimension ( player ) )
				setElementInterior ( pickup, getElementInterior ( player ) )
				addEventHandler ( "onPickupHit", pickup, matDropHit )
			end
			
			local money = westsideGetElementData ( player, "money" )
			loss = 5
			if money > 0 then
				westsideSetElementData ( player, "money", math.abs(math.floor(money/100*(100-loss))) )
				takePlayerMoney ( player, math.floor(money/100*loss) )
				local x, y, z = getElementPosition ( player )
				pickup = createPickup ( 0, 0, 0, 3, 1212, 1 )
				setElementPosition ( pickup, x, y + 0.5, z )
				westsideSetElementData ( pickup, "money", math.floor(money/100*loss) )
				setElementDimension ( pickup, getElementDimension ( player ) )
				setElementInterior ( pickup, getElementInterior ( player ) )
						
				addEventHandler ( "onPickupHit", pickup, moneyDropHit )
			end
			setElementDimension ( player, 0 )
			setElementInterior ( player, 0 )

		showChat ( player, true )
		showPlayerHudComponent ( player, "radar", true )
			
		if isElement ( killer ) then
			if getElementType ( killer ) == "player" then
				outputLog ( getPlayerName ( player ).." wurde von "..tostring ( getPlayerName ( killer ) ).." getoetet ( Waffe: "..weapon.." )", "Kills" )
			elseif getElementType ( killer ) == "vehicle" then
				outputLog ( getPlayerName ( player ).." wurde von "..tostring ( getVehicleOccupant( killer, 0)).." getoetet ( Waffe: "..getVehicleName(killer).." )", "Kills" )
			else
				outputLog ( getPlayerName ( player ).." wurde von einem unbekannten "..getElementType ( killer ).." getoetet!", "Kills" )
			end
		else
			outputLog ( getPlayerName ( player ).." ist gestorben!", "Tode" )
		end
	--end
end
addEventHandler ( "onPlayerWasted", getRootElement(), playerdeath )

function endfade ( player, timeToBeDeath )
	if isElement ( player ) then
		removePedFromVehicle ( player )
		
		-- Position, wo hingezeigt wird, wenn man im Krankenhaus ist
		setCameraMatrix ( player, 1257.5805664063, -1387.7769775391, 77.007797241211, 1256.9145507813, -1387.337890625, 76.404777526855 )
		
		if tonumber ( westsideGetElementData ( player, "adminlvl" ) ) < 1 then
			toggleAllControls ( player, false )
		end
		showPlayerHudComponent ( player, "radar", false )
		triggerClientEvent ( player, "showProgressBar", player )
		showChat ( player, true )
		refreshDeathTimeForPlayer ( player, 0, timeToBeDeath )
	end
end

function refreshDeathTimeForPlayer ( player, timeDone, holeTime )
	if isElement ( player ) then
		if timeDone / holeTime >= 1 then
			revive ( player )
			triggerClientEvent ( player, "updateDeathBar", player, 100 )
			return nil
		end
		triggerClientEvent ( player, "updateDeathBar", player, timeDone / holeTime * 100 )
		todeszeit = setTimer ( refreshDeathTimeForPlayer, 2500, 1, player, timeDone + 2500, holeTime )
	end
end

function revive ( player )
	if isElement ( player ) then
		toggleAllControls ( player, true )
		westsideSetElementData ( player, "heaventime", 0 )
		infobox(player,"Du bist wieder gesund!")
		if(westsideGetElementData(player,'hunger')<6)then
			westsideSetElementData(player,'hunger',5)
		end
		if(westsideGetElementData(player,'harndrang')>94)then
			westsideSetElementData(player,'harndrang',95)
		end
		playSoundFrontEnd ( player, 17 )
		RemoteSpawnPlayer ( player )
		showChat ( player, true )
	end
end

function headFixOnSpawn ()
	setPedHeadless ( source, false )
end
addEventHandler ( "onPlayerSpawn", getRootElement(), headFixOnSpawn )

----- Befehl, zum abbrechen des Krankenhauses -----
addCommandHandler('nodeath',function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'adminlvl')>=4)then
			if(isTimer(todeszeit))then
				infobox(player,'Krankenhauszeit vorzeitig beendet!')
				revive(player)
				triggerClientEvent(player,'deathbarclose',player)
				outputLog(getPlayerName(player).." hat seine Krankenhauszeit vorzeitig beendet!","Adminsystem")
				if(isTimer(todeszeit))then
					killTimer(todeszeit)
				end
			end
		end
	end
end)