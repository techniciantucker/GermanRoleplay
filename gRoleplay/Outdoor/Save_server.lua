local lastsave = {}
local savetimer = {}
local savepositions = {}
local savecountdown = 20
local savecountdownmessage = 5
local secondstocomeback = 20																			

function saveFiveMinScript ( player )
	if not getPedOccupiedVehicle ( player ) then
		if savetimer[player] then
			killTimer ( savetimer[player] )
		end
		savetimer[player] = setTimer ( startSaveCountdown, savecountdownmessage * 1000, savecountdown / savecountdownmessage, player )
		local x, y, z = getElementPosition ( player )
		savepositions[player] = { x, y, z }
		outputChatBox ( "[INFO]: Du wirst in "..savecountdown.." Sekunden ausgeloggt!", player, 0, 100,150 )
	end
end
addCommandHandler ( "save", saveFiveMinScript )

function startSaveCountdown ( player )
	if getPlayerName ( player ) then
		local x, y, z = getElementPosition ( player )
		if getDistanceBetweenPoints3D ( x, y, z, savepositions[player][1], savepositions[player][2], savepositions[player][3] ) <= 1 then
			local _, remainingexecutes = getTimerDetails ( savetimer[player] )
			if remainingexecutes > 1 then
				local totalexecutes = savecountdown / savecountdownmessage
				outputChatBox ( savecountdown - ( ( totalexecutes-remainingexecutes+1 ) * savecountdownmessage ).." Sekunden ...", player, 0,100,150 )
			else
				lastsave[getPlayerName(player)] = getTickCount()
				logoutPlayer_func ( player, x, y, z, getElementInterior ( player ), getElementDimension ( player ) )
				savepositions[player] = nil
			end
		else
			infobox(player,"Save abgebrochen!",4000,255,0,0)
			if savetimer[player] and isTimer ( savetimer[player] ) then
				killTimer ( savetimer[player] )
				savetimer[player] = nil
			end
			savepositions[player] = nil
		end
	else
		if savetimer[player] and isTimer ( savetimer[player] ) then
			killTimer ( savetimer[player] )
			savetimer[player] = nil
		end
		savepositions[player] = nil
	end
end

function checkLastSaveOnConnect ( nick )															
	if lastsave[nick] and lastsave[nick] + secondstocomeback * 1000 < getTickCount() then
		MySQL_DelRow ( "logout", "Name LIKE '"..nick.."'" )
	end
	lastsave[nick] = nil
end
addEventHandler ( "onPlayerConnect", getRootElement(), checkLastSaveOnConnect )

function logoutPlayer_func ( player, x, y, z, int, dim )
		local pname = MySQL_Save ( getPlayerName ( player ) )
		local int = tonumber ( MySQL_Save ( int ) )
		local dim = tonumber ( MySQL_Save ( dim ) )
		local curWeaponsForSave = "|"
		for i = 1, 11 do
			if i ~= 10 then
				local weapon = getPedWeapon ( player, i )
				local ammo = getPedTotalAmmo ( player, i )
				if weapon and ammo then
					if weapon > 0 and ammo > 0 then
						if #curWeaponsForSave <= 40 then
							curWeaponsForSave = curWeaponsForSave..weapon..","..ammo.."|"
						end
					end
				end
			end
		end
		curWeaponsForSave = MySQL_Save ( curWeaponsForSave )
		pos = "|"..(math.floor(x*100)/100).."|"..(math.floor(y*100)/100).."|"..(math.floor(z*100)/100).."|"..int.."|"..dim.."|"
		if #curWeaponsForSave < 5 then
			curWeaponsForSave = ""
		end
		local result = mysql_vio_query( "INSERT INTO logout (Position, Waffen, Name) VALUES ('"..pos.."', '"..curWeaponsForSave.."', '"..pname.."')")
		kickPlayer ( player, "Ausgeloggt." )
end
addEvent ( "logoutPlayer", true )
addEventHandler ( "logoutPlayer", getRootElement(), logoutPlayer_func )