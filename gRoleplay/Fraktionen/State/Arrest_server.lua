local Zellen = {}
Zellen[1] = false
Zellen[2] = false

local CellKoords = {}

for i=1, 2, 1 do
	CellKoords[i] = {}
end

-- Knast Positionen
CellKoords[1]["x"], CellKoords[1]["y"], CellKoords[1]["z"], CellKoords[1]["rot"] = 264.40576, 87.07385, 1001.03906, 0
CellKoords[2]["x"], CellKoords[2]["y"], CellKoords[2]["z"], CellKoords[2]["rot"] = 264.28690, 81.85932, 1001.03906, 0

addEvent ( "onPlayerGetsFreed", true )

function getFreeCell ( )
	local va = false
	local num = false
	local vale = 0
	while va == false do
		if vale == 2 then
			return false
		end
		num = math.random ( 1, 2 )
		if Zellen[num] == false then
			va = true
			return num
		end
		vale = vale+1
	end
end

function getCellCoords ( count )
	if count == false then
		return CellKoords[count]["x"], CellKoords[count]["y"], CellKoords[count]["z"], CellKoords[count]["rot"]
	end
	return CellKoords[count]["x"], CellKoords[count]["y"], CellKoords[count]["z"], CellKoords[count]["rot"]
end

function cellHandlerFunc ( player )
		if not player then
			player = source
		end
		if not source then
			source = player
		end
		local cell = getElementData ( source, "playerCelled" )
		Zellen[cell] = false
		removeElementData ( source, "playerCelled" )
		removeEventHandler ( "onPlayerGetsFreed", source, cellHandlerFunc )
		removeEventHandler ( "onPlayerQuit", source, cellHandlerFunc )
		removeEventHandler ( "onPlayerWasted", source, cellHandlerFunc )
end

function putPlayerInFreeCell ( player )
	local cell = getFreeCell()
	if cell == false then
	else
		Zellen[cell] = getPlayerName ( player )
		setElementData ( player, "playerCelled", cell )
		addEventHandler ( "onPlayerGetsFreed", player, cellHandlerFunc )
		addEventHandler ( "onPlayerQuit", player, cellHandlerFunc )
		addEventHandler ( "onPlayerWasted", player, cellHandlerFunc )
	end
	local x, y, z, rz = getCellCoords ( cell )
	setElementPosition ( player, x, y, z )
	setElementRotation ( player, 0, 0, rz )
	setElementInterior ( player, 6 ) -- // Interior der Knastpositionen
	setElementDimension ( player, 0)
	triggerClientEvent(player, "startJailTimeRenderEvent", player)
end

--

function arrestPlayer ( officer, player, time )
	if westsideGetElementData ( player, "tied" ) then
		fadeCamera ( player, true, 0.5, 0, 0, 0 )
		toggleAllControls ( player, true )
	end
	westsideSetElementData ( player, "jailtime", time )
	westsideSetElementData ( officer, "boni", westsideGetElementData ( officer, "boni" ) + westsideGetElementData ( player, "wanteds" ) * wantedprice )
	if bail == nil then bail = 0 end
	if bail == 0 then
		westsideSetElementData ( player, "bail", 0 )
		outputChatBox ( "[INFO]: Du hast "..getPlayerName ( player ).." für "..time.." Minuten eingesperrt!", officer,0,100,150 )
		outputChatBox ( "[INFO]: Du wurdest von "..getPlayerName ( officer ).." für "..time.." Minuten eingesperrt!", player,0,100,150 )
		
		outputChatBox( "Spieler "..getPlayerName(player).." wurde von "..getPlayerName(officer).." eingesperrt!",player,115,115,155)
	else
		westsideSetElementData ( player, "bail", bail )
		outputChatBox ( "[INFO]: Du wurdest von "..getPlayerName ( officer ).." für "..time.." Minuten eingesperrt!", player,0,100,150 )
		outputChatBox ( "[INFO]: Du hast "..getPlayerName ( player ).." für "..time.." Minuten eingesperrt!", officer ,0,100,150)
		
		outputChatBox( "Spieler "..getPlayerName(player).." wurde von "..getPlayerName(officer).." eingesperrt!",player,115,115,155)
	end
	putPlayerInJail ( player )
end

--

local knast_cmds = {}
knast_cmds["smoke"] = true
knast_cmds["usedrugs"] = true
knast_cmds["sellgun"] = true

function disbaleKnastCMD ( cmd )
	if knast_cmds[cmd] then
		cancelEvent()
	end

end

function putPlayerInJail ( player )
	takeAllWeapons ( player )
	westsideSetElementData ( player, "wanteds", 0 )
	setPlayerWantedLevel ( player, 0 )
	triggerClientEvent ( player, "jailKeyDisable", player )
	putPlayerInFreeCell ( player )
	addEventHandler( "onPlayerCommand", player, disbaleKnastCMD )
	setElementDimension ( player, 0 )
end

function freePlayerFromJail ( player )
	removeEventHandler ( "onPlayerCommand", player, disbaleKnastCMD )
	triggerEvent ( "onPlayerGetsFreed", player, player )
	westsideSetElementData ( player, "jailtime", 0 )
	westsideSetElementData ( player, "bail", 0 )
	westsideSetElementData ( player, "jailtime", 0 )
	toggleControl ( player, "enter_exit", true )
	toggleControl ( player, "fire", true )
	toggleControl ( player, "jump", true )
	toggleControl ( player, "action", true )
	if westsideGetElementData ( player, "heaventime" ) == 0 then
		setElementInterior ( player, 0 )
		setElementDimension(player,0)
		if getElementData ( player, "jail" ) == "lv" then
			setElementPosition ( player, 1544.4622802734,-1670.4765625,13.558456420898)
			setPedRotation ( player, 180 )
		else
			setElementPosition ( player, 1544.4622802734,-1670.4765625,13.558456420898 )
		end
	end
end