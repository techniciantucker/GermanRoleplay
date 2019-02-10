-- Variablen

BR_AKTIV = 0
BR_MOEGLICH = 0

-- Teleporter
BankRein = createPickup (1454.7601318359,-1009.9211425781,26.84375,3,1318,500)

BankRaus = createPickup (1434.6160888672,-973.51922607422,12.135936737061,3,1318,500)

addEventHandler ("onPickupHit", BankRein, function (player, dim )
	if isPedInVehicle (player) == false then
		--if hour > 6 and hour < 23 then
			fadeElementInterior (player, 0, 1436.0999755859,-973.09997558594,12.10000038147)
			setElementRotation (player, 0, 0, 270)
			outputChatBox("Um die Bankverwaltung zu öffnen, klicke den Angestellten an.",player)
		--else
		--	outputChatBox("Die Los Santos Bank hat nur von 06:00 - 23:00 Uhr geöffnet!",player,200,0,0)
		--end
	end
end)

addEventHandler ("onPickupHit", BankRaus, function (player, dim )
	if isPedInVehicle (player) == false then
		fadeElementInterior (player, 0, 1459.4000244141,-1012.5999755859,26.799999237061)
		setElementRotation (player, 0, 0, 180)
	end
end)

-- Rauben

RAUB_MARKER = createMarker(1452.45947,-976.84460,-0.48168,"corona",2,0,200,0)
BANK_DOOR = createObject (2930, 1489.3000488281,-970.5,13.699999809265,0,0,0)

addEventHandler("onMarkerHit",RAUB_MARKER,function(player)
	if isEvil(player) then
		outputChatBox("Tippe /startBankrob, um die Bank auszurauben!",player,0,255,0)
	end
end)

-- Killped

local movingVal = 5

function KILLPED_FUNC(_,player)
	if (getStateFactionMembersOnline() >= 2) then
		if isEvil(player) then
			if BR_AKTIV == 0 then
				BR_AKTIV = 1
				setElementData(player,"Bankrobber",true)
				outputChatBox("Du hast den Bankdirektor ermordet! Die Tresor Tür öffnet sich!",player,0,255,0)
				westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 25)
				outputLog( "[BR]: Der Bankdirektor wurde von "..getPlayerName(player).." erschossen.", "Robs")
				if westsideGetElementData(player,"wanteds") < 4 then
					westsideSetElementData(player,"wanteds",westsideGetElementData(player,"wanteds") + 3)
				else
					westsideSetElementData(player,"wanteds",6)
				end
				local x,y,z = getElementPosition(BANK_DOOR)
				moveObject(BANK_DOOR,1000,x,y,z-movingVal)
				setElementData(player,"key",false)
				outputChatBox("Sie bleibt 20 Minuten geöffnet!",player,0,255,0)
				setTimer(function()
					local x,y,z = getElementPosition(BANK_DOOR)
					moveObject(BANK_DOOR,1000,x,y,z-movingVal)
				end,1200000,1)
				
				sendMSGForFaction('Die Los Santos Bank meldet einen Überfall!!!',1,200,0,0)
				sendMSGForFaction('Die Los Santos Bank meldet einen Überfall!!!',2,200,0,0)
				sendMSGForFaction('Die Los Santos Bank meldet einen Überfall!!!',3,200,0,0)
				sendMSGForFaction('Die Los Santos Bank meldet einen Überfall!!!',4,200,0,0)
				sendMSGForFaction('Die Los Santos Bank meldet einen Überfall!!!',6,200,0,0)
				sendMSGForFaction('Die Los Santos Bank meldet einen Überfall!!!',7,200,0,0)
				sendMSGForFaction('Die Los Santos Bank meldet einen Überfall!!!',8,200,0,0)
				sendMSGForFaction('Die Los Santos Bank meldet einen Überfall!!!',9,200,0,0)
				
				setTimer(function()
					BR_AKTIV = 0
					BR_MOEGLICH = 0
					destroyElement(BANK_PED)
					respawnPed()
				end,3600000,1)
				respawnPed() -- Damit der Ped spawnt und man ihn anklicken kann
			else
				outputChatBox("Es kann nur jede Stunde ein Bankraub gestartet werden!",player,255,0,0)
				respawnPed()
			end
		else
			infobox(player,"Du bist nicht befugt!",4000,255,0,0)
			respawnPed()
		end
	else
		infobox(player,"Es müssen mindestens 2\nCops online sein!",4000,255,0,0)
		respawnPed()
	end
end

function respawnPed()
	destroyElement(BANK_PED)
	BANK_PED = createPed(17,1444.8000488281,-983.29998779297,12.10000038147,0.00274658)
	addEventHandler("onPedWasted",BANK_PED,KILLPED_FUNC)
	addEventHandler("onElementClicked",BANK_PED,BANK_PED_CLICK)
end

-- Ped

BANK_PED = createPed(17,1444.8000488281,-983.29998779297,12.10000038147,0.00274658)
addEventHandler("onPedWasted",BANK_PED,KILLPED_FUNC)

function BANK_PED_CLICK(but,stat,thePlayer)
	if(but =="left") and (stat == "down") then
		if getDistanceBetweenPoints3D(1444.8000488281,-983.29998779297,12.10000038147,getElementPosition(thePlayer)) < 10 then
			triggerClientEvent(thePlayer,"konto",thePlayer)
		end
	end
end
addEventHandler("onElementClicked",BANK_PED,BANK_PED_CLICK)

-- Starten

addCommandHandler("startBankrob",function(player)
	if isEvil(player) then
		if getDistanceBetweenPoints3D(1452.45947,-976.84460,-0.48168,getElementPosition(player)) < 5 then
			if BR_MOEGLICH == 0 then
				BR_MOEGLICH = 1
				triggerClientEvent(player,"startBR",player)
				setElementData(player,"Bankrobber",true)
				outputChatBox("Halte die Position 5 Minuten Lang!",player,0,255,0)

				bankraubFertigTimer = setTimer(function()
					removeEventHandler("onPlayerWasted",player,BR_DIE)
					removeEventHandler("onMarkerLeave",RAUB_MARKER,BR_LEAVE)
					setElementData(player,"Bankrobber",false)
					outputChatBox("Der Bankraub war erfolgreich!",player,0,255,0)
					if(getStateFactionMembersOnline()==0)then
						outputChatBox('Du bekommst 0$!',player,255,0,0)
					elseif (getStateFactionMembersOnline() >= 2) then
						outputChatBox("Du bekommst 5000$!",player,0,255,0)
						westsideSetElementData(player,"money",westsideGetElementData(player,"money") + 5000)
					elseif (getStateFactionMembersOnline() >= 4) then
						outputChatBox("Du bekommst 10.000$!",player,0,255,0)
						westsideSetElementData(player,"money",westsideGetElementData(player,"money") + 10000)
					elseif (getStateFactionMembersOnline() >= 6) then
						outputChatBox("Du bekommst 15.000$!",player,0,255,0)
						westsideSetElementData(player,"money",westsideGetElementData(player,"money") + 15000)
					elseif (getStateFactionMembersOnline() >= 10) then
						outputChatBox("Du bekommst 20.000$!",player,0,255,0)
						westsideSetElementData(player,"money",westsideGetElementData(player,"money") + 20000)
					elseif (getStateFactionMembersOnline() >= 14) then
						outputChatBox("Du bekommst 35.000$!",player,0,255,0)
						westsideSetElementData(player,"money",westsideGetElementData(player,"money") + 35000)
					end
				end,300000,1)
				
				addEventHandler("onPlayerWasted",player,BR_DIE)
				addEventHandler("onMarkerLeave",RAUB_MARKER,BR_LEAVE)
			end
		else
			infobox(player,"Du bist nicht in der Bank!",4000,255,0,0)
		end
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end)

-- Sterben

function BR_DIE(player)
	if getElementData(player,"Bankrobber") == true then
		killTimer(bankraubFertigTimer)
	
		removeEventHandler("onPlayerWasted",player,BR_DIE)
		removeEventHandler("onMarkerLeave",RAUB_MARKER,BR_LEAVE)
		outputChatBox("Du bist gestorben! Der Bankraub ist fehlgeschlagen!",player,255,0,0)
		setElementData(player,"Bankrobber",false)
		triggerClientEvent(player,"stopBR",player)
	end
end

-- Verlassen

function BR_LEAVE(player)
	if getElementData(player,"Bankrobber") == true then
		killTimer(bankraubFertigTimer)
	
		removeEventHandler("onPlayerWasted",player,BR_DIE)
		removeEventHandler("onMarkerLeave",RAUB_MARKER,BR_LEAVE)
		outputChatBox("Du hast den Marker verlassen! Der Bankraub ist fehlgeschlagen!",player,255,0,0)
		setElementData(player,"Bankrobber",false)
		triggerClientEvent(player,"stopBR",player)
	end
end


-- Konto Funktionen

addEvent("kontobeantragen",true)
addEventHandler("kontobeantragen",root,function(player)
	local yourpin = getElementData(player,"bankpin")
	
	if yourpin == 0 then
		if tonumber(westsideGetElementData ( player, "perso" )) == 1 then
			createpin = math.random (1000,9999)
			westsideSetElementData(player,"bankpin",createpin)
			outputChatBox("Du hast nun ein Konto! Dein Pin lautet: "..createpin,player)
		else
			infobox(player,"Du hast keinen Personalausweis!",4000,255,0,0)
		end
	else
		infobox(player,"Du hast bereits ein Konto!",4000,255,0,0)
	end
end)

addEvent("kontoclose",true)
addEventHandler("kontoclose",root,function(player)
	local yourpin = getElementData(player,"bankpin")
	
	if yourpin ~= 0 then
		if getElementData(player,"sicher") == false then
			outputChatBox("Bankangestellter: Sind Sie sicher, dass sie ihr Konto schließen wollen?",player,255,255,255)
			outputChatBox("[Das Geld, welches sich auf dem Konto befindet, wird verbrannt!",player,200,0,0)
			outputChatBox("Klicke erneut auf den Button, falls du fortfahren möchtest!",player,0,200,0)
			setElementData(player,"sicher",true)
		else
			infobox(player,"Du hast dein Konto gekündigt!",4000,0,255,0)
			westsideSetElementData(player,"bankpin",0)
			westsideSetElementData(player,"bankmoney",0)
			setElementData(player,"sicher",false)
		end
	else
		infobox(player,"Du hast kein Konto!",4000,255,0,0)
	end
end)