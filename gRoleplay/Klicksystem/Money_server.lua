----- /pay -----
function pay_func ( player, cmd, target, money )
	if(westsideGetElementData(player,'loggedin')==1)then
		if target and money then
			local money = tonumber ( money )
			local target = getPlayerFromName ( target )
		
			money = math.abs ( math.floor ( money + 0.5 ) )
			local pmoney = westsideGetElementData ( player, "money" )
			if pmoney >= money then
				local x1, y1, z1 = getElementPosition ( player )
				local x2, y2, z2 = getElementPosition ( target )
				if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 5 then
					if westsideGetElementData ( player, "playingtime" ) >= 180 then
						takePlayerSaveMoney ( player, money )
						givePlayerSaveMoney ( target, money )
						infobox ( target, "Du hast von "..getPlayerName ( player ).."\n"..money.." $ erhalten!", 4000, 0, 255, 0 )
						infobox ( player, "Du hast "..getPlayerName ( target ).."\n"..money.." $ gegeben!", 4000, 0, 255, 0 )
						outputLog ( getPlayerName ( player ).." hat "..getPlayerName ( target ).." "..money.." $ gegeben!","Money" )
					else
						infobox ( player, "Du kannst erst ab 3\nStunden Geld übergeben!", 4000, 255, 0, 0 )
					end
				else
					infobox ( player, "Du bist zu weit entfernt!", 4000, 255, 0, 0 )
				end
			else
				infobox ( player, "Soviel Geld hast du nicht!", 4000, 255, 0, 0 )
			end
		else
			infobox ( player, "Gebrauch: /pay [Name] [Summe]", 4000, 255, 0, 0 )
		end
	end
end
addCommandHandler ( "pay", pay_func )

function moneychange ( player, betrag )

	westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) + betrag )
	if betrag >= 0 then
		givePlayerMoney ( player, betrag )
	else
		takePlayerMoney ( player, betrag )
	end
	
	playSoundFrontEnd ( player, 40 )
end

function givePlayerSaveMoney ( player, amount )

	local amount = tonumber ( amount )
	if isElement ( player ) and amount then
		westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) + amount )
		givePlayerMoney ( player, amount )
		playSoundFrontEnd ( player, 40 )
		
	end
end

function takePlayerSaveMoney ( player, amount )

	local amount = tonumber ( amount )
	if isElement ( player ) and amount then
		westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - amount )
		takePlayerMoney ( player, amount )
		playSoundFrontEnd ( player, 40 )
		
	end
end

function showBankMoney_func ()

	if source == source then
		local bankmoney = westsideGetElementData ( source, "bankmoney" )
		outputChatBox ("Du hast "..bankmoney.." $ auf der Bank.", source)
	end
end
addEvent ( "showBankMoney", true )
addEventHandler ("showBankMoney", getRootElement(), showBankMoney_func )

function cashPointPayIn_func ( summe )

	local summe = math.abs(math.floor(tonumber(summe)))
	if source == client then
		if westsideGetElementData ( source, "money" ) >= tonumber(summe) then
			infobox(source,"Du hast "..tonumber(summe).." $ eingezahlt!",4000,0,255,0 )
			westsideSetElementData ( source, "money", westsideGetElementData ( source, "money" ) - tonumber(summe) )
			westsideSetElementData ( source, "bankmoney", westsideGetElementData ( source, "bankmoney" ) + tonumber(summe) )
			takePlayerMoney ( source, tonumber(summe) )
			playSoundFrontEnd ( source, 40 )
			setElementData( source , "bankmoney" , westsideGetElementData ( source, "bankmoney" ) + tonumber(summe) )
		end
	end
end
addEvent ( "cashPointPayIn", true )
addEventHandler ( "cashPointPayIn", getRootElement(), cashPointPayIn_func )

function getPlaceOfPlayer ( player )

	local x, y, z = getElementPosition ( player )
	return getZoneName ( x, y, z, true )
end

function cashPointPayOut_func ( summe )

	local summe = math.abs(math.floor(tonumber(summe)))
	if source == client then
		if westsideGetElementData ( source, "bankmoney" ) >= tonumber(summe) then
			triggerClientEvent ( source, "infobox_start", getRootElement(), "Du hast "..tonumber(summe).."$ abgehoben!", 4000,0,255,0)
			westsideSetElementData ( source, "bankmoney", westsideGetElementData ( source, "bankmoney" ) - tonumber(summe) )
			westsideSetElementData ( source, "money", westsideGetElementData ( source, "money" ) + tonumber(summe) )
			givePlayerMoney ( source, tonumber(summe) )
			playSoundFrontEnd ( source, 40 )
			setElementData( source , "bankmoney" , westsideGetElementData ( source, "bankmoney" ) - tonumber(summe) )
		end
	end
end
addEvent ( "cashPointPayOut", true )
addEventHandler ( "cashPointPayOut", getRootElement(), cashPointPayOut_func )

function cashPointTransfer_func ( summe, ziel, online, reason )
	if source == client then
		if online then
			westsideSetElementData ( source, "bankmoney", westsideGetElementData ( source, "bankmoney" ) - 10 )
			reason = "Onlineueberweisung"
		end
		local summe = math.abs(math.floor(tonumber(summe)))
		if westsideGetElementData ( source, "playingtime" ) >= 180 then
			if getPlayerFromName ( ziel ) then
				if tonumber(summe) >= 1 then
					if westsideGetElementData ( source, "bankmoney" ) >= tonumber(summe) then
						local player = getPlayerFromName ( ziel )
						if westsideGetElementData ( player, "loggedin" ) == 1 then
							westsideSetElementData ( source, "bankmoney", westsideGetElementData ( source, "bankmoney" ) - tonumber(summe) )
							westsideSetElementData ( player, "bankmoney", westsideGetElementData ( player, "bankmoney" ) + tonumber(summe) )
							outputChatBox ( "Du hast von "..getPlayerName(source).." "..tonumber(summe).."$ erhalten (Grund: "..reason..")!", player,255,255,0 )
							outputChatBox ( "Du hast "..getPlayerName(player).." "..tonumber(summe).."$ überwiesen.", source,255,255,0 )
							playSoundFrontEnd ( source, 40 )
							playSoundFrontEnd ( player, 40 )
							setElementData( source , "bankmoney" , westsideGetElementData ( source, "bankmoney" ) - tonumber(summe) )
							setElementData( player , "bankmoney" , westsideGetElementData ( player, "bankmoney" ) + tonumber(summe) )

							outputLog(getPlayerName(source).." hat an "..ziel.." "..summe.."$ überwiesen.","Pay")
						else
							triggerClientEvent ( source, "infobox_start", getRootElement(), "Der Spieler ist\nnoch nicht eingeloggt!", 4000,255,0,0)
						end
					else
						triggerClientEvent ( source, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000,255,0,0)
					end
				else
					triggerClientEvent ( source, "infobox_start", getRootElement(), "Ungültiger Betrag!", 4000,255,0,0)
				end
			else
				triggerClientEvent ( source, "infobox_start", getRootElement(), "Du musst einen gültigen\nSpielernamen eingeben!", 4000,255,0,0)
			end
		else
			triggerClientEvent ( source, "infobox_start", getRootElement(), "Du kannst erst ab 3\nStunden Geld überweisen!", 2500, 200,0,0)
		end
	end
end
addEvent ( "Ueberweisen", true )
addEvent ( "cashPointTransfer", true )
addEventHandler ( "Ueberweisen", getRootElement(), cashPointTransfer_func )
addEventHandler ( "cashPointTransfer", getRootElement(), cashPointTransfer_func )

function geldgeben_func ( summe )

	if source == client then
		local summe = math.abs(math.floor(tonumber(summe)))
		if tonumber(summe) + 5 ~= nil then
			if westsideGetElementData ( source, "playingtime" ) >= 180 then
				local x1, y1, z1 = getElementPosition ( source )
				local player = getPlayerFromName ( westsideGetElementData ( source, "curclicked" ) )
				local x2, y2, z2 = getElementPosition ( player )
				local summe = tonumber(summe)
				if summe <= westsideGetElementData ( source, "money" ) then
					if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 10 then
						westsideSetElementData ( source, "money", westsideGetElementData ( source, "money" ) - summe )
						westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) + summe )
						setPlayerMoney( source, westsideGetElementData ( source, "money" ) )
						setPlayerMoney( player, westsideGetElementData ( player, "money" ) )
						triggerClientEvent ( source, "infobox_start", getRootElement(), "Du hast "..getPlayerName(player).."\n"..summe.."$ gegeben.", 2500, 0,125,0)
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast von"..getPlayerName(source).."\n"..summe.."$ bekommen.", 2500, 0,125,0)
						
						playSoundFrontEnd ( player, 40 )
						playSoundFrontEnd ( source, 40 )
						outputLog ( getPlayerName(source).." hat an "..ziel.." "..summe.." $ gegeben!","Pay" )
					else
						triggerClientEvent ( source, "infobox_start", getRootElement(), "Du bist zu weit weg!", 4000,255,0,0)
					end
				else
					triggerClientEvent ( source, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000,255,0,0)
				end
			else
				triggerClientEvent ( source, "infobox_start", getRootElement(), "Du kannst erst ab 3\nStunden Geld übergeben!", 2500, 200,0,0)
			end
		else
			triggerClientEvent ( source, "infobox_start", getRootElement(), "Ungültiger Betrag!", 4000,255,0,0)
		end
	end
end
addEvent ( "geldgeben", true )
addEventHandler ( "geldgeben", getRootElement(), geldgeben_func )

function checkmoney ( player )
	local money = westsideGetElementData ( player, "bankmoney" )
	setElementData ( player , "bmoney" , money*1)
end
addEvent("checkBMoney", true )
addEventHandler ( "checkBMoney", getRootElement(), checkmoney )