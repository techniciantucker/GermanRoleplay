-- Weste
addEvent("weste",true)
addEventHandler("weste",root,function(player)
	if westsideGetElementData(player,"erfahrungspunkte") >= 50 then
		setPedArmor(player,100)
		infobox(player,"Artikel gekauft!",4000,0,255,0)
		westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) - 50)
	else
		infobox(player,"Du hast nicht genug EXP!",4000,255,0,0)
	end
end)

-- Leben
addEvent("leben",true)
addEventHandler("leben",root,function(player)
	if westsideGetElementData(player,"erfahrungspunkte") >= 50 then
		setElementHealth(player,100)
		infobox(player,"Artikel gekauft!",4000,0,255,0)
		westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) - 50)
	else
		infobox(player,"Du hast nicht genug EXP!",4000,255,0,0)
	end
end)

-- M4
addEvent("m4",true)
addEventHandler("m4",root,function(player)
	if westsideGetElementData(player,"erfahrungspunkte") >= 250 then
		if(westsideGetElementData(player,"gunlicense")==1)then
			giveWeapon(player,30,50,true)
			infobox(player,"Artikel gekauft!",4000,0,255,0)
			westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) - 250)
		else
			infobox(player,"Du hast keinen Waffenschein!",4000,255,0,0)
		end
	else
		infobox(player,"Du hast nicht genug EXP!",4000,255,0,0)
	end
end)

-- Deagle
addEvent("deagle",true)
addEventHandler("deagle",root,function(player)
	if westsideGetElementData(player,"erfahrungspunkte") >= 250 then
		if(westsideGetElementData(player,"gunlicense")==1)then
			giveWeapon(player,24,7,true)
			infobox(player,"Artikel gekauft!",4000,0,255,0)
			westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) - 250)
		else
			infobox(player,"Du hast keinen Waffenschein!",4000,255,0,0)
		end
	else
		infobox(player,"Du hast nicht genug EXP!",4000,255,0,0)
	end
end)

-- Mp5
addEvent("mp5",true)
addEventHandler("mp5",root,function(player)
	if westsideGetElementData(player,"erfahrungspunkte") >= 250 then
		if(westsideGetElementData(player,"gunlicense")==1)then
			giveWeapon(player,29,30,true)
			infobox(player,"Artikel gekauft!",4000,0,255,0)
			westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) - 250)
		else
			infobox(player,"Du hast keinen Waffenschein!",4000,255,0,0)
		end
	else
		infobox(player,"Du hast nicht genug EXP!",4000,255,0,0)
	end
end)

-- Rifle
addEvent("rifle",true)
addEventHandler("rifle",root,function(player)
	if westsideGetElementData(player,"erfahrungspunkte") >= 250 then
		if(westsideGetElementData(player,"gunlicense")==1)then
			giveWeapon(player,31,20,true)
			infobox(player,"Artikel gekauft!",4000,0,255,0)
			westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) - 250)
		else
			infobox(player,"Du hast keinen Waffenschein!",4000,255,0,0)
		end
	else
		infobox(player,"Du hast nicht genug EXP!",4000,255,0,0)
	end
end)

-- Fahrzeugslots
addEvent("fahrzeugslots",true)
addEventHandler("fahrzeugslots",root,function(player)
	if westsideGetElementData(player,"carslotupgrade") == 1 then
		infobox(player,"Du hast diesen Artikel bereits!",4000,255,0,0)
	else
		if westsideGetElementData(player,"erfahrungspunkte") >= 25000 then
			infobox(player,"Artikel gekauft!",4000,0,255,0)
			outputChatBox("Du kannst nun insgesamt 10 Fahrzeuge besitzen!",player)
			westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) - 25000)
			westsideSetElementData(player,'carslotupgrade',1)
			westsideSetElementData(player,"maxcars",10)
		
			westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 250)
			outputLog("[BONUSSHOP]: "..getPlayerName(player).." hat sich Fahrzeugslots gekauft!","Bonusshop")
		else
			infobox(player,"Du hast nicht genügend EXP!",4000,255,0,0)
		end
	end
end)

-- Max Autos setzen
function setMaximumCarsForPlayer(player)
	if(westsideGetElementData(player,'carslotupgrade')==1)then
		max = 10
	else
		max = 3
	end
	westsideSetElementData(player,"maxcars",max)
end

-- Knastzeit
addEvent("knastzeit",true)
addEventHandler("knastzeit",root,function(player)
	if westsideGetElementData(player,"jailtime") > 2 then
		infobox(player,"Deine Knastzeit wurde um\n2 Minuten verkürtzt!")
		westsideSetElementData(player,"jailtime",tonumber(westsideGetElementData(player,"jailtime")) - 2)
		westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) - 500)
	else
		infobox(player,"Nicht möglich, da du weniger\nals 3 Minuten hast, oder\nnicht im Gefängnis bist!")
	end
end)