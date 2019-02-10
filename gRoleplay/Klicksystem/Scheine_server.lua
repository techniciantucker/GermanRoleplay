function LizenzKaufen_func ( player, lizens )

	if player == client then
		local pname = getPlayerName ( player )
		if lizens == "planeb" then -- Flugschein B
			if tonumber(westsideGetElementData ( player, "planelicenseb" )) == 0 then
				if tonumber(westsideGetElementData ( player, "money" )) >= 50000 then
					if westsideGetElementData ( player, "planelicensea" ) == 1 then
						westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - 50000 )
						westsideSetElementData ( player, "planelicenseb", 1 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Fluglizens B erhalten!", 4000, 0, 255, 0 )
						playSoundFrontEnd ( player, 40 )
						takePlayerMoney ( player, 50000 )
						MySQL_SetString("userdata", "FlugscheinKlasseB", westsideGetElementData ( player, "planelicenseb" ), "Name LIKE '"..pname.."'")
						
						westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 500)
						
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Du benötigst zuerst\neinen Flugschein A!", 4000, 255, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast bereits einen Flugschein B!", 4000, 255, 0, 0 )
			end
		elseif lizens == "bike" then -- Motorradschein
			if tonumber(westsideGetElementData ( player, "bikelicense" )) == 0 then
				if tonumber(westsideGetElementData ( player, "money" )) >= 500 then
					westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - 500 )
					westsideSetElementData ( player, "bikelicense", 1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Motorradführerschein erhalten!", 4000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					takePlayerMoney ( player, 500 )
					
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 500)
					
					MySQL_SetString("userdata", "Motorradtfuehrerschein", westsideGetElementData ( player, "bikelicense" ), "Name LIKE '"..pname.."'")
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast bereits einen\nMotorradfuehrerschein!", 4000, 255, 0, 0 )
			end
		elseif lizens == "planea" then -- Flugschein A
			if tonumber(westsideGetElementData ( player, "planelicensea" )) == 0 then
				if tonumber(westsideGetElementData ( player, "money" )) >= 25000 then
					westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - 25000 )
					westsideSetElementData ( player, "planelicensea", 1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Flugschein A erhalten!", 4000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					takePlayerMoney ( player, 25000 )
					
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 500)
					
					MySQL_SetString("userdata", "FlugscheinKlasseA", westsideGetElementData ( player, "planelicensea" ), "Name LIKE '"..pname.."'")
					
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast bereits einen Flugschein!", 4000, 255, 0, 0 )
			end
		elseif lizens == "car" then -- Autoführerschein
			local price
			if getElementData ( player, "playingtime" ) >= 60 * 50 then
				price = 750
			elseif getElementData ( player, "playingtime" ) >= 60 * 25 then
				price = 750
			else
				price = 750
			end
			westsideSetElementData ( player, "drivingLicensePrice", price )
			if tonumber(westsideGetElementData ( player, "carlicense" )) == 0 then
				if tonumber(westsideGetElementData ( player, "money" )) >= price then
					startDrivingSchoolTheory_func ()
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast bereits einen Führerschein!", 4000, 255, 0, 0 )
			end
		elseif lizens == "heli" then -- Helikopterschein
			if tonumber(westsideGetElementData ( player, "helilicense" )) == 0 then
				if tonumber(westsideGetElementData ( player, "money" )) >= 15000 then
					westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - 15000 )
					westsideSetElementData ( player, "helilicense", 1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Helikopter Flugschein erhalten!", 4000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					takePlayerMoney ( player, 15000 )
					
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 500)
					
					MySQL_SetString("userdata", "Helikopterfuehrerschein", westsideGetElementData ( player, "helilicense" ), "Name LIKE '"..pname.."'")
					
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast bereits einen\nHelikopter Flugschein!", 4000, 255, 0, 0 )
			end
		elseif lizens == "raft" then -- Segellizenz
			if tonumber(westsideGetElementData ( player, "segellicense" )) == 0 then
				if tonumber(westsideGetElementData ( player, "money" )) >= 350 then
					if westsideGetElementData ( player, "motorbootlicense" ) == 1 then
						westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - 350 )
						westsideSetElementData ( player, "segellicense", 1 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Segellizens erhalten!", 4000, 0, 255, 0 )
						playSoundFrontEnd ( player, 40 )
						takePlayerMoney ( player, 350 )
						
						westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 500)
						
						MySQL_SetString("userdata", "Segelschein", westsideGetElementData ( player, "segellicense" ), "Name LIKE '"..pname.."'")
						
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Du benötigst zuerst einen\nMotorboot Führerschein!", 4000, 255, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast bereits\neinen Segelschein!", 4000, 255, 0, 0 )
			end
		elseif lizens == "motorboot" then -- Motorbootschein
			if tonumber(westsideGetElementData ( player, "motorbootlicense" )) == 0 then
				if tonumber(westsideGetElementData ( player, "money" )) >= 400 then
					westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - 400 )
					westsideSetElementData ( player, "motorbootlicense", 1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Motorboot Führerschein erhalten!", 4000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					takePlayerMoney ( player, 400 )
					
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 500)
					
					MySQL_SetString("userdata", "Motorbootschein", westsideGetElementData ( player, "motorbootlicense" ), "Name LIKE '"..pname.."'")
					
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast bereits einen\nMotorboot Führerschein!", 4000, 255, 0, 0 )
			end
		end
	end
end
addEvent ( "LizenzKaufen", true )
addEventHandler ( "LizenzKaufen", getRootElement(), LizenzKaufen_func )

----- Infos -----
fahrschulinfopickup = createPickup(1132.1558837891,-1692.7386474609,13.878098487854,3,1239,500)

addEventHandler("onPickupHit",fahrschulinfopickup,function(player)
	if isPedInVehicle(player) == false then
		triggerClientEvent(player,"fahrschulinfos",player)
	end
end)