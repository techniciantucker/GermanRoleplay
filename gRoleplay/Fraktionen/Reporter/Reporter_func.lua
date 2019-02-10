function news_func ( player, cmd, veh, ... )

	local parametersTable = {...}
	local stringWithAllParameters = table.concat( parametersTable, " " )
	if isReporter ( player ) and getElementData(player,"rduty") == true then
		if not westsideGetElementData ( player, "newsNotPostable" ) then
			 if isReporterCar(getPedOccupiedVehicle(player)) then
				if #stringWithAllParameters > 1 then
					outputChatBox ( "Reporter "..getPlayerName(player)..": "..stringWithAllParameters, getRootElement(), 255,150,0 )
					westsideSetElementData ( player, "boni", tonumber ( westsideGetElementData ( player, "boni" ) ) + 10 )
					westsideSetElementData ( player, "newsNotPostable", true )
					setTimer ( westsideSetElementData, 3000, 1, player, "newsNotPostable", false )
				else
					infobox(player,"Dein Text ist zu kurz!",4000,255,0,0)
				end
			else
				infobox(player,"Du sitzt in keinem\nReporter Fahrzeug!",4000,255,0,0)
			end
		else
			infobox(player,"Nur alle 3 Sekunden\nmöglich!",4000,255,0,0)
		end
	else
		infobox(player,"Du bist kein Reporter oder\nnicht im Dienst!")
	end
end
addCommandHandler ( "news", news_func )

function live_func ( player, cmd, target )
	
	if isReporter ( player ) and not westsideGetElementData ( player, "isLive" ) and getElementData(player,"rduty") == true then
		local target = findPlayerByName( target )
		if target then
			westsideSetElementData ( target, "isLive", true )
			westsideSetElementData ( player, "isLive", true )
			westsideSetElementData ( target, "isLiveWith", getPlayerName(player) )
			westsideSetElementData ( player, "isLiveWith", getPlayerName(target) )
			outputChatBox ( "[INFO]: Du bist nun in einem Interview mit "..getPlayerName(player)..", tippe /endlive zum beenden!", target, 0,100,150 )
			outputChatBox ( "[INFO]: Du bist nun in einem Interview mit "..getPlayerName(target)..", tippe /endlive zum beenden.", player, 0,100,150 )
		end
	else
		infobox(player,"Du bist kein Reporter oder\nnicht im Dienst!")
	end
end
addCommandHandler ( "live", live_func )

function endlive_func ( player )
	
	if westsideGetElementData ( player, "isLive" ) then
		westsideSetElementData ( player, "isLive", false )
		infobox(player,"Das Interview wurde beendet!",4000,255,0,0)
		local target = westsideGetElementData ( player, "isLiveWith" )
		local target = getPlayerFromName ( target )
		if target then
			infobox(target,"Das Interview wurde beendet!",4000,255,0,0)
			westsideSetElementData ( target, "isLive", false )
		end
	end
end
addCommandHandler ( "endlive", endlive_func )

function spendennews_func ( player, cmd, amount )
	local amount = tonumber ( amount )
	if amount then
		if amount >= 500 then
			amount = math.abs ( math.floor ( amount ) )
			local money = westsideGetElementData ( player, "bankmoney" )
			if money >= amount then
				MySQL_SetString("fraktionen", "FKasse", fmoney + amount, "ID LIKE '5'")
				westsideSetElementData ( player, "bankmoney", money - amount )
				infobox ( player, "Du hast "..amount.."$ an\ndie Reporter gespendet!", 4000, 0,255,0 )
				sendMSGForFaction ( "[INFO]: "..getPlayerName(player).." hat "..amount.."$ gespendet!", 5, 200,200,0 )
				outputLog( "[SPENDE]: "..getPlayerName(player).." hat "..amount.."$ and die Reporter gespendet!", "pay")
				triggerClientEvent ( player, "createNewStatementEntry", player, "Reporter Spende\n", amount * -1, "\n" )
			else
				infobox ( player, "Du hast nicht genug Geld!", 4000,255,0,0)
			end
		else
			infobox ( player, "Mindestens 500$ (Spamschutz)!", 4000, 255, 0, 0 )
		end
	else
		infobox ( player, "Nutze /spenden [Summe]!", 4000, 0,100,150 )
	end
end
addCommandHandler ( "spenden", spendennews_func )

-- Duty
reporterDuty = createPickup(741.17877197266,-1336.5451660156,13.535906791687,3,1239,500)

addEventHandler("onPickupHit",reporterDuty,function(player)
	if isReporter(player) then
		if not isPedInVehicle(player) then
			infobox(player,"Tippe /duty, um den Dienst\nals Reporter zu beginnen und\n/fumkleide, zum wechsel deines Skins.")
		end
	end
end)

addCommandHandler("duty",function(player)
	if isReporter(player) then
		if getDistanceBetweenPoints3D(741.17877197266,-1336.5451660156,13.535906791687,getElementPosition(player)) < 5 then
			if getElementData(player,"rduty") == false then
				infobox(player,"Reporter Dienst begonnen.")
				setElementData(player,"rduty",true)
			else
				infobox(player,"Reporter Dienst beendet.")
				setElementData(player,"rduty",false)
			end
		else
			infobox(player,"Du bist nicht am Duty Pickup!")
		end
	end
end)