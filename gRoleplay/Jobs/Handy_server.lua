function handychange_func ( player, cmd )
	if player == client then
		if westsideGetElementData ( player, "handystate" ) == "on" then
			westsideSetElementData ( player, "handystate", "off" )
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Handy ausgeschaltet!", 4000,255,0,0 )
		else
			westsideSetElementData ( player, "handystate", "on" )
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Handy angeschaltet!", 4000, 0, 255, 0 )
		end
	end
end
addEvent ( "handychange", true )
addEventHandler ( "handychange", getRootElement(), handychange_func )

function SMS_func ( player, sendnr, sendtext )

	if player == client or not client then
		if westsideGetElementData ( player, "handystate" ) == "on" then
			local pmoney = westsideGetElementData ( player, "money" )
			if ( westsideGetElementData ( player, "handyType" ) == 2 and westsideGetElementData ( player, "handyCosts" ) >= smsprice ) or westsideGetElementData ( player, "handyType" ) ~= 2 then
				for id, playeritem in ipairs(getElementsByType("player")) do 
					if westsideGetElementData ( playeritem, "telenr" ) then
						if westsideGetElementData ( playeritem, "telenr" ) == sendnr then
							if(getElementData(playeritem,'handyAbgenommen')==false)then
								if westsideGetElementData ( playeritem, "handystate" ) == "on" then
									triggerClientEvent ( player, "infobox_start", getRootElement(), "SMS versendet!", 4000, 0, 255, 0 )
									playSoundFrontEnd ( player, 40 )
									outputChatBox ( "SMS von "..getPlayerName(player).."("..westsideGetElementData(player,"telenr").."): "..sendtext, playeritem, 0, 200, 200 )
									if westsideGetElementData ( player, "handyType" ) == 2 then
										westsideSetElementData ( player, "handyCosts", westsideGetElementData ( player, "handyCosts" ) - smsprice )
									elseif westsideGetElementData ( player, "handyType" ) == 1 then
										westsideSetElementData ( player, "handyCosts", westsideGetElementData ( player, "handyCosts" ) + smsprice )
									end
									return
								end
							else
								infobox(player,'Der Spieler hat kein Handy!')
							end
						end
					end
				end
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Das Handy des Spieler ist\naus, oder der Spieler ist\noffline!", 4000,255,0,0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Guthaben!", 4000,255,0,0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Dein Handy ist aus!", 4000,255,0,0 )
		end
	end
end
addEvent ( "SMS", true )
addEventHandler ( "SMS", getRootElement(), SMS_func )

function callSomeone_func ( player, number )
	if player == client or not client then
		if westsideGetElementData ( player, "handystate" ) == "on" then
			local pmoney = westsideGetElementData ( player, "money" )
			if number == "*100#" then
				if westsideGetElementData ( player, "handyType" ) == 2 then
					outputChatBox ( "[INFO]: Aktuelles Guthaben: "..westsideGetElementData ( player, "handyCosts" ).." $", player, 125,125,0 )
				elseif westsideGetElementData ( player, "handyType" ) == 3 then
					outputChatBox ( "[INFO]: Du hast eine Flatrate, Kosten pro Stunde: 50 $", player, 125,125,0 )
				elseif westsideGetElementData ( player, "handyType" ) == 1 then
					outputChatBox ( "[INFO]: Aktuelle Kosten: "..westsideGetElementData ( player, "handyCosts" ).." $", player, 125,125,0 )
				end
			elseif not speznr[tonumber(number)] then
				number = tonumber ( number )
				if ( westsideGetElementData ( player, "handyType" ) == 2 and westsideGetElementData ( player, "handyCosts" ) >= callprice ) or westsideGetElementData ( player, "handyType" ) ~= 2 then
					for id, playeritem in ipairs(getElementsByType("player")) do 
						if westsideGetElementData ( playeritem, "telenr" ) then
							if westsideGetElementData ( playeritem, "telenr" ) == number then
								if(getElementData(playeritem,'handyAbgenommen')==false)then
									if westsideGetElementData ( playeritem, "handystate" ) == "on" then
										if westsideGetElementData ( player, "call" ) == false then
											if westsideGetElementData ( playeritem, "call" ) == false then
												infobox(player,"Tippe /auflegen, um den\nAnruf zu beenden.", 4000, 0,255,0 )
												setPedAnimation ( player, "ped", "phone_in", 1, false, false, true )
												setTimer ( setPedAnimation, 600, 1, player )
												outputChatBox ( getPlayerName(player).." [Nummer: "..westsideGetElementData(player,"telenr").."] ruft an, tippe /abheben, um abzunehmen!", playeritem, 0, 200, 200 )
												westsideSetElementData ( player, "calls", getPlayerName ( playeritem ) )
												westsideSetElementData ( playeritem, "calledby", getPlayerName ( player ) )
												westsideGetElementData ( player, "call", true )
												if westsideGetElementData ( player, "handyType" ) == 2 then
													westsideSetElementData ( player, "handyCosts", westsideGetElementData ( player, "handyCosts" ) - callprice )
												elseif westsideGetElementData ( player, "handyType" ) == 1 then
													westsideSetElementData ( player, "handyCosts", westsideGetElementData ( player, "handyCosts" ) + callprice )
												end
												return
											else
												infobox(player,"Besetzt...",4000,255,0,0)
											end
										else
											infobox(player,"Du telefonierst bereits!",4000,255,0,0)
										end
									end
								else
									infobox(player,'Der Spieler hat kein Handy!')
								end
							end
						end
					end
					if westsideGetElementData ( player, "money" ) == pmoney then
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Das Handy des Spieler ist\naus, oder der Spieler ist\noffline!", 4000, 255, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!\nEin Anruf kostet "..callprice.." $!", 4000, 255, 0, 0 )
				end
			else
				speznr = { [110]=true }
				number = tonumber ( number )
				if number == 110 then
					outputChatBox ( "Sie sprechen mit dem German Roleplay Police Department!", player, 0,100,150 )
					outputChatBox ( "Nennen Sie uns bitte den Namen des Verdächtigen.", player, 0,100,150 )
					westsideSetElementData ( player, "callswithpolice", true )
				end
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Dein Handy ist aus!", 4000, 255, 0, 0 )
		end
	end
end
addEvent ( "callSomeone", true )
addEventHandler ( "callSomeone", getRootElement(), callSomeone_func )

function hangup ( player )

	westsideSetElementData ( getPlayerFromName ( westsideGetElementData ( player, "calls" ) ), "calledby", "none" )
	local caller = getPlayerFromName ( westsideGetElementData ( player, "callswith" ) )
	if caller then
		westsideSetElementData ( caller, "callswith", "none" )
		westsideSetElementData ( caller, "call", false )
		westsideSetElementData ( caller, "calls", "none" )
		westsideSetElementData ( caller, "callswith", "none" )
		westsideSetElementData ( caller, "calledby", "none" )
	end
	westsideSetElementData ( player, "callswith", "none" )
	westsideSetElementData ( player, "call", false )
	westsideSetElementData ( player, "calls", "none" )
	westsideSetElementData ( player, "callswith", "none" )
	westsideSetElementData ( player, "calledby", "none" )
	outputChatBox ( "Du hast aufgelegt!", player, 150,0,0 )
	setPedAnimation ( player, "ped", "phone_out", 1, false, false, true )
    setTimer ( setPedAnimation, 600, 1, player )
	if getPlayerPing ( caller ) ~= false then infobox(caller,"Dein Gesprächspartner hat aufgelegt!",4000,255,0,0) end
end
addCommandHandler ( "auflegen", hangup )

function pickup ( player )

	local caller = getPlayerFromName ( westsideGetElementData ( player, "calledby" ) )
	westsideSetElementData ( player, "calledby", "none" )
	if caller and westsideGetElementData ( player, "call" ) == false then
		westsideSetElementData ( player, "call", true )
		westsideSetElementData ( caller, "call", true )
		westsideSetElementData ( player, "callswith", getPlayerName ( caller ) )
		westsideSetElementData ( caller, "callswith", getPlayerName ( player ) )
		infobox(player,"Du hast abgehoben!",4000,0,255,0)
		infobox(caller,"Dein Gesprächspartner hat abgehoben!",4000,0,255,0)
	else
		infobox(player,"Dich ruft keiner an!",4000,255,0,0)
	end
end
addCommandHandler ( "abheben", pickup )