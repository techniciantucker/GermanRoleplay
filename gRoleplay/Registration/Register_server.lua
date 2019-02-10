_G["Clantag"] = "[gR]"

clanMembers = {}
ticketPermitted = {}

function banCheck ( nick, ip, uname, serial )

	bool = false
	connectCanceled = false
	local i, j = string.find ( nick, "mtasa" )
	if nick ~= MySQL_Save ( nick ) then
		cancelEvent ( true, "Dein Nickname enthaelt unnoetige Zeichen" )
		connectCanceled = true
	elseif nick == "Player" then
		cancelEvent ( true, "Bitte waehle einen Nickname!" )
		connectCanceled = true
	elseif i and j then
		cancelEvent ( true, "Fuck you!" )
		connectCanceled = true
	else
		local bantime = tonumber ( MySQL_GetString ( "ban", "STime", "Name LIKE '"..nick.."'" ) )
		if bantime then
			bool = not ( bantime == 0 )
		end
		if bool and bantime then
			if ( bantime - getTBanSecTime ( 0 ) ) < 0 then
				MySQL_DelRow ( "ban", "Name LIKE '"..nick.."'")
			elseif bantime > 0 then
				local reason = MySQL_GetString ( "ban", "Grund", "Name LIKE '"..nick.."'" )
				local admin = MySQL_GetString ( "ban", "Admin", "Name LIKE '"..nick.."'" )
				local diff = math.floor ( ( ( bantime - getTBanSecTime ( 0 ) ) / 60 ) * 100 ) / 100
				cancelEvent ( true, "Du bist noch fuer"..diff.." Stunden von "..admin.." gebannt! Grund: "..reason.."!" )
				connectCanceled = true
			end
		else
		    -- // IP BAN (DEAKTIVIERT!)
			local ipBanned = false
			
			local ip1 = tostring ( gettok ( ip, 1, string.byte('.') ) )
			local ip2 = tostring ( gettok ( ip, 2, string.byte('.') ) )
			local ipRangeBanned = MySQL_GetString ( "ban", "Grund", "IP LIKE '"..ip1.."."..ip2..".*.*'" )
			
			local nickBanned = MySQL_GetString("ban", "Name", "Name LIKE '" ..nick.."'" )
			
			if ipBanned then
				local reason = MySQL_GetString ( "ban", "Grund", "IP LIKE '" ..ip.."'" )
				local admin = MySQL_GetString ( "ban", "Admin", "IP LIKE '" ..ip.."'" )
				cancelEvent ( true, "Der Admin "..admin.." hat dich gebannt! Grund: "..reason.."!" )
				connectCanceled = true
			elseif ipRangeBanned then
				cancelEvent ( true, "#409: Bad socket!" )
			elseif nickBanned then
				local reason = MySQL_GetString ( "ban", "Grund", "Name LIKE '" ..nick.."'" )
				local admin = MySQL_GetString ( "ban", "Admin", "Name LIKE '" ..nick.."'" )
				cancelEvent ( true, "Du wurdest von "..admin.." gebannt! Grund: "..reason.."! Bei Fragen wende dich an das Forum." )
				connectCanceled = true
			else
				local serialBanned = MySQL_GetString ( "ban", "Grund", "Serial LIKE '%"..serial.."%'" )
				if serialBanned then
					local reason = MySQL_GetString ( "ban", "Grund", "Serial LIKE '"..serial.."'" )
					local admin = MySQL_GetString ( "ban", "Admin", "Serial LIKE '"..serial.."'" )
					cancelEvent ( true, "Du wurdest von "..admin.." gebannt! Grund: "..reason.."! Bei Fragen wende dich an das Forum." )
					connectCanceled = true
				end
			end
		end
	end
	if not connectCanceled then
		insertPlayerIntoLoggedIn ( nick, ip, serial )
	end
end
addEventHandler ( "onPlayerConnect", getRootElement(), banCheck )

function saltPassword ( pname, string )

	local salt = MySQL_GetString("players", "Salt", "Name LIKE '" ..MySQL_Save(pname).."'")
	return string..salt
end

function generateNewSalt ()
	
	local runs = 1
	while true and runs <= 10 do
		runs = runs + 1
		salt = ""
		for i = 1, 20 do
			salt = salt .. string.char ( math.random(1,128) )
		end
		if salt == MySQL_Save ( salt ) then
			break
		end
	end
	return salt
end

function regcheck_func ( player )

	setPedStat ( player, 22, 50 )
	
	westsideSetElementData  ( player, "loggedin", 0 )
	westsideSetElementData ( player, "pwfailed", 0 )
	
	pname = getPlayerName ( player )
	toggleAllControls ( player, false )
	if player == client then
		if isSerialValid ( getPlayerSerial(player) ) or isRegistered ( pname ) then
			if hasInvalidChar ( player ) and not isRegistered ( pname ) then
				kickPlayer ( player, "Dein Name enthaelt ungueltige Zeichen!" )
			else
				if pname ~= "player" then
					if isRegistered ( pname ) then
						triggerClientEvent ( player, "ShowLoginWindow", getRootElement() )
					else
						local clantag = gettok ( pname, 1, string.byte(']') )
						if testmode == true then
						
							triggerClientEvent ( player, "ShowRegisterGui", getRootElement() )
						else
							if string.lower ( clantag ) == "GRP" then
								outputChatBox ("Du bist kein Mitglied des Clans!", player, 125, 0, 0 )
							elseif #pname < 3 or #pname > 20 then
								kickPlayer ( player, "Bitte mindestens 3 und maximal 20 Zeichen als Nickname!" )
							elseif hasInvalidChar ( player ) then
								kickPlayer ( player, "Bitte nimm einen Nickname ohne ueberfluessige Zeichen!" )
							else
								if not MySQL_DatasetExist ( "players", "Serial LIKE '"..getPlayerSerial(player).."'") then
									triggerClientEvent ( player, "ShowRegisterGui", getRootElement() )
								else
									local result = mysql_query ( handler, "SELECT * FROM players WHERE Serial = '"..getPlayerSerial(player).."'" )
									local dsatz = mysql_fetch_assoc ( result )
									local name = dsatz["Name"]
									outputChatBox("[INFO]: Es ist bereits ein Account mit dieser Serial registriert! ( Alter Accountname: "..name.." )", player, 0,100,150)
								end
							end
						end
					end
				else
					kickPlayer ( player, "Bitte aendere deinen Nickname!" )
				end
			end
		else
			kickPlayer ( player, "Dein MTA verwendet eine ungueltige Serial! Bitte neu installieren!" )
		end
	end
end
addEvent ( "regcheck", true )
addEventHandler ("regcheck", getRootElement(), regcheck_func )

function getIDByName ( pname )

	return tonumber ( MySQL_GetString ( "players", "id", "Name LIKE '"..pname.."'" ) )
end

function register_func ( player, passwort, bday, bmon, byear, geschlecht )

	if player == client then
		local pname = MySQL_Save ( getPlayerName ( player ) )
		if passwort == MySQL_Save ( passwort ) then
			passwort = MySQL_Save ( passwort )
			bday = MySQL_Save ( bday )
			bmon = MySQL_Save ( bmon )
			byear = MySQL_Save ( byear )
			geschlecht = MySQL_Save ( geschlecht )
			if westsideGetElementData ( player, "loggedin" ) == 0 and not isRegistered ( pname ) and player == client then
				setPlayerLoggedIn ( pname )
				
				mysql_vio_query ( "DELETE FROM inventar WHERE Name = '"..pname.."'" )
				mysql_vio_query ( "DELETE FROM packages WHERE Name = '"..pname.."'" )
				mysql_vio_query ( "DELETE FROM players WHERE Name = '"..pname.."'" )
				mysql_vio_query ( "DELETE FROM userdata WHERE Name = '"..pname.."'" )
				
				toggleAllControls ( player, true )
				westsideSetElementData ( player, "loggedin", 1 )

				triggerClientEvent ( source, "DisableRegisterGui", getRootElement() )

				local ip = getPlayerIP ( player )
				
				local regtime = getRealTime()
				local year = regtime.year + 1900
				local month = regtime.month
				local day = regtime.monthday
				local hour = regtime.hour
				local minute = regtime.minute
				
				local registerdatum = tostring(day.."."..month.."."..year..", "..hour..":"..minute)
				local lastlogin = registerdatum
				
				local salt = generateNewSalt ()
				westsideSetElementData ( player, "salt", salt )
				
				local passwort = md5 ( passwort .. salt )
				local lastLoginInt = getSecTime ( 0 )
				
				local id = MySQL_GetString ( "idcounter", "id", "id = id" )
				mysql_vio_query ( "UPDATE idcounter SET id = id + 1" )
				
				local result = mysql_query(handler, "INSERT INTO players ( Name, Serial, IP, Last_login, Passwort, RegisterDatum, Salt, LastLogin) VALUES ( '"..pname.."', '"..getPlayerSerial(player).."', '"..getPlayerIP ( player ).."', '"..lastlogin.."', '"..passwort.."', '"..registerdatum.."', '"..salt.."', '"..lastLoginInt.."' )")
				if( not result) then
					outputDebugString("Error executing the query: ("		.. mysql_errno(handler) .. ") " .. mysql_error(handler))
				else
					mysql_free_result(result)
				end

				if( not result) then
					-- //
				else
					mysql_free_result(result)
				end
				
				local result = mysql_query(handler, "INSERT INTO inventar (Name) VALUES ('"..pname.."')")
				if( not result) then
					-- //
				else
					mysql_free_result(result)
				end
				local result = mysql_query(handler, "INSERT INTO packages (Name, Paket1, Paket2, Paket3, Paket4, Paket5, Paket6, Paket7, Paket8, Paket9, Paket10, Paket11, Paket12, Paket13, Paket14, Paket15, Paket16, Paket17, Paket18, Paket19, Paket20, Paket21, Paket22, Paket23, Paket24, Paket25) VALUES ('"..pname.."','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0' )")
				if( not result) then
					-- //
				else
					mysql_free_result(result)
				end

				local Geld = 17500
				westsideSetElementData ( player, "money", Geld )
				givePlayerMoney ( player, Geld )
				local Punkte = 0
				westsideSetElementData ( player, "points", Punkte )
				local Paeckchen = "0"
				westsideSetElementData ( player, "packages", Paeckchen )
				local Spawnpos_X = 1568.0203857422
				westsideSetElementData ( player, "spawnpos_x", Spawnpos_X )
				local Spawnpos_Y = -1898.0130615234
				westsideSetElementData ( player, "spawnpos_y", Spawnpos_Y )
				local Spawnpos_Z = 13.560887336731
				westsideSetElementData ( player, "spawnpos_z", Spawnpos_Z )
				local Spawnrot_X = 0.00274658
				westsideSetElementData ( player, "spawnrot_x", Spawnrot_X )
				local SpawnInterior = 0
				westsideSetElementData ( player, "spawnint", SpawnInterior )
				local SpawnDimension = 0
				westsideSetElementData ( player, "spawndim", SpawnDimension )
				local Fraktion = 0
				westsideSetElementData ( player, "fraktion", Fraktion )
				local FraktionsRang = 0
				westsideSetElementData ( player, "rang", FraktionsRang )
				local Adminlevel = 0
				westsideSetElementData ( player, "adminlvl", Adminlevel )
				local Spielzeit = 0
				westsideSetElementData ( player, "playingtime", Spielzeit )
				local CurrentCars = 0
				westsideSetElementData ( player, "curcars", CurrentCars )
				local Maximumcars = 3
				westsideSetElementData ( player, "maxcars", Maximumcars )
				local Carslot1 = 0
				westsideSetElementData ( player, "carslot1", Carslot1 )
				local Carslot2 = 0
				westsideSetElementData ( player, "carslot2", Carslot2 )
				local Carslot3 = 0
				westsideSetElementData ( player, "carslot3", Carslot3 )
				local Carslot4 = 0
				westsideSetElementData ( player, "carslot4", Carslot4 )
				local Carslot5 = 0
				westsideSetElementData ( player, "carslot5", Carslot5 )
				local Carslot6 = 0
				westsideSetElementData ( player, "carslot6", Carslot6 )
				local Carslot7 = 0
				westsideSetElementData ( player, "carslot7", Carslot7 )
				local Carslot8 = 0
				westsideSetElementData ( player, "carslot8", Carslot8 )
				local Carslot9 = 0
				westsideSetElementData ( player, "carslot9", Carslot9 )
				local Carslot10 = 0
				westsideSetElementData ( player, "carslot10", Carslot10 )
				local Tode = 0
				westsideSetElementData ( player, "deaths", Tode )
				local Kills = 0
				westsideSetElementData ( player, "kills", Kills )
				local Knastzeit = 0
				westsideSetElementData ( player, "jailtime", Knastzeit )
				local Hoellenzeit = 0
				westsideSetElementData ( player, "helltime", Hoellenzeit )
				local Himmelszeit = 0
				westsideSetElementData ( player, "heaventime", Himmelszeit )
				local Hausschluessel = 0
				westsideSetElementData ( player, "housekey", 0 )
				local Bankgeld = 0
				westsideSetElementData ( player, "bankmoney", Bankgeld )
				local Drogen  = 0
				westsideSetElementData ( player, "drugs", Drogen )
				local rnd = math.random ( 1, 5 )
				westsideSetElementData ( player, "skinid", rnd )
				local Level = 0
				westsideSetElementData(player,"level",Level)
				local Erfahrungspunkte = 0
				westsideSetElementData(player,"erfahrungspunkte",Erfahrungspunkte)
				local Vip = 0
				westsideSetElementData(player,"vip",Vip)
				local Arbeitsgenehmigung = 0
				westsideSetElementData(player,"worklicense",Arbeitsgenehmigung)
				local WaffenscheinB = 0
				westsideSetElementData(player,'gunlicenseB',WaffenscheinB)
				local WaffenscheinC = 0
				westsideSetElementData(player,'gunlicenseC',WaffenscheinC)
				local Hartz7 = 0
				westsideSetElementData(player,"hartzseven",Hartz7)
				local Pizzadienst = 0
				westsideSetElementData(player,"pizzadienst",Pizzadienst)
				local Autofuehrerschein = 0
				westsideSetElementData ( player, "carlicense", Autofuehrerschein )
				local Motorradtfuehrerschein = 0
				westsideSetElementData ( player, "bikelicense", Motorradtfuehrerschein )
				local LKWfuehrerschein = 1
				westsideSetElementData ( player, "lkwlicense", LKWfuehrerschein )
				local Helikopterfuehrerschein = 0
				westsideSetElementData ( player, "helilicense", Helikopterfuehrerschein )
				local FlugscheinKlasseA = 0
				westsideSetElementData ( player, "planelicensea", FlugscheinKlasseA )
				local FlugscheinKlasseB = 0
				westsideSetElementData ( player, "planelicenseb", FlugscheinKlasseB )
				local Motorbootschein = 0
				westsideSetElementData ( player, "motorbootlicense", Motorbootschein )
				local Segelschein = 0
				westsideSetElementData ( player, "segellicense", Segelschein)
				local Wanteds = 0
				westsideSetElementData ( player, "wanteds", Wanteds )
				local Fskin = 0
				westsideSetElementData ( player, "fskin", Fskin )
				local StvoPunkte = 0
				westsideSetElementData ( player, "stvo_punkte", StvoPunkte )
				local Waffenschein = 0
				westsideSetElementData ( player, "gunlicense", Waffenschein )
				local Perso = 0
				westsideSetElementData ( player, "perso", Perso )
				local IncomePayday = 0
				westsideSetElementData ( player, "incomepayday", IncomePayday )
				local Boni = 1000
				westsideSetElementData ( player, "boni", Boni )
				local PdayIncome = 0
				westsideSetElementData ( player, "pdayincome", PdayIncome )
				local PdayKosten = 0
				westsideSetElementData ( player, "pdaykosten", PdayKosten )
				run = 1
				while true do
					if run >= 20 then
						break
					else
						run = run + 1
					end
					local tnr = math.random ( 1000,9999 )
					local result = MySQL_GetString( "userdata", "Telefonnr", "Telefonnr LIKE '"..tnr.."'" )
					if not result then
						if tonumber ( tnr ) ~= 110 and tonumber ( tnr ) ~= 11032015 then
							Telefonnr = tnr
							break
						end
					end
				end
				if Telefonnr == nil then
					Telefonnr = math.random ( 1000, 9999 )
				end
				westsideSetElementData ( player, "telenr", Telefonnr )
				local Bankpin = 0
				westsideSetElementData(player,"bankpin",Bankpin)
				local GunboxA = "0|0"
				westsideSetElementData ( player, "gunboxa", GunboxA )
				local GunboxB = "0|0"
				westsideSetElementData ( player, "gunboxb", GunboxB )
				local GunboxC = "0|0"
				westsideSetElementData ( player, "gunboxc", GunboxC )
				local Job = "none"
				westsideSetElementData ( player, "job", Job )
				local BonusPunkte = 0
				westsideSetElementData ( player, "bonuspoints", BonusPunkte )
				local socialState = "Neuling"
				westsideSetElementData ( player, "socialState", socialState )
				
				----- Alles neue -----
				local Pipi=0
				westsideSetElementData(player,'harndrang',Pipi)
				local Hunger=100
				westsideSetElementData(player,'hunger',Hunger)
				local Unternehmen=0
				westsideSetElementData(player,'unternehmen',Unternehmen)
				local Unternehmenrang=0
				westsideSetElementData(player,'unternehmenrang',Unternehmenrang)
				local Alkoholpegel=0
				westsideSetElementData(player,'alkoholPegel',Alkoholpegel)
				local Drogenepgel=0
				westsideSetElementData(player,'drogenPegel',Drogenepgel)
				local Jobgehalt=0
				westsideSetElementData(player,'jobgehalt',Drogenepgel)
				westsideSetElementData(player,'carslotupgrade',0)
				-- Erfolge --
				westsideSetElementData(player,'Punkte_Rekordschwimmer',0)
				westsideSetElementData(player,'Erfolg_Rekordschwimmer',0)
				westsideSetElementData(player,'Punkte_Langlaeufer',0)
				westsideSetElementData(player,'Erfolg_Langlaeufer',0)
				westsideSetElementData(player,'Punkte_Busfahrer',0)
				westsideSetElementData(player,'Erfolg_Busfahrer',0)
				westsideSetElementData(player,'Punkte_Eisfahrer',0)
				westsideSetElementData(player,'Erfolg_Eisfahrer',0)
				westsideSetElementData(player,'Punkte_Hotdog',0)
				westsideSetElementData(player,'Erfolg_Hotdog',0)
				westsideSetElementData(player,'Punkte_Meeresreiniger',0)
				westsideSetElementData(player,'Erfolg_Meeresreiniger',0)
				westsideSetElementData(player,'Punkte_Pilot',0)
				westsideSetElementData(player,'Erfolg_Pilot',0)
				westsideSetElementData(player,'Punkte_Pizzalieferant',0)
				westsideSetElementData(player,'Erfolg_Pizzalieferant',0)
				westsideSetElementData(player,'Punkte_Strassenreiniger',0)
				westsideSetElementData(player,'Erfolg_Strassenreiniger',0)
				westsideSetElementData(player,'Punkte_Trucker',0)
				westsideSetElementData(player,'Erfolg_Trucker',0)
				westsideSetElementData(player,'Erfolg_MeinZuhause',0)
				westsideSetElementData(player,'Erfolg_MeinErstesFahrzeug',0)
				westsideSetElementData(player,'Erfolg_MeinErstesGeld',0)
				westsideSetElementData(player,'Erfolg_Millionaer',0)
				westsideSetElementData(player,'Erfolg_Fahrzeugsammler',0)
				westsideSetElementData(player,'Erfolg_EndlichLevel25',0)
				westsideSetElementData(player,'Erfolg_250Spielstunden',0)
				westsideSetElementData(player,'Punkte_Bergwerkarbeiter',0)
				westsideSetElementData(player,'Erfolg_Bergwerkarbeiter',0)
				westsideSetElementData(player,'Erfolg_Gym',0)
				westsideSetElementData(player,'Punkte_Zugjob',0)
				westsideSetElementData(player,'Erfolg_Zugjob',0)
				
				westsideSetElementData ( player, "handyType", 1 )
				westsideSetElementData ( player, "handyCosts", 0 )
				
				_G[pname.."paydaytime"] = setTimer ( playingtime, 60000, 1, player )
				
				westsideSetElementData  ( player, "loggedin", 1 )
				westsideSetElementData ( player, "ElementClicked", false )
				westsideSetElementData ( player, "curplayingtime", 0 )
				westsideSetElementData ( player, "housex", 0 )
				westsideSetElementData ( player, "housey", 0 )
				westsideSetElementData ( player, "housez", 0 )
				westsideSetElementData ( player, "house", "none" )
				westsideSetElementData ( player, "handystate", "on" )
				
				-- // Waffenskills
				setPedStat ( player, 69, 1000 )
				setPedStat ( player, 70, 1000 )
				setPedStat ( player, 71, 1000 )
				setPedStat ( player, 72, 1000 )
				setPedStat ( player, 73, 1000 )
				setPedStat ( player, 74, 1000 )
				setPedStat ( player, 75, 1000 )
				setPedStat ( player, 76, 1000 )
				setPedStat ( player, 77, 1000 )
				setPedStat ( player, 78, 1000 )
				setPedStat ( player, 79, 1000 )
				
				spawnPlayer ( player, westsideGetElementData ( player, "spawnpos_z" ), westsideGetElementData ( player, "spawnpos_y" ), westsideGetElementData ( player, "spawnpos_z" ), westsideGetElementData ( player, "spawnrot_x" ), westsideGetElementData ( player, "spawnint" ), westsideGetElementData ( player, "spawndim" ) )
				
				setPlayerWantedLevel ( player, Wanteds )
				
				packageLoad ( player )
				inventoryload ( player )
				elementDataSettings ( player )

				local result = mysql_query(handler, "INSERT INTO userdata ( Name,Skinid,Telefonnr) VALUES('"..pname.."', '"..westsideGetElementData ( player, "skinid" ).."', '"..Telefonnr.."')")
				if( not result) then
					-- //
				else
					mysql_free_result(result)
					outputDebugString ("DATEN FÜR "..pname.." WURDEN ANGELEGT!")
				end
				
				-- // Tutorial
				westsideSetElementData ( player, "isInTut", true )
				startintro_func ( player )
				
				triggerEvent ( "onVioPlayerLogin", player )
				
				outputLog('Der Spieler '..getPlayerName(player)..' hat sich so eben registriert!','Anmeldung')
			end
		end
	end
end
addEvent ( "register", true )
addEventHandler ( "register", getRootElement(), register_func)

function login_func ( player, passwort )
	
	if player == client then
		if westsideGetElementData ( player, "loggedin" ) == 0 then
			local pname = MySQL_Save ( getPlayerName ( player ) )
			local passwort = MySQL_Save ( passwort )
				
			local passwort = saltPassword ( pname, passwort )
			
			local result = MySQL_GetString("players", "Passwort", "Name LIKE '" ..pname.."'")
			if ( not result ) then
				-- //
			else
				if result == md5(passwort) then
					
					local clantag = gettok ( pname, 1, string.byte(']') )

					if string.lower ( clantag ) == "[".._G["Clantag"] then
						if string.lower ( clantag ) == "[".._G["Clantag"] then
							clanMembers[player] = pname
						end
						ticketPermitted[player] = pname
					end
					if MySQL_DatasetExist ( "ticket_answeres", "name LIKE '"..pname.."'" ) then
					end
					
					setPlayerLoggedIn ( pname )
					local salt = MySQL_GetString("players", "Salt", "Name LIKE '" ..MySQL_Save(pname).."'")
					if salt == "" then
						salt = generateNewSalt()
						passwort = md5 ( passwort .. salt )
						MySQL_SetString("players", "Salt", salt, "Name LIKE '" ..pname.."'")
						MySQL_SetString("players", "Passwort", passwort, "Name LIKE '" ..pname.."'")
					end
					-- // Salt
					westsideSetElementData ( player, "salt", salt )
					
					toggleAllControls ( player, true )

					westsideSetElementData ( player, "loggedin", 1 )
					
					westsideSetElementData  ( player, "loggedin", 1 )
					
					-- // Waffenskills
					setPedStat ( player, 69, 1000 )
					setPedStat ( player, 70, 1000 )
					setPedStat ( player, 71, 1000 )
					setPedStat ( player, 72, 1000 )
					setPedStat ( player, 73, 1000 )
					setPedStat ( player, 74, 1000 )
					setPedStat ( player, 75, 1000 )
					setPedStat ( player, 76, 1000 )
					setPedStat ( player, 77, 1000 )
					setPedStat ( player, 78, 1000 )
					setPedStat ( player, 79, 1000 )
					
					local logtime = getRealTime()
					local year = logtime.year + 1900
					local month = logtime.month + 1
					local day = logtime.monthday
					local hour = logtime.hour
					local minute = logtime.minute
					
					local lastLoginInt = getSecTime ( 0 )
					local lastlogin = tostring(day.."."..month.."."..year..", "..hour..":"..minute)
					
					local result = mysql_query ( handler, "SELECT * from userdata WHERE Name LIKE '"..pname.."'" )
					if result then
						if ( mysql_num_rows ( result ) > 0 ) then
							dsatz = mysql_fetch_assoc ( result )
							mysql_free_result ( result )
						end
					end
					
					local money = tonumber ( dsatz["Geld"] )
					westsideSetElementData ( player, "money", money )
					if money >= 0 then
						givePlayerMoney ( player, money )
					else
						takePlayerMoney ( player, money )
					end
					westsideSetElementData ( player, "busroute", 0 )
					local fraktion = tonumber ( dsatz["Fraktion"] )
					westsideSetElementData ( player, "fraktion", fraktion )
					if fraktion > 0 then
						fraktionMembers[fraktion][player] = fraktion
					end
					local rang = tonumber ( dsatz["FraktionsRang"] )
					if rang == 1 then
						bindKey ( player, "1", "down", tazer_func, player )
					end
					westsideSetElementData ( player, "rang", tonumber ( rang ) )
					local admnlvl = tonumber ( dsatz["Adminlevel"] )
					westsideSetElementData ( player, "adminlvl", admnlvl )
					if admnlvl >= 1 then
						adminsIngame[player] = admnlvl
						triggerEvent("getTicketMessage", player, player)
					end
					
					westsideSetElementData ( player, "spawnpos_x", dsatz["Spawnpos_X"] )
					westsideSetElementData ( player, "spawnpos_y", dsatz["Spawnpos_Y"] )
					westsideSetElementData ( player, "spawnpos_z", tonumber ( dsatz["Spawnpos_Z"] ) )
					westsideSetElementData ( player, "spawnrot_x", tonumber ( dsatz["Spawnrot_X"] ) )
					westsideSetElementData ( player, "spawnint", tonumber ( dsatz["SpawnInterior"] ) )
					westsideSetElementData ( player, "spawndim", tonumber ( dsatz["SpawnDimension"] ) )
					westsideSetElementData ( player, "playingtime", tonumber ( dsatz["Spielzeit"] ) )
					westsideSetElementData ( player, "curcars", tonumber ( dsatz["CurrentCars"] ) )
					curcars = 0
					local offerOnCar = false
					for i = 1, 12 do
						carvalue = MySQL_GetString("vehicles", "Special", "Slot LIKE '" ..i.."' AND Besitzer LIKE '"..pname.."'")
						if carvalue == 2 then
							westsideSetElementData ( player, "yachtImBesitz", true )
						end
						if not carvalue then
							if MySQL_DatasetExist("buyit", "Hoechstbietender LIKE '"..pname.."' AND Typ LIKE 'Veh'") then
								carvalue = 3
								offerOnCar = true
							else
								carvalue = 0
							end
						else
							if carvalue == 2 then
								carvalue = 2
							else
								carvalue = 1
							end
							curcars = curcars + 1
						end
						westsideSetElementData ( player, "carslot"..i, carvalue )
					end
					westsideSetElementData ( player, "curcars", curcars )
					
					westsideSetElementData ( player, "deaths", tonumber ( dsatz["Tode"] ) )
					westsideSetElementData ( player, "kills", tonumber ( dsatz["Kills"] ) )
					westsideSetElementData ( player, "jailtime", tonumber ( dsatz["Knastzeit"] ) )
					westsideSetElementData ( player, "heaventime", tonumber ( dsatz["Himmelszeit"] ) )
					
					local Hausschluessel = MySQL_GetString("houses", "ID", "Besitzer LIKE '" ..pname.."'")
					local key = tonumber ( dsatz["Hausschluessel"] )
					if Hausschluessel then
						westsideSetElementData ( player, "housekey", tonumber ( Hausschluessel ) )
					elseif key <= 0 then
						westsideSetElementData ( player, "housekey", key )
					else
						westsideSetElementData ( player, "housekey", 0 )
					end
					
					westsideSetElementData ( player, "bankmoney", tonumber ( dsatz["Bankgeld"] ) )
					westsideSetElementData ( player, "drugs", tonumber ( dsatz["Drogen"] ) )
					westsideSetElementData ( player, "skinid", tonumber ( dsatz["Skinid"] ) )
					westsideSetElementData ( player, "carlicense", tonumber ( dsatz["Autofuehrerschein"] ) )
					westsideSetElementData ( player, "worklicense", tonumber ( dsatz["Arbeitsgenehmigung"] ) )
					westsideSetElementData(player,'gunlicenseB',tonumber(dsatz['WaffenscheinB']))
					westsideSetElementData(player,'gunlicenseC',tonumber(dsatz['WaffenscheinC']))
					westsideSetElementData ( player, "hartzseven", tonumber ( dsatz["Hartz7"] ) )
					westsideSetElementData(player,"pizzadienst",tonumber(dsatz["Pizzadienst"]))
					westsideSetElementData ( player, "bikelicense", tonumber ( dsatz["Motorradtfuehrerschein"] ) )
					westsideSetElementData ( player, "lkwlicense", tonumber ( dsatz["LKWfuehrerschein"] ) )
					westsideSetElementData ( player, "helilicense", tonumber ( dsatz["Helikopterfuehrerschein"] ) )
					westsideSetElementData ( player, "planelicensea", tonumber ( dsatz["FlugscheinKlasseA"] ) )
					westsideSetElementData ( player, "planelicenseb", tonumber ( dsatz["FlugscheinKlasseB"] ) )
					westsideSetElementData ( player, "motorbootlicense", tonumber ( dsatz["Motorbootschein"] ) )
					westsideSetElementData ( player, "segellicense", tonumber ( dsatz["Segelschein"] ) )
					westsideSetElementData ( player, "wanteds", tonumber ( dsatz["Wanteds"] ) )
					westsideSetElementData(player,"level",tonumber(dsatz["Level"]))
					westsideSetElementData(player,"erfahrungspunkte",tonumber(dsatz["Erfahrungspunkte"]))
					westsideSetElementData(player,"vip",tonumber(dsatz["Vip"]))
					westsideSetElementData ( player, "fskin", tonumber ( dsatz["Fskin"] ) )
					westsideSetElementData ( player, "stvo_punkte", tonumber ( dsatz["StvoPunkte"] ) )
					westsideSetElementData ( player, "gunlicense", tonumber ( dsatz["Waffenschein"] ) )
					westsideSetElementData ( player, "perso", tonumber ( dsatz["Perso"] ) )
					westsideSetElementData ( player, "boni", tonumber ( dsatz["Boni"] ) )
					westsideSetElementData ( player, "incomepayday", tonumber ( dsatz["IncomePayday"] ) )
					westsideSetElementData ( player, "pdayincome", tonumber ( dsatz["PdayIncome"] ) )
					westsideSetElementData ( player, "pdaykosten", tonumber ( dsatz["PdayKosten"] ) )
					westsideSetElementData ( player, "telenr", tonumber ( dsatz["Telefonnr"] ) )
					westsideSetElementData ( player, "bankpin", tonumber ( dsatz["Bankpin"] ) )
					westsideSetElementData ( player, "gunboxa", dsatz["Gunbox1"] )
					westsideSetElementData ( player, "gunboxb", dsatz["Gunbox2"] )
					westsideSetElementData ( player, "gunboxc", dsatz["Gunbox3"] )
					westsideSetElementData ( player, "job", dsatz["Job"] )
					
					----- Alles neue -----
					westsideSetElementData(player,'harndrang',tonumber(dsatz['Harndrang']))
					westsideSetElementData(player,'hunger',tonumber(dsatz['Hunger']))
					westsideSetElementData(player,'unternehmen',tonumber(dsatz['Unternehmen']))
					westsideSetElementData(player,'unternehmenrang',tonumber(dsatz['Unternehmenrang']))
					westsideSetElementData(player,'alkoholPegel',tonumber(dsatz['Alkoholpegel']))
					westsideSetElementData(player,'drogenPegel',tonumber(dsatz['Drogenpegel']))
					westsideSetElementData(player,'jobgehalt',tonumber(dsatz['Jobgehalt']))
					westsideSetElementData(player,'carslotupgrade',tonumber(dsatz['Carslotupgrade']))
					-- Erfolge --
					westsideSetElementData(player,'Punkte_Rekordschwimmer',tonumber(dsatz['Punkte_Rekordschwimmer']))
					westsideSetElementData(player,'Erfolg_Rekordschwimmer',tonumber(dsatz['Erfolg_Rekordschwimmer']))
					westsideSetElementData(player,'Punkte_Langlaeufer',tonumber(dsatz['Punkte_Langlaeufer']))
					westsideSetElementData(player,'Erfolg_Langlaeufer',tonumber(dsatz['Erfolg_Langlaeufer']))
					westsideSetElementData(player,'Punkte_Busfahrer',tonumber(dsatz['Punkte_Busfahrer']))
					westsideSetElementData(player,'Erfolg_Busfahrer',tonumber(dsatz['Erfolg_Busfahrer']))
					westsideSetElementData(player,'Punkte_Eisfahrer',tonumber(dsatz['Punkte_Eisfahrer']))
					westsideSetElementData(player,'Erfolg_Eisfahrer',tonumber(dsatz['Erfolg_Eisfahrer']))
					westsideSetElementData(player,'Punkte_Hotdog',tonumber(dsatz['Punkte_Hotdog']))
					westsideSetElementData(player,'Erfolg_Hotdog',tonumber(dsatz['Erfolg_Hotdog']))
					westsideSetElementData(player,'Punkte_Meeresreiniger',tonumber(dsatz['Punkte_Meeresreiniger']))
					westsideSetElementData(player,'Erfolg_Meeresreiniger',tonumber(dsatz['Erfolg_Meeresreiniger']))
					westsideSetElementData(player,'Punkte_Pilot',tonumber(dsatz['Punkte_Pilot']))
					westsideSetElementData(player,'Erfolg_Pilot',tonumber(dsatz['Erfolg_Pilot']))
					westsideSetElementData(player,'Punkte_Pizzalieferant',tonumber(dsatz['Punkte_Pizzalieferant']))
					westsideSetElementData(player,'Erfolg_Pizzalieferant',tonumber(dsatz['Erfolg_Pizzalieferant']))
					westsideSetElementData(player,'Punkte_Strassenreiniger',tonumber(dsatz['Punkte_Strassenreiniger']))
					westsideSetElementData(player,'Erfolg_Strassenreiniger',tonumber(dsatz['Erfolg_Strassenreiniger']))
					westsideSetElementData(player,'Punkte_Trucker',tonumber(dsatz['Punkte_Trucker']))
					westsideSetElementData(player,'Erfolg_Trucker',tonumber(dsatz['Erfolg_Trucker']))
					westsideSetElementData(player,'Erfolg_MeinZuhause',tonumber(dsatz['Erfolg_MeinZuhause']))
					westsideSetElementData(player,'Erfolg_MeinErstesFahrzeug',tonumber(dsatz['Erfolg_MeinErstesFahrzeug']))
					westsideSetElementData(player,'Erfolg_MeinErstesGeld',tonumber(dsatz['Erfolg_MeinErstesGeld']))
					westsideSetElementData(player,'Erfolg_Millionaer',tonumber(dsatz['Erfolg_Millionaer']))
					westsideSetElementData(player,'Erfolg_Fahrzeugsammler',tonumber(dsatz['Erfolg_Fahrzeugsammler']))
					westsideSetElementData(player,'Erfolg_EndlichLevel25',tonumber(dsatz['Erfolg_EndlichLevel25']))
					westsideSetElementData(player,'Erfolg_250Spielstunden',tonumber(dsatz['Erfolg_250Spielstunden']))
					westsideSetElementData(player,'Punkte_Bergwerkarbeiter',tonumber(dsatz['Punkte_Bergwerkarbeiter']))
					westsideSetElementData(player,'Erfolg_Bergwerkarbeiter',tonumber(dsatz['Erfolg_Bergwerkarbeiter']))
					westsideSetElementData(player,'Erfolg_Gym',tonumber(dsatz['Erfolg_Gym']))
					westsideSetElementData(player,'Punkte_Zugjob',tonumber(dsatz['Punkte_Zugjob']))
					westsideSetElementData(player,'Erfolg_Zugjob',tonumber(dsatz['Erfolg_Zugjob']))
					
					westsideSetElementData ( player, "socialState", dsatz["SocialState"] )
					if tonumber ( dsatz["SocialState"] ) then
						if tonumber ( dsatz["SocialState"] ) == 0 then
							westsideSetElementData ( player, "socialState", "Obdachloser" )
						end
					end
					
					bindKey(player, 'f5', 'down', fraktionPanelOpen, player)
					
					local handyString = dsatz["Handy"] 
					local v1, v2
					v1 = tonumber ( gettok ( handyString, 1, string.byte ( '|' ) ) )
					v2 = tonumber ( gettok ( handyString, 2, string.byte ( '|' ) ) )
					westsideSetElementData ( player, "handyType", v1 )
					westsideSetElementData ( player, "handyCosts", v2 )
					
					westsideSetElementData ( player, "housex", 0 )
					westsideSetElementData ( player, "housey", 0 )
					westsideSetElementData ( player, "housez", 0 )
					westsideSetElementData ( player, "house", "none" )
					westsideSetElementData ( player, "curplayingtime", 0 )
					westsideSetElementData ( player, "handystate", "on" )
					
					westsideSetElementData ( player, "ammoTyp", 0 )
					westsideSetElementData ( player, "ammoAmount", 0 )

					packageLoad ( player )
					inventoryload ( player )
					elementDataSettings ( player )
					
					_G[pname.."paydaytime"] = setTimer ( playingtime, 60000, 1, player )
					
					RemoteSpawnPlayer ( player )
					triggerClientEvent ( player, "DisableLoginWindow", getRootElement() )
					
					----- Vip Level -----
					
					if(getElementData(player,"vip")==1)then
						setPedArmor(player,100)
						giveWeapon(player,24,50,true)
						outputChatBox("[INFO]: Vip Status: aktiv (Level 1)!",player,0,100,150)
					elseif(getElementData(player,"vip")==2)then
						setPedArmor(player,100)
						giveWeapon(player,24,200,true)
						giveWeapon(player,29,200,true)
						outputChatBox("[INFO]: Vip Status: aktiv (Level 2)!",player,0,100,150)
					elseif(getElementData(player,"vip")==3)then
						setPedArmor(player,100)
						giveWeapon(player,24,300,true)
						giveWeapon(player,29,500,true)
						giveWeapon(player,33,100,true)
						outputChatBox("[INFO]: Vip Status: aktiv (Level 3)!",player,0,100,150)
					elseif(getElementData(player,"vip")==4)then
						setPedArmor(player,100)
						giveWeapon(player,24,1000,true)
						giveWeapon(player,29,1000,true)
						giveWeapon(player,31,1000,true)
						giveWeapon(player,33,1000,true)
						outputChatBox("[INFO]: Vip Status: aktiv (Level 4)!",player,0,100,150)
					else
						outputChatBox("[INFO]: Vip Status: Nicht aktiv!",player,0,100,150)
					end
					
					outputLog('Der Spieler '..getPlayerName(player)..' hat sich so eben eingeloggt!','Anmeldung')
					
					if(getElementData(player,'handyAbgenommen')==true)then
						setElementData(player,'handyAbgenommen',false)
					end
					
					if isCop(player) or isFBI(player) or isArmy(player) then
						setElementData(player,"onDuty",false)
					end
					
					setElementData(player,"tut",false)
					
					infobox(player,"Du hast dich erfolgreich eingeloggt!",4000,0,255,0)

					local curtime = getRealTime()
					local hour = curtime.hour
					outputDebugString (pname.." WURDE EINGELOGGT! IP: "..getPlayerIP(player))
					westsideSetElementData ( player, "loggedin", 1 )
					westsideSetElementData ( player, "ElementClicked", false )

					if westsideGetElementData ( player, "stvo_punkte" ) >= 15 then
						westsideSetElementData ( player, "carlicense", 0 )
						westsideSetElementData ( player, "stvo_punkte", 0 )
						MySQL_SetString("userdata", "Autofuehrerschein", westsideGetElementData ( player, "carlicense" ), "Name LIKE '"..pname.."'")
						outputChatBox ( "Aufgrund von 15 STVO Punkten wurde dir dein Führerschein entzogen!", player, 255,0,0 )
					end
					
					checkmsgs ( player )
					
					blacklistLogin ( pname )
					
					MySQL_SetString("players", "Last_login", lastlogin, "Name LIKE '"..pname.."'")
					MySQL_SetString("players", "LastLogin", lastLoginInt, "Name LIKE '"..pname.."'")
					
					AFKTimer[player] = setTimer(checkAFK, 100000, 0, player, player);
					
					local position = MySQL_GetString("logout", "Position", "Name LIKE '" ..pname.."'")
					if position then
						weapons = MySQL_GetString ( "logout", "Waffen", "Name LIKE '" ..pname.."'" )
						MySQL_DelRow ( "logout", "Name LIKE '"..pname.."'" )
						for i = 1, 12 do
							local wstring = gettok ( weapons, i, string.byte( '|' ) )
							if wstring then
								if wstring then
									if #wstring >= 3 then
										local weapon = tonumber ( gettok ( wstring, 1, string.byte( ',' ) ) )
										local ammo = tonumber ( gettok ( wstring, 2, string.byte( ',' ) ) )
										giveWeapon ( player, weapon, ammo, true )
										triggerClientEvent ( player, "sec_gun_give", getRootElement(), weapon, ammo )
									end
								end
							end
						end
						if position ~= "false" then
							local x = tonumber ( gettok ( position, 1, string.byte( '|' ) ) )
							local y = tonumber ( gettok ( position, 2, string.byte( '|' ) ) )
							local z = tonumber ( gettok ( position, 3, string.byte( '|' ) ) )
							local int = tonumber ( gettok ( position, 4, string.byte( '|' ) ) )
							local dim = tonumber ( gettok ( position, 5, string.byte( '|' ) ) )
							setTimer ( setElementInterior, 1000, 1, player, int )
							setTimer ( setElementDimension, 1000, 1, player, dim )
							setTimer ( setElementPosition, 1000, 1, player, x, y, z )
						end
					end
					setMaximumCarsForPlayer ( player )
					triggerEvent ( "onVioPlayerLogin", player )
					
					if tonumber ( dsatz["pred"] ) == 0 then
						mysql_vio_query ( "UPDATE userdata SET pred = '1' WHERE Name = '"..pname.."'" )
					end
				else
					outputChatBox('[LOGIN]: Das Passwort ist falsch!',player,255,0,0)
					triggerClientEvent ( player, "guiShowLoginAgain", getRootElement() )
					westsideSetElementData ( player, "pwfailed", tonumber ( westsideGetElementData ( player, "pwfailed" )) + 1 )
					if westsideGetElementData ( player, "pwfailed" ) >= 3 then
						kickPlayer ( player, "Du hast 3x dein Passwort falsch eingegeben!", 0 )
					end
				end
			end
			result = mysql_query ( handler, "SELECT * FROM help" )
			if result then
				helpData = mysql_fetch_assoc ( result )
				while helpData do
					local title = helpData["title"]
					local text = helpData["text"]
					local stars = 0
					if helpData["s1"]+helpData["s2"]+helpData["s3"]+helpData["s4"]+helpData["s5"] >= 1 then
						stars = (helpData["s1"]+helpData["s2"]*2+helpData["s3"]*3+helpData["s4"]*4+helpData["s5"]*5)/(helpData["s1"]+helpData["s2"]+helpData["s3"]+helpData["s4"]+helpData["s5"])
					end
					local bewertungen = helpData["s1"]+helpData["s2"]+helpData["s3"]+helpData["s4"]+helpData["s5"]
					triggerClientEvent ( player, "addHelpPage", player, title, text, stars, bewertungen )
					helpData = mysql_fetch_assoc ( result )
				end
				mysql_free_result(result)
			end
			bindKey ( player, "ralt", "down", showcurser, player )
		end
	end
end
addEvent ( "einloggen", true )
addEventHandler ( "einloggen", getRootElement(), login_func )

function telefonnrset (pname, value)
	MySQL_SetString("userdata", "Telefonnr", tonumber(value), "Name LIKE '" ..pname.."'")
	westsideSetElementData ( getPlayerFromName(pname), "telenr", tonumber(value) )
end
addEvent ( "telefonnrset", true )
addEventHandler ( "telefonnrset", getRootElement(), telefonnrset )

function datasave ( quitReason, reason )

	if clanMembers[source] then
		clanMembers[source] = nil
	end
	if ticketPermitted[source] then
		ticketPermitted[source] = nil
	end
	local pname = getPlayerName ( source )
	removePlayerFromLoggedIn ( pname )
	if westsideGetElementData ( source, "loggedin" ) == 1 then
		triggerEvent ( "onLoggedInPlayerQuit", source )
		pname = MySQL_Save ( getPlayerName ( source ) )
		fraktionMembers[westsideGetElementData(source,"fraktion")][source] = nil
		adminsIngame[source] = nil
		if quitReason and reason ~= "Ausgeloggt." then
			if westsideGetElementData ( source, "wanteds" ) >= 1 and westsideGetElementData ( source, "jailtime" ) == 0 then
				local x, y, z = getElementPosition ( source )
				local copShape = createColSphere ( x, y, z, 20 )
				local elementsInCopSphere = getElementsWithinColShape ( copShape, "player" )
				destroyElement ( copShape )
				for key, cPlayer in ipairs ( elementsInCopSphere ) do
					if getElementData(cPlayer,"onDuty") == true	and cPlayer ~= source then
						local wanteds = westsideGetElementData ( source, "wanteds" )
						westsideSetElementData ( source, "wanteds", 0 )
						westsideSetElementData ( source, "jailtime", wanteds * 12 + westsideGetElementData ( source, "jailtime" ) )
						wantedCost = 100*wanteds*(wanteds*.5)
						westsideSetElementData ( source, "money", westsideGetElementData ( source, "money" ) - wantedCost )
						if westsideGetElementData ( source, "money" ) < 0 then
							westsideSetElementData ( source, "money", 0 )
						end
						outputChatBox ( "Der Gesuchte "..getPlayerName ( source ).." ist offline gegangen!", cPlayer, 255,0,0)
						outputChatBox ( "Er wird beim nächsten Einloggen im Gefängnis sein!", cPlayer, 0,255,0 )
						offlinemsg ( "Du bist für "..(wanteds*15).." Minuten im Gefängnis! (Offlineflucht?)", "Server", getPlayerName(source) )
						break
					end
				end
			end
			if quitReason == "Kicked" or quitReason == "Bad Connection" or quitReason == "Timed out" then
				local curWeaponsForSave = "|"
				for i = 1, 12 do
					if i ~= 10 and i ~= 12 then
						local weapon = getPedWeapon ( source, i )
						local ammo = getPedTotalAmmo ( source, i )
						if weapon and ammo then
							if weapon > 0 and ammo > 0 then
								if #curWeaponsForSave <= 40 then
									curWeaponsForSave = curWeaponsForSave..weapon..","..ammo.."|"
								end
							end
						end
					end
				end
				if #curWeaponsForSave > 1 then
					mysql_vio_query( "INSERT INTO logout (Position, Waffen, Name) VALUES ('false', '"..curWeaponsForSave.."', '"..pname.."')")
				end
			end
		end
		if westsideGetElementData ( source, "callswith" ) then
			if westsideGetElementData ( source, "callswith" ) ~= "none" then
				local caller = getPlayerFromName ( westsideGetElementData ( source, "callswith" ) )
				if caller then
					westsideSetElementData ( caller, "callswith", "none" )
					westsideSetElementData ( caller, "call", false )
					westsideSetElementData ( caller, "calls", "none" )
					westsideSetElementData ( caller, "callswith", "none" )
					westsideSetElementData ( caller, "calledby", "none" )
					outputChatBox ( "Aufgelegt..", caller, 255, 0, 0 )
				end
				westsideSetElementData ( source, "callswith", "none" )
				westsideSetElementData ( source, "call", false )
				westsideSetElementData ( source, "calls", "none" )
				westsideSetElementData ( source, "callswith", "none" )
				westsideSetElementData ( source, "calledby", "none" )
			end
		end
		datasave_remote ( source )
		if westsideGetElementData ( source, "isInArea51Mission" ) then
			removeArea51Bots ( pname )
		end
		local veh = getPedOccupiedVehicle ( source )
		if veh then
			if isElement ( veh ) then
				if getElementModel(veh) == 502 then
					destroyElement ( veh )
				end
			end
		end
		killTimer ( _G[pname.."paydaytime"] )
		clearInv ( source )
		clearUserdata ( source )
		clearPackage ( source )
		clearDataSettings ( source )
	end
end
addEventHandler ("onPlayerQuit", getRootElement(), datasave )

function elementDataSettings ( player )

	local pname = MySQL_Save ( getPlayerName ( player ) )
	westsideSetElementData ( player, "cheatingtrys", -1 )
	westsideSetElementData ( player, "growing", false )
	westsideSetElementData ( player, "callswithpolice", false )
	westsideSetElementData ( player, "isLive", false )
	westsideSetElementData ( player, "tied", true )
	westsideSetElementData ( player, "wanzen", false )

end

function SaveCarData ( player )

	local pname = MySQL_Save ( getPlayerName ( player ) )
	MySQL_SetString("userdata", "Geld", MySQL_Save ( MySQL_Save ( westsideGetElementData ( player, "money" )) ), "Name LIKE '"..pname.."'")
	MySQL_SetString("userdata", "CurrentCars", MySQL_Save ( MySQL_Save ( westsideGetElementData ( player, "curcars" )) ), "Name LIKE '"..pname.."'")
	MySQL_SetString("userdata", "Maximumcars", MySQL_Save ( MySQL_Save ( westsideGetElementData ( player, "maxcars" )) ), "Name LIKE '"..pname.."'")
end

function datasave_remote ( player )
	
	local source = player
	if tonumber ( MySQL_Save ( westsideGetElementData ( source, "loggedin" ))) == 1 then
		local pname = getPlayerName ( source )
		local fields = "SET"
		fields = fields.." Geld = '"..math.abs ( math.floor ( westsideGetElementData ( source, "money" ) ) ).."'"
		fields = fields..", Fraktion = '"..math.abs ( math.floor ( westsideGetElementData ( source, "fraktion") ) ).."'"
		fields = fields..", FraktionsRang = '"..math.floor ( westsideGetElementData ( source, "rang" ) ).."'"
		fields = fields..", Spielzeit = '"..math.floor ( westsideGetElementData ( source, "playingtime" ) ).."'"
		fields = fields..", CurrentCars = '"..math.floor ( westsideGetElementData ( source, "curcars" ) ).."'"
		fields = fields..", Maximumcars = '"..math.floor ( westsideGetElementData ( source, "maxcars" ) or 10 ).."'"
		fields = fields..", Tode = '"..math.floor ( westsideGetElementData ( source, "deaths" ) ).."'"
		fields = fields..", Kills = '"..math.floor ( westsideGetElementData ( source, "kills" ) ).."'"
		fields = fields..", Knastzeit = '"..math.floor ( westsideGetElementData ( source, "jailtime" ) ).."'"
		fields = fields..", Himmelszeit = '"..math.floor ( westsideGetElementData ( source, "heaventime" ) ).."'"
		fields = fields..", Hausschluessel = '"..math.floor ( westsideGetElementData ( source, "housekey" ) ).."'"
		fields = fields..", Bankgeld = '"..math.floor ( westsideGetElementData ( source, "bankmoney" ) ).."'"
		fields = fields..", Drogen = '"..math.floor ( westsideGetElementData ( source, "drugs" ) ).."'"
		fields = fields..", Skinid = '"..math.floor ( westsideGetElementData ( source, "skinid" ) ).."'"
		fields = fields..", Wanteds = '"..math.floor ( westsideGetElementData ( source, "wanteds" ) ).."'"
		fields = fields..", Level = '"..math.floor(westsideGetElementData(source,"level")).."'"
		fields = fields..", Erfahrungspunkte = '"..math.floor(westsideGetElementData(source,"erfahrungspunkte")).."'"
		fields = fields..", Vip = '"..math.floor(westsideGetElementData(source,"vip")).."'"
		fields = fields..", Bankpin = '"..math.floor(westsideGetElementData(source,"bankpin")).."'"
		fields = fields..", Fskin = '"..math.floor ( westsideGetElementData ( source, "fskin" ) ).."'"
		fields = fields..", StvoPunkte = '"..math.floor ( westsideGetElementData ( source, "stvo_punkte" ) ).."'"
		fields = fields..", Boni = '"..math.floor ( westsideGetElementData ( source, "boni" ) ).."'"
		fields = fields..", IncomePayday = '"..math.floor ( westsideGetElementData ( source, "incomepayday" ) ).."'"
		fields = fields..", PdayIncome = '"..math.floor ( westsideGetElementData ( source, "pdayincome" ) ).."'"
		fields = fields..", PdayKosten = '"..math.floor ( westsideGetElementData ( source, "pdaykosten" ) ).."'"
		fields = fields..", Gunbox1 = '"..westsideGetElementData ( source, "gunboxa" ).."'"
		fields = fields..", Gunbox2 = '"..westsideGetElementData ( source, "gunboxb" ).."'"
		fields = fields..", Gunbox3 = '"..westsideGetElementData ( source, "gunboxc" ).."'"
		fields = fields..", Job = '"..westsideGetElementData ( source, "job" ).."'"
		fields = fields..", SocialState = '"..MySQL_Save ( getElementData ( source, "socialState") ).."'"
		
		----- Alles neue -----
		fields=fields..",Harndrang='"..math.floor(westsideGetElementData(source,'harndrang')).."'"
		fields=fields..",Hunger='"..math.floor(westsideGetElementData(source,'hunger')).."'"
		fields=fields..",Unternehmen='"..math.floor(westsideGetElementData(source,'unternehmen')).."'"
		fields=fields..",Unternehmenrang='"..math.floor(westsideGetElementData(source,'unternehmenrang')).."'"
		fields=fields..",Drogenpegel='"..math.floor(westsideGetElementData(source,'drogenPegel')).."'"
		fields=fields..",Alkoholpegel='"..math.floor(westsideGetElementData(source,'alkoholPegel')).."'"
		fields=fields..",Jobgehalt='"..math.floor(westsideGetElementData(source,'jobgehalt')).."'"
		fields=fields..",Carslotupgrade='"..math.floor(westsideGetElementData(source,'carslotupgrade')).."'"
		-- Erfolge --
		fields=fields..",Punkte_Rekordschwimmer='"..math.floor(westsideGetElementData(source,'Punkte_Rekordschwimmer')).."'"
		fields=fields..",Erfolg_Rekordschwimmer='"..math.floor(westsideGetElementData(source,'Erfolg_Rekordschwimmer')).."'"
		fields=fields..",Punkte_Langlaeufer='"..math.floor(westsideGetElementData(source,'Punkte_Langlaeufer')).."'"
		fields=fields..",Erfolg_Langlaeufer='"..math.floor(westsideGetElementData(source,'Erfolg_Langlaeufer')).."'"
		fields=fields..",Punkte_Busfahrer='"..math.floor(westsideGetElementData(source,'Punkte_Busfahrer')).."'"
		fields=fields..",Erfolg_Busfahrer='"..math.floor(westsideGetElementData(source,'Erfolg_Busfahrer')).."'"
		fields=fields..",Punkte_Eisfahrer='"..math.floor(westsideGetElementData(source,'Punkte_Eisfahrer')).."'"
		fields=fields..",Erfolg_Eisfahrer='"..math.floor(westsideGetElementData(source,'Erfolg_Eisfahrer')).."'"
		fields=fields..",Punkte_Hotdog='"..math.floor(westsideGetElementData(source,'Punkte_Hotdog')).."'"
		fields=fields..",Erfolg_Hotdog='"..math.floor(westsideGetElementData(source,'Erfolg_Hotdog')).."'"
		fields=fields..",Punkte_Meeresreiniger='"..math.floor(westsideGetElementData(source,'Punkte_Meeresreiniger')).."'"
		fields=fields..",Erfolg_Meeresreiniger='"..math.floor(westsideGetElementData(source,'Erfolg_Meeresreiniger')).."'"
		fields=fields..",Punkte_Pilot='"..math.floor(westsideGetElementData(source,'Punkte_Pilot')).."'"
		fields=fields..",Erfolg_Pilot='"..math.floor(westsideGetElementData(source,'Erfolg_Pilot')).."'"
		fields=fields..",Punkte_Pizzalieferant='"..math.floor(westsideGetElementData(source,'Punkte_Pizzalieferant')).."'"
		fields=fields..",Erfolg_Pizzalieferant='"..math.floor(westsideGetElementData(source,'Erfolg_Pizzalieferant')).."'"
		fields=fields..",Punkte_Strassenreiniger='"..math.floor(westsideGetElementData(source,'Punkte_Strassenreiniger')).."'"
		fields=fields..",Erfolg_Strassenreiniger='"..math.floor(westsideGetElementData(source,'Erfolg_Strassenreiniger')).."'"
		fields=fields..",Punkte_Trucker='"..math.floor(westsideGetElementData(source,'Punkte_Trucker')).."'"
		fields=fields..",Erfolg_Trucker='"..math.floor(westsideGetElementData(source,'Erfolg_Trucker')).."'"
		fields=fields..",Erfolg_MeinZuhause='"..math.floor(westsideGetElementData(source,'Erfolg_MeinZuhause')).."'"
		fields=fields..",Erfolg_MeinErstesFahrzeug='"..math.floor(westsideGetElementData(source,'Erfolg_MeinErstesFahrzeug')).."'"
		fields=fields..",Erfolg_MeinErstesGeld='"..math.floor(westsideGetElementData(source,'Erfolg_MeinErstesGeld')).."'"
		fields=fields..",Erfolg_Millionaer='"..math.floor(westsideGetElementData(source,'Erfolg_Millionaer')).."'"
		fields=fields..",Erfolg_Fahrzeugsammler='"..math.floor(westsideGetElementData(source,'Erfolg_Fahrzeugsammler')).."'"
		fields=fields..",Erfolg_EndlichLevel25='"..math.floor(westsideGetElementData(source,'Erfolg_EndlichLevel25')).."'"
		fields=fields..",Erfolg_250Spielstunden='"..math.floor(westsideGetElementData(source,'Erfolg_250Spielstunden')).."'"
		fields=fields..",Punkte_Bergwerkarbeiter='"..math.floor(westsideGetElementData(source,'Punkte_Bergwerkarbeiter')).."'"
		fields=fields..",Erfolg_Bergwerkarbeiter='"..math.floor(westsideGetElementData(source,'Erfolg_Bergwerkarbeiter')).."'"
		fields=fields..",Erfolg_Gym='"..math.floor(westsideGetElementData(source,'Erfolg_Gym')).."'"
		fields=fields..",Punkte_Zugjob='"..math.floor(westsideGetElementData(source,'Punkte_Zugjob')).."'"
		fields=fields..",Erfolg_Zugjob='"..math.floor(westsideGetElementData(source,'Erfolg_Zugjob')).."'"
		
		local v1 = "|"..westsideGetElementData ( source, "handyType" ).."|"
		local v2 = westsideGetElementData ( source, "handyCosts" ).."|"
		local v3 = v1..v2
		fields = fields..", Handy = '"..v3.."'"
		mysql_vio_query ( "UPDATE userdata "..fields.." WHERE Name LIKE '"..pname.."'" )

		inventorysave(source)
		outputDebugString ("DIE DATEN VON "..pname.." WURDEN GESICHTERT!")
	end
end

function inventorysave ( player )

	local pname = getPlayerName ( player )
	MySQL_SetString("inventar", "Waffenslot5", MySQL_Save ( westsideGetElementData ( player, "guninv5") ) , "Name LIKE '"..pname.."'")

	local fields = "SET"
	fields = fields.." Blumensamen = '"..westsideGetElementData ( player, "flowerseeds" ).."'"
	fields = fields..", Zigaretten = '"..westsideGetElementData ( player, "zigaretten" ).."'"
	fields = fields..", Materials = '"..westsideGetElementData ( player, "mats" ).."'"
	fields = fields..", Benzinkanister = '"..westsideGetElementData ( player, "benzinkannister" ).."'"
	fields = fields..", Bomben ='"..westsideGetElementData(player,"bomben").."'"
	fields = fields..", Schwarzpulver ='"..westsideGetElementData(player,"schwarzpulver").."'"
	fields = fields..", Coins ='"..westsideGetElementData(player,"coins").."'"
	fields = fields..", Hotdogs ='"..westsideGetElementData(player,"hotdogs").."'"
	fields = fields..", Eis ='"..westsideGetElementData(player,"eis").."'"
	fields = fields..", FGutschein ='"..westsideGetElementData(player,"fgutschein").."'"
	fields = fields..", Pokale ='"..westsideGetElementData(player,"pokale").."'"
	mysql_vio_query ( "UPDATE inventar "..fields.." WHERE Name LIKE '"..pname.."'" )
end

function inventoryload ( player )

	local pname = getPlayerName ( player )
	westsideSetElementData ( player, "playerid", tonumber ( MySQL_GetString("players", "id", "Name LIKE '" ..pname.."'")) )
	
	local dsatz
	local result = mysql_query ( handler, "SELECT * from inventar WHERE Name LIKE '"..pname.."'" )
	if result then
		if ( mysql_num_rows ( result ) > 0 ) then
			dsatz = mysql_fetch_assoc ( result )
			mysql_free_result ( result )
		end
	end
	
	westsideSetElementData ( player, "dice", tonumber ( dsatz["Wuerfel"] ) )
	westsideSetElementData ( player, "flowerseeds", tonumber ( dsatz["Blumensamen"] ) )
	westsideSetElementData ( player, "zigaretten", tonumber ( dsatz["Zigaretten"] ) )
	westsideSetElementData ( player, "mats", tonumber ( dsatz["Materials"] ) )
	westsideSetElementData ( player, "benzinkannister", tonumber ( dsatz["Benzinkanister"] ) )
	westsideSetElementData ( player, "bomben", tonumber ( dsatz["Bomben"] ) )
	westsideSetElementData ( player, "schwarzpulver", tonumber ( dsatz["Schwarzpulver"] ) )
	westsideSetElementData ( player, "coins" ,tonumber( dsatz["Coins"] ) )
	westsideSetElementData ( player, "hotdogs" ,tonumber( dsatz["Hotdogs"] ) )
	westsideSetElementData ( player, "eis" ,tonumber( dsatz["Eis"] ) )
	westsideSetElementData ( player, "fgutschein" ,tonumber( dsatz["FGutschein"] ) )
	westsideSetElementData ( player, "pokale" ,tonumber( dsatz["Pokale"] ) )
	dsatz = nil
end