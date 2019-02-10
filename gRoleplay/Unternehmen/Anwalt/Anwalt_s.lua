local anwaltpickup=createPickup(1721.90381, -1652.41504, 20.06250,3,1239,50)
setElementInterior(anwaltpickup,18)
setElementDimension(anwaltpickup,1)
addEventHandler('onPickupHit',anwaltpickup,function(player)
	if(westsideGetElementData(player,'unternehmen')==2)then
		if(getElementData(player,'aduty')==false)then
			infobox(player,'Tippe /aduty, um den Dienst zu beginnen!')
		else
			infobox(player,'Tippe /aduty, um den Dienst zu verlassen!')
		end
	else
		outputChatBox('Du benötigst einen Anwalt? Dann rufe einen an.',player,0,200,0)
	end
end)

addCommandHandler('aduty',function(player)
	if(westsideGetElementData(player,'unternehmen')==2)then
		if(getDistanceBetweenPoints3D(1721.90381, -1652.41504, 20.06250,getElementPosition(player))<10)then
			if(getElementData(player,'aduty')==false)then
				outputChatBox('Der Anwalt '..getPlayerName(player)..' ist nun im Dienst! [NR]: '..westsideGetElementData(player,'telenr'),root,110,110,100)
				infobox(player,'Du bist nun im Dienst!')
				setElementData(player,'aduty',true)
				outputChatBox('~~~~~ Anwalt ~~~~~',player,255,255,255)
				outputChatBox('Befehle: /aversuch [Spieler]',player,0,200,0)
			else
				outputChatBox('Der Anwalt '..getPlayerName(player)..' ist nun nicht mehr im Dienst!',root,110,110,100)
				infobox(player,'Du bist nun nicht mehr im Dienst!')
				setElementData(player,'aduty',false)
			end
		else
			infobox(player,'Du bist zu weit weg!')
		end
	else
		outputChatBox('Du benötigst einen Anwalt? Dann rufe einen an.',player,0,200,0)
	end
end)

local anwaltRein=createMarker(1381.8000488281,-1088.6999511719,26.39999961853,'cylinder',2,0,0,200)
local anwaltRaus=createMarker(1726.9000244141,-1638.4000244141,19.200000762939,'cylinder',2,0,0,200)
setElementInterior(anwaltRaus,18)
setElementDimension(anwaltRaus,1)
addEventHandler('onMarkerHit',anwaltRein,function(player)
	if(not(isPedInVehicle(player)))then
		fadeElementInterior(player,18,1726.8000488281,-1642.3000488281,20.200000762939,180)
		setElementDimension(player,1)
	end
end)
addEventHandler('onMarkerHit',anwaltRaus,function(player)
	if(getElementDimension(player)==1)then
		fadeElementInterior(player,0,1379.1999511719,-1088.6999511719,27.200000762939,270)
		setElementDimension(player,0)
	end
end)

local anwaltvehicles={
[1]=createVehicle(580,1363.599609375,-1119.7001953125,23.700000762939,0,0,355.99548339844),
[2]=createVehicle(580,1363.099609375,-1127.5,23.700000762939,0,0,355.99548339844),
[3]=createVehicle(580,1370.5,-1135.7001953125,23.700000762939,0,0,87.994995117188),
[4]=createVehicle(580,1379.099609375,-1135.900390625,23.700000762939,0,0,87.994995117188),
}

for i=1,#anwaltvehicles do
	setVehiclePlateText(anwaltvehicles[i],'Anwaltskanzlei'..i)
	setVehicleColor(anwaltvehicles[i],110,110,100)
	setElementFrozen(anwaltvehicles[i],true)
	addEventHandler('onVehicleStartEnter',anwaltvehicles[i],function(player)
		if(getElementData(player,'aduty')==true)then
			setElementFrozen(anwaltvehicles[i],false)
		else
			cancelEvent()
			infobox(player,'Du bist nicht befugt!')
		end
	end)
end

addCommandHandler('aversuch',function(player,cmd,target)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'unternehmen')==2)then
			if(target)then
				local kostenprowntd=200
				local geldprowntd=50
				local tplayer=getPlayerFromName(target)
				local jailtime=westsideGetElementData(tplayer,'jailtime')
				local bankmoney=westsideGetElementData(tplayer,'bankmoney')
				local userkosten=jailtime*kostenprowntd
				local anwaltgeld=jailtime*geldprowntd
				local tx,ty,tz=getElementPosition(tplayer)
				local x,y,z=getElementPosition(player)
				if(bankmoney>=tonumber(userkosten))then
					if(tonumber(westsideGetElementData(tplayer,'jailtime'))>0)then
						if(getDistanceBetweenPoints3D(tx,ty,tz,x,y,z)<10)then
							setElementData(tplayer,'anwaltsgeld',anwaltgeld)
							setElementData(tplayer,'wantedgeld',userkosten)
							setElementData(tplayer,'youranwalt',getPlayerName(player))
							outputChatBox('Du hast '..getPlayerName(tplayer)..' angeboten, zu versuchen, ihn für '..userkosten..'$ aus dem Knast zu holen.',player,0,200,0)
							outputChatBox(getPlayerName(player)..' hat dir angeboten, zu versuchen, dich für '..userkosten..'$ aus dem Knast zu holen.',tplayer,0,200,0)
							outputChatBox('Tippe /aaccept, um das Angebot anzunehmen!',player,0,200,0)
						else
							infobox(player,'Du bist zu weit weg!')
						end
					else
						infobox(player,'Der Spieler ist nicht im Knast!')
					end
				else
					infobox(player,'Der Spieler hat nicht\ngenug Geld auf dem Konto!')
				end
			else
				infobox(player,'Kein Spieler angegeben!')
			end
		end
	end
end)

addCommandHandler('aaccept',function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		local youranwalt=getPlayerFromName(getElementData(player,'youranwalt'))
		local bezahlkosten=getElementData(player,'wantedgeld')
		local anwaltkriegt=getElementData(player,'anwaltsgeld')
		if(youranwalt)then
			local tx,ty,tz=getElementPosition(youranwalt)
			local x,y,z=getElementPosition(player)
			if(getDistanceBetweenPoints3D(tx,ty,tz,x,y,z)<10)then
				if(westsideGetElementData(player,'bankmoney')>=tonumber(bezahlkosten))then
					if(tonumber(westsideGetElementData(player,'jailtime'))>0)then
						givePlayerSaveMoney(youranwalt,anwaltkriegt)
						westsideSetElementData(player,'bankmoney',westsideGetElementData(player,'bankmoney')-bezahlkosten)
						setElementData(player,'wantedgeld',nil)
						setElementData(player,'youranwalt',nil)
						setElementData(player,'anwaltsgeld',nil)
						local chance=math.random(1,3)
						if(chance==2)then
							freePlayerFromJail(player)
							infobox(player,'Der Anwalt hat dich aus\naus dem Knast geholt!')
							infobox(youranwalt,'Du hast '..getPlayerName(player)..'\naus dem Knast geholt!')
						else
							infobox(player,'Das Gericht hat dich nicht\nfreigesprochen!')
							infobox(youranwalt,'Der Spieler '..getPlayerName(player)..'\nwurde vom Gericht nicht freigesprochen!')
						end
					else
						infobox(player,'Du bist nicht im Knast!')
					end
				else
					infobox(player,'Du hast nicht genug Geld auf dem Konto!')
				end
			else
				infobox(player,'Du bist zu weit weg!')
			end
		else
			infobox(player,'Dir wurde nichts angeboten!')
		end
	end
end)