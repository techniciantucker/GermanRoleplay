local loehne_payday = {}

for i = 1, 9, 1 do
	loehne_payday[i] = {}
end
	
loehne_payday[1][0] = 500
loehne_payday[1][1] = 100
loehne_payday[1][2] = 1500
loehne_payday[1][3] = 2000
loehne_payday[1][4] = 2500
loehne_payday[1][5] = 3000

loehne_payday[6][0] = 500
loehne_payday[6][1] = 1000
loehne_payday[6][2] = 1500
loehne_payday[6][3] = 2000
loehne_payday[6][4] = 2500
loehne_payday[6][5] = 3000

loehne_payday[8][0] = 500
loehne_payday[8][1] = 1000
loehne_payday[8][2] = 1500
loehne_payday[8][3] = 2000
loehne_payday[8][4] = 2500
loehne_payday[8][5] = 3000

loehne_payday[5][0] = 500
loehne_payday[5][1] = 1000
loehne_payday[5][2] = 1500
loehne_payday[5][3] = 2000
loehne_payday[5][4] = 2500
loehne_payday[5][5] = 3000

local test_table = {}
test_table[1] = 2
test_table[2] = 3
test_table[3] = 7
test_table[4] = 9
test_table[5] = 4

for i = 1, 5, 1 do

	loehne_payday[test_table[i]][0] = 500
	loehne_payday[test_table[i]][1] = 1000
	loehne_payday[test_table[i]][2] = 1500
	loehne_payday[test_table[i]][3] = 2000
	loehne_payday[test_table[i]][4] = 2500
	loehne_payday[test_table[i]][5] = 3000

end

AFKTimer					  	  = {}
local CheckAFKValue 			  = {}

addEventHandler("onPlayerQuit", root, function()
	if AFKTimer[source] then
		killTimer(AFKTimer[source])
	end
end)

function checkAFK(player)
	
	if not CheckAFKValue[player] then
		CheckAFKValue[player] 	  = {}
		CheckAFKValue[player].var = 0
		
		local x, y, z 			  = getElementPosition(player);
		CheckAFKValue[player].x   = x
		CheckAFKValue[player].y   = y
		
		return
	end
	
	local x, y, z 			= getElementPosition(player);
	
	if getDistanceBetweenPoints2D(x, y, CheckAFKValue[player].x, CheckAFKValue[player].y) <= 5 then

		
		if(CheckAFKValue[player].var >= 10)then
			if not getElementData(player, "AFK") then
				infobox(player,"Du bist nun AFK!")
			end
			setElementData(player, "AFK", true);
		else
			CheckAFKValue[player].var = CheckAFKValue[player].var + 1;
		end
	else
		if getElementData(player, "AFK") then
			setElementData(player, "AFK", false);
			infobox(player,"Willkommen zurück!",4000,0,255,0)
			
			CheckAFKValue[player].var = 0
		end
	end
	
	CheckAFKValue[player].x = x;
	CheckAFKValue[player].y = y;
	
end

function payday ( player )

	if math.floor ( westsideGetElementData ( player, "playingtime" ) / 60 ) == ( westsideGetElementData ( player, "playingtime" ) / 60 ) then
	
		if getElementData(player, "AFK") then
			return
			outputChatBox("Da du Afk bist, hast du keinen Payday erhalten!",player,255,0,0)
		end
		
		local player_payday = {}
		
		local faction = getPlayerFaction ( player )
		local rank = getPlayerRank ( player )
		player_payday["Boni"] = tonumber(westsideGetElementData( player, "boni" )) 
		
		if isEvil ( player ) then
			player_payday["Zuschuesse"] = loehne_payday[faction][rank]
		else
			player_payday["Zuschuesse"] = 0
		end
		
		if isStateFaction ( player ) then
		
			local incoming = tonumber(westsideGetElementData( player, "pdayincome" ))
			local multiplikator
			
			if incoming > 50 then
				multiplikator = 1
			elseif incoming > 40 then
				multiplikator = 5/6
			elseif incoming > 30 then
				multiplikator = 4/6
			elseif incoming > 20 then
				multiplikator = 3/6
			elseif incoming > 10 then
				multiplikator = 2/6
			else
				multiplikator = 1/6
			end
			
			local var = math.floor(loehne_payday[faction][rank] * multiplikator)
		
			player_payday["Lohn"] = var
			
		elseif faction == 5 then
		
			player_payday["Lohn"] = loehne_payday[faction][rank]
			
		else
		
			player_payday["Lohn"] = 0
		
		end
		
		local grund 
		local costs
		
		if westsideGetElementData ( player, "handyType" ) == 1 then
			grund = 10
			costs = tonumber(westsideGetElementData( player, "handyCosts" ))
		elseif westsideGetElementData ( player, "handyType" ) == 2 then
			grund = 0
			costs = 0
		else
			grund = 50
			costs = 0
		end
		
		player_payday["Handykosten"] = grund + costs
		
		local var_zinsen = westsideGetElementData( player, "bankmoney" ) * 0.01
		local Zinsen = math.floor(var_zinsen)
		
		if Zinsen > 1500 then
			player_payday["Zinsen"] = 1500
		else
			player_payday["Zinsen"] = Zinsen
		end
		
		local new_steuern = player_payday["Lohn"] + player_payday["Zuschuesse"] + player_payday["Boni"]
		player_payday["Steuern"] = math.floor ( new_steuern * 0.1 )
		
		if(getElementData(player,"vip")==1)then
			player_payday["Fahrzeugsteuer"] = math.floor( westsideGetElementData(player, "curcars") * 100 )
		elseif(getElementData(player,"vip")==2)then
			player_payday["Fahrzeugsteuer"] = math.floor( westsideGetElementData(player, "curcars") * 50 )
		elseif(getElementData(player,"vip")==3)then
			player_payday["Fahrzeugsteuer"] = math.floor( westsideGetElementData(player, "curcars") * 25 )
		elseif(getElementData(player,"vip")==4)then
			player_payday["Fahrzeugsteuer"] = math.floor( westsideGetElementData(player, "curcars") * 10 )
		else
			player_payday["Fahrzeugsteuer"] = math.floor( westsideGetElementData(player, "curcars") * 250 )
		end
		
		rent = 0
		
		if westsideGetElementData ( player, "housekey" ) < 0 then
			local ID = math.abs(westsideGetElementData ( player, "housekey" ))
			local haus = houses["pickup"][ID]
			rent = westsideGetElementData ( haus, "miete" )
			local Kasse = MySQL_GetString("houses", "Kasse", "ID LIKE '"..ID.."'")
			local Kasse = Kasse + rent
			MySQL_SetString("houses", "Kasse", Kasse, "ID LIKE '"..ID.."'")
		end
		
		player_payday["Miete"] = rent
		
		--[[ if getElementData ( player, "socialState" ) == "Rentner" then
			player_payday["Zuschuesse"] = player_payday["Zuschuesse"] + 2000
		end ]]--
		
		if(getElementData(player,"vip")==1)then
			player_payday["vip"] = 1250
		elseif(getElementData(player,"vip")==2)then
			player_payday["vip"] = 2000
		elseif(getElementData(player,"vip")==3)then
			player_payday["vip"] = 3500
		elseif(getElementData(player,"vip")==4)then
			player_payday["vip"] = 5000
		else
			player_payday["vip"] = 0
		end
		
		if getElementData(player,"hartzseven") == 1 then
			player_payday["hartz7"] = 2500
		else
			player_payday["hartz7"] = 0
		end
		
		player_payday['Jobgehalt']=westsideGetElementData(player,'jobgehalt')
		
		if(westsideGetElementData(player,'pokale')>0)then
			player_payday['pokale']=westsideGetElementData(player,'pokale')*100
		else
			player_payday['pokale']=0
		end
		
		----- Payday -----
		triggerClientEvent(player,"geschafftSound",player)
		
		outputChatBox("~~~~~ PAYDAY ~~~~~",player,255,255,255)
		outputChatBox("Du erhälst 50 Erfahrunspunkte!",player,0,100,150)
		
		-- Personalausweis
		if tonumber(westsideGetElementData ( player, "perso" )) == 0 then
			outputChatBox("[INFO]: Du hast noch keinen Personalausweis!",player,255,0,0)
		end
		
		local amount = MySQL_ExistAmount ( "gangs", "BesitzerFraktion = '"..faction.."'" )
						
		if westsideGetElementData ( player, "stvo_punkte" ) >= 1 then
			if tonumber(westsideGetElementData ( player, "perso" )) == 1 then
				westsideSetElementData ( player, "stvo_punkte", westsideGetElementData ( player, "stvo_punkte" ) - 1 )
				--outputChatBox ( "Dir wurde ein StVo Punkt erlassen!", player, 0,100,150 )
				infobox(player,"Dir wurde ein StVo Punkt erlassen!",4000,0,255,0)
			end
		end
		
		if math.floor ( tonumber ( westsideGetElementData ( player, "playingtime" ) ) / 60 ) == ( tonumber ( westsideGetElementData ( player, "playingtime" ) ) / 60 ) and tonumber ( westsideGetElementData ( player, "wanteds" ) ) >= 1 then
			if tonumber(westsideGetElementData ( player, "perso" )) == 1 then
				westsideSetElementData ( player, "wanteds", westsideGetElementData ( player, "wanteds" ) - 1 )
				setPlayerWantedLevel ( player, westsideGetElementData ( player, "wanteds" ) )
				--outputChatBox ( "Dir wurde ein Wanted erlassen!", player, 0,100,150 )
				infobox(player,"Dir wurde ein Wanted erlassen!",4000,0,255,0)
			end
		end
		
		--[[ triggerClientEvent(player, 'createPaydayDxDraw', player, player_payday["Lohn"], player_payday["Boni"], player_payday["Zuschuesse"], player_payday["Handykosten"], 
		player_payday["Steuern"], player_payday["Fahrzeugsteuer"], player_payday["Miete"], player_payday["Zinsen"]); ]]--
		
		outputChatBox("Lohn: "..player_payday["Lohn"].."$, Boni: "..player_payday["Boni"].."$, Zuschüsse: "..player_payday["Zuschuesse"].."$, Handykosten: "..player_payday["Handykosten"].."$",player, 0,100,150)
		
		if(tonumber(westsideGetElementData(player,"perso"))==0)then
			outputChatBox("Du hast noch keinen Personalausweis Ausweis!",player,255,0,0)
		else
			outputChatBox("Steuern: "..player_payday["Steuern"].."$, Fahrzeugsteuern: "..player_payday["Fahrzeugsteuer"].."$",player,0,100,150)
		end
		
		if(tonumber(westsideGetElementData(player,"perso"))==1)then
			outputChatBox("Miete: "..player_payday["Miete"].."$, Zinsen: "..player_payday["Zinsen"].."$, Job: "..player_payday["Jobgehalt"].."$, Pokale: "..player_payday["pokale"].."$",player,0,100,150)
		end
		
		if(tonumber(westsideGetElementData(player,"hartzseven"))== 1)then
			outputChatBox("Hartz 7: 2500$",player,0,100,150)
			--westsideSetElementData ( player, "bankmoney", westsideGetElementData ( player, "bankmoney" ) + 2500 )
		end
		
		if amount > 0 then
			player_payday["Gangarea"] = amount * 100
			outputChatBox ( "Einnahmen durch Ganggebiete: "..player_payday["Gangarea"].."$!", player, 0,100,150)
		else
			player_payday["Gangarea"] = 0
		end
		
		----- Vip -----
		
		if(getElementData(player,"vip")==1)then
			outputChatBox("Vip Bonus: 1250$ / 100 Erfahrunspunkte",player,0,200,0)
			westsideSetElementData ( player, "bankmoney", westsideGetElementData ( player, "bankmoney" ) + 1250 )
			westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 100)
		elseif(getElementData(player,"vip")==2)then
			outputChatBox("Vip Bonus: 2000$ / 150 Erfahrunspunkte / 1 Coin",player,0,200,0)
			westsideSetElementData ( player, "bankmoney", westsideGetElementData ( player, "bankmoney" ) + 2000 )
			westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 150)
			westsideSetElementData(player,"coins",tonumber(westsideGetElementData(player,"coins")) + 1)
		elseif(getElementData(player,"vip")==3)then
			outputChatBox("Vip Bonus: 3500$ / 300 Erfahrunspunkte / 2 Coins",player,0,200,0)
			westsideSetElementData ( player, "bankmoney", westsideGetElementData ( player, "bankmoney" ) + 3500 )
			westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 300)
			westsideSetElementData(player,"coins",tonumber(westsideGetElementData(player,"coins")) + 2)
		elseif(getElementData(player,"vip")==4)then
			outputChatBox("Vip Bonus: 5000$ / 500 Erfahrunspunkte / 3 Coins",player,0,200,0)
			westsideSetElementData ( player, "bankmoney", westsideGetElementData ( player, "bankmoney" ) + 5000 )
			westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 500)
			westsideSetElementData(player,"coins",tonumber(westsideGetElementData(player,"coins")) + 3)
		else
			outputChatBox("Vip Bonus: Nicht aktiv!",player,150,0,0)
		end
		
		outputChatBox("------------------------------",player,0,200,0)
		outputChatBox("Die Einnahmen wurden auf dein Konto überwiesen!",player,0,100,200)
		
		if(tonumber(westsideGetElementData(player,"perso"))==0)then
			player_payday["Gesamt"] = player_payday["Handykosten"] - player_payday["Miete"] + player_payday["Gangarea"] + player_payday["vip"] + player_payday['pokale']
		else
			player_payday["Gesamt"] = player_payday["Lohn"] + player_payday["Boni"] + player_payday["Zuschuesse"] - player_payday["Handykosten"] - player_payday["Steuern"] - player_payday["Fahrzeugsteuer"] - player_payday["Miete"] + player_payday["Zinsen"] + player_payday["Gangarea"] + player_payday["hartz7"] + player_payday["vip"] + player_payday['Jobgehalt'] + player_payday['pokale']
		end
		
		outputChatBox("Gesamteinnahmen: "..player_payday["Gesamt"].."$",player,0,100,200)
		
		if(westsideGetElementData(player,'Erfolg_MeinErstesGeld')==0)then
			westsideSetElementData(player,'Erfolg_MeinErstesGeld',1)
			triggerClientEvent(player,'erfolgWindow',player,'Mein erstes Geld')
			westsideSetElementData(player,'pokale',tonumber(westsideGetElementData(player,'pokale'))+1)
			outputLog(getPlayerName(player)..' hat den Erfolg Mein erstes Geld freigeschalten!','Erfolge')
		end
		if(westsideGetElementData(player,'bankmoney')>999999)then
			if(westsideGetElementData(player,'Erfolg_Millionaer')==0)then
				westsideSetElementData(player,'Erfolg_Millionaer',1)
				triggerClientEvent(player,'erfolgWindow',player,'Millionär')
				westsideSetElementData(player,'pokale',tonumber(westsideGetElementData(player,'pokale'))+1)
				outputLog(getPlayerName(player)..' hat den Erfolg Millionär freigeschalten!','Erfolge')
			end
		end
		if(westsideGetElementData(player,'playingtime')==15000)then
			if(westsideGetElementData(player,'Erfolg_250Spielstunden')==0)then
				westsideSetElementData(player,'Erfolg_250Spielstunden',1)
				triggerClientEvent(player,'erfolgWindow',player,'250 Spielstunden')
				westsideSetElementData(player,'pokale',tonumber(westsideGetElementData(player,'pokale'))+1)
				outputLog(getPlayerName(player)..' hat den Erfolg 250 Spielstunden freigeschalten!','Erfolge')
			end
		end

		westsideSetElementData ( player, "pdayincome", 0 )
		westsideSetElementData ( player, "boni", 0 )
		westsideSetElementData(player,'jobgehalt',0)
		
		westsideSetElementData ( player, "bankmoney", westsideGetElementData ( player, "bankmoney" ) + player_payday["Gesamt"] )
		westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 50)
		datasave_remote ( player )
		
	end
end

function playingtime ( player )
	if isElement ( player ) then
		if westsideGetElementData ( player, "loggedin" ) == 1 then
			setPlayerWantedLevel ( player, tonumber( westsideGetElementData ( player, "wanteds" ) ))
			local pname = getPlayerName ( player )
			westsideSetElementData ( player, "curplayingtime", westsideGetElementData ( player, "curplayingtime" ) + 1 )
			westsideSetElementData ( player, "playingtime", westsideGetElementData ( player, "playingtime" ) + 1 )
			local jailed = tonumber( westsideGetElementData ( player, "jailtime" ) )
			if jailed > 1 then
				westsideSetElementData ( player, "jailtime", jailed - 1 )
			elseif jailed == 1 then
				freePlayerFromJail ( player )
			end
			
			if(not(getElementData(player,'AFK')==true))then
				if(westsideGetElementData(player,'harndrang')==99)then
					outputChatBox('Du fühlst dich nicht wohl und musst auf die Toilette!',player,255,0,0)
					outputChatBox('Nutze /piss oder suche eine öffentliche Toilette auf.',player,255,0,0)
					
					pipiTimer=setTimer(function()
						if(westsideGetElementData(player,'harndrang')==100)then
							if(pipiTimer)then
								killTimer(pipiTimer)
							end
						
							local pipiDieChance=math.random(1,5)
							
							if(pipiDieChance==5)then
								setElementHealth(player,0)
								outputChatBox('Du hast deine Blase nicht entleert und bist durch eine',player,255,0,0)
								outputChatBox('Entzündung in deinem Magen gestorben!',player,255,255,0)
							end
						end
					end,300000,1)
				else
					westsideSetElementData(player,'harndrang',tonumber(westsideGetElementData(player,'harndrang'))+1)
				end
			
				if(westsideGetElementData(player,'hunger')==1)then
					setElementHealth(player,0)
					outputChatBox('Du hast zu lange nichts gegessen und bist gestorben!',player,255,0,0)
				elseif(westsideGetElementData(player,'hunger')<10)then
					outputChatBox('Du hast kaum etwas im Magen und bist hungrig, suche ein Restaurant auf!',player,255,0,0)
					westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))-1)
				else
					westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))-1)
				end
				
				if(westsideGetElementData(player,'alkoholPegel')>0)then
					if(alkoholPegel==1)then
						outputChatBox('Es befindet sich nun kein Alkohol mehr in deinem Blut!')
					end
					westsideSetElementData(player,'alkoholPegel',tonumber(westsideGetElementData(player,'alkoholPegel'))-1)
				end
				if(westsideGetElementData(player,'drogenPegel')>0)then
					if(drogenPegel==1)then
						outputChatBox('Es befinden sich nun keine Drogen mehr in deinem Blut!')
					end
					westsideSetElementData(player,'drogenPegel',tonumber(westsideGetElementData(player,'alkoholPegel'))-1)
				end
			end
			
			_G[pname.."paydaytime"] = setTimer ( playingtime, 60000, 1, player )
			westsideSetElementData ( player, "lastcrime", "none" )
			
			if getElementData(player,"onDuty") == true then	
				if isFBI(player) then
					bonus = 1.2
				else
					bonus = 1
				end
				local income = tonumber(westsideGetElementData( player, "pdayincome" ))
				westsideSetElementData ( player, "pdayincome", income+1 )
			end
			
			payday ( player )
			MySQL_SetString("userdata", "Bankgeld", MySQL_Save ( westsideGetElementData ( player, "bankmoney") ), "Name LIKE '"..pname.."'")
			MySQL_SetString("userdata", "Geld", MySQL_Save ( westsideGetElementData ( player, "money" ) ), "Name LIKE '"..pname.."'")
		end	
	end
end