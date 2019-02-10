--[[

1 Ticketbeauftragter
2 Supporter
3 Moderator
4 Administrator
5 Servermanager
6 Stellv. Projektleiter
7 Projektleiter

]]--

----- Table -----
adminsIngame = {}
local player_admin = {}
local frozen_players = {}
local veh_frozen_players = {}
local veh_frozen_vehs = {}

----- Funktionen -----
local pack_cmds = {}
pack_cmds["msg"] = true
pack_cmds["pm"] = true

function blockParticularCmds ( cmd )
	if pack_cmds[cmd] then
		cancelEvent()
		infobox(source,"Du bist nicht befugt!",4000,255,0,0)
	end
end

function blockParticularCmdsJoin ( )
	addEventHandler( "onPlayerCommand", source, blockParticularCmds )
end
addEventHandler ( "onPlayerJoin", getRootElement(), blockParticularCmdsJoin )

function executeAdminServerCMD_func ( cmd, arguments )
	executeCommandHandler ( cmd, client, arguments )
end

function doesAnyPlayerOccupieTheVeh ( car )
	local bool = false
	for i = 0, 5, 1 do
		local test = getVehicleOccupant ( car, i )
		if test ~= false then
			bool = true
		end
	end
	if bool == false then
		return false
	else
		return true
	end
end

function getAdminLevel ( player )
	local plevel = westsideGetElementData ( player, "adminlvl" )
	if not plevel or plevel == nil then
		return 0
	end
	return tonumber(plevel)
end

function isAdminLevel ( player, level )
	local plevel = westsideGetElementData ( player, "adminlvl" )
	if not plevel or plevel == nil then
		return false
	end
	if plevel >= level then
		return true
	else
		return false
	end
end

----- Account löschen -----
addCommandHandler("deleteAcc",function(player,cmd,target)
	if(westsideGetElementData(player,"adminlvl")>=6)then
		if(target)then
			if(getPlayerFromName(target))then
				infobox(player,"Der Spieler darf nicht\nonline sein!",4000,255,0,0)
			else
				if(MySQL_DatasetExist("players", "Name LIKE '"..target.."'"))then
					MySQL_SetString("houses", "Besitzer", "none", "Besitzer LIKE '"..target.."'")
					MySQL_DelRow("inventar", "Name LIKE '"..target.."'")
					MySQL_DelRow("logout", "Name LIKE '"..target.."'")
					MySQL_DelRow("packages", "Name LIKE '"..target.."'")
					MySQL_DelRow("players", "Name LIKE '"..target.."'")
					MySQL_DelRow("userdata", "Name LIKE '"..target.."'")
					MySQL_DelRow("vehicles", "Besitzer LIKE '"..target.."'")
					infobox(player,"Der Account von "..target.." wurde\nerfolgreich gelöscht!",4000,0,255,0)
					
					outputLog("[ADMIN]: "..getPlayerName(player).." hat den Account von "..target.." gelöscht!","Adminsystem")
				end
			end
		else
			infobox(player,"Kein Spieler angegeben!",4000,255,0,0)
		end
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end)

----- Nickchange -----
function nickchange_func ( player, cmd, alterName, neuerName )
	if isAdminLevel ( player, 5 ) then
		if(alterName)then
			local alterName = MySQL_Save ( alterName )
			if(neuerName)then
				local neuerName = MySQL_Save ( neuerName )
				if MySQL_DatasetExist ( "players", "Name LIKE '"..alterName.."'") then
					if not MySQL_DatasetExist ( "players", "Name LIKE '"..neuerName.."'") and not MySQL_DatasetOldExist ( "players", "Name LIKE '"..neuerName.."'") then
						-- Daten
						MySQL_SetString ( "houses", "Besitzer", neuerName, "Besitzer LIKE '"..alterName.."'")
						MySQL_SetString ( "inventar", "Name", neuerName, "Name LIKE '"..alterName.."'")
						MySQL_SetString ( "logout", "Name", neuerName, "Name LIKE '"..alterName.."'")
						MySQL_SetString ( "packages", "Name", neuerName, "Name LIKE '"..alterName.."'")
						MySQL_SetString ( "players", "Name", neuerName, "Name LIKE '"..alterName.."'")
						MySQL_SetString ( "userdata", "Name", neuerName, "Name LIKE '"..alterName.."'")
						MySQL_SetString ( "vehicles", "Besitzer", neuerName, "Besitzer LIKE '"..alterName.."'")
						infobox(player,"Du hast "..alterName.." in\n"..neuerName.." umbenannt!",4000,0,255,0)

						outputLog("[ADMIN]: "..getPlayerName(player).." hat "..alterName.." in "..neuerName.." umbenannt!","Adminsystem")
					else
						infobox(player,"Der Name ist bereits vergeben!",4000,255,0,0)
					end
				else
					infobox(player,"Der Spieler wurde\nnicht gefunden!",4000,255,0,0)
				end
			else
				infobox(player,'Kein neuen Namen angegeben!')
			end
		else
			infobox(player,"Kein Name angegeben!",4000,255,0,0)
		end
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end

----- Passwort ändern -----
function pwchange_func ( player, cmd, target, newPW )
	if isAdminLevel ( player, 4 ) then
		if newPW and target then
			local target = MySQL_Save ( target )
			local newPW = MySQL_Save ( newPW )
			local empty = ""
			MySQL_SetString ( "players", "Passwort", md5(newPW), "Name LIKE '" ..target.."'" )
			MySQL_SetString ( "players", "Salt", empty, "Name LIKE '" ..target.."'" )
			infobox(player,"Das Passwort von "..target.."\nwurde erfolgreich geändert!",4000,0,255,0)
			
			outputLog("[ADMIN]: "..getPlayerName(player).." hat das Passwort von "..target.." geändert!","Adminsystem")
		else
			infobox(player,"Nutze /pwchange [Name],\n[Passwort]!",4000,0,100,150)
		end
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end

----- Rebind -----
function rebind_func ( player )
	if isKeyBound ( player, "ralt", "down", showcurser ) then
		unbindKey ( player, "ralt", "down", showcurser )
	end
	if isKeyBound ( player, "m", "down", showcurser ) then
		unbindKey ( player, "m", "down", showcurser )
	end
	if isKeyBound ( player, "r", "down", reload ) then
		unbindKey ( player, "r", "down", reload )
	end
	bindKey ( player, "ralt", "down", showcurser, player )
	bindKey ( player, "m", "down", showcurser, player )
	bindKey ( player, "r", "down", reload )
	infobox(player,"Klicksystem neu aufgesetzt!",4000,0,255,0)
	
	outputLog("[ADMIN]: "..getPlayerName(player).." hat /rebind benutzt!","Adminsystem")
end

----- Respawnen -----
function respawn_func ( player, cmd, respawn )
	if isAdminLevel(player,4) then
		if respawn ~= nil then
			if respawn == "Sapd" then
				for veh, _ in pairs ( factionVehicles[1] ) do
					if not getVehicleOccupant ( veh ) then
						respawnVehicle ( veh )
					end
				end
			elseif respawn == "Brigada" then
				for veh, _ in pairs ( factionVehicles[2] ) do
					if not getVehicleOccupant ( veh ) then
						respawnVehicle ( veh )
					end
				end
			elseif respawn == "Triaden" then
				for veh, _ in pairs ( factionVehicles[3] ) do
					if not getVehicleOccupant ( veh ) then
						respawnVehicle ( veh )
					end
				end
			elseif respawn == "Kartell" then
				for veh, _ in pairs ( factionVehicles[4] ) do
					if not getVehicleOccupant ( veh ) then
						respawnVehicle ( veh )
					end
				end
			elseif respawn == "Reporter" then
				for veh, _ in pairs ( factionVehicles[5] ) do
					if not getVehicleOccupant ( veh ) then
						respawnVehicle ( veh )
					end
				end
			elseif respawn == "FBI" then
				for veh, _ in pairs ( factionVehicles[6] ) do
					if not getVehicleOccupant ( veh ) then
						respawnVehicle ( veh )
					end
				end
			elseif respawn == "Grove" then
				for veh, _ in pairs ( factionVehicles[7] ) do
					if not getVehicleOccupant ( veh ) then
						respawnVehicle ( veh )
					end
				end
			elseif respawn == "Army" then
				for veh, _ in pairs ( factionVehicles[8] ) do
					if not getVehicleOccupant ( veh ) then
						respawnVehicle ( veh )
					end
				end			
			elseif respawn == "Biker" then
				for veh, _ in pairs ( factionVehicles[9] ) do
					if not getVehicleOccupant ( veh ) then
						respawnVehicle ( veh )
					end
				end
			elseif respawn == "Mechaniker" then
				for veh, _ in pairs ( factionVehicles[10] ) do
					if not getVehicleOccupant ( veh ) then
						respawnVehicle ( veh )
					end
				end
			else
				infobox(player,"Die Fraktion wurde\nnicht gefunden!",4000,255,0,0)
			end
		else
			infobox(player,"Tippe /respawn [Fraktion]!",4000,0,100,150)
		end
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end

----- Nach Restart respawnen -----
function ServerRestartFactionRespawn ()
	respawn_func ( "none", "none", "Sapd" )
	respawn_func ( "none", "none", "Kartell" )
	respawn_func ( "none", "none", "Brigada" )
	respawn_func ( "none", "none", "Triaden" )
	respawn_func ( "none", "none", "Reporter" )
	respawn_func ( "none", "none", "FBI" )
	respawn_func ( "none", "none", "Grove" )
	respawn_func ( "none", "none", "Army" )
	respawn_func ( "none", "none", "Biker" )
	respawn_func ( "none", "none", "Mechaniker" )
end
setTimer ( ServerRestartFactionRespawn, 30000, 1 )

----- Wetter ändern -----
function changeweather ( player )
	if isAdminLevel ( player, 2 ) then
		outputChatBox ( "~ Wetter Ansage ~", getRootElement(), 250, 150, 0 )
		outputChatBox ( "Jayden Terrel: Aufgrund einer drastischen Hitze Welle, ", getRootElement(), 250, 150, 0 )
		outputChatBox ( "Jayden Terrel: wird sich das Wetter demnächst zum guten Wenden! ", getRootElement(), 250, 150, 0 )
		outputChatBox ( "Jayden Terrel: Dies war es auch schon von mir! Euer Jayden! ", getRootElement(), 250, 150, 0 )
		infobox(player,"Wetteränderung ausgelöst!",4000,0,255,0)
		
		outputLog("[ADMIN]: "..getPlayerName(player).." hat eine Wetter Änderung ausgelöst!","Adminsystem")
		-----------------------
		setTimer ( function()
		setWeather ( 1 )
		end, 60000, 1 )
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end

----- Text leeren -----
function cleartext_func ( player )
	if westsideGetElementData ( player, "adminlvl" ) == "console" then
		westsideSetElementData( player, "adminlvl", 99 )
	end
	if isAdminLevel ( player, 2 ) then
		for i = 1, 50 do
			outputChatBox ( " " )
		end
		infobox(player,"Du hast den Chat geleert!",4000,0,255,0)
		
		outputLog("[ADMIN]: "..getPlayerName(player).." hat den Chat geleert!","Adminsystem")
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end

----- Öffentlicher Adminchat -----
function ochat_func ( player, cmd, ... )
	local parametersTable = {...}
	local stringWithAllParameters = table.concat( parametersTable, " " )
	if isAdminLevel ( player, 1 ) then
		if stringWithAllParameters == "" then
			infobox(player,"Gebe einen Text ein!",4000,0,100,150)
		else
		    if tonumber(getElementData ( player, "adminlvl" )) == 1 then 
			   rank = "Ticketbeauftragter"
			   outputChatBox ("(( "..rank.." "..getPlayerName(player)..": "..stringWithAllParameters.." ))", getRootElement(), 255,255,255)
			elseif tonumber(getElementData ( player, "adminlvl" )) == 2 then
				rank = "Supporter"
				outputChatBox ( "(( "..rank.." "..getPlayerName(player)..": "..stringWithAllParameters.." ))", getRootElement(), 255,255,255 )
			elseif tonumber(getElementData ( player, "adminlvl" )) == 3 then
				rank = "Moderator"
				outputChatBox ( "(( "..rank.." "..getPlayerName(player)..": "..stringWithAllParameters.." ))", getRootElement(), 255,255,255 )
			elseif tonumber(getElementData ( player, "adminlvl" )) == 4 then
				rank = "Administrator"
				outputChatBox ( "(( "..rank.." "..getPlayerName(player)..": "..stringWithAllParameters.." ))", getRootElement(), 255,255,255 )
			elseif tonumber(getElementData ( player, "adminlvl" )) == 5 then
				rank = "Servermanager"
				outputChatBox ( "(( "..rank.." "..getPlayerName(player)..": "..stringWithAllParameters.." ))", getRootElement(), 255,255,255 )
			elseif tonumber(getElementData(player,"adminlvl")) == 6 then
				rank = "Stellv. Projektleiter"
				outputChatBox ( "(( "..rank.." "..getPlayerName(player)..": "..stringWithAllParameters.." ))", getRootElement(), 255,255,255 )
			elseif tonumber(getElementData ( player, "adminlvl" )) == 7 then
				rank = "Projektleiter"
				outputChatBox ( "(( "..rank.." "..getPlayerName(player)..": "..stringWithAllParameters.." ))", getRootElement(), 255,255,255 )
			end
			outputLog ("[ADMIN]: (O-Chat):"..getPlayerName(player)..": "..stringWithAllParameters.."", "Adminsystem" )
		end
	end
end

----- Internet Adminchat -----
function achat_func ( player, cmd, ... )
	local parametersTable = {...}
	local stringWithAllParameters = table.concat( parametersTable, " " )
	if isAdminLevel ( player, 1 ) then
		if stringWithAllParameters == "" then
			infobox(player,"Gebe einen Text ein!",4000,0,100,150)
		else
			local rang = tonumber(getElementData ( player, "adminlvl" ))
			if rang == 1 then
				rank = "Ticketbeauftragter"
			elseif rang == 2 then
				rank = "Supporter"
			elseif rang == 3 then
				rank = "Moderator"
			elseif rang == 4 then
				rank = "Administrator"
			elseif rang == 5 then
				rank = "Servermanager"
			elseif rang == 6 then
				rank = "Stellv. Projektleiter"
			elseif rang == 7 then
				rank = "Projektleiter"
			end
			for playeritem, index in pairs(adminsIngame) do
				if westsideGetElementData ( playeritem, "adminlvl" ) then
					if tonumber(westsideGetElementData ( playeritem, "adminlvl" )) >= 1 then
						outputChatBox ( "(( "..rank.." "..getPlayerName(player)..": "..stringWithAllParameters.." ))", playeritem, 255,255,0 )
						
						outputLog ("[ADMIN]: (A-Chat): "..getPlayerName(player)..": "..stringWithAllParameters.."", "Adminsystem")
					end
				end
			end
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht befugt!", 2500, 255, 0, 0 )
	end
end

----- Rang setzen -----
function setrank_func ( player, cmd, target, rank )
	if(isAdminLevel(player,5))then
		if(target)then
			local target=getPlayerFromName(target)
			if(rank)then
				if(rank<=5)then
					westsideSetElementData(target,'rang',rank)
					infobox(target,"Dein Rang wurde auf\n"..rank.." gesetzt!",4000,0,255,0)
					infobox(player,"Du hast den Rang von "..target.."\nauf "..rank.." gesetzt!",4000,0,255,0)
				
					outputLog ("[ADMIN]: "..getPlayerName(player).." hat "..getPlayerName(target).." seinen Rank auf "..rank.." gesetzt!", "Adminsystem")
				else
					infobox(player,'Nur 0-5 erlaubt!')
				end
			else
				infobox(player,'Kein Rang angegeben!')
			end
		else
			infobox(player,'Kein Spieller angegeben!')
		end
	else
		infobox(player,'Du bist nicht befugt!')
	end
end

----- Leader setzen -----
function makeleader_func ( player, cmd, target, fraktion )
	target = findPlayerByName( target )
	fraktion = math.floor ( math.abs ( tonumber ( fraktion ) ) )
	if isAdminLevel ( player, 5 ) then
		if getPlayerPing ( target ) == false then
			infobox(player,'Nutze /leader Spieler, Fraktion!')
		else
			if getElementData ( target, "loggedin" ) == 1 then
				if fraktion >= 0 then
					fraktionMembers[westsideGetElementData ( target, "fraktion")][target] = nil
					if fraktion == 0 then
						westsideSetElementData ( target, "rang", 0 )
						outputChatBox ( "[INFO]: Du wurdest von "..getPlayerName ( player ).." zum Zivilisten gemacht!", target, 0,100,150 )
						outputLog ( "[ADMIN]: "..getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum Zivilisten gemacht!","Adminsystem" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
					end
					if fraktion == 1 then
						westsideSetElementData ( target, "rang", 5 )
						outputChatBox ( "[INFO]: Du wurdest von "..getPlayerName ( player ).." zum Leader des SAPD´s ernannt!", target, 0,100,150 )
						outputLog ( "[ADMIN]: "..getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum SAPD Leader ernannt!","Adminsystem" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
					end
					if fraktion == 2 then
						westsideSetElementData ( target, "rang", 5 )
						outputChatBox ( "[INFO]: Du wurdest von "..getPlayerName ( player ).." zum Leader der Brigada ernannt!", target, 0,100,150 )
						outputLog ( "[ADMIN]: "..getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum Brigada Leader ernannt!","Adminsystem" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
					end
					if fraktion == 3 then
						westsideSetElementData ( target, "rang", 5 )
						outputChatBox ( "[INFO]: Du wurdest von "..getPlayerName ( player ).." zum Leader der Triaden ernannt!", target, 0,100,150 )
						outputLog ( "[ADMIN]: "..getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum Triaden Leader ernannt!","Adminsystem" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
					end
					if fraktion == 4 then
						westsideSetElementData ( target, "rang", 5 )
						outputChatBox ( "[INFO]: Du wurdest von "..getPlayerName ( player ).." zum Leader des Cali Kartell´s ernannt!", target, 0,100,150 )
						outputLog ( "[ADMIN]: "..getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum Cali Kartell Leader ernannt!","Adminsystem" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
					end
					if fraktion == 5 then
						westsideSetElementData ( target, "rang", 5 )
						outputChatBox ( "[INFO]: Du wurdest von "..getPlayerName ( player ).." zum Chefredakteur der San News ernannt!", target, 0,100,150 )
						outputLog ( "[ADMIN]: "..getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum Reporter Leader ernannt!","Adminsystem" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
					end
					if fraktion == 6 then
						westsideSetElementData ( target, "rang", 5 )
						outputChatBox ( "[INFO]: Du wurdest von "..getPlayerName ( player ).." zum Director des FBI´s ernannt!", target, 0,100,150 )
						outputLog ( "[ADMIN]: "..getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum FBI Leader ernannt!","Adminsystem" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
					end
					if fraktion == 7 then
						westsideSetElementData ( target, "rang", 5 )
						outputChatBox ( "[INFO]: Du wurdest von "..getPlayerName ( player ).." zum Leader der Grove Street ernannt!", target, 0,100,150 )
						outputLog ( "[ADMIN]: "..getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum Grove Leader ernannt!","Adminsystem" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
					end
					if fraktion == 8 then
						westsideSetElementData ( target, "rang", 5 )
						outputChatBox ( "[INFO]: Du wurdest von "..getPlayerName ( player ).." zum Commander der Army ernannt!", target, 0,100,150 )
						outputLog ( "[ADMIN]: "..getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum Bundeswehr Leader ernannt!","Adminsystem" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
					end
					if fraktion == 9 then
						westsideSetElementData ( target, "rang", 5 )
						outputChatBox ( "[INFO]: Du wurdest von "..getPlayerName ( player ).." zum Leader der Dillymore Devils ernannt!", target, 0,100,150 )
						outputLog ( "[ADMIN]: "..getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum Biker Leader ernannt!","Adminsystem" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
					end
					if fraktion == 10 then
						westsideSetElementData ( target, "rang", 5 )
						outputChatBox ( "[INFO]: Du wurdest von "..getPlayerName ( player ).." zum Leader der Mechaniker ernannt!", target, 0,100,150 )
						outputLog ( "[ADMIN]: "..getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum Mechaniker Leader ernannt!","Adminsystem" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
					end
					westsideSetElementData ( target, "fraktion", fraktion )
					for playeritem, key in pairs(adminsIngame) do 
						outputChatBox ( "[ADMIN]: "..getPlayerName(player).." hat "..getPlayerName(target).." zum Leader von Fraktion "..fraktion.." gemacht!", playeritem, 0,100,150)
					end
					if fraktion ~= 0 then
						fraktionMembers[fraktion][target] = fraktion
					end
				else
					infobox(player,'Ungültige Fraktion!')
				end
			else
				infobox(player,'Der Spieler ist nicht eingeloggt!')
			end
		end
	else
		infobox(player,'Du bist nicht befugt!')
	end
end

----- Specten -----
function spec_func ( player, command, spec )
	if isAdminLevel ( player, 3 ) then
		if not spec then
			spec = getPlayerName(player)
		end
		if findPlayerByName ( spec ) then
			if spec == getPlayerName(player) then
				setElementFrozen ( player, false )
			else
				setElementFrozen ( player, true )
			end
			fadeCamera( player, true )
			setCameraTarget( player, findPlayerByName ( spec ) )
			westsideSetElementData ( player, "spectates", getPlayerFromName ( spec ) )
			for playeritem, key in pairs(adminsIngame) do
				outputChatBox ( "[ADMIN]: "..getPlayerName(player).." hat "..spec.." gespectet.", playeritem, 0,100,150 )
				
				outputLog("[ADMIN]: "..getPlayerName(player).." hat "..spec.." gespectet!","Adminsystem")
			end
			if spec ~= getPlayerName ( player ) then
				infobox(player,"Zum verlassen tippe nur /spec!",4000,0,100,150)
			end
		else
			infobox(player,"Nutze /spec [Name]!",4000,0,100,150)
		end
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end

----- Kicken -----
function rkick_func ( player, command, kplayer, ... )
	if isElement(player) then
		if getElementType(player) == "console" then
			westsideSetElementData(player, "adminlvl", 99 )
		end
	end
	if isAdminLevel ( player, 2 ) then
		local reason = {...}
		reason = table.concat( reason, " " )
		local target = findPlayerByName(kplayer)
		if not isElement(target) then
			infobox(player,"Der Spieler ist offline!",4000,255,0,0)
			return
		end
		if getAdminLevel ( player ) > getAdminLevel ( target ) then
			outputChatBox (getPlayerName(target).." wurde von "..getPlayerName ( player ).." gekickt! (Grund: "..tostring ( reason )..")", getRootElement(),255,0,0 )
			kickPlayer ( target, player, tostring(reason) )
		else
			infobox(player,"Du bist nicht befugt!",4000,255,0,0)
		end
		outputLog ("[ADMIN]: "..getPlayerName ( player ).." hat "..kplayer.." gekickt!","Adminsystem")
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end

----- Permanent bannen -----
function rban_func ( player, command, kplayer, ... )
	if getElementType(player) == "console" then
		westsideSetElementData(player, "adminlvl", 99 )
	end
	if isAdminLevel ( player, 5 ) then
		local reason = {...}
		reason = table.concat( reason, " " )
		local target = findPlayerByName ( kplayer )
		kplayer = MySQL_Save ( kplayer )
		if not target then
			if MySQL_DatasetExist("players", "Name LIKE '"..kplayer.."'") then
				local serial = MySQL_GetString( "players", "Serial", "Name LIKE '"..kplayer.."'" )
				infobox(player,"Der Spieler wurde\noffline gebannt!",4000,255,0,0)
				mysql_vio_query("INSERT INTO ban (Name, Admin, Grund, Datum, IP, Serial) VALUES ('"..kplayer.."', '"..getPlayerName(player).."', '"..reason.."', '"..timestamp().."', '0.0.0.0', '"..serial.."')")
				
				outputLog("[ADMIN]: "..getPlayerName(player).." hat "..kplayer.." permanent gebannt! Grund: "..reason.."!","Adminsystem")
			else
				infobox(player,"Der Spieler existiert nicht!",4000,255,0,0)
			end
		else
			if getAdminLevel ( player ) < getAdminLevel ( target ) then
				infobox(player,"Du bist nicht befugt!",4000,255,0,0)
				return
			end
			outputChatBox (getPlayerName(target).." wurde von "..getPlayerName(player).." permanent gebannt! (Grund: "..tostring(reason)..")",getRootElement(),255,0,0)
			local ip = getPlayerIP ( findPlayerByName(kplayer) )
			local serial = getPlayerSerial ( findPlayerByName(kplayer) )
			mysql_vio_query("INSERT INTO ban (Name, Admin, Grund, Datum, IP, Serial) VALUES ('"..kplayer.."', '"..getPlayerName(player).."', '"..reason.."', '"..timestamp().."', '"..ip.."', '"..serial.."')")
			kickPlayer ( target, player, tostring(reason).." (gebannt!)" )
			
			outputLog("[ADMIN]: "..getPlayerName(player).." hat "..kplayer.." gekickt! Grund: "..reason.."!","Adminsystem")
		end
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end

----- Zeitbannen -----
function tban_func(player,command,kplayer,btime,...)
	if getElementType(player) == "console" then
		westsideSetElementData(player, "adminlvl", 99 )
	end
	if isAdminLevel ( player, 2 )then
		local reason = {...}
		reason = table.concat( reason, " " )
		local target = findPlayerByName ( kplayer )
		if not isElement(target) then
			local success = timebanPlayer ( kplayer, tonumber(btime), getPlayerName( player ), reason )
			outputChatBox (kplayer.." wurde von "..getPlayerName(player).." für "..tonumber(btime).." Stunden gebannt! (Grund: "..tostring(reason)..")",getRootElement(),255,0,0)
			
			outputLog("[ADMIN]: "..getPlayerName(player).." hat "..kplayer.." für "..tonumber(btime).." Stunden gebannt! (Grund: "..tostring(reson)..")","Adminsystem")
			if success == false then
				infobox(player,"Gebrauch: /tban [Spieler],\n[Grund], [Zeit]!", 4000,0,100,150 )
			end
			return
		end
		local name = getPlayerName( target )
		local savename = MySQL_Save ( name )
		local success = timebanPlayer ( savename, tonumber(btime), getPlayerName( player ), reason )
		if success == false then
			infobox(player,"Gebrauch: /tban [Spieler],\n[Grund], [Zeit]!", 4000,0,100,150 )
		end
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end

----- Spieler teleportieren -----
function goto_func(player,command,tplayer)
	if isAdminLevel ( player, 2 ) then
		local target = findPlayerByName ( tplayer )
		if not isElement(target) then
			infobox(player,"Der Spieler ist offline!",4000,255,0,0)
			return
		end
		local x, y, z = getElementPosition( target )
		if getPedOccupiedVehicleSeat ( player ) == 0 then
			setElementInterior ( player, getElementInterior(target) )
			setElementInterior ( getPedOccupiedVehicle(player), getElementInterior(target) )
			setElementPosition ( getPedOccupiedVehicle ( player ), x+3, y+3, z )
			setElementDimension ( getPedOccupiedVehicle ( player ), getElementDimension ( target ) )
			setElementDimension ( player, getElementDimension ( target ) )
			setElementVelocity(getPedOccupiedVehicle(player),0,0,0)
			setElementFrozen ( getPedOccupiedVehicle(player), true )
			setTimer ( setElementFrozen, 500, 1, getPedOccupiedVehicle(player), false )
		else
			infobox(tplayer,getPlayerName(player).." hat sich\nzu dir teleportiert!", 4000,0,255,0 )
			infobox(player,"Du hast dich zu\n"..getPlayerName(target).." teleportiert!", 4000,0,255,0 )
			removePedFromVehicle ( player )
			setElementPosition ( player, x, y + 1, z )
			setElementInterior ( player, getElementInterior(target) )
			setElementDimension ( player, getElementDimension ( target ) )
		end
		outputLog("[ADMIN]: "..getPlayerName(player).." hat sich zu "..getPlayerName(target).." teleportiert!","Adminsystem")
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end

----- Spieler her teleportieren -----
function gethere_func(player,command,tplayer)
	if isAdminLevel ( player, 2 ) then
		local target = findPlayerByName ( tplayer )
		local x, y, z = getElementPosition ( player )
		if not isElement(target) then
			infobox(player,"Der Spieler ist offline!",4000,255,0,0)
			return
		end
		if getPedOccupiedVehicleSeat ( target ) == 0 then
			setElementInterior ( target, getElementInterior(player) )
			setElementInterior ( getPedOccupiedVehicle(target), getElementInterior(player ) )
			setElementPosition ( getPedOccupiedVehicle(target), x+3, y+3, z )
			setElementDimension ( target, getElementDimension ( player ) )
			setElementDimension ( getPedOccupiedVehicle(target), getElementDimension ( player ) )
			setElementVelocity(getPedOccupiedVehicle(target),0,0,0)
			setElementFrozen ( getPedOccupiedVehicle(target), true )
			setTimer ( setElementFrozen, 500, 1, getPedOccupiedVehicle(target), false )
		else
			infobox(tplayer,getPlayerName(player).." hat\ndich teleportiert!", 4000, 0,255,0 )
			infobox(player,"Du hast "..getPlayerName(target).."\nteleportiert!", 4000, 0,255,0 )
			removePedFromVehicle ( target )
			setElementPosition ( target, x, y + 1, z )
			setElementInterior ( target, getElementInterior(player) )
			setElementDimension ( target, getElementDimension ( player ) )
		end
		outputLog("[ADMIN]: "..getPlayerName(player).." hat "..getPlayerName(target).." zu sich teleportiert!","Adminsystem")
	end
end

----- Spieler entbannen -----
function unban_func ( player, cmd, nick )
	if getElementType ( player ) == "console" then
		westsideSetElementData ( player, "adminlvl", 999 )
	end
	if isAdminLevel ( player, 6 ) then
		nick = MySQL_Save ( nick )
		local name = MySQL_GetString("ban", "Name", "Name LIKE '"..nick.."'")
		if name then
			MySQL_DelRow ( "ban", "Name LIKE '"..name.."'")
			outputChatBox (nick.." wurde von "..getPlayerName(player).." entbannt!", root, 0, 255, 0 )
			outputLog("[ADMIN]: "..getPlayerName(player).." hat "..nick.." entbannt!","Adminsystem")
		else
		    infobox(player,"Der Spieler existiert nicht!",4000,255,0,0)
		end
	end
end

---- Zum Fahrzeug teleportieren -----
function gotocar_func ( player, cmd, targetname, slot )
	if isAdminLevel ( player, 5 ) then
		if targetname and slot then
			slot = tonumber(slot)
			local target = findPlayerByName ( targetname )
			local newtargetname = MySQL_Save ( getPlayerName ( target ) )
			if isElement(target) then
				local carslot = westsideGetElementData ( target, "carslot"..slot )
				if carslot then
					if carslot >= 1 then
						local veh = _G[getPrivVehString ( newtargetname, slot )]
						if isElement(veh) then
							local x, y, z = getElementPosition(veh)
							local inter = getElementInterior(veh)
							local dimension = getElementDimension(veh)
							setElementPosition ( player, x, y, z+1.5 )
							setElementInterior ( player, inter )
							setElementDimension ( player, dimension )
						else
							respawnPrivVeh ( slot, newtargetname )
							veh = _G[getPrivVehString ( newtargetname, slot )]
							local x, y, z = getElementPosition(veh)
							local inter = getElementInterior(veh)
							local dimension = getElementDimension(veh)
							setElementPosition ( player, x, y, z+1.5 )
							setElementInterior ( player, inter )
							setElementDimension ( player, dimension )
						end
						outputLog("[ADMIN]: "..getPlayerName(player).." hat sich zu einem Auto geportet!","Adminsystem")
					else
						infobox(player,"Der Spieler hat keinen\nWagen mit dieser Nummer!",4000,255,0,0)
					end
				else
					infobox(player,"Der Spieler hat keinen\nWagen mit dieser Nummer!",4000,255,0,0)
				end
			else
				infobox(player,"Der Spieler muss\nonline sein!",4000,255,0,0)
			end
		else
			infobox(player,"Nutze /gotocar [Spieler],\n[Slot]!", 4000,0,100,150 )
		end
	else
		infobox(player,"Du bist nicht befugt!", 4000, 255,0,0 )
	end
end

----- Auto her Teleportieren -----
function getcar_func ( player, cmd, targetname, slot )
	if isAdminLevel ( player, 5 ) then
		if targetname and slot then
			slot = tonumber(slot)
			local target = findPlayerByName ( targetname )
			local newtargetname = MySQL_Save ( getPlayerName ( target ) )
			if isElement(target) then
				local carslot = westsideGetElementData ( target, "carslot"..slot )
				if carslot then
					if carslot >= 1 then
						local veh = _G[getPrivVehString ( newtargetname, slot )]
						if isElement(veh) then
							local x, y, z = getElementPosition(player)
							local inter = getElementInterior(player)
							local dimension = getElementDimension(player)
							setElementPosition ( veh, x, y, z+1.5 )
							setElementInterior ( veh, inter )
							setElementDimension ( veh, dimension )
						else
							respawnPrivVeh ( slot, newtargetname )
							veh = _G[getPrivVehString ( newtargetname, slot )]
							local x, y, z = getElementPosition(player)
							local inter = getElementInterior(player)
							local dimension = getElementDimension(player)
							setElementPosition ( veh, x, y, z+1.5 )
							setElementInterior ( veh, inter )
							setElementDimension ( veh, dimension )
						end
						outputLog("[ADMIN]: "..getPlayerName(player).." ein Auto zu sich geportet!","Adminsystem")
					else
						infobox(player,"Der Spieler hat keinen\nWagen mit dieser Nummer!",4000,0,100,150)
					end
				else
					infobox(player,"Der Spieler hat keinen\nWagen mit dieser Nummer!",4000,0,100,150)
				end
			else
				infobox(player,"Der Spieler muss\nonline sein!",4000,255,0,0)
			end
		else
			infobox(player,"Nutze /getcar [Spieler],\n[Slot]!", 4000,0,100,150 )
		end
	else
		infobox(player,"Du bist nicht befugt!", 4000, 255,0,0 )
	end
end

----- Unspawnen / Löschen -----
function moveVehicleAway_func ( veh )
	if isAdminLevel ( player, 4 ) then
		setElementPosition ( veh, 999999, 999999, 999999 )
		setElementInterior ( veh, 999999 )
		setElementDimension ( veh, 999999 )
		
		outputLog("[ADMIN]: "..getPlayerName(client).." hat ein Fahrzeug unspawnt/gelöscht!","Adminsystem")
	end
end
addEvent("moveVehicleAway",true)
addEventHandler("moveVehicleAway",root,moveVehicleAway_func)

----- Motor anschalten -----
function astart_func ( player, cmd )
	if isAdminLevel ( player, 5 ) then
		local veh = getPedOccupiedVehicle ( player )
		if not isElement ( veh ) then
			infobox(player,"Du musst in einem Wagen sitzen!",4000,255,0,0)
			return
		end
		if getElementModel ( veh ) ~= 438 then
			if ( getPedOccupiedVehicleSeat ( player ) == 0 ) then
				westsideSetElementData ( veh, "fuelstate", 100 )
				westsideSetElementData ( veh, "engine", false )
				setVehicleOverrideLights ( veh, 1 )
				westsideSetElementData ( veh, "light", false)
				setVehicleEngineState ( veh, false )
				if getVehicleEngineState ( veh ) then
					setVehicleEngineState ( veh, false )
					westsideSetElementData ( veh, "engine", false )
					return
				end
				if westsideGetElementData ( veh, "fuelstate" ) >= 1 then
					setVehicleEngineState ( veh, true )
					westsideSetElementData ( veh, "engine", true )
					if not westsideGetElementData ( veh, "timerrunning" ) then
						setVehicleNewFuelState ( veh )
						westsideSetElementData ( veh, "timerrunning", true )
					end
					outputLog("[ADMIN]: "..getPlayerName(player).." hat den Motor eines Fahrzeuges gestartet!","Adminsystem")
				else
					infobox(player,"Das Auto hat kein Benzin mehr!",4000,255,0,0)
				end
			end
		end
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end

----- Fahrzeug umparken -----
function apark_func ( player, command )
	if getPedOccupiedVehicleSeat ( player ) == 0 then
		local veh = getPedOccupiedVehicle ( player )
		if (westsideGetElementData ( player, "adminlvl" )) >= 2 then
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
			
			infobox(player,"Fahrzeug geparkt!",4000,0,255,0)
			outputLog("[ADMIN]: "..getPlayerName(player).." hat ein Fahrzeug umgeparkt!","Adminsystem")
				
			local color = "|"..c1.."|"..c2.."|"..c3.."|"..c4.."|"
			local Paintjob = getVehiclePaintjob ( veh )
			local Benzin = westsideGetElementData ( veh, "fuelstate" )
			local pname = westsideGetElementData ( veh, "owner" )
			local Distance = westsideGetElementData ( veh, "distance" )
			local slot = westsideGetElementData ( veh, "carslotnr_owner" )
			MySQL_SetString("vehicles", "Spawnpos_X", x, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Spawnpos_Y", y, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Spawnpos_Z", z, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Spawnrot_X", rx, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Spawnrot_Y", ry, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Spawnrot_Z", rz, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Farbe", color, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Paintjob", Paintjob, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Benzin", Benzin, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			MySQL_SetString("vehicles", "Distance", Distance, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
		else
			infobox(player,"Du bist nicht befugt!",4000,255,0,0)
		end
	else
		infobox(player,"Du sitzt in keinem Fahrzeug!",4000,255,0,0)
	end
end

----- Adminmode -----
addCommandHandler('amode',function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'adminlvl')>=2)then
			if(getElementData(player,'amode')==false)then
				infobox(player,'Adminmodus betreten!')
				setElementModel(player,260)
				setElementData(player,'amode',true)
			else
				infobox(player,'Adminmodus verlassen!')
				setPedSkin(player,westsideGetElementData(player,'skinid'))
				setElementData(player,'amode',false)
			end
		end
	end
end)

----- Geld vergeben -----
addCommandHandler('givemoney',function(player,cmd,target,summe)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'adminlvl')>=7)then
			if(target)then
				local tplayer = getPlayerFromName(target)
				
				if(summe)then
					westsideSetElementData(tplayer,'bankmoney',westsideGetElementData(tplayer,'bankmoney') + summe)
					
					infobox(tplayer,'Du hast '..summe..'$ auf dein\nKonto erhalten!')
					infobox(player,'Du hast '..getPlayerName(tplayer)..'\n'..summe..'$ gegeben.')
				else
					infobox(player,'Keine Summe angegeben!')
				end
			else
				infobox(player,'Keinen Spieler angegeben!')
			end
		end
	end
end)

----- Adminlevel vergeben -----
addCommandHandler('adminlevel',function(player,cmd,target,adminlevel)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'adminlvl')>=7)then
			if(tonumber(adminlevel) and (target))then
				local tplayer = getPlayerFromName(target)
			
				if(getElementData(tplayer,'loggedin')==1)then
					if(MySQL_DatasetExist("userdata", "Name LIKE '"..target.."'"))then
						local adminlevelnr = tonumber(adminlevel)
						MySQL_SetString("userdata","Adminlevel",adminlevelnr,"Name LIKE '"..target.."'")
						westsideSetElementData(tplayer,'adminlvl',adminlevelnr)
						
						for playeritem,key in pairs(adminsIngame)do
							outputChatBox ( "[ADMIN]: "..getPlayerName(player).." hat das Adminlevel von "..target.." auf "..adminlevel.." gesetzt!", playeritem, 0,100,150 )
						end
						outputLog("[ADMIN]: "..getPlayerName(player).." hat das Adminlevel von "..target.." auf "..adminlevel.." gesetzt!","Adminsystem")
					else
						infobox(player,'Der Spieler existiert nicht!')
					end
				else
					if(MySQL_DatasetExist("userdata", "Name LIKE '"..target.."'"))then
						local adminlevelnr = tonumber(adminlevel)
						MySQL_SetString("userdata", "Adminlevel", adminlevelnr, "Name LIKE '"..target.."'")
						
						for playeritem, key in pairs(adminsIngame) do
							outputChatBox ( "[ADMIN]: "..getPlayerName(player).." hat das Adminlevel von "..target.." auf "..adminlevel.." gesetzt!", playeritem, 0,100,150 )
						end
						outputLog("[ADMIN]: "..getPlayerName(player).." hat das Adminlevel von "..target.." auf "..adminlevel.." gesetzt!","Adminsystem")
					else
						infobox(player,'Der Spieler existiert nicht!')
					end
				end
			else
				infobox(player,'Nutze /adminlevel [Spieler], [Level]!')
			end
		end
	end
end)

----- Fahrzeug ID ändern -----
addCommandHandler('changecar',function(player,cmd,target,slot,id)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'adminlvl')>=7)then
			if tonumber(slot) and tonumber(id) and (target) then
				if MySQL_DatasetExist("vehicles","Besitze LIKE '"..target.."' and Slot LIKE '"..slot.."'") then
					local slotid = tonumber(slot)
					local idid   = tonumber(id)
					
					abfrage = "UPDATE `vehicles` SET `Typ` = '"..idid.."' WHERE `vehicles`.`Besitzer`LIKE '"..target.."' and Slot LIKE '"..slotid.."'"
					
					mysql_vio_query(abfrage)
					
					for playeritem,key in pairs(adminsIngame) do
						outputChatBox('[ADMIN]: '..getPlayerName(player)..' hat das Fahrzeug von '..target..' in Slot '..slot..' in ID: '..id..' geändert!',playeritem,0,100,150)
					end
					outputLog("[ADMIN]: "..getPlayerName(player).." hat das Fahrzeug von "..target.." in Slot "..slot.." in ID "..id.." geändert!","Adminsystem")
				else
					infobox(player,'Das Fahrzeug existiert nicht!')
				end
			else
				infobox(player,'Nutze /changecar [Name],\n[Slot], [ID]!')
			end
		end
	end
end)

----- Prison -----
addCommandHandler('prison',function(player,cmd,target,reason,time)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'adminlvl')>=2)then
			if(target)then
				if(reason)then
					if(time)then
						target = getPlayerFromName(target)
						
						if(isPedInVehicle(target)==true)then
							removePedFromVehicle(target)
						end
						takeAllWeapons(target)
						
						setElementPosition(target,1883.34949, -1316.85767, 1276.19653)
						setElementDimension(target,1)
						setElementInterior(target,0)
						
						westsideSetElementData(target,'jailtime',time)
						outputChatBox(getPlayerName(target)..' wurde von '..getPlayerName(player)..' für '..time..' Minuten ins Prison gesperrt!',root,255,0,0)
						outputChatBox('Grund: '..reason..'!',root,255,0,0)
						
						if(getElementData(target,'aduty')==true)then
							setElementData(target,'aduty',false)
						end
						
						triggerClientEvent(target,'startJailTimeRenderEvent',target)
						
						toggleControl(target,'fire',false)
						
						outputLog("[ADMIN]: "..getPlayerName(player).." hat "..getPlayerName(target).." für "..time.." Minuten ins Prison gesperrt!","Adminsystem")
					end
				end
			end
		end
	end
end)

----- Adminfahrzeug -----
addCommandHandler('acar',function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'adminlvl')>=5)then
			local x,y,z = getElementPosition(player)
			
			_G['admincar'..getPlayerName(player)] = createVehicle(411,x,y,z)
			warpPedIntoVehicle(player,_G['admincar'..getPlayerName(player)])
			setVehicleColor(_G['admincar'..getPlayerName(player)],255,255,255)
			setVehicleDamageProof(_G['admincar'..getPlayerName(player)],true)
			
			addEventHandler('onVehicleExit',_G['admincar'..getPlayerName(player)],function()
				destroyElement(_G['admincar'..getPlayerName(player)])
			end)
		end
	end
end)

----- Coins vergeben -----
addCommandHandler("setcoins",function(player,cmd,target,coins)
	if(westsideGetElementData(player,"loggedin")==1)then
		if(westsideGetElementData(player,"adminlvl")>=7)then
			if(target)then
				local tplayer = getPlayerFromName(target)
				
				if(coins)then
					infobox(player,"Du hast "..getPlayerName(tplayer).."\n"..coins.." Coin(s) gegeben!",4000,255,0,0)
					infobox(tplayer,"Du hast von "..getPlayerName(player).."\n"..coins.." Coin(s) bekommen!",4000,255,0,0)
					westsideSetElementData(tplayer,"coins",tonumber(westsideGetElementData(tplayer,"coins")) + coins)
				else
					infobox(player,"Keine Menge angegeben!",4000,255,0,0)
				end
			else
				infobox(player,"Keinen Spieler angegeben!",4000,255,0,0)
			end
		end
	end
end)

----- Fahrzeuggutscheine vergeben -----
addCommandHandler("setfgutschein",function(player,cmd,target,gutscheine)
	if(westsideGetElementData(player,"loggedin")==1)then
		if(westsideGetElementData(player,"adminlvl")>=7)then
			if(target)then
				local tplayer = getPlayerFromName(target)
				
				if(gutscheine)then
					infobox(player,"Du hast "..getPlayerName(tplayer).."\n"..gutscheine.." Fahrzeuggutschein(e)\ngegeben!",4000,255,0,0)
					infobox(tplayer,"Du hast von "..getPlayerName(player).."\n"..gutscheine.." Fahrzeuggutschein(e)\nbekommen!",4000,255,0,0)
					westsideSetElementData(tplayer,"fgutschein",tonumber(westsideGetElementData(tplayer,"fgutschein")) + gutscheine)
				else
					infobox(player,"Keine Menge angegeben!",4000,255,0,0)
				end
			else
				infobox(player,"Keinen Spieler angegeben!",4000,255,0,0)
			end
		end
	end
end)

----- Erfahrungspunkte vergeben -----
addCommandHandler('setexp',function(player,cmd,target,points)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'adminlvl')>=7)then
			if(target)then
				local tplayer = getPlayerFromName(target)
				
				if(points)then
					infobox(player,'Du hast '..getPlayerName(tplayer)..'\n'..points..' EXP gegeben!',4000,255,0,0)
					infobox(tplayer,'Du hast von '..getPlayerName(player)..'\n'..points..' EXP bekommen!',4000,255,0,0)
					westsideSetElementData(tplayer,'erfahrungspunkte',tonumber(westsideGetElementData(tplayer,'erfahrungspunkte')) + points)
				else
					infobox(player,'Keine Menge angegeben!',4000,255,0,0)
				end
			else
				infobox(player,'Keinen Spieler angegeben!',4000,255,0,0)
			end
		end
	end
end)

----- Führerschein vergeben -----
addCommandHandler('givecarlicense',function(player,cmd,target)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'adminlvl')>=5)then
			if(target)then
				local tplayer = getPlayerFromName(target)
				
				if(tonumber(westsideGetElementData(tplayer,'carlicense')==0))then
					infobox(tplayer,'Du hast einen Führerschein erhalten!')
					infobox(player,'Du hast '..getPlayerName(tplayer)..'\neinen Führerschein gegeben.')
					
					westsideSetElementData ( tplayer, "carlicense", 1 )
					MySQL_SetString ( "userdata", "Autofuehrerschein", westsideGetElementData ( tplayer, "carlicense" ), "Name LIKE '"..getPlayerName ( tplayer ).."'")
				else
					infobox(player,'Der Spieler hat bereits\neinen Führerschein!')
				end
			else
				infobox(player,'Kein Spieler angegeben!')
			end
		end
	end
end)

----- Daten setzen -----
function setDatas ()
	for _, v in ipairs( getElementsByType 'player' ) do
		setElementData(v,"amode",false)
	end
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),setDatas)

----- Commands -----
addCommandHandler ( "apark", apark_func )
addCommandHandler ( "nickchange", nickchange_func )
addCommandHandler ( "pwchange", pwchange_func )
addCommandHandler ( "rebind", rebind_func )
addCommandHandler ( "respawn", respawn_func )
addCommandHandler ( "cleartext", cleartext_func )
addCommandHandler ( "a", achat_func )
addCommandHandler ( "setrank", setrank_func )
addCommandHandler ( "leader", makeleader_func )
addCommandHandler ( "spec", spec_func )
addCommandHandler ( "rkick", rkick_func )
addCommandHandler ( "rban", rban_func )
addCommandHandler ( "tban", tban_func )
addCommandHandler ( "goto", goto_func )
addCommandHandler ( "gethere", gethere_func )
addCommandHandler ( "unban", unban_func )
addCommandHandler ( "gotocar", gotocar_func )
addCommandHandler ( "getcar", getcar_func )
addCommandHandler ( "astart", astart_func )
addCommandHandler ( "cweather", changeweather )
addCommandHandler ("o", ochat_func )