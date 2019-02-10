function tazer_func ( player )
	if player == client or not client then
		if isCop(player) or isFBI(player) or isArmy(player) and getElementData(player,"onDuty") == true then
			if westsideGetElementData ( player, "tazer" ) == 1 then else westsideSetElementData ( player, "tazer", 0 ) end
			if westsideGetElementData ( player, "tazer" ) == 0 then
				if not getPedOccupiedVehicle ( player ) then
					local posX, posY, posZ = getElementPosition( player )
					local tazerSphere = createColSphere( posX, posY, posZ, 3 )
					local nearbyPlayers = getElementsWithinColShape( tazerSphere, "player" )
					destroyElement( tazerSphere )
					local bestDist = 999
					local px, py, pz = 0, 0, 0
					local cDist = 0
					for index, nearbyPlayer in ipairs( nearbyPlayers ) do
						if nearbyPlayer ~= player and not getPedOccupiedVehicle ( nearbyPlayer ) and ( ( isPedAiming ( nearbyPlayer ) and getPedWeapon ( nearbyPlayer ) < 2 ) or not isPedAiming ( nearbyPlayer ) ) then
							px, py, pz = getElementPosition ( nearbyPlayer )
							cDist = getDistanceBetweenPoints3D ( posX, posY, posZ, px, py, pz )
							if cDist <= bestDist then
								curTazerVicitm = nearbyPlayer
								bestDist = cDist
							end
						end
					end
					if bestDist < 999 then
						setPedAnimation( curTazerVicitm, "crack", "crckdeth2",-1,true,true,false)
						setTimer ( defreeze_tazer, 20000, 1, curTazerVicitm )
						westsideSetElementData ( player, "tazer", 1 )
						setTimer ( reuse_tazer, 25000, 1, player )
						local posX, posY, posZ = getElementPosition( player )
						local chatSphere = createColSphere( posX, posY, posZ, 10 )
						local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
						destroyElement ( chatSphere )
						toggleAllControls ( curTazerVicitm, false, true, false )
						for index, nearbyPlayer in ipairs( nearbyPlayers ) do
							local pname = getPlayerName ( player )
							outputChatBox ("** "..getPlayerName(curTazerVicitm).." wurde von "..pname.." getazert! **", nearbyPlayer,150,150,0)
						end
						westsideSetElementData ( curTazerVicitm, "tazered", true )
					else
						infobox(player,"Es ist kein Spieler\nin der Nähe!",4000,255,0,0)
					end
				end
			else
				infobox(player,"Tazern ist nur alle\n25 Sekunden möglich!",4000,255,0,0)
			end
		end
	end
end
addEvent ( "tazer", true )
addEventHandler ( "tazer", getRootElement(), tazer_func )
addCommandHandler ( "tazer", tazer_func )

function defreeze_tazer ( player )
	setPedAnimation ( player )
	westsideSetElementData ( player, "tazered", false )
	if westsideGetElementData ( player, "tied" ) then
		toggleAllControls ( player, true, true, false )
	end
end

function reuse_tazer ( player )
	westsideSetElementData ( player, "tazer", 0 )
end