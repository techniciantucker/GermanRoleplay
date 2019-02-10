--[[

/dontacceptLizenz
/acceptLizenz
/startLizenz
/stopLizenz
/giveLizenz
/fcommands

]]--

local fuehrerscheinPreis=500
local motorradscheinPreis=400
local motorbootscheinPreis=300
local segelscheinPreis=300
local helischeinPreis=12500
local flugscheinaPreis=20000
local flugscheinbPreis=45000

addCommandHandler('fcommands',function(player)
	if(getElementData(player,'unternehmen')==1)then
		outputChatBox('/startLizenz Spieler, Schein',player,0,255,0)
		outputChatBox('/stopLizenz Spieler',player,0,230,0)
		outputChatBox('/giveLizenz Spieler, Schein',player,0,210,0)
		outputChatBox('/acceptLizenz',player,0,180,0)
		outputChatBox('/dontacceptLizenz',player,0,150,0)
	end
end)

addCommandHandler('giveLizenz',function(player,cmd,target,schein)
	if(getElementData(player,'unternehmen')==1)then
		if(target)then
			local tplayer=getPlayerFromName(target)
			
			if(schein)then
				local fahrschueler=getPlayerFromName(getElementData(player,'fahrschueler'))
				
				if(getPlayerName(fahrschueler)==target)then
					if(schein=='fahrzeugschein')then
						if(westsideGetElementData(tplayer,'carlicense')==0)then
							outputChatBox(getPlayerName(player)..' hat dir den Fahrzeugschein überreicht.',tplayer,0,200,0)
							outputChatBox('Du hast '..getPlayerName(tplayer)..' den Fahrzeugschein überreicht.',player,0,200,0)
							outputChatBox('Tippe nun /stopLizenz, um die Fahrstunde zu beenden.',player,0,150,0)
							
							westsideSetElementData(tplayer,'carlicense',1)
							MySQL_SetString ( "userdata", "Autofuehrerschein", westsideGetElementData ( tplayer, "carlicense" ), "Name LIKE '"..getPlayerName(tplayer).."'")
						else
							outputChatBox('Der Spieler hat bereits einen Fahrzeugschein!',player,200,0,0)
						end
					elseif(schein=='motorradschein')then
						if(westsideGetElementData(tplayer,'bikelicense')==0)then
							outputChatBox(getPlayerName(tplayer)..' hat dir den Motorradschein überreicht.',tplayer,0,200,0)
							outputChatBox('Du hast '..getPlayerName(tplayer)..' den Motorradschein überreicht.',player,0,200,0)
							outputChatBox('Tippe nun /stopLizenz, um die Fahrstunde zu beenden.',player,0,150,0)
						
							westsideSetElementData(tplayer,'bikelicense',1)
							MySQL_SetString("userdata", "Motorradtfuehrerschein", westsideGetElementData ( tplayer, "bikelicense" ), "Name LIKE '"..getPlayerName(tplayer).."'")
						else
							outputChatBox('Der Spieler hat bereits einen Motorradschein!',player,200,0,0)
						end
					elseif(schein=='motorbootschein')then
						if(westsideGetElementData(tplayer,'motorbootlicense')==0)then
							outputChatBox(getPlayerName(player)..' hat dir den Motorbootschein überreicht.',tplayer,0,200,0)
							outputChatBox('Du hast '..getPlayerName(tplayer)..' den Motorbootschein überreicht.',player,0,200,0)
							outputChatBox('Tippe nun /stopLizenz, um die Fahrstunde zu beenden.',player,0,150,0)
							
							westsideSetElementData(tplayer,'motorbootlicense',1)
							MySQL_SetString("userdata", "Motorbootschein", westsideGetElementData ( tplayer, "motorbootlicense" ), "Name LIKE '"..getPlayerName(tplayer).."'")
						else
							outputChatBox('Der Spieler hat bereits einen Motorbootschein!',player,200,0,0)
						end
					elseif(schein=='segelschein')then
						if(westsideGetElementData(tplayer,'segellicense')==0)then
							outputChatBox(getPlayerName(player)..' hat dir den Segelschein überreicht.',tplayer,0,200,0)
							outputChatBox('Du hast '..getPlayerName(tplayer)..' den Segelschein überreicht.',player,0,200,0)
							outputChatBox('Tippe nun /stopLizenz, um die Fahrstunde zu beenden.',player,0,150,0)
							
							westsideSetElementData(tplayer,'segellicense',1)
							MySQL_SetString("userdata", "Segelschein", westsideGetElementData ( tplayer, "segellicense" ), "Name LIKE '"..getPlayerName(tplayer).."'")
						else
							outputChatBox('Der Spieler hat bereits einen Segelschein!',player,200,0,0)
						end
					elseif(schein=='helischein')then
						if(westsideGetElementData(tplayer,'helischein')==0)then
							outputChatBox(getPlayerName(player)..' hat dir den Helischein überreicht.',tplayer,0,200,0)
							outputChatBox('Du hast '..getPlayerName(tplayer)..' den Helischein überreicht.',player,0,200,0)
							outputChatBox('Tippe nun /stopLizenz, um die Fahrstunde zu beenden.',player,0,150,0)
							
							westsideSetElementData(tplayer,'helilicense',1)
							MySQL_SetString("userdata", "Helikopterfuehrerschein", westsideGetElementData ( tplayer, "helilicense" ), "Name LIKE '"..getPlayerName(tplayer).."'")
						else
							outputChatBox('Der Spieler hat bereits einen Helischein!',player,200,0,0)
						end
					elseif(schein=='flugscheina')then
						if(westsideGetElementData(tplayer,'planelicensea')==0)then
							outputChatBox(getPlayerName(player)..' hat dir den Flugschein A überreicht.',tplayer,0,200,0)
							outputChatBox('Du hast '..getPlayerName(tplayer)..' den Flugschein A überreicht.',player,0,200,0)
							outputChatBox('Tippe nun /stopLizenz, um die Fahrstunde zu beenden.',player,0,150,0)
							
							westsideSetElementData(tplayer,'planelicensea',1)
							MySQL_SetString("userdata", "FlugscheinKlasseA", westsideGetElementData ( tplayer, "planelicensea" ), "Name LIKE '"..getPlayerName(tplayer).."'")
						else
							outputChatBox('Der Spieler hat bereits einen Flugschein A!',player,200,0,0)
						end
					elseif(schein=='flugscheinb')then
						if(westsideGetElementData(tplayer,'planelicenseb')==0)then
							outputChatBox(getPlayerName(player)..' hat dir den Flugschein B überreicht.',tplayer,0,200,0)
							outputChatBox('Du hast '..getPlayerName(tplayer)..' den Flugschein B überreicht.',player,0,200,0)
							outputChatBox('Tippe nun /stopLizenz, um die Fahrstunde zu beenden.',player,0,150,0)
							
							westsideSetElementData(tplayer,'planelicenseb',1)
							MySQL_SetString("userdata", "FlugscheinKlasseB", westsideGetElementData ( tplayer, "planelicenseb" ), "Name LIKE '"..getPlayerName(tplayer).."'")
						else
							outputChatBox('Der Spieler hat bereits einen Flugschein B!',player,200,0,0)
						end
					else
						outputChatBox('Diesen Schein gibt es nicht!',player,200,0,0)
					end
				else
					outputChatBox('Der Spieler ist nicht dein Fahrschüler!',player,200,0,0)
				end
			else
				outputChatBox('Kein Schein angegeben (fahrzeugschein/motorradschein/motorbootschein/segelschein/\nhelischein/flugscheina/flugscheinb)!',player,200,0,0)
			end
		else
			outputChatBox('Kein Spieler angegeben!',player,200,0,0)
		end
	end
end)

addCommandHandler('stopLizenz',function(player,cmd,target,grund)
	if(getElementData(player,'fduty')==true)then
		if(target)then
			local tplayer=getPlayerFromName(target)
			
			if(grund)then
				local fahrschueler=getPlayerFromName(getElementData(player,'fahrschueler'))
				
				if(fahrschueler)then
					if(getPlayerName(fahrschueler)==target)then
						outputChatBox(getPlayerName(player)..' hat die Fahrstunde beendet. (Grund: '..grund..')',tplayer,200,0,0)
						outputChatBox('Du hast die Fahrstunde von '..getPlayerName(fahrschueler)..' beendet.',player,200,0,0)
						setElementData(player,'fahrschueler',nil)
						setElementData(tplayer,'fahrlehrer',nil)
					else
						outputChatBox('Der Spieler ist nicht dein Fahrschüler!',player,200,0,0)
					end
				else
					outputChatBox('Du hast keinen Fahrschüler!',player,200,0,0)
				end
			else
				outputChatBox('Kein Grund angegeben!',player,200,0,0)
			end
		else
			outputChatBox('Kein Spieler angegeben!',player,200,0,0)
		end
	end
end)

addCommandHandler('dontacceptLizenz',function(player)
	local fahrlehrer=getPlayerFromName(getElementData(player,'fahrlehrer'))
	
	if(fahrlehrer)then
		if(getElementData(player,'acceptStatus')==true)then
			setElementData(player,'acceptStatus',false)
			setElementData(fahrlehrer,'fahrschueler',nil)
			setElementData(player,'fahrlehrer',nil)
			outputChatBox(getPlayerName(player)..' hat das Angebot abgelehnt.',fahrlehrer,200,0,0)
			outputChatBox('Du hast das Angebot von '..getPlayerName(fahrlehrer)..' abgelehnt.',player,200,0,0)
		end
	else
		outputChatBox('Dir wurde keine Prüfung angeboten!',player,200,0,0)
	end
end)

addCommandHandler('acceptLizenz',function(player)
	local fahrlehrer=getPlayerFromName(getElementData(player,'fahrlehrer'))
	
	if(fahrlehrer)then
		if(getElementData(player,'acceptStatus')==true)then
			setElementData(player,'acceptStatus',false)
		
			if(getElementData(player,'fuehrerschein')==true)then
				money=fuehrerscheinPreis
			elseif(getElementData(player,'motorradschein')==true)then
				money=motorbootscheinPreis
			elseif(getElementData(player,'motorbootschein')==true)then
				money=motorbootscheinPreis
			elseif(getElementData(player,'segelschein')==true)then
				money=segelscheinPreis
			elseif(getElementData(player,'helischein')==true)then
				money=helischeinPreis
			elseif(getElementData(player,'flugscheina')==true)then
				money=flugscheinaPreis
			elseif(getElementData(player,'flugscheinb')==true)then
				money=flugscheinbPreis
			end
			
			if(westsideGetElementData(player,'money')>=money)then
				takePlayerSaveMoney(player,money)
				givePlayerSaveMoney(fahrlehrer,money/4)
				outputChatBox(getPlayerName(fahrlehrer)..' ist nun dein Fahrlehrer, befolge seine Anweisungen.',player,0,200,0)
				outputChatBox(getPlayerName(player)..' hat die Fahrstunde angenommen.',fahrlehrer,0,200,0)
				
				if(getElementData(player,'fuehrerschein')==true)then
					setElementData(player,'fuehrerschein',false)
				elseif(getElementData(player,'motorradschein')==true)then
					setElementData(player,'motorradschein',false)
				elseif(getElementData(player,'motorbootschein')==true)then
					setElementData(player,'motorbootschein',false)
				elseif(getElementData(player,'segelschein')==true)then
					setElementData(player,'segelschein',false)
				elseif(getElementData(player,'helischein')==true)then
					setElementData(player,'helischein',true)
				elseif(getElementData(player,'flugscheina')==true)then
					setElementData(player,'flugscheina',false)
				elseif(getElementData(player,'flugscheinb')==true)then
					setElementData(player,'flugscheinb',false)
				end
			else
				outputChatBox('Du hast nicht genug Geld! ('..money..'$)',player,200,0,0)
			end
		end
	else
		outputChatBox('Dir wurde keine Prüfung angeboten.',player,200,0,0)
	end
end)

addCommandHandler('startLizenz',function(player,cmd,target,schein)
	if(getElementData(player,'fduty')==true)then
		if(target)then
			local tplayer=getPlayerFromName(target)
			
			if(schein)then
				if(not(getElementData(tplayer,'fahrlehrer')))then
					if(not(getElementData(player,'fahrschueler')))then
						if(schein=='fuehrerschein')then
							outputChatBox(getPlayerName(player)..' hat dir eine Prüfung für den Führerschein angeboten.',tplayer,0,200,0)
							outputChatBox('Du hast '..getPlayerName(tplayer)..' eine Prüfung für den Führerschein angeboten.',player,0,200,0)
							
							setElementData(tplayer,'fahrlehrer',getPlayerName(player))
							setElementData(player,'fahrschueler',getPlayerName(tplayer))
							
							outputChatBox('Tippe /acceptLizenz, zum annehmen der Prüfung oder /dontacceptLizenz zum ablehnen.',tplayer,0,200,0)
							
							setElementData(tplayer,'fuehrerschein',true)
							setElementData(tplayer,'acceptStatus',true)
						elseif(schein=='motorradschein')then
							outputChatBox(getPlayerName(player)..' hat dir eine Prüfung für den Motorradschein angeboten.',tplayer,0,200,0)
							outputChatBox('Du hast '..getPlayerName(tplayer)..' eine Prüfung für den Motorradschein angeboten.',player,0,200,0)
							
							setElementData(tplayer,'fahrlehrer',getPlayerName(player))
							setElementData(player,'fahrschueler',getPlayerName(tplayer))
							
							outputChatBox('Tippe /acceptLizenz, zum annehmen der Prüfung oder /dontacceptLizenz zum ablehnen.',tplayer,0,200,0)
							
							setElementData(tplayer,'motorradschein',true)
							setElementData(tplayer,'acceptStatus',true)
						elseif(schein=='motorbootschein')then
							outputChatBox(getPlayerName(player)..' hat dir eine Prüfung für den Motorbootschein angeboten.',tplayer,0,200,0)
							outputChatBox('Du hast '..getPlayerName(tplayer)..' eine Prüfung für den Motorbootschein angeboten.',player,0,200,0)
							
							setElementData(tplayer,'fahrlehrer',getPlayerName(player))
							setElementData(player,'fahrschueler',getPlayerName(tplayer))
							
							outputChatBox('Tippe /acceptLizenz, zum annehmen der Prüfung oder /dontacceptLizenz zum ablehnen.',tplayer,0,200,0)
							
							setElementData(tplayer,'motorbootschein',true)
							setElementData(tplayer,'acceptStatus',true)
						elseif(schein=='segelschein')then
							outputChatBox(getPlayerName(player)..' hat dir eine Prüfung für den Segelschein angeboten.',tplayer,0,200,0)
							outputChatBox('Du hast '..getPlayerName(tplayer)..' eine Prüfung für den Segelschein angeboten.',player,0,200,0)
							
							setElementData(tplayer,'fahrlehrer',getPlayerName(player))
							setElementData(player,'fahrschueler',getPlayerName(tplayer))
							
							outputChatBox('Tippe /acceptLizenz, zum annehmen der Prüfung oder /dontacceptLizenz zum ablehnen.',tplayer,0,200,0)
							
							setElementData(tplayer,'segelschein',true)
							setElementData(tplayer,'acceptStatus',true)
						elseif(schein=='helischein')then
							outputChatBox(getPlayerName(player)..' hat dir eine Prüfung für den Helischein angeboten.',tplayer,0,200,0)
							outputChatBox('Du hast '..getPlayerName(tplayer)..' eine Prüfung für den Helischein angeboten.',player,0,200,0)
							
							setElementData(tplayer,'fahrlehrer',getPlayerName(player))
							setElementData(player,'fahrschueler',getPlayerName(tplayer))
							
							outputChatBox('Tippe /acceptLizenz, zum annehmen der Prüfung oder /dontacceptLizenz zum ablehnen.',tplayer,0,200,0)
							
							setElementData(tplayer,'helischein',true)
							setElementData(tplayer,'acceptStatus',true)
						elseif(schein=='flugscheina')then
							outputChatBox(getPlayerName(player)..' hat dir eine Prüfung für den Flugschein A angeboten.',tplayer,0,200,0)
							outputChatBox('Du hast '..getPlayerName(tplayer)..' eine Prüfung für den Flugschein A angeboten.',player,0,200,0)
							
							setElementData(tplayer,'fahrlehrer',getPlayerName(player))
							setElementData(player,'fahrschueler',getPlayerName(tplayer))
							
							outputChatBox('Tippe /acceptLizenz, zum annehmen der Prüfung oder /dontacceptLizenz zum ablehnen.',tplayer,0,200,0)
							
							setElementData(tplayer,'flugscheina',true)
							setElementData(tplayer,'acceptStatus',true)
						elseif(schein=='flugscheinb')then
							outputChatBox(getPlayerName(player)..' hat dir eine Prüfung für den Flugschein B angeboten.',tplayer,0,200,0)
							outputChatBox('Du hast '..getPlayerName(tplayer)..' eine Prüfung für den Flugschein B angeboten.',player,0,200,0)
							
							setElementData(tplayer,'fahrlehrer',getPlayerName(player))
							setElementData(player,'fahrschueler',getPlayerName(tplayer))
							
							outputChatBox('Tippe /acceptLizenz, zum annehmen der Prüfung oder /dontacceptLizenz zum ablehnen.',tplayer,0,200,0)
							
							setElementData(tplayer,'flugscheinb',true)
							setElementData(tplayer,'acceptStatus',true)
						else
							outputChatBox('Diesen Schein gibt es nicht!',player,200,0,0)
						end
					else
						outputChatBox('Du hast bereits einen Fahrschüler!',player,200,0,0)
					end
				else
					outputChatBox('Der Spieler hat bereits einen Fahrlehrer!',player,200,0,0)
				end
			else
				outputChatBox('Kein Schein angegeben!',player,200,0,0)
			end
		else
			outputChatBox('Kein Spieler angegeben!',player,200,0,0)
		end
	end
end)

local fahrschuleduty=createPickup(-2021.8358154297,-114.70402526855,1035.171875,3,1239,50)
setElementInterior(fahrschuleduty,3)

addEventHandler('onPickupHit',fahrschuleduty,function(player)
	if(getElementData(player,'unternehmen')==1)then
		if(getElementData(player,'fduty')==false)then
			infobox(player,'Tippe /fduty, um den Dienst als\nFahrlehrer zu beginnen.',4000,0,255,0)
		else
			infobox(player,'Tippe /fduty, um den Dienst als\nFahrlehrer zu beenden.',4000,255,0,0)
		end
	else
		outputChatBox('Du möchtest Scheine billiger bekommen? Dann ruf einen Fahrlehrer an.',player,0,200,0)
	end
end)

addCommandHandler('fduty',function(player)
	if(getElementData(player,'unternehmen')==1)then
		if(getDistanceBetweenPoints3D(-2021.8358154297,-114.70402526855,1035.171875,getElementPosition(player))<10)then
			if(getElementData(player,'fduty')==false)then
				setElementData(player,'fduty',true)
				infobox(player,'Du bist nun im Dienst!',4000,0,255,0)
				outputChatBox('Der Fahrlehrer '..getPlayerName(player)..' hat den Dienst begonnen! [NR]: '..westsideGetElementData(player,'telenr'),root,255,255,0)
			else
				setElementData(player,'fduty',false)
				infobox(player,'Du bist nun nicht mehr im Dienst!',4000,255,0,0)
				outputChatBox('Der Fahrlehrer '..getPlayerName(player)..' hat den Dienst verlassen!',root,255,255,0)
			end
		end
	end
end)

setTimer(function()

local fahrschulvehicles={
	[1]=createVehicle(487,1056.0999755859,-1680.3000488281,18.39999961853,0,0,270), 			-- Maverick
	[2]=createVehicle(461,1104.9000244141,-1686.8000488281,13.60000038147,0,0,293.99963378906), -- Motorrad
	[3]=createVehicle(405,1095.9000244141,-1693.1999511719,13.89999961853,0,0,0), 				-- Auto
	[4]=createVehicle(487,1056.0999755859,-1692,18.39999961853,0,0,270), 						-- Maverick
	[5]=createVehicle(461,1104.6999511719,-1684.5999755859,13.60000038147,0,0,294), 			-- Motorrad
	[6]=createVehicle(405,1099.1999511719,-1693.1999511719,13.89999961853,0,0,0), 				-- Auto
}

for i=1,#fahrschulvehicles do
	setVehiclePlateText(fahrschulvehicles[i],'Fahrschule'..i)
	setVehicleColor(fahrschulvehicles[i],255,255,255)
	setElementFrozen(fahrschulvehicles[i],true)
	addEventHandler('onVehicleStartEnter',fahrschulvehicles[i],function(player)
		if(getElementData(player,'fduty')==true)or(getElementData(player,'fahrlehrer'))then
			setElementFrozen(fahrschulvehicles[i],false)
		else
			cancelEvent()
			infobox(player,'Du bist nicht befugt!',4000,255,0,0)
		end
	end)
end

end,5000,1)