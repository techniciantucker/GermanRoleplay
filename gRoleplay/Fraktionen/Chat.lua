factionColours = {}
factionRankNames = {}
	local i = 0
	
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 0,255,0
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Cadet"
		factionRankNames[i][1] = "Officer"
		factionRankNames[i][2] = "Detective"
		factionRankNames[i][3] = "Captain"
		factionRankNames[i][4] = "Lieutenant"
		factionRankNames[i][5] = "Chief"
	
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 100,100,100
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Shinok"
		factionRankNames[i][1] = "Pristupnik"
		factionRankNames[i][2] = "Dilovoj"
		factionRankNames[i][3] = "Nostawnik"
		factionRankNames[i][4] = "Brat"
		factionRankNames[i][5] = "Pacan"
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 200,0,0
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Shatei"
		factionRankNames[i][1] = "Kyodai"
		factionRankNames[i][2] = "Shingiin"
		factionRankNames[i][3] = "Wakagashira"
		factionRankNames[i][4] = "Saiko"
		factionRankNames[i][5] = "Oyabun"
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 219,175,92
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Inicio"
		factionRankNames[i][1] = "Novato"
		factionRankNames[i][2] = "Prinicante"
		factionRankNames[i][3] = "Jugador"
		factionRankNames[i][4] = "Diestra"
		factionRankNames[i][5] = "Patron"
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 255,150,0
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Zeitungsjunge"
		factionRankNames[i][1] = "Klatschtante"
		factionRankNames[i][2] = "Zeitungsreporter"
		factionRankNames[i][3] = "Reporter"
		factionRankNames[i][4] = "Journalist"
		factionRankNames[i][5] = "Chefredakteur"
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 125,125,200
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Probationaly Agent"
		factionRankNames[i][1] = "Special Agent"
		factionRankNames[i][2] = "Special Agent I.C"
		factionRankNames[i][3] = "Senior Special Agent"
		factionRankNames[i][4] = "Deputy Director"
		factionRankNames[i][5] = "Director"
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 0,150,0
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Newbie"
		factionRankNames[i][1] = "Coolman"
		factionRankNames[i][2] = "Homeboy"
		factionRankNames[i][3] = "Dealer"
		factionRankNames[i][4] = "Banger"
		factionRankNames[i][5] = "Big Boss"
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 0,125,0
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Private"
		factionRankNames[i][1] = "Corporal"
		factionRankNames[i][2] = "Staff Sergeant"
		factionRankNames[i][3] = "Major"
		factionRankNames[i][4] = "Colonel"
		factionRankNames[i][5] = "Commander"
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 100,50,100
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Associate"
		factionRankNames[i][1] = "Member"
		factionRankNames[i][2] = "Sergeant at Arms"
		factionRankNames[i][3] = "Road Captain"
		factionRankNames[i][4] = "Vice-President"
		factionRankNames[i][5] = "President"
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 255,100,100
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Praktikant"
		factionRankNames[i][1] = "Reifenmonteur"
		factionRankNames[i][2] = "Mechaniker"
		factionRankNames[i][3] = "Mechatroniker"
		factionRankNames[i][4] = "Chef-Mechaniker"
		factionRankNames[i][5] = "Garagenaufseher"
		
function teamchat_func ( player, cmd, ... )	

	local parametersTable = {...}
	local text = table.concat( parametersTable, " " )
	local Fraktion = tonumber(westsideGetElementData ( player, "fraktion" ))
	local FRank = tonumber(westsideGetElementData ( player, "rang" ))
	if Fraktion >= 1 then
		if text == "" then
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast keinen Text angegeben!", 4000, 255, 0, 0 )
		else
			local red = 0
			local green = 0
			local blue = 0
			local title = "intern"
			if factionRankNames[Fraktion][FRank] then
				title = factionRankNames[Fraktion][FRank]
				red, green, blue = factionColours[Fraktion][1], factionColours[Fraktion][2], factionColours[Fraktion][3]
			end
			
			for playeritem, index in pairs(fraktionMembers[Fraktion]) do 
				outputChatBox ( "[ "..title.." "..getPlayerName(player)..": "..text.." ]", playeritem, red, green, blue )
				outputLog ( "[ "..title.." "..getPlayerName(player)..": "..text.." ]","Fraktionschat" )
			end
			for playeritem, index in pairs(adminsIngame) do 
				if westsideGetElementData ( playeritem, "adminlvl" ) then
					if tonumber(westsideGetElementData ( playeritem, "adminlvl" )) >= 5 then
						outputConsole ( "Fraktion "..Fraktion..":", playeritem )
						outputConsole ( " [ "..title.." "..getPlayerName(player)..": "..text.." ]", playeritem )
						outputConsole ( "----------------------------", playeritem )
					end
				end
			end
		end
	end
end
addCommandHandler ( "t", teamchat_func )

function gteamchat_func ( player, cmd, ... )	
	
	local parametersTable = {...}
	local text = table.concat( parametersTable, " " )
	local Fraktion = tonumber(westsideGetElementData ( player, "fraktion" ))
	local FRank = tonumber(westsideGetElementData ( player, "rang" ))
	if Fraktion == 1 or Fraktion == 6 or Fraktion == 8 or Fraktion == 10 then
		if text == "" then
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Bitte einen Text eingeben!", 4000, 255, 0, 0 )
		else
			red = 140
			green = 10
			blue = 10
			local title = "intern"
			
			if factionRankNames[Fraktion][FRank] then
				title = factionRankNames[Fraktion][FRank]
			end
			
			if Fraktion == 1 then
				red = 140
				green = 10
				blue = 10
			end
			if Fraktion == 6 then
				red = 140
				green = 10
				blue = 10
			end
			if Fraktion == 8 then
				red = 140
				green = 10
				blue = 10
			end
			if Fraktion == 10 then
				red = 140
				green = 10
				blue = 10
			end
			for playeritem, key in pairs(fraktionMembers[1]) do
				outputChatBox ( "[LSPD] "..title.." "..getPlayerName(player)..": "..text.." ]", playeritem, red, green, blue )
				outputLog ( "[LSPD] "..title.." "..getPlayerName(player)..": "..text.." ]","Fraktionschat" )
			end
			for playeritem, key in pairs(fraktionMembers[6]) do
				outputChatBox ( "[FBI] "..title.." "..getPlayerName(player)..": "..text.." ]", playeritem, red, green, blue )
				outputLog ( "[FBI] "..title.." "..getPlayerName(player)..": "..text.." ]","Fraktionschat" )
			end
			for playeritem, key in pairs(fraktionMembers[8]) do
				outputChatBox ( "[ARMY] "..title.." "..getPlayerName(player)..": "..text.." ]", playeritem, red, green, blue )
				outputLog ( "[ARMY] "..title.." "..getPlayerName(player)..": "..text.." ]","Fraktionschat" )
			end
			for playeritem, key in pairs(fraktionMembers[10]) do
				outputChatBox ( "[MECH] "..title.." "..getPlayerName(player)..": "..text.." ]", playeritem, red, green, blue )
				outputLog ( "[MECH] "..title.." "..getPlayerName(player)..": "..text.." ]","Fraktionschat" )
			end
			for playeritem, index in pairs(adminsIngame) do 
				if westsideGetElementData ( playeritem, "adminlvl" ) then
					if tonumber(westsideGetElementData ( playeritem, "adminlvl" )) >= 5 then
						outputConsole ( "G-Chat:", playeritem )
						outputConsole ( " [ "..title.." "..getPlayerName(player)..": "..text.." ]", playeritem )
						outputConsole ( "----------------------------", playeritem )
					end
				end
			end
		end
	end
end
addCommandHandler ("g", gteamchat_func )