local levelTable = {
[1]  =  5000,
[2]  = 10000,
[3]  = 15000,
[4]  = 20000,
[5]  = 25000,
[6]  = 30000,
[7]  = 35000,
[8]  = 40000,
[9]  = 45000,
[10] = 50000,
[11] = 55000,
[12] = 60000,
[13] = 65000,
[14] = 70000,
[15] = 75000,
[16] = 80000,
[17] = 85000,
[18] = 90000,
[19] = 95000,
[20] = 100000,
[21] = 115000,
[22] = 135000,
[23] = 150000,
[24] = 170000,
[25] = 200000
}

-- Level kaufen --
addEvent("levelKaufen",true)
addEventHandler("levelKaufen",getRootElement(),function(player)

	local lvl = westsideGetElementData(player,"level")
	local money = tonumber(westsideGetElementData(player,"money"))

	local price = levelTable[tonumber(getElementData(player,"level")) +1]

	if westsideGetElementData(player,"loggedin") == 1 then
	
		if getElementData(player,"level") <= 25 then
		
			if money >= price then

				if westsideGetElementData(player,"erfahrungspunkte") >= 1000 then
				
					takePlayerSaveMoney(player,price)
					westsideSetElementData(player,"level",tonumber(westsideGetElementData(player,"level")) + 1)
					westsideSetElementData(player,"erfahrungspunkte",westsideGetElementData(player,"erfahrungspunkte") - 1000)
					
					infobox(player,"Du hast dir ein Level-Up gekauft!\nKosten: "..price.." & 1000 EP",4000,0,255,0)
					
					if(westsideGetElementData(player,'level')==25)then
						if(westsideGetElementData(player,'Erfolg_EndlichLevel25')==0)then
							westsideSetElementData(player,'Erfolg_EndlichLevel25',1)
							triggerClientEvent(player,'erfolgWindow',player,'Endlich Level 25')
							westsideSetElementData(player,'pokale',tonumber(westsideGetElementData(player,'pokale'))+1)
							outputLog(getPlayerName(player)..' hat den Erfolg Endlich Level 25 freigeschalten!','Erfolge')
						end
					end
					
					outputLog("[LEVEL]: "..getPlayerName(player).." hat sich ein Level Up gekauft!","Levelsystem")
					
				else
					infobox(player,"Du hast nicht genug EP!\n(1000 EP)",4000,255,0,0)
				end
			else
				infobox(player,"Du hast nicht genug Geld!\n("..price.."$)",4000,255,0,0)
			end
		else
			infobox(player,"Du hast bereits das\nhöchste Level!",4000,255,0,0)
		end
	end
end)