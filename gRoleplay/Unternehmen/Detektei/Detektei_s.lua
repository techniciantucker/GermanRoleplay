local detektiepickup=createPickup(1721.66711, -1652.61340, 20.06250,3,1239,50)
setElementInterior(detektiepickup,18)
setElementDimension(detektiepickup,2)
addEventHandler('onPickupHit',detektiepickup,function(player)
	if(westsideGetElementData(player,'unternehmen')==3)then
		if(getElementData(player,'dduty')==false)then
			infobox(player,'Tippe /dduty, um den Dienst als\nDetektiv zu beginnen!')
		else
			infobox(player,'Tippe /dduty, um den Dienst als\nDetektiv zu verlassen!')
		end
	else
		outputChatBox('Du benötigst einen Detektiv? Dann rufe einen an.',player,0,200,0)
	end
end)

local detekteiRein=createMarker(1413.1999511719,-1487.4000244141,19.39999961853,'cylinder',1.5,0,0,200)
local detekteiRaus=createMarker(1726.9000244141,-1638.4000244141,19.200000762939,'cylinder',2,0,0,200)
setElementInterior(detekteiRaus,18)
setElementDimension(detekteiRaus,2)

addEventHandler('onMarkerHit',detekteiRein,function(player)
	if(not(isPedInVehicle(player)))then
		fadeElementInterior(player,18,1727,-1640.9000244141,20.200000762939,180)
		setElementDimension(player,2)
	end
end)
addEventHandler('onMarkerHit',detekteiRaus,function(player)
	if(getElementDimension(player)==2)then
		fadeElementInterior(player,0,1413.1999511719,-1490,20.39999961853,180)
		setElementDimension(player,0)
	end
end)

local detekteivehicles={
[1]=createVehicle(405,1438.4000244141,-1510.8000488281,13.5,0,0,165.99963378906),
[2]=createVehicle(405,1436.9000244141,-1516.9000244141,13.5,0,0,165.99786376953),
[3]=createVehicle(405,1435.4000244141,-1522.9000244141,13.5,0,0,165.99243164063),
}

for i=1,#detekteivehicles do
	setVehiclePlateText(detekteivehicles[i],'Detektei'..i)
	setVehicleColor(detekteivehicles[i],0,0,0)
	setElementFrozen(detekteivehicles[i],true)
	addEventHandler('onVehicleStartEnter',detekteivehicles[i],function(player)
		if(getElementData(player,'dduty')==true)then
			setElementFrozen(detekteivehicles[i],false)
		else
			cancelEvent()
			infobox(player,'Du bist nicht befugt!')
		end
	end)
end

addCommandHandler('dduty',function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'unternehmen')==3)then
			if(getDistanceBetweenPoints3D(1721.66711, -1652.61340, 20.06250,getElementPosition(player))<10)then
				if(getElementData(player,'dduty')==false)then
					setElementData(player,'dduty',true)
					infobox(player,'Du bist nun im Dienst!')
					giveWeapon(player,43,9999,true)
					outputChatBox('Der Detektiv '..getPlayerName(player)..' ist nun im Dienst! [NR]: '..westsideGetElementData(player,'telenr'),root,110,110,100)
					outputChatBox('~~~~~ Detektei ~~~~~',player,255,255,255)
					outputChatBox('Befehle: /dspec [Spieler]',player,0,200,0)
				else
					setElementData(player,'dduty',false)
					infobox(player,'Du bist nun nicht mehr im Dienst!')
					takeAllWeapons(player)
					outputChatBox('Der Detektiv '..getPlayerName(player)..' ist nun nicht mehr im Dienst!',root,110,110,100)
				end
			else
				infobox(player,'Du bist nicht am Marker!')
			end
		end
	end
end)

addCommandHandler('dspec',function(player,cmd,target)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'unternehmen')==3)then
			if(getElementData(player,'dduty')==true)then
				if(target)then
					local tplayer=getPlayerFromName(target)
					local tx,ty,tz=getElementPosition(tplayer)
					local tplayerort=getZoneName(tx,ty,tz)
					outputChatBox('Der Spieler befindet sich in: '..tplayerort,player,0,200,0)					
				else
					infobox(player,'Kein Spieler angegeben!')
				end
			end
		end
	end
end)