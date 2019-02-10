----- Pizzadienst -----
addCommandHandler("pizza",function(player)
	if tonumber(westsideGetElementData ( player, "pizzadienst" )) == 1 then
		if(getElementData(player,'pizzabestellt')==false)then
			local x,y,z = getElementPosition(player)
			_G["Pizzaboy"..getPlayerName(player)] = createVehicle(448,x,y,z)
			_G["Ped"..getPlayerName(player)] = createPed(155,x,y,z)
			setElementData(player,'pizzabestellt',true)
			warpPedIntoVehicle(_G["Ped"..getPlayerName(player)],_G["Pizzaboy"..getPlayerName(player)])
			setTimer(function()
				_G["Pizza"..getPlayerName(player)] = createPickup(x,y,z,3,1582,500)
				
				addEventHandler("onPickupHit",_G["Pizza"..getPlayerName(player)],function(player)
					setElementHealth(player,100)
					destroyElement(_G["Pizza"..getPlayerName(player)])
					setElementData(player,'pizzabestellt',false)
					westsideSetElementData(player,'hunger',100)
				end)
				
				destroyElement(_G["Pizzaboy"..getPlayerName(player)])
				destroyElement(_G["Ped"..getPlayerName(player)])
			end,5000,1)
		else
			infobox(player,'Sammel erst die Pizz ein!')
		end
	else
		infobox(player,"Du hast keinen Pizzadienst!",4000,255,0,0)
	end
end)

----- Executecommand -----
function executeCommand_func ( player, cmd)
	if player == client then
		if cmd == "grow" then
			grow_func ( player, "grow", "weed" )
		else
			local proceed = true
			for i = 1, 6 do
				-- //
			end
			if proceed then
				executeCommandHandler ( cmd, player )
			end
		end
		triggerClientEvent ( player, "refreshItems", getRootElement() )
	end
end
addEvent ( "executeCommand", true )
addEventHandler ( "executeCommand", getRootElement(), executeCommand_func )

----- Würfeln -----
addCommandHandler("dice",function(player)
	if westsideGetElementData(player,"dice") == 1 then
		zahl = math.random(1,6)
		infobox(player,"Du hast eine "..zahl.." gewürfelt!",4000,0,255,0)
		executeCommandHandler ( "meCMD", player, " hat eine "..zahl.." gewürfelt!" )
	else
		infobox(player,"Du hast keinen Würfel!",4000,255,0,0)
	end
end)

----- Wegwerfen -----
addEvent("throw",true)
addEventHandler("throw",root,function(player,cmd,item)
	if player == client then
		if item == "mats" then
			westsideSetElementData ( player, "mats", 0 )
			executeCommandHandler ( "meCMD", player, " wirft einige Materialien weg..." )
			outputChatBox ( "[INFO]: Du hast deine Materialien weggeworfen!", player, 0,100,150 )
		elseif item == "drugs" then
			westsideSetElementData ( player, "drugs", 0 )
			executeCommandHandler ( "meCMD", player, " wirft einige Drogen weg..." )
			outputChatBox ( "[INFO]: Du hast deine Drogen weggeworfen!", player, 0,100,150 )
		elseif item == "fuel" then
			westsideSetElementData ( player, "benzinkannister", 0 )
			outputChatBox ( "[INFO]: Du hast deinen Benzinkannister weggeworfen!", player, 0,100,150 )
		elseif item == "dice" then
			westsideSetElementData ( player, "dice", 0 )
			outputChatBox ( "[INFO]: Du hast deinen Würfen weggeworfen!", player,0,100,150 )
		elseif item == "zigaretten" then
			westsideSetElementData ( player, "zigaretten", 0 )
			outputChatBox ( "[INFO]: Du hast deine Zigaretten weggeworfen!", player, 0,100,150)
		elseif item == "flowerseeds" then
			westsideSetElementData ( player, "flowerseeds", 0 )
			outputChatBox ( "[INFO]: Du hast deine Hanfsamen weggeworfen!", player, 0,100,150 )
			executeCommandHandler ( "meCMD", player, " wirft einige Hanfsamen weg..." )
		else
			infobox(player,"Dieses Item kannst\ndu nicht wegwerfen!",4000,255,0,0)
		end
	end
end)

addCommandHandler('geben',function(player,cmd,target,artikel,anzahl)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(target)then
			local tplayer = getPlayerFromName(target)
			
			if(artikel)then
				if(anzahl)then
					if(artikel=='weed')then
						if(westsideGetElementData(player,'drugs')>=tonumber(anzahl))then
							infobox(player,'Du hast '..getPlayerName(tplayer)..'\n'..anzahl..'g Weed gegeben!')
							infobox(tplayer,'Du hast von '..getPlayerName(player)..'\n'..anzahl..'g Weed bekommen!')
							
							westsideSetElementData(player,'drugs',tonumber(westsideGetElementData(player,'drugs')) - anzahl)
							westsideSetElementData(tplayer,'drugs',tonumber(westsideGetElementData(tplayer,'drugs')) + anzahl)
						else
							infobox(player,'Du hast nicht genug Weed!')
						end
					elseif(artikel=='bombe')then
						if(westsideGetElementData(player,'bomben')>=tonumber(anzahl))then
							infobox(player,'Du hast '..getPlayerName(tplayer)..'\m'..anzahl..' Bomben gegeben!')
							infobox(tplayer,'Du hast von '..getPlayerName(player)..'\m'..anzahl..' Bomben bekommen!')
							
							westsideSetElementData(player,'bomben',tonumber(westsideGetElementData(player,'bomben')) - anzahl)
							westsideSetElementData(tplayer,'bomben',tonumber(westsideGetElementData(tplayer,'bomben')) + anzahl)
						else
							infobox(player,'Du hast nicht genug Bomben!')
						end
					elseif(artikel=='mats')then
						if(westsideGetElementData(player,'mats')>=tonumber(anzahl))then
							infobox(player,'Du hast '..getPlayerName(tplayer)..'\m'..anzahl..' Mats gegeben!')
							infobox(tplayer,'Du hast von '..getPlayerName(player)..'\m'..anzahl..' Mats bekommen!')
							
							westsideSetElementData(player,'mats',tonumber(westsideGetElementData(player,'mats')) - anzahl)
							westsideSetElementData(tplayer,'mats',tonumber(westsideGetElementData(tplayer,'mats')) + anzahl)
						else
							infobox(player,'Du hast nicht genug Mats!')
						end
					elseif(artikel=='kanister')then
						if(westsideGetElementData(player,'benzinkannister')>=tonumber(anzahl))then
							if(westsideGetElementData(tplayer,'benzinkannister')<5)then
								infobox(player,'Du hast '..getPlayerName(tplayer)..'\m'..anzahl..' Kanister gegeben!')
								infobox(tplayer,'Du hast von '..getPlayerName(player)..'\m'..anzahl..' Kanister bekommen!')
								
								westsideSetElementData(player,'benzinkannister',tonumber(westsideGetElementData(player,'benzinkannister')) - anzahl)
								westsideSetElementData(tplayer,'benzinkannister',tonumber(westsideGetElementData(tplayer,'benzinkannister')) + anzahl)
							else
								infobox(player,'Der Spieler hat schon 5 Kanister!')
							end
						else
							infobox(player,'Du hast nicht genug Mats!')
						end
					else
						outputChatBox('Mögliche Handelgegenstände: [weed/bombe/mats/kanister]!',player,0,200,0)
					end
				else
					infobox(player,'Keine Anzahl angegeben!')
				end
			else
				infobox(player,'Kein Gegenstand angegeben!')
				outputChatBox('Mögliche Handelgegenstände: [weed/bombe/mats/kanister]!',player,0,200,0)
			end
		else
			infobox(player,'Keinen Spieler angegeben!')
		end
	end
end)

----- Drogen nehmen -----
addCommandHandler('usedrugs',function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'drugs')>=2)then
			outputChatBox('Du hast 2g Weed geraucht, dein Drogenpegel steigt..',player,200,0,0)
			westsideSetElementData(player,'drugs',westsideGetElementData(player,'drugs')-2)
			if(westsideGetElementData(player,'hunger')<100)then
				westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))+5)
			end
			if(westsideGetElementData(player,'drogenPegel')<100)then
				westsideSetElementData(player,'drogenPegel',tonumber(westsideGetElementData(player,'drogenPegel'))+10)
			end
		else
			infobox(player,'Du brauchst mindestens 2g!')
		end
	end
end)