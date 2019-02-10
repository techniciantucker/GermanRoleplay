curMaxSpeed = false

function limit_func ( cmd, amount )

	local amount = tonumber ( amount )
	if amount then
		local amount = math.abs ( amount )
		curMaxSpeed = amount
		if not isTimer ( curMaxSpeedTimer ) then
			curMaxSpeedTimer = setTimer ( fixSpeed, 50, -1 )
		end
		outputChatBox ( "[INFO]: Du hast deine maximale Geschwindigkeit auf "..amount.." km/h gesetzt!",0,100,150)
	else
		infobox("Gib eine gültige Zahl an!")
	end
end
addCommandHandler ( "limit", limit_func )

function stoplimit_func ()

	if curMaxSpeed then
		curMaxSpeed = false
		killTimer ( curMaxSpeedTimer )
		infobox("Der Tempomat wurde entfernt!")
	end
end
addCommandHandler ( "stoplimit", stoplimit_func )

function getSpeed(element) 
	speedx, speedy, speedz = getElementVelocity (element)
	actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) 
	kmh = actualspeed * 180
	return math.floor(kmh)
end

function fixSpeed ()

	local veh = getPedOccupiedVehicle(lp)
	if veh then
		local speedx, speedy, speedz = getElementVelocity (veh)
		local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) 
		local kmh = actualspeed * 180
		if kmh > curMaxSpeed then
			setElementVelocity ( veh, speedx*0.95, speedy*0.95, speedz*0.95 )
		end
	end
end