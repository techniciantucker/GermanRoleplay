serverRestartedAMinuteAgo = true

setTimer (function ()
	serverRestartedAMinuteAgo = false
end,5000, 1 )

setTimer ( function ()
	client = nil
end,1000, 0 )

function joinHandler ()
	setElementDimension ( source, 0 )
    fadeCamera( source, true)
    setCameraTarget( source, source )
	
	local loginPerspektive=math.random(1,7)

	if(loginPerspektive==1)then
		setCameraMatrix(source,1881.7390136719,-1848.9045410156,15.008600234985,1880.7999267578,-1849.2142333984,14.859927177429,0,70)
	elseif(loginPerspektive==2)then
		setCameraMatrix(source,1547.5684814453,-1710.1221923828,31.258899688721,1546.7232666016,-1710.4716796875,30.85457611084,0,70)
	elseif(loginPerspektive==3)then
		setCameraMatrix(source,1152.4095458984,-1678.6864013672,15.049200057983,1151.4464111328,-1678.9273681641,14.929926872253,0,70)
	elseif(loginPerspektive==4)then
		setCameraMatrix(source,1433.4993896484,-1042.2663574219,24.82200050354,1434.1043701172,-1041.4765625,24.7209815979,0,70)
	elseif(loginPerspektive==5)then
		setCameraMatrix(source,927.66748046875,-1642.5943603516,14.397000312805,926.85119628906,-1643.1702880859,14.352333068848,0,70)
	elseif(loginPerspektive==6)then
		setCameraMatrix(source,326.25421142578,-266.1044921875,6.686999797821,325.72406005859,-265.349609375,6.3008460998535,0,70)
	elseif(loginPerspektive==7)then
		setCameraMatrix(source,-1084.3922119141,-1650.5622558594,77.162002563477,-1084.8120117188,-1649.6552734375,77.127220153809,0,70)
	end
end
addEventHandler ( "onPlayerJoin", getRootElement(), joinHandler )

function getServerSlotCount ()
	triggerClientEvent ( client, "recieveServerSlotCount", client, getMaxPlayers () )
end
addEvent ( "getServerSlotCount", true )
addEventHandler ( "getServerSlotCount", getRootElement(), getServerSlotCount )

invalidChars = {}
for i = 33, 39 do
invalidChars[i] = true
end
for i = 40, 43 do
invalidChars[i] = true
end
invalidChars[47] = true
for i = 58, 64 do
invalidChars[i] = true
end
invalidChars[92] = true
invalidChars[94] = true
invalidChars[96] = true
for i = 123, 126 do
invalidChars[i] = true
end

function hasInvalidChar ( player )
	name = getPlayerName ( player )
	for i, index in pairs ( invalidChars ) do
		if not gettok ( name, 1, i ) or gettok ( name, 1, i ) ~= name then
			return true
		end
	end
	return false
end

function serverstart ()
	setGameType ( "German Roleplay" )
	setMapName ( "San Andreas" )
	lastadtime = 0
	for i = 1, 14 do
		_G["arenaSlot"..i.."Occupied"] = false
	end
	deleteAllFromLoggedIn ()
end
addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource() ), serverstart )

function asd ()
restartServer()
end

setFPSLimit ( 59 )

local kicktab = {}  

----- Starterpacket -----
addCommandHandler("starterpack",function(player,cmd,packet)
	if(westsideGetElementData(player,"loggedin")==1)then
		if(packet)then
			if(getElementData(player,"starterPaket")==true)then
				if(packet=="1")then
					givePlayerSaveMoney(player,150000)
					westsideSetElementData(player,"fgutschein",tonumber(westsideGetElementData(player,"fgutschein")) + 1)
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 3000)
					infobox(player,"Dir wurde alles gutgeschrieben!",4000,0,255,0)
					setElementData(player,"starterPaket",false)
				elseif(packet=="2")then
					givePlayerSaveMoney(player,75000)
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 4000)
					westsideSetElementData(player,"coins",tonumber(westsideGetElementData(player,"coins")) + 5)
					westsideSetElementData(player,"playingtime",tonumber(westsideGetElementData(player,"playingtime")) + 300)
					infobox(player,"Dir wurde alles gutgeschrieben!",4000,0,255,0)
					setElementData(player,"starterPaket",false)
				else
					infobox(playe,"Dieses Packet ist uns nicht\nbekannt!",4000,255,0,0)
				end
			else
				infobox(player,"Du hast dein Startpacket\nbereits abgeholt!",4000,255,0,0)
			end
		else
			infobox(player,"Du hast kein Packet angegeben!",4000,255,0,0)
		end
	end
end)