function startintro_func(player)
	triggerClientEvent(player, 'startIntro', player)
end

function gameBeginGuiShow_func ( player )
	if player == client then
		westsideSetElementData ( player, "isInTut", false )
		setCameraTarget(player, player)
		spawnPlayer(player, 1567.81055, -1896.81274, 13.56059);
		toggleAllControls ( player, true )
		setElementInterior ( player, 0 )
		bindKey ( player, "ralt", "down", showcurser, player )
		bindKey ( player, "m", "down", showcurser, player )
	end
end
addEvent ( "gameBeginGuiShow", true )
addEventHandler ( "gameBeginGuiShow", getRootElement(), gameBeginGuiShow_func)