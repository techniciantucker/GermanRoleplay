gangColor = {}
	gangColor[2] = {}
		gangColor[2][1] = 115
		gangColor[2][2] = 115
		gangColor[2][3] = 115
	gangColor[3] = {}
		gangColor[3][1] = 21
		gangColor[3][2] = 67
		gangColor[3][3] = 207
	gangColor[4] = {}
		gangColor[4][1] = 219
		gangColor[4][2] = 175
		gangColor[4][3] = 92
	gangColor[7] = {}
		gangColor[7][1] = 0
		gangColor[7][2] = 150
		gangColor[7][3] = 0
	gangColor[9] = {}
		gangColor[9][1] = 99
		gangColor[9][2] = 52
		gangColor[9][3] = 19	
		
gangName = { 
 [0]="Niemandem",
 [2]="Brigada",
 [3]="Triaden",
 [4]="Kartell",
 [7]="Grove Street",
 [9]="Dillimore Devils"
 }
 
gangPraefix = {
 [2]="Brigada",
 [3]="Triaden",
 [4]="Kartell",
 [7]="Grove Street",
 [9]="Dillimore Devils"
 }
 
validGangs = { 
 [2]=true,
 [3]=true,
 [4]=true,
 [7]=true,
 [9]=true
 }

gwstart 		     	 = false
gangAreaUnderAttack 	 = false
gangCount 				 = 20
gangAreaConquerEach  	 = 1000
sec 				 	 = 1000
local member_online  	 = 1
local attackerpoints 	 = 0
local defenderpoints 	 = 0
local baysideGangwar	 = false
local holzfaellerGangwar = false
local skaterparkGangwar  = false
local friedhofGangwar    = false
local pissgebietGangwar  = false
local GangwarTime        = 0
local GangwarPause       = false
local drogenlaborGangwar = false
local jizzysGangwar      = false
local parkGangwar 		 = false
local docksGangwar 		 = false
local vorbereitungszeit  = 60000

----- Gebiet erstellen -----
function createGangAreas ()
	local gangCounter = 1
	local Besitzer = tonumber ( MySQL_GetString("gangs", "BesitzerFraktion", "Nummer LIKE '" ..gangCounter.."'") )
	while true do
		local Besitzer = tonumber ( MySQL_GetString("gangs", "BesitzerFraktion", "Nummer LIKE '" ..gangCounter.."'") )
		if Besitzer then
			local Einnahmen = MySQL_GetString("gangs", "Einnahmen", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			local X1 = MySQL_GetString("gangs", "X1", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			local Y1 = MySQL_GetString("gangs", "Y1", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			local X2 = MySQL_GetString("gangs", "X2", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			local Y2 = MySQL_GetString("gangs", "Y2", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			
			local XS = math.abs(X1-X2)
			local YS = math.abs(Y1-Y2)
			
			local X3 = MySQL_GetString("gangs", "X3", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			local Y3 = MySQL_GetString("gangs", "Y3", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			local Z3 = MySQL_GetString("gangs", "Z3", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			local Einnahmen = MySQL_GetString("gangs", "Einnahmen", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			local r = gangColor[Besitzer][1]
			local g = gangColor[Besitzer][2]
			local b = gangColor[Besitzer][3]
			
			_G["gangArea"..gangCounter] = createRadarArea ( X1, Y1, XS, YS, r, g, b, 125, getRootElement() )
			
			_G["gangPickup"..gangCounter] = createPickup ( X3, Y3, Z3, 3, 1313, 1, 9999 )
			westsideSetElementData ( _G["gangPickup"..gangCounter], "gang", Besitzer )
			westsideSetElementData ( _G["gangPickup"..gangCounter], "id", gangCounter )
			westsideSetElementData ( _G["gangPickup"..gangCounter], "einnahmen", Einnahmen )
			westsideSetElementData ( _G["gangPickup"..gangCounter], "isUnderAttack", false )
			
			addEventHandler ( "onPickupHit", _G["gangPickup"..gangCounter], Pickuphit )
			
			gangCounter = gangCounter + 1
		else
			break
		end
	end
end
addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource() ), createGangAreas )

----- Pickup Hit -----
function Pickuphit(player)
	if isPedInVehicle (player) == false then
		if isEvil(player) then
			if gwstart == false then
				outputChatBox("/gInfos für Informationen bzg. des Gangwarsystems.",player,0,200,0)
				if westsideGetElementData(player,"rang") > 2 then
					infobox(player,"Besitzer: "..gangName[westsideGetElementData(source,"gang")].."\nTippe /attack, um es anzugreifen!",4000,0,255,0)
				else
					infobox(player,"Besitzer: "..gangName[westsideGetElementData(source,"gang")],4000,0,255,0)
				end
			else
				if(isEvil(player))then
					if(tonumber(westsideGetElementData(player,"fraktion"))==attackerfrac)or(tonumber(westsideGetElementData(player,"fraktion"))==owner)then
						outputChatBox("Angreifer: "..attackerpoints.." Punkte, Verteidiger: "..defenderpoints.." Punkte",player,0,200,0)
						outputChatBox("Verbleibende Zeit: "..GangwarTime.." Minute(n).",player,150,150,0)
					end
				end
			end
		else
			infobox(player,"Dies ist ein Ganggebiet!",4000,255,0,0)
		end
	end
end

----- Angreifen -----
addCommandHandler("attack",function(player)
	if validGangs[westsideGetElementData ( player, "fraktion" )] and westsideGetElementData ( player, "rang" ) >= 3 then
		if isPedInVehicle (player) == false then
			local x1, y1, z1 = getElementPosition ( player )
			sucess = false
			validID = nil
			for i = 1, gangCount do
				local x2, y2, z2 = getElementPosition ( _G["gangPickup"..i] )
				if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 3 then
					validID = i
					sucess = true
					break
				end
			end
			if sucess then
				local pickup = _G["gangPickup"..validID]
				owner = tonumber ( westsideGetElementData ( pickup, "gang" ) )
				if owner ~= westsideGetElementData ( player, "fraktion" ) then
					if getFactionMembersOnline ( owner ) >= member_online then
						if not gangAreaUnderAttack then
							if not westsideGetElementData ( pickup, "Blocked" ) then
								if(GangwarPause==false)then
									startGangAreaAttack ( player, pickup, owner, validID )
								else
									infobox(player,"Nach jedem Gangwar herrscht\n5 Minuten Pause!",4000,255,0,0)
								end
							else
								infobox(player,"Dieses Gebiet wurde\nheute bereits angegriffen!",4000,255,0,0)
							end
						else
							infobox(player,"Es läuft bereits ein Gangwar!",4000,255,0,0)
						end
					else
						infobox(player,"Es müssen mindestens\n"..member_online.." Gegner online sein!",4000,255,0,0)
					end
				else
					infobox(player,"Du kannst dein eigenes\nGebiet nicht angreifen!",4000,255,0,0)
				end
			end
		else
			infobox(player,"Steig aus deinem Fahrzeug aus!")
		end
	end
end)

----- Starten -----
function startGangAreaAttack ( player, pickup, owner, id )
	sendMSGForFaction('Ein Gangfight wird vorbereitet!',2,125,0,0)
	sendMSGForFaction('Ein Gangfight wird vorbereitet!',3,125,0,0)
	sendMSGForFaction('Ein Gangfight wird vorbereitet!',4,125,0,0)
	sendMSGForFaction('Ein Gangfight wird vorbereitet!',7,125,0,0)
	sendMSGForFaction('Ein Gangfight wird vorbereitet!',9,125,0,0)
	setTimer(function()
		GangwarTime = 10
		
		setTimer(function()
			GangwarTime = GangwarTime - 1
		end,60000,10)

		attackerfrac 		= westsideGetElementData ( player, "fraktion" )
		local area 			= _G["gangArea"..id]
		gwstart 		    = true
		gangAreaUnderAttack = true
		
		setRadarAreaFlashing(area,true)
		setRadarAreaColor(area,125,0,0,125)
		westsideSetElementData(pickup,"isUnderAttack",true)

		victoryTimer = setTimer(areaFinishCheck,600000,1,area,attackerfrac,owner,pickup,id)
		
		attackerpoints = attackerpoints + 1
		
		outputChatBox("#00ffff[Gangfight]#ffffff Die "..gangName[attackerfrac].." greifen/greift eine Zone der "..gangName[owner].." an!",root,0,200,200,true)
		
		for playeritem, index in pairs ( getElementsByType("player") ) do
			if tonumber(westsideGetElementData(index, "fraktion")) == attackerfrac or  tonumber(westsideGetElementData(index, "fraktion")) == owner then
				westsideSetElementData(index, "imGW", true)
			end
		end
		checkForDeath()

		if(area==_G["gangArea1"])then
			baysideGangwar = true
		end
		if(area==_G["gangArea2"])then
			holzfaellerGangwar = true
		end
		if(area==_G["gangArea3"])then
			skaterparkGangwar = true
		end
		if(area==_G["gangArea4"])then
			friedhofGangwar = true
		end
		if(area==_G["gangArea5"])then
			pissgebietGangwar = true
		end
		if(area==_G['gangArea6'])then
			drogenlaborGangwar = true
		end
		if(area==_G['gangArea7'])then
			jizzysGangwar = true
		end
		if(area==_G['gangArea8'])then
			parkGangwar = true
		end
		if(area==_G['gangArea9'])then
			docksGangwar = true
		end
	end,vorbereitungszeit,1)
end

----- Tod checken -----
function checkForDeath ()
	addEventHandler("onPlayerWasted", getRootElement(), function ()
		if tonumber(westsideGetElementData(source,"fraktion")) == attackerfrac then
			defenderpoints = defenderpoints + 1
		elseif tonumber(westsideGetElementData(source,"fraktion")) == owner then
			attackerpoints = attackerpoints + 1
		end
		
		if(getElementData(source,"gotogw")==true)then
			setElementData(source,"gotogw",false)
		end
	end)
end

----- Erobert -----
function areaFinishCheck ( area, attackers, owner, pickup, id )	
	if attackerpoints > defenderpoints then
		westsideSetElementData ( pickup, "gang", attackers )
		MySQL_SetString("gangs", "BesitzerFraktion", attackers, "ID LIKE '"..id.."'")
		
		local r = gangColor[attackers][1]
		local g = gangColor[attackers][2]
		local b = gangColor[attackers][3]
		setRadarAreaColor(area,r,g,b,125)
	
		for id, playeritem in ipairs ( getElementsByType( "player" ) ) do
			if tonumber ( westsideGetElementData ( playeritem, "fraktion" ) ) == tonumber ( attackers ) then
				givePlayerSaveMoney ( playeritem, gangAreaConquerEach )
			end
		end
		
		outputChatBox("#00ffff[Gangfight] #ffffffDie "..gangName[attackerfrac].." haben das Gebiet der "..gangName[owner].." erobert!",root,0,200,200,true)
		outputChatBox("#ffffffPunktestand: #00ffffAngreifer: #ffffff"..attackerpoints.."#00ffff, Verteidiger: #ffffff"..defenderpoints,root,0,200,200,true)	
	else
		local r = gangColor[owner][1]
		local g = gangColor[owner][2]
		local b = gangColor[owner][3]
		setRadarAreaColor(area,r,g,b,125)
	
		outputChatBox("#00ffff[Gangfight] #ffffffDie "..gangName[attackerfrac].." haben das Gebiet der "..gangName[owner].." nicht erobern können!",root,0,200,200,true)
		outputChatBox("#ffffffPunktestand: #00ffffAngreifer: #ffffff"..attackerpoints.."#00ffff, Verteidiger: #ffffff"..defenderpoints,root,0,200,200,true)
	end
	gwstart 			= false
	gangAreaUnderAttack = false
	
	killTimer(victoryTimer)
	westsideSetElementData(pickup,"Blocked",true)
	westsideSetElementData(pickup,"isUnderAttack",false)
	setRadarAreaFlashing(area,false)
	
	attackerpoints = attackerpoints - attackerpoints
	defenderpoints = defenderpoints - defenderpoints
	
	if(baysideGangwar==true)then
		baysideGangwar=false
	end
	if(holzfaellerGangwar==true)then
		holzfaellerGangwar=false
	end
	if(skaterparkGangwar==true)then
		skaterparkGangwar=false
	end
	if(friedhofGangwar==true)then
		friedhofGangwar=false
	end
	if(pissgebietGangwar==true)then
		pissgebietGangwar=false
	end
	if(drogenlaborGangwar==true)then
		drogenlaborGangwar=false
	end
	if(jizzysGangwar==true)then
		jizzysGangwar=false
	end
	if(parkGangwar==true)then
		parkGangwar=false
	end
	if(docksGangwar==true)then
		docksGangwar=false
	end
	
	if(GangwarTime > 0)then
		GangwarTime = 0
	end
	
	GangwarPause = true
	
	setTimer(function()
		GangwarPause = false
	end,300000,1)
end

----- Gebiet zurücksetzen -----
addCommandHandler("areareset",function(player,cmd,area)
	if westsideGetElementData ( player, "adminlvl" ) >= 8 then
		if tonumber(area) then
			if (tonumber(area) > 0) and (tonumber(area) <= 8) then
				if westsideGetElementData (_G["gangPickup"..tonumber(area)], "Blocked") == true then
					westsideSetElementData ( _G["gangPickup"..area], "Blocked", false )

					outputChatBox(getPlayerName(player).." hat den Angriffschutz von Gebiet "..area.." deaktiviert!",root,0,200,200)
				else
					westsideSetElementData ( _G["gangPickup"..area], "Blocked", true )

					outputChatBox(getPlayerName(player).." hat den Angriffschutz von Gebiet "..area.." aktiviert!",root,0,200,200)
				end
			else
				infobox(player,"Nutze /areareset [1-5]",4000,0,100,150)
			end
		else
			infobox(player,"Nutze /areareset [1-5]!",4000,0,100,150)
		end
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end)

----- Zum Gebiet porten -----
addCommandHandler("gotogw",function(player)
	if(isEvil(player))then
		if(tonumber(westsideGetElementData(player,"fraktion"))==attackerfrac)or(tonumber(westsideGetElementData(player,"fraktion"))==owner)then
			if(getElementData(player,"gotogw")==false)then
				if(gangAreaUnderAttack)then
					if(baysideGangwar==true)then
						local spawnPos = math.random(1,5)
						
						if(spawnPos==1)then
							setElementPosition(player,-2371.9475097656,2366.341796875,4.9688649177551)
						elseif(spawnPos==2)then
							setElementPosition(player,-2259.2055664063,2439.6125488281,4.969612121582)
						elseif(spawnPos==3)then
							setElementPosition(player,-2400.818359375,2464.9936523438,11.886539459229)
						elseif(spawnPos==4)then
							setElementPosition(player,-2472.9680175781,2371.9753417969,9.9843816757202)
						elseif(spawnPos==5)then
							setElementPosition(player,-2418.4345703125,2225.7534179688,4.984375)
						end
					end
					if(holzfaellerGangwar==true)then
						local spawnPos = math.random(1,5)
						
						if(spawnPos==1)then
							setElementPosition(player,-635.09662, -86.51125, 64.68660)
						elseif(spawnPos==2)then
							setElementPosition(player,-440.88065, 9.63969, 52.41550)
						elseif(spawnPos==3)then
							setElementPosition(player,-388.73636, -173.56950, 60.53411)
						elseif(spawnPos==4)then
							setElementPosition(player,-557.59833, -229.14442, 71.95148)
						elseif(spawnPos==5)then
							setElementPosition(player,-661.46991, -146.53462, 60.72390)
						end
					end
					if(skaterparkGangwar==true)then
						local spawnPos = math.random(1,5)
						
						if(spawnPos==1)then
							setElementPosition(player,2097.7041015625,-1443.7585449219,23.987194061279)
						elseif(spawnPos==2)then
							setElementPosition(player,1810.9139404297,-1482.2735595703,7.1986112594604)
						elseif(spawnPos==3)then
							setElementPosition(player,1736.4692382813,-1323.9382324219,13.5859375)
						elseif(spawnPos==4)then
							setElementPosition(player,1838.8869628906,-1281.5336914063,13.544870376587)
						elseif(spawnPos==5)then
							setElementPosition(player,1968.2572021484,-1304.4406738281,23.951549530029)
						end
					end
					if(friedhofGangwar==true)then
						local spawnPos = math.random(1,5)
						
						if(spawnPos==1)then
							setElementPosition(player,905.57788085938,-1132.2298583984,23.828125)
						elseif(spawnPos==2)then
							setElementPosition(player,757.74542236328,-1064.0526123047,24.024198532104)
						elseif(spawnPos==3)then
							setElementPosition(player,986.86236572266,-981.9287109375,40.030963897705)
						elseif(spawnPos==4)then
							setElementPosition(player,1008.4115600586,-1125.6264648438,23.899803161621)
						elseif(spawnPos==5)then
							setElementPosition(player,1008.4115600586,-1125.6264648438,23.899803161621)
						end
					end
					if(pissgebietGangwar==true)then
						local spawnPos = math.random(1,5)
						
						if(spawnPos==1)then
							setElementPosition(player,2614.9138183594,2704.935546875,25.822219848633)
						elseif(spawnPos==2)then
							setElementPosition(player,2542.02734375,2852.171875,10.8203125)
						elseif(spawnPos==3)then
							setElementPosition(player,2626.4162597656,2839.9763183594,10.8203125)
						elseif(spawnPos==4)then
							setElementPosition(player,2663.943359375,2714.6181640625,10.8203125)
						elseif(spawnPos==5)then
							setElementPosition(player,2651.2897949219,2758.1513671875,19.322219848633)
						end
					end
					if(drogenlaborGangwar==true)then
						local spawnPos = math.random(1,5)
						
						if(spawnPos==1)then
							setElementPosition(player,-2176.29883, -188.19351, 35.32031)
						elseif(spawnPos==2)then
							setElementPosition(player,-2102.97485, -290.39127, 35.41409)
						elseif(spawnPos==3)then
							setElementPosition(player,-2058.30542, -93.75809, 35.17180)
						elseif(spawnPos==4)then
							setElementPosition(player,-2144.41309, -115.25961, 40.00866)
						elseif(spawnPos==5)then
							setElementPosition(player,-2100.93433, -176.92166, 35.32031)
						end
					end
					if(jizzysGangwar==true)then
						local spawnPos = math.random(1,5)
						
						if(spawnPos==1)then
							setElementPosition(player,-2735.04053, 1334.85559, 3.78980)
						elseif(spawnPos==2)then
							setElementPosition(player,-2631.14966, 1468.69336, 2.97191)
						elseif(spawnPos==3)then
							setElementPosition(player,-2568.27954, 1310.96118, 14.32474)
						elseif(spawnPos==4)then
							setElementPosition(player,-2680.45386, 1262.35278, 16.99777)
						elseif(spawnPos==5)then
							setElementPosition(player,-2660.32520, 1416.86108, 36.93481)
						end
					end
					if(parkGangwar==true)then
						local spawnPos = math.random(1,5)
						
						if(spawnPos==1)then
							setElementPosition(player,-2730.29370, 1079.33228, 47.17254)
						elseif(spawnPos==2)then
							setElementPosition(player,-2855.74463, 938.86780, 44.00132)
						elseif(spawnPos==3)then
							setElementPosition(player,-2917.06641, 1154.52393, 13.53125)
						elseif(spawnPos==4)then
							setElementPosition(player,-2800.54321, 1219.42224, 20.17710)
						elseif(spawnPos==5)then
							setElementPosition(player,-2825.16479, 1102.48499, 27.74219)
						end
					end
					if(docksGangwar==true)then
						local spawnPos = math.random(1,5)
						
						if(spawnPos==1)then
							setElementPosition(player,-1665.06738, -31.30001, 3.56913)
						elseif(spawnPos==2)then
							setElementPosition(player,-1791.21289, -36.41920, 15.28906)
						elseif(spawnPos==3)then
							setElementPosition(player,-1730.58240, 90.04550, 3.55469)
						elseif(spawnPos==4)then
							setElementPosition(player,-1583.19263, 56.04554, 17.32813)
						elseif(spawnPos==5)then
							setElementPosition(player,-1672.36450, 106.03006, 3.55469)
						end
					end
					
					setElementData(player,"gotogw",true)
					
					giveWeapon(player,24,9999,true)
					giveWeapon(player,29,9999,true)
					giveWeapon(player,31,9999,true)
					giveWeapon(player,33,9999,true)
					
					setElementHealth(player,100)
					setPedArmor(player,100)
                    
                    setElementInterior(player,0)
                    setElementDimension(player,0)
					
					if(GangwarTime==10)then
						if(not(ZehnMTimer))then
							ZehnMTimer = setTimer(function()
								setElementData(player,"gotogw",false)
								takeAllWeapons(player)
							end,600000,1)
						end
					elseif(GangwarTime==9)then
						if(not(NeunMTimer))then
							NeunMTimer = setTimer(function()
								setElementData(player,"gotogw",false)
								takeAllWeapons(player)
							end,540000,1)
						end
					elseif(GangwarTime==8)then
						if(not(AchtMTimer))then
							AchtMTimer = setTimer(function()
								setElementData(player,"gotogw",false)
								takeAllWeapons(player)
							end,480000,1)
						end
					elseif(GangwarTime==7)then
						if(not(SiebenMTimer))then
							SiebenMTimer = setTimer(function()
								setElementData(player,"gotogw",false)
								takeAllWeapons(player)
							end,420000,1)
						end
					elseif(GangwarTime==6)then
						if(not(SechsMTimer))then
							SechsMTimer = setTimer(function()
								setElementData(player,"gotogw",false)
								takeAllWeapons(player)
							end,360000,1)
						end
					elseif(GangwarTime==5)then
						if(not(FuenfMTimer))then
							FuenfMTimer = setTimer(function()
								setElementData(player,"gotogw",false)
								takeAllWeapons(player)
							end,300000,1)
						end
					elseif(GangwarTime==4)then
						if(not(VierMTimer))then
							VierMTimer = setTimer(function()
								setElementData(player,"gotogw",false)
								takeAllWeapons(player)
							end,240000,1)
						end
					elseif(GangwarTime==3)then
						if(not(DreiMTimer))then
							DreiMTimer = setTimer(function()
								setElementData(player,"gotogw",false)
								takeAllWeapons(player)
							end,180000,1)
						end
					elseif(GangwarTime==2)then
						if(not(ZweiMTimer))then
							ZweiMTimer = setTimer(function()
								setElementData(player,"gotogw",false)
								takeAllWeapons(player)
							end,120000,1)
						end
					elseif(GangwarTime==1)then
						if(not(EinsMTimer))then
							EinsMTimer = setTimer(function()
								setElementData(player,"gotogw",false)
								takeAllWeapons(player)
							end,60000,1)
						end
					end
				else
					infobox(player,"Es läuft kein Gangwar!",4000,255,0,0)
				end
			else
				infobox(player,"Du hast dich bereits geportet!",4000,255,0,0)
			end
		else
			infobox(player,"Du bist kein Angreifer/Verteidiger!",4000,255,0,0)
		end
	end
end)

----- Gangwar Informationen -----
addCommandHandler("gInfos",function(player)
	if(isEvil(player))then
		outputChatBox("~~~~~ Gangwar Informationen ~~~~~",player,255,255,255)
		outputChatBox("Ein Gangwar dauert 15 Minuten - In dieser Zeit müssen",player,0,200,0)
		outputChatBox("Angreifer wie auch Verteidiger Punkte sammeln, indem",player,0,200,0)
		outputChatBox("sie Kills machen. Mit /gotogw spawnt man mit Waffen",player,0,200,0)
		outputChatBox("in der Nähe des Gebietes.",player,0,200,0)
		outputChatBox("~~~~~ Gangwar Informationen ~~~~~",player,255,255,255)
	end
end)