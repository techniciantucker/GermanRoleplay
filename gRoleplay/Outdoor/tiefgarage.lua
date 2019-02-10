local tgaragerein = createMarker(1412.9000244141,-1649,12.5,"cylinder",5,0,200,200)
local tgarageraus = createMarker(1326.0999755859,-1682.0999755859,-75.599998474121,"cylinder",5,0,200,200)

addEventHandler("onMarkerHit",tgaragerein,function(player)
	triggerClientEvent(player,"newloadscreen",player)
	
	setTimer(function()
		setElementData(player,"inTiefgarage",true)
		infobox(player,"Willkommen in der Tiefgarage\nvon Commerce!")
		setElementPosition(player,1343,-1673.4000244141,-74.699996948242)
		setElementRotation(player,0,0,0)
	end,4000,1)
end)

addEventHandler("onMarkerHit",tgarageraus,function(player)
	triggerClientEvent(player,"newloadscreen",player)

	setTimer(function()
		setElementData(player,"inTiefgarage",false)
		infobox(player,"Auf wiedersehen!")
		setElementPosition(player,1423.6999511719,-1644.8000488281,13.39999961853)
		setElementRotation(player,0,0,304)
	end,4000,1)
end)