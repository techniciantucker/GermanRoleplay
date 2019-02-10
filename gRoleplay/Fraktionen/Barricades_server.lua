addCommandHandler('barricade',function(player)

	local x,y,z = getElementPosition(player)
	local rx, ry, rz = getElementRotation(player)
	
	if isCop(player) or isFBI(player) or isArmy(player) and getElementData(player,"onDuty") == true then
		if isPedInVehicle (player) == false then
			_G["barricadeNo"] = createObject ( 1459, x,y,z-0.3, rx, ry, rz )
			outputLog(getPlayerName(player).." hat eine Barricade gesetzt.","Barrikaden")

			setTimer(function()
				destroyElement(_G["barricadeNo"])
			end,1200000,1)
		else
			infobox(player,"Steige aus deinem Fahrzeug aus!")
		end
	end
end)