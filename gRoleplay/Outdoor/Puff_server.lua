PuffBlip = createBlip (2421.55737, -1219.24329, 25.56156, 21, 2, 255, 0, 0, 255, 0, 200, getRootElement() )

----------------
-- Teleporter --
----------------

GoIntoThePuff = createPickup(2421.55737, -1219.24329, 25.56156,3,1318,500)
GoOutThePuff = createPickup(1210.8000488281,5.5999999046326,1000.9000244141,3,1318,500)
setElementInterior(GoOutThePuff,2)

-- Rein --
addEventHandler("onPickupHit",GoIntoThePuff,function(player,dim)
	if isPedInVehicle (player) == false then
		fadeElementInterior(player,2,1210.8000488281,3.2999999523163,1000.9000244141,180)
		infobox(player,"Willkommen im Puff!",4000,200,0,200)
	end
end)

-- Raus --
addEventHandler("onPickupHit",GoOutThePuff,function(player,dim)
	if isPedInVehicle (player) == false then
		fadeElementInterior(player,0,2421.6000976563,-1221.9000244141,25.39999961853,180)
		infobox(player,"Bis bald...",4000,200,0,200)
	end
end)

------------
-- Nutten --
------------

Nutte1 = createPed(244,1208.2998046875,-6.2001953125,1001.299987793,0.00274658)
Nutte2 = createPed(178,1213.0999755859,-3.7000000476837,1001.299987793,0.00274658)
Nutte3 = createPed(178,1222.9000244141,-1.7999999523163,1001.299987793,58.0027465)
Nutte4 = createPed(152,1220.9000244141,8.1000003814697,1001.299987793,140.003662)

setTimer(setPedAnimation, 2000, 1,Nutte1,"STRIP","STR_C1")			-- Da die Animation nicht von alleine startet, wird sie durch einen Timer gestertet,
setTimer(setPedAnimation, 2000, 1,Nutte2,"STRIP","STR_A2B")			-- welcher die Animation direkt nach Start des Script startet. Leider nicht anders
setTimer(setPedAnimation, 2000, 1,Nutte3,"STRIP","strip_D")			-- lösbar ... warum auch immer.
setTimer(setPedAnimation, 2000, 1,Nutte4,"DANCING","DAN_Down_A")

setPedFrozen(Nutte1,true)
setPedFrozen(Nutte2,true)
setPedFrozen(Nutte3,true)
setPedFrozen(Nutte4,true)

setElementInterior(Nutte1,2)
setElementInterior(Nutte2,2)
setElementInterior(Nutte3,2)
setElementInterior(Nutte4,2)

-- Nutte 1 --
function KillNutte1(ammu,player)
	if player then
		destroyElement(Nutte1)

		Nutte1 = createPed(244,1208.2998046875,-6.2001953125,1001.299987793,0.00274658)
		setElementInterior(Nutte1,2)
	
		setPedFrozen(Nutte1,true)
		setPedAnimation(Nutte1,"STRIP","STR_C1")
		addEventHandler("onPedWasted",Nutte1,KillNutte1)
		addEventHandler("onElementClicked",Nutte1,Nutte1Klick)
		
		if westsideGetElementData(player,"money") >= 150 then
			outputChatBox("[INFO]: Da du eine Angestellte verletzt hast, musstest du 150$ zahlen!",player,0,100,150)
			takePlayerSaveMoney(player,150)
		else
			outputChatBox("[INFO]: Du wurdest aus dem Club geworfen!",player,0,100,150)
			fadeElementInterior(player,0,2421.6000976563,-1221.9000244141,25.39999961853,180)
		end
	end
end
addEventHandler("onPedWasted",Nutte1,KillNutte1)

-- Nutte 2 --
function KillNutte2(ammu,player)
	if player then
		destroyElement(Nutte2)

		Nutte2 = createPed(178,1213.0999755859,-3.7000000476837,1001.299987793,0.00274658)
		setElementInterior(Nutte2,2)
	
		setPedFrozen(Nutte2,true)
		setPedAnimation(Nutte2,"STRIP","STR_A2B")
		addEventHandler("onPedWasted",Nutte2,KillNutte2)
		addEventHandler("onElementClicked",Nutte2,Nutte2Klick)
		
		if westsideGetElementData(player,"money") >= 150 then
			outputChatBox("[INFO]: Da du eine Angestellte verletzt hast, musstest du 150$ zahlen!",player,0,100,150)
			takePlayerSaveMoney(player,150)
		else
			outputChatBox("[INFO]: Du wurdest aus dem Club geworfen!",player,0,100,150)
			fadeElementInterior(player,0,2421.6000976563,-1221.9000244141,25.39999961853,180)
		end
	end
end
addEventHandler("onPedWasted",Nutte2,KillNutte2)

-- Nutte 3 --
function KillNutte3(ammu,player)
	if player then
		destroyElement(Nutte3)

		Nutte3 = createPed(178,1222.9000244141,-1.7999999523163,1001.299987793,58.0027465)
		setElementInterior(Nutte3,2)
	
		setPedFrozen(Nutte3,true)
		setPedAnimation(Nutte3,"STRIP","strip_D")
		addEventHandler("onPedWasted",Nutte3,KillNutte3)
		addEventHandler("onElementClicked",Nutte3,Nutte3Klick)
		
		if westsideGetElementData(player,"money") >= 150 then
			outputChatBox("[INFO]: Da du eine Angestellte verletzt hast, musstest du 150$ zahlen!",player,0,100,150)
			takePlayerSaveMoney(player,150)
		else
			outputChatBox("[INFO]: Du wurdest aus dem Club geworfen!",player,0,100,150)
			fadeElementInterior(player,0,2421.6000976563,-1221.9000244141,25.39999961853,180)
		end
	end
end
addEventHandler("onPedWasted",Nutte3,KillNutte3)

-- Nutte 4 --
function KillNutte4(ammu,player)
	if player then
		destroyElement(Nutte4)

		Nutte4 = createPed(152,1220.9000244141,8.1000003814697,1001.299987793,140.003662)
		setElementInterior(Nutte4,2)
	
		setPedFrozen(Nutte4,true)
		setPedAnimation(Nutte4,"DANCING","DAN_Down_A")
		addEventHandler("onPedWasted",Nutte4,KillNutte4)
		addEventHandler("onElementClicked",Nutte4,Nutte4Klick)
		
		if westsideGetElementData(player,"money") >= 150 then
			outputChatBox("[INFO]: Da du eine Angestellte verletzt hast, musstest du 150$ zahlen!",player,0,100,150)
			takePlayerSaveMoney(player,150)
		else
			outputChatBox("[INFO]: Du wurdest aus dem Club geworfen!",player,0,100,150)
			fadeElementInterior(player,0,2421.6000976563,-1221.9000244141,25.39999961853,180)
		end
	end
end
addEventHandler("onPedWasted",Nutte4,KillNutte4)

---------------
-- Anklicken --
---------------

-- Nutte 1 --
function Nutte1Klick(but,stat,thePlayer)
	if(but == "left") and (stat == "down") then
		if getDistanceBetweenPoints3D(1208.2998046875,-6.2001953125,1001.299987793,getElementPosition(thePlayer)) < 5 then
			triggerClientEvent(thePlayer,"openPuff",thePlayer)
		end
	end
end
addEventHandler("onElementClicked",Nutte1,Nutte1Klick)

-- Nutte 2 --
function Nutte2Klick(but,stat,thePlayer)
	if(but == "left") and (stat == "down") then
		if getDistanceBetweenPoints3D(1213.0999755859,-3.7000000476837,1001.299987793,getElementPosition(thePlayer)) < 5 then
			triggerClientEvent(thePlayer,"openPuff",thePlayer)
		end
	end
end
addEventHandler("onElementClicked",Nutte2,Nutte2Klick)

-- Nutte 3 --
function Nutte3Klick(but,stat,thePlayer)
	if(but == "left") and (stat == "down") then
		if getDistanceBetweenPoints3D(1222.9000244141,-1.7999999523163,1001.299987793,getElementPosition(thePlayer)) < 5 then
			triggerClientEvent(thePlayer,"openPuff",thePlayer)
		end
	end
end
addEventHandler("onElementClicked",Nutte3,Nutte3Klick)

-- Nutte 4 --
function Nutte4Klick(but,stat,thePlayer)
	if(but == "left") and (stat == "down") then
		if getDistanceBetweenPoints3D(1220.9000244141,8.1000003814697,1001.299987793,getElementPosition(thePlayer)) < 5 then
			triggerClientEvent(thePlayer,"openPuff",thePlayer)
		end
	end
end
addEventHandler("onElementClicked",Nutte4,Nutte4Klick)

-- 25$ --
function Geld1_func(player)
	if westsideGetElementData(player,"money") >= 25 then
		takePlayerSaveMoney(player,25)
		infobox(player,"Geld zugesteckt!",4000,0,255,0)
	else
		infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
	end
end
addEvent("Geld1",true)
addEventHandler("Geld1",getRootElement(),Geld1_func)

-- 50$ --
function Geld2_func(player)
	if westsideGetElementData(player,"money") >= 50 then
		takePlayerSaveMoney(player,50)
		infobox(player,"Geld zugesteckt!",4000,0,255,0)
	else
		infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
	end
end
addEvent("Geld2",true)
addEventHandler("Geld2",getRootElement(),Geld2_func)

-- 100$ --
function Geld3_func(player)
	if westsideGetElementData(player,"money") >= 100 then
		takePlayerSaveMoney(player,100)
		infobox(player,"Geld zugesteckt!",4000,0,255,0)
	else
		infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
	end
end
addEvent("Geld3",true)
addEventHandler("Geld3",getRootElement(),Geld3_func)