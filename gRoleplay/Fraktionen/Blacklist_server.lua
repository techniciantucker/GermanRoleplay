blacklistPlayers = {}
 blacklistPlayers[2] = {}
 blacklistPlayers[3] = {}
 blacklistPlayers[4] = {}
 blacklistPlayers[7] = {}
 blacklistPlayers[9] = {}
 
blacklistReason = {}
 blacklistReason[2] = {}
 blacklistReason[3] = {}
 blacklistReason[4] = {}
 blacklistReason[7] = {}
 blacklistReason[9] = {}

local playersAddetToBlacklist = {}
for i = 1, 9 do
	playersAddetToBlacklist[i] = {}
end

validBlackListFactions = {
 [2]=true,
 [3]=true,
 [4]=true,
 [7]=true,
 [9]=true
 }

factionBlackListGuns = {
 [2]=24,
 [3]=24,
 [4]=24,
 [7]=24,
 [9]=24
}

function blacklistLogin ( pname )

	if isOnBlacklist ( pname, 2 ) then
		blacklistPlayers[2][pname] = true
		blacklistReason[2][pname] = getBlacklistGrund ( pname, 2 )
	end
	if isOnBlacklist ( pname, 3 ) then
		blacklistPlayers[3][pname] = true
		blacklistReason[3][pname] = getBlacklistGrund ( pname, 3 )
	end
	if isOnBlacklist ( pname, 4 ) then
		blacklistPlayers[4][pname] = true
		blacklistReason[4][pname] = getBlacklistGrund ( pname, 3 )
	end
	if isOnBlacklist ( pname, 7 ) then
		blacklistPlayers[7][pname] = true
		blacklistReason[7][pname] = getBlacklistGrund ( pname, 7 )
	end
	if isOnBlacklist ( pname, 9 ) then
		blacklistPlayers[9][pname] = true
		blacklistReason[9][pname] = getBlacklistGrund ( pname, 9 )
	end
end

-- Kill Check
function blackListKillCheck ( player, killer, weapon )

	local killerFaction = westsideGetElementData ( killer, "fraktion" )
	local name = getPlayerName ( player )
	if validBlackListFactions[killerFaction] then
		if isOnBlacklist ( name, killerFaction ) then
			local prizeMoney = 250
			local prizeText = "[INFO]: Du erhälst 250$!"
			if factionBlackListGuns[killerFaction] == weapon then
				prizeText = prizeText.." + 100 $ aufgrund der verwendeten Waffe."
				prizeMoney = prizeMoney + 100
			else
				prizeText = prizeText.."."
			end
			blacklistPlayers[killerFaction][name] = nil
			MySQL_DelRow ( "blacklist", "Name LIKE '"..name.."' AND Fraktion LIKE '"..killerFaction.."'" )
			givePlayerSaveMoney ( killer, prizeMoney )
			infobox(player,"Du bist nun nicht mehr\nauf der Blacklist!",4000,0,255,0)
			infobox(killer,"Du hast jemanden von der\nBlacklist erledigt!",4000,0,255,0)
			outputChatBox ( prizeText, killer, 0,100,150 )
			
			westsideSetElementData(killer,"erfahrungspunkte",tonumber(westsideGetElementData(killer,"erfahrungspunkte")) + 100)
		end
	end
end

-- Löscht alte Einträge
local blackListCurTime = getSecTime ( 0 )
function checkBlackListEntrys()

	result = mysql_query ( handler, "SELECT * FROM blacklist" )
	if result then
		if ( mysql_num_rows ( result ) > 0 ) then
			blackListData = mysql_fetch_assoc ( result )
			mySQLBlackList ()
		else
			mysql_free_result ( result )
		end
	end
end

-- Mysql Blacklist
function mySQLBlackList ()

	local Name = blackListData["Name"]
	local Eintraeger = blackListData["Eintraeger"]
	local Fraktion = blackListData["Fraktion"]
	local Eintragungsdatum = blackListData["Eintragungsdatum"]
	
	if blackListCurTime - Eintragungsdatum > 7 * 24 * 60 * 60 then
		MySQL_DelRow ( "blacklist", "Name LIKE '"..Name.."' AND Fraktion LIKE '"..Fraktions.."'" )
	end
	
	blackListData = mysql_fetch_assoc ( result )
	if blackListData then
		mySQLBlackList ()
	else
		mysql_free_result ( result )
	end
end
checkBlackListEntrys()

-- Blacklist
function blacklist_func ( player, cmd, add, target, ... )

	if not add then
		infobox(player,"Nutze /blacklist\n[add/delete/show] (Name)!",4000,0,100,150)
	else
		if validBlackListFactions[westsideGetElementData ( player, "fraktion" )] then
			if add == "add" then
				
				local parametersTable = {...}
				local text = table.concat( parametersTable, " " )
				
				if text == nil then
				
					infobox(player,"Nutze /blacklist\n[add/delete/show] (Name)!",4000,0,100,150)
				
				else
			
					addBlacklist_func ( player, target, text )
					
				end
				
			elseif add == "delete" then
				blacklistdelete_func ( player, target )
			elseif add == "show" then
				showblacklist_func ( player )
			else
				infobox(player,"Nutze /blacklist\n[add/delete/show] (Name)!",4000,0,100,150)
			end
		else
			infobox ( player, "Du bist in keiner Gang oder\nhast nicht den erforderlichen\nRang!", 4000, 255, 0, 0 )
		end
	end
end
addCommandHandler ( "blacklist", blacklist_func )

-- Blacklist Löschen
function blacklistdelete_func ( player, name )

	local name = getPlayerName ( getPlayerFromName ( name ) )
	if name then
		local fraktion = westsideGetElementData ( player, "fraktion" )
		blacklistPlayers[fraktion][name] = nil
		MySQL_DelRow ( "blacklist", "Name LIKE '"..name.."' AND Fraktion LIKE '"..fraktion.."'" )
		infobox (player,"Der Spieler wurde von der Blacklist gelöscht!", 4000,0,255,0 )
	else
		infobox (player"Der Spieler ist nicht auf der Blacklist!", 4000,255,0,0 )
	end
end

-- Blacklist anzeigen
function showblacklist_func ( player )

	local fraktion = westsideGetElementData ( player, "fraktion" )
	if blacklistPlayers[fraktion] then
		outputChatBox ( "Blacklist", player)
		outputChatBox ( "════════════════════════════════", player, 255, 255, 255 )
		for key, index in pairs ( blacklistPlayers[fraktion] ) do
			if getPlayerName ( getPlayerFromName ( key ) ) then
				outputChatBox ( tostring( key )..": "..blacklistReason[fraktion][tostring(key)], player)
				outputChatBox ( "════════════════════════════════", player, 255, 255, 255 )
			else
				blacklistPlayers[fraktion][key] = nil
			end
		end
	end
end

-- Auf die Blacklist setzen
function addBlacklist_func ( player, member, text )

	local pname = getPlayerName ( player )
	local target = getPlayerFromName ( member )
	local fraktion = westsideGetElementData ( player, "fraktion" )
	if target then
		if westsideGetElementData ( player, "rang" ) >= 3 then
			if isOnBlacklist ( member, fraktion ) then
				infobox ( player, "Der Spieler ist bereits\nauf der Blacklist!", 4000, 255, 0, 0 )
			else
				if westsideGetElementData ( getPlayerFromName(member), "fraktion" ) ~= fraktion then
					if not playersAddetToBlacklist[westsideGetElementData(player,"fraktion")][member] then
						playersAddetToBlacklist[westsideGetElementData(player,"fraktion")][member] = true
						
						local result = mysql_query ( handler, "INSERT INTO blacklist ( Name, Eintraeger, Fraktion, Grund, Eintragungsdatum ) VALUES ( '"..member.."', '"..pname.."', '"..fraktion.."', '"..text.."', '"..getSecTime ( 0 ).."' ) " )
						mysql_free_result ( result )
						infobox ( player, "Du hast den Spieler\nauf die Blacklist gesetzt!", 000, 0,255, 0 )
						blacklistPlayers[fraktion][getPlayerName(getPlayerFromName(member))] = true
						blacklistReason[fraktion][getPlayerName(getPlayerFromName(member))] = text
						
						infobox(member,"Du wurdest von "..getPlayerName(player).." auf die Blacklist der "..fraktion.." gesetzt!",4000,255,0,0)
					else
						infobox ( player, "Der Spieler war heute bereits\nauf der Blacklist deiner Fraktion!", 4000, 255, 0, 0 )
					end
				else
					infobox ( player, "Der Spieler ist in deiner Fraktion!", 4000, 255, 0, 0 )
				end
			end
		else
			infobox ( player, "Du bist nicht befugt!", 4000, 255, 0, 0 )
		end
	else
		infobox ( player, "Der Spieler ist nicht online!", 4000, 255, 0, 0 )
	end
end

-- Auf Blacklist
function isOnBlacklist ( pname, fraktion )

	if MySQL_DatasetExist ( "blacklist", "Name LIKE '"..pname.."' AND Fraktion LIKE '"..fraktion.."'" ) then
		return true
	end
	return false
end

-- Grund
function getBlacklistGrund ( pname, fraktion )

	local ress = MySQL_GetString("blacklist", "Grund", "Name LIKE '"..pname.."' AND Fraktion LIKE '"..fraktion.."'" )
	
	return ress
	
end