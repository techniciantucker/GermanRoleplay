local noobcars={
[1]=createVehicle(510,1564.1999511719,-1880.9000244141,13.199999809265,0,0,0),
[2]=createVehicle(510,1562.1999511719,-1880.9000244141,13.199999809265,0,0,0),
[3]=createVehicle(510,1560.1999511719,-1880.9000244141,13.199999809265,0,0,0),
[4]=createVehicle(510,1558.1999511719,-1880.9000244141,13.199999809265,0,0,0),
[5]=createVehicle(510,1556.1999511719,-1880.9000244141,13.199999809265,0,0,0),
[6]=createVehicle(510,1554.1999511719,-1880.9000244141,13.199999809265,0,0,0),
[7]=createVehicle(510,1552.1999511719,-1880.9000244141,13.199999809265,0,0,0),
[8]=createVehicle(510,1550.1999511719,-1880.9000244141,13.199999809265,0,0,0),
[9]=createVehicle(510,1548.1999511719,-1880.9000244141,13.199999809265,0,0,0),
[10]=createVehicle(510,1546.1999511719,-1880.9000244141,13.199999809265,0,0,0),
[11]=createVehicle(510,1544.1999511719,-1880.9000244141,13.199999809265,0,0,0),
[12]=createVehicle(510,1542.1999511719,-1880.9000244141,13.199999809265,0,0,0),
}

for i=1, #noobcars do
	setVehiclePlateText(noobcars[i],'Noob-Fahrrad'..i)
	setVehicleColor(noobcars[i],255,255,0)
	setElementFrozen(noobcars[i],true)
	
	addEventHandler('onVehicleStartEnter',noobcars[i],function(player)
		if(westsideGetElementData(player,'playingtime')<=600)then
			setElementFrozen(noobcars[i],false)
		else
			cancelEvent()
			infobox(player,'Du hast zu viele Spielstunden!')
		end
	end)
	
	setTimer(function()
		if(getVehicleOccupant(noobcars[i])==false)then
			respawnVehicle(noobcars[i])
		end
	end,1800000,0)
end