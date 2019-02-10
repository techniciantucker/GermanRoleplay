allTeam = createTeam ( "ChatTeam", 255, 255, 255 )

function playerJoinTeam ()
	setPlayerTeam ( source, allTeam )
end
addEventHandler ( "onPlayerJoin", getRootElement(), playerJoinTeam )

function chatAble ( player )
	if westsideGetElementData ( player, "loggedin" ) == 1 and not isPedDead ( player ) then
		return true
	end
	return false
end

function sendMessageToNearbyPlayers ( message, messageType )
	local pname = getPlayerName ( source )
	if messageType == 0 and chatAble ( source ) then
			local posX, posY, posZ = getElementPosition( source )
			local chatSphere = createColSphere( posX, posY, posZ, 10 )
			local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
			destroyElement( chatSphere )
			if westsideGetElementData ( source, "isLive" ) then
				if isReporter ( source ) then name = "Reporter "..getPlayerName(source).." : " else name = "Gast "..getPlayerName(source).." : " end
				outputChatBox ( name..message, getRootElement(), 200, 150, 0 )
			else
				local x1, y1, z1 = getElementPosition ( source)
				for i = 1, 3 do
					if _G["Wanze"..i] then
						local x2, y2, z2 = getElementPosition ( _G["Wanze"..i] )
						local x3, y3, z3 = getElementPosition ( FederalBoxville )
						local distance = getDistanceBetweenPoints3D ( x1,y1,z1,x2,y2,z2 )
						if distance then
							if distance <= 10 then
								if getDistanceBetweenPoints3D ( x3, y3, z3, x2, y2, z2 ) <= wanzenrange then
									local msg = "Wanze "..i.." - "..getPlayerName(source)..": "..message
									sendMSGToBoxville ( msg )
								end
							end
						end
					end
				end
				for index, nearbyPlayer in ipairs( nearbyPlayers ) do
					local x2, y2, z2 = getElementPosition ( nearbyPlayer )
					local distance = getDistanceBetweenPoints3D ( x1,y1,z1,x2,y2,z2 )
					if getElementDimension ( source ) == getElementDimension ( nearbyPlayer ) then
						if westsideGetElementData ( source, "call" ) == true then
							if isElement ( nearbyPlayer ) then
								outputChatBox ( pname.. " (Handy) sagt: " ..message, nearbyPlayer, 255,255,255 )
							end
						else
							outputChatBox ( pname.. " sagt: " ..message, nearbyPlayer, 255,255,255 )
						end
					end
				end
			end
		if westsideGetElementData ( source, "call" ) == true then
			local target = getPlayerFromName(westsideGetElementData(source,"callswith"))
			outputChatBox ( pname.." am Handy: "..message, target, 200,200,0 )
		end
	else
		if messageType == 2 then
			executeCommandHandler ( "t", source, message )
		elseif messageType == 1 then
			local posX, posY, posZ = getElementPosition( source )
			local chatSphere = createColSphere( posX, posY, posZ, 20 )
			local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
			destroyElement( chatSphere )
			for index, nearbyPlayer in ipairs( nearbyPlayers ) do
				local pname = getPlayerName ( source )
				outputChatBox ( pname.." "..message, nearbyPlayer, 100, 0, 200 )
			end
		end
	end
end
addEventHandler( "onPlayerChat", getRootElement(), sendMessageToNearbyPlayers )

function blockmsg ( message, messageType )
	cancelEvent()
end
addEventHandler( "onPlayerChat", getRootElement(), blockmsg )

function meCMD_func ( player, cmd, ... )
	local tb = {...}
	local msg = table.concat ( tb, " " )
	local pname = getPlayerName ( player )
	local posX, posY, posZ = getElementPosition ( player )
	local chatSphere = createColSphere( posX, posY, posZ, 20 )
	local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
	destroyElement( chatSphere )
	for index, nearbyPlayer in pairs ( nearbyPlayers ) do
		local pname = getPlayerName ( player )
		outputChatBox ( pname.." "..msg, nearbyPlayer, 200, 0, 200 )
	end
end
addCommandHandler ( "meCMD", meCMD_func )