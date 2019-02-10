createBlip(1933.48389, -1864.77222, 13.56194,54,2,255,0,0,255,0,200,root)
createBlip(-2270.64648, -155.92531, 35.32031,54,2,255,0,0,255,0,200,root)
createBlip(1968.82349, 2295.87207, 16.45586,54,2,255,0,0,255,0,200,root)

local gymReinLS=createMarker(1933.48389, -1864.77222, 13.56194,'corona',1,255,255,255)
local gymReinSF=createMarker(-2270.64648, -155.92531, 35.32031,'corona',1,255,255,255)
local gymReinLV=createMarker(1968.82349, 2295.87207, 16.45586,'corona',1,255,255,255)

local gymRausLS=createMarker(772.27637, -5.51471, 1000.72839,'corona',1,255,255,255)

setElementInterior(gymRausLS,5)

function gymRein(player)
	local x,y,z=getElementPosition(player)
	setElementData(player,'posx',x)
	setElementData(player,'posy',y)
	setElementData(player,'posz',z)
	
	fadeElementInterior(player,5,772.20001220703,-2.2000000476837,1000.700012207,0.00274658)
	
	setTimer(function()
		if(westsideGetElementData(player,'Erfolg_Gym')==0)then
			westsideSetElementData(player,'Erfolg_Gym',1)
			triggerClientEvent(player,'erfolgWindow',player,'44er Bizeps')
			westsideSetElementData(player,'pokale',tonumber(westsideGetElementData(player,'pokale'))+1)
			outputLog(getPlayerName(player)..' hat den Erfolg 44er Bizeps freigeschalten!','Erfolge')
		end
	end,5000,1)
end
addEventHandler('onMarkerHit',gymReinLS,gymRein)
addEventHandler('onMarkerHit',gymReinSF,gymRein)
addEventHandler('onMarkerHit',gymReinLV,gymRein)

function gymRaus(player)
	setElementPosition(player,getElementData(player,'posx'),getElementData(player,'posy'),getElementData(player,'posz'))
	setElementInterior(player,0)
end
addEventHandler('onMarkerHit',gymRausLS,gymRaus)