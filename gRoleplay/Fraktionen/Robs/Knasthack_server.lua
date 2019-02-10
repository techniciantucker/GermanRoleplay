----- Variablen -----
local zellenOffen    = false
local knasthackAktiv = false
local knasthackstart = true
local defusenAktiv   = false

----- Marker -----
KnastMarker = createMarker(268.10000610352,92,1000.200012207,"cylinder",1,200,200,0)
setElementInterior(KnastMarker,6)

KnastMarkerSphere = createColSphere (268.10000610352,92,1000.200012207,5)
setElementInterior(KnastMarkerSphere,6)

DeleteTimeMarker = createMarker(248.44391, 87.06098, 1003.61603,"corona",2,0,0,0)
setElementInterior(DeleteTimeMarker,6)
setElementAlpha(DeleteTimeMarker,0)

addEventHandler('onMarkerHit',KnastMarker,function(player)
	if(isCop(player) or isFBI(player) or isArmy(player) and getElementData(player,'onDuty')==true)then
		if(knasthackAktiv==true)then
			infobox(player,'Tippe /stopKnasthack, und halte\ndie Position 15 Sekunden lang!')
		elseif(knasthackAktiv==false and zellenOffen==true)then
			outputChatBox("[INFO]: Der PC wurde gehackt und ist beschädigt! Er setzt sich neu auf,",player,0,100,150)
			outputChatBox("was 5 Minunten dauert! Passt auf, dass nicht noch mehr Spieler flüchten!",player,0,100,150)
		else
			outputChatBox('Der PC arbeitet....',player,250,150,0)
		end
	end
end)

addEventHandler("onMarkerHit",KnastMarker,function(player)
	if isEvil(player) then
		if(not(knasthackAktiv==true))then
			triggerClientEvent(player,"Knasthackopen",player)
		end
	end
end)

addEventHandler("onMarkerHit",DeleteTimeMarker,function(player)
	if(zellenOffen==true)then
		if(westsideGetElementData(player,'jailtime')>=1)then
			removeEventHandler ( "onPlayerCommand", player, disbaleKnastCMD )
			triggerEvent ( "onPlayerGetsFreed", player, player )
			westsideSetElementData ( player, "jailtime", 0 )
			westsideSetElementData ( player, "bail", 0 )
			westsideSetElementData ( player, "jailtime", 0 )
			toggleControl ( player, "enter_exit", true )
			toggleControl ( player, "fire", true )
			toggleControl ( player, "jump", true )
			toggleControl ( player, "action", true )
		end
	end
end)

----- Objekte -----
KnastDoor1 = createObject(2930,266.2998046875,88.400390625,1002.5999755859,0,0,0)
KnastDoor2 = createObject(2930,266.29998779297,83.900001525879,1002.5999755859,0,0,0)
setElementInterior(KnastDoor1,6)
setElementInterior(KnastDoor2,6)

TableKnast = createObject(2370,269.20001220703,91.599998474121,1000,0,0,0)
ComputerKnast = createObject(2190,269.39999389648,92.300003051758,1000.799987793,0,0,288)
setElementInterior(TableKnast,6)
setElementInterior(ComputerKnast,6)

addEvent('Knasthackstart',true)
addEventHandler('Knasthackstart',root,function(player)
	if(isEvil(player))then
		if(getStateFactionMembersOnline()>=2)then
			if(knasthackstart==true)then
				if(knasthackAktiv==false)then
					knasthackAktiv = true
					knasthackstart = false
					
					setTimer(function()
						knasthackstart = true
					end,7200000,1)
					
					outputChatBox("[INFO]: Knasthack gestartet, haltet die Cops 2 Minuten vom Marker fern!",player,0,100,150)
					
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 25)
					
					sendMSGForFaction("[INFO]: Der Knast-PC meldet Probleme! Es wird ein Hacker vermutet!",1,200,200,0)
					sendMSGForFaction("[INFO]: Der Knast-PC meldet Probleme! Es wird ein Hacker vermutet!",6,200,200,0)
					sendMSGForFaction("[INFO]: Der Knast-PC meldet Probleme! Es wird ein Hacker vermutet!",8,200,200,0)
					
					knasthackGeschafft = setTimer(function()
						zellenOffen = true
						knasthackAktiv = false
						
						sendMSGForFaction('[ILLEGAL]: Der Knast wurde gehackt, alle Zellen sind offen!',1,200,0,0)
						sendMSGForFaction('[ILLEGAL]: Der Knast wurde gehackt, alle Zellen sind offen!',2,200,0,0)
						sendMSGForFaction('[ILLEGAL]: Der Knast wurde gehackt, alle Zellen sind offen!',3,200,0,0)
						sendMSGForFaction('[ILLEGAL]: Der Knast wurde gehackt, alle Zellen sind offen!',4,200,0,0)
						sendMSGForFaction('[ILLEGAL]: Der Knast wurde gehackt, alle Zellen sind offen!',6,200,0,0)
						sendMSGForFaction('[ILLEGAL]: Der Knast wurde gehackt, alle Zellen sind offen!',7,200,0,0)
						sendMSGForFaction('[ILLEGAL]: Der Knast wurde gehackt, alle Zellen sind offen!',8,200,0,0)
						sendMSGForFaction('[ILLEGAL]: Der Knast wurde gehackt, alle Zellen sind offen!',9,200,0,0)
						
						westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 250)
						
						moveObject(KnastDoor1,3000,266.29998779297,88.400001525879,1000)
						moveObject(KnastDoor2,3000,266.29998779297,83.900001525879,1000)
						
						setTimer(function()
							if(zellenOffen==true)then
								zellenOffen = false
								moveObject(KnastDoor1,3000,266.2998046875,88.400390625,1002.5999755859)
								moveObject(KnastDoor2,3000,266.29998779297,83.900001525879,1002.5999755859)
							end
						end,300000,1)
						
						outputLog("Der Knast wurde erfolgreiche gehackt.","Robs")
					end,120000,1)
				else
					infobox(player,'Zurzeit nicht möglich!')
				end
			else
				infobox(player,'Zurzeit nicht möglich!')
			end
		else
			infobox(player,'Es müssen 2 Cops online sein!')
		end
	end
end)

addCommandHandler('stopKnasthack',function(player)
	if(isCop(player) or isFBI(player) or isArmy(player) and getElementData(player,'onDuty')==true)then
		if(knasthackAktiv==true)then
			if(zellenOffen==false)then
				if(defusenAktiv==false)then
					defusenAktiv = true
					setElementData(player,'knastDefuser',true)
					infobox(player,'Halt die Position 15 Sekunden lang!')
					
					defuseTimer = setTimer(function()
						if(zellenOffen==true)then
							zellenOffen = false
							moveObject(KnastDoor1,3000,266.2998046875,88.400390625,1002.5999755859)
							moveObject(KnastDoor2,3000,266.29998779297,83.900001525879,1002.5999755859)
						end
							
						defusenAktiv = false
						knasthackAktiv = false
						
						sendMSGForFaction('[ILLEGAL]: Der Knasthack wurde von den Staatsfraktionisten verhindert!',1,0,200,0)
						sendMSGForFaction('[ILLEGAL]: Der Knasthack wurde von den Staatsfraktionisten verhindert!',2,0,200,0)
						sendMSGForFaction('[ILLEGAL]: Der Knasthack wurde von den Staatsfraktionisten verhindert!',3,0,200,0)
						sendMSGForFaction('[ILLEGAL]: Der Knasthack wurde von den Staatsfraktionisten verhindert!',4,0,200,0)
						sendMSGForFaction('[ILLEGAL]: Der Knasthack wurde von den Staatsfraktionisten verhindert!',6,0,200,0)
						sendMSGForFaction('[ILLEGAL]: Der Knasthack wurde von den Staatsfraktionisten verhindert!',7,0,200,0)
						sendMSGForFaction('[ILLEGAL]: Der Knasthack wurde von den Staatsfraktionisten verhindert!',8,0,200,0)
						sendMSGForFaction('[ILLEGAL]: Der Knasthack wurde von den Staatsfraktionisten verhindert!',9,0,200,0)
						
						westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 500)
						
						outputLog(getPlayerName(player).." hat den Knasthack aufgehalten.","Robs")
						
						removeEventHandler('onPlayerWasted',player)
						removeEventHandler('onColShapeLeave',KnastMarkerSphere)
					end,15000,1)
					
					addEventHandler('onPlayerWasted',player,function()
						if(getElementData(player,'knastDefuser')==true)then
							if(defuseTimer)then
								killTimer(defuseTimer)
							end
							setElementData(player,'knastDefuser',false)
							defusenAktiv = false
							removeEventHandler('onPlayerWasted',player)
						end
					end)
					addEventHandler('onColShapeLeave',KnastMarkerSphere,function()
						if(getElementData(player,'knastDefuser')==true)then
							if(defuseTimer)then
								killTimer(defuseTimer)
							end
							setElementData(player,'knastDefuser',false)
							defusenAktiv = false
						end
					end)
				end
			end
		end
	end
end)