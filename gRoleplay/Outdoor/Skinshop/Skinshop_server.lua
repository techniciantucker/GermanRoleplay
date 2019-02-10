createBlip(461.39999389648,-1500.8000488281,31.04588508606, 45, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(477.42919921875,-1534.5981445313,19.669803619385, 45, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(499.48403930664,-1360.6166992188,16.369129180908, 45, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(2244.2758789063,-1665.5360107422,15.4765625, 45, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(-1882.2955322266,866.54260253906,35.171875, 45, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(-1694.5063476563,951.84637451172,24.890625, 45, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(-2373.7780761719,910.11846923828,45.4453125, 45, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(2112.9284667969,-1211.4588623047,23.962869644165, 45, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(-2489.861328125,-29.028966903687,25.6171875, 45, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(2779.8171386719,2453.8310546875,11.0625, 45, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(2802.9311523438,2430.7153320313,11.0625, 45, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(1657.0363769531,1733.3309326172,10.82811164856, 45, 2, 255, 0, 0, 255, 0, 200,root)
createBlip(2101.8933105469,2257.4916992188,11.0234375, 45, 2, 255, 0, 0, 255, 0, 200,root)

local skinshopMarker={
[1]=createPickup(461.39999389648,-1500.8000488281,31.04588508606,3,1318,50),
[2]=createPickup(477.42919921875,-1534.5981445313,19.669803619385,3,1318,50),
[3]=createPickup(499.48403930664,-1360.6166992188,16.369129180908,3,1318,50),
[4]=createPickup(2244.2758789063,-1665.5360107422,15.4765625,3,1318,50),
[5]=createPickup(-1882.2955322266,866.54260253906,35.171875,3,1318,50),
[6]=createPickup(-1694.5063476563,951.84637451172,24.890625,3,1318,50),
[7]=createPickup(-2373.7780761719,910.11846923828,45.4453125,3,1318,50),
[8]=createPickup(2112.9284667969,-1211.4588623047,23.962869644165,3,1318,50),
[9]=createPickup(-2489.861328125,-29.028966903687,25.6171875,3,1318,50),
[10]=createPickup(2779.8171386719,2453.8310546875,11.0625,3,1318,50),
[11]=createPickup(2802.9311523438,2430.7153320313,11.0625,3,1318,50),
[12]=createPickup(1657.0363769531,1733.3309326172,10.82811164856,3,1318,50),
[13]=createPickup(2101.8933105469,2257.4916992188,11.0234375,3,1318,50),
}

for i, SkinMarker in pairs(skinshopMarker)do
	addEventHandler('onPickupHit',SkinMarker,function(player)
		if(not(isPedInVehicle(player)))then
			local x,y,z=getElementPosition(player)
			setElementData(player,'saveposx',x)
			setElementData(player,'saveposy',y)
			setElementData(player,'saveposz',z)
			fadeElementInterior(player,5,224.21118164063,-8.0980434417725,1002.2109375)
			setElementDimension(player,i)
			
			SkinMarkerRaus=createPickup(227.69999694824,-8.1999998092651,1002.2109375,3,1318,50)
			setElementInterior(SkinMarkerRaus,5)
			setElementDimension(SkinMarkerRaus,i)
			SkinKaufen=createMarker(206.3740234375 , -7.2646484375 , 1000.3109375,'cylinder',1,0,0,200)
			setElementInterior(SkinKaufen,5)
			setElementDimension(SkinKaufen,i)
			
			addEventHandler('onMarkerHit',SkinKaufen,skinshop_open)
			addEventHandler('onPickupHit',SkinMarkerRaus,skinshop_leave)
		end
	end)
end

function skinshop_leave(player)
	setElementPosition(player,getElementData(player,'saveposx'),getElementData(player,'saveposy'),getElementData(player,'saveposz'))
	setElementDimension(player,0)
	setElementInterior(player,0)
	setElementData(player,'saveposx',nil)
	setElementData(player,'saveposy',nil)
	setElementData(player,'saveposz',nil)
end

function skinshop_open(player)
	triggerClientEvent(player,'open_skinshop',player)
end

addEvent('skinchange',true)
addEventHandler('skinchange',root,function(player,skinid,preis)
	setCameraTarget(player,player)
	local skinid = tonumber(skinid)
	local preis = tonumber(preis)
	setElementPosition(player,204.2998046875, -12.3447265625, 1001.2109375)
	setCameraTarget(player,player)
	if tonumber(westsideGetElementData(player,'money')) >= preis then
		takePlayerSaveMoney(player,preis)
		westsideSetElementData(player,'skinid',skinid)
		setElementModel(player,skinid)
	else
		infobox(player,'Du hast nicht genug Geld!')
	end
end)

addEvent('dont_skinbuy',true)
addEventHandler('dont_skinbuy',root,function(player)
	setElementPosition(player,204.2998046875, -12.3447265625, 1001.2109375)
	setCameraTarget(player,player)
end)

function skinklauenserver(player,skinid)
	setCameraTarget(player,player)
	local skinid = tonumber(skinid)
	setElementPosition(player,204.2998046875, -12.3447265625, 1001.2109375)
	setCameraTarget(player,player)
	westsideSetElementData(player,'skinid',skinid)
	setElementModel(player,skinid)
	if(westsideGetElementData(player,'wanteds')==5)then
		westsideSetElementData(player,'wanteds',6)
	else
		westsideSetElementData(player,'wanteds',westsideGetElementData(player,'wanteds')+1)
	end
end
addEvent("skinKlauen", true)
addEventHandler("skinKlauen", getRootElement(),skinklauenserver)