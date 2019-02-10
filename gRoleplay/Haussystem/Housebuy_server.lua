function housePickup ( player )
	if isPedInVehicle (player) == false then
		if getElementModel ( source ) == 1273 or getElementModel ( source ) == 1272 then
			if westsideGetElementData ( source, "owner" ) == "none" then
				preis = westsideGetElementData ( source, "preis" )
				--mintime = westsideGetElementData (source, "mintime")
				
				local x, y, z = getElementPosition ( source )
				westsideSetElementData ( player, "housex", x )
				westsideSetElementData ( player, "housey", y )
				westsideSetElementData ( player, "housez", z )
				westsideSetElementData ( player, "house", source )
				
				triggerClientEvent(player, 'onCreateNewHouseGUI', player)
			elseif westsideGetElementData ( source, "owner" ) ~= "none" then
				
				if tostring(getElementData(source, "owner")) ~= getPlayerName(player) then
					--mintime = westsideGetElementData (source, "mintime")
					
					triggerClientEvent ( player, 'onLoadMieterhouse', player )
					
					local x, y, z = getElementPosition ( source )
					westsideSetElementData ( player, "housex", x )
					westsideSetElementData ( player, "housey", y )
					westsideSetElementData ( player, "housez", z )
					westsideSetElementData ( player, "house", source )
				else
					westsideSetElementData ( player, "housex", x )
					westsideSetElementData ( player, "housey", y )
					westsideSetElementData ( player, "housez", z )
					westsideSetElementData ( player, "house", source )
					triggerClientEvent ( player, 'onCreateOwnerHouseGUI', player )
				end
			end
		end
	end
end
addEventHandler ( "onPickupHit", getRootElement(), housePickup )

function buyhouse_func ( player, cmd, zahlart )

	if zahlart == "bank" or zahlart == "bar" then
		if westsideGetElementData ( player, "housex" ) ~= 0 then
			local haus = westsideGetElementData ( player, "house" )
			local x1, y1, z1 = getElementPosition ( player )
			local x2 = westsideGetElementData ( player, "housex" )
			local y2 = westsideGetElementData ( player, "housey" )
			local z2 = westsideGetElementData ( player, "housez" )
			local pname = getPlayerName ( player )
			local distance = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 )
			if distance < 5 then
				if westsideGetElementData ( haus, "owner" ) == "none" then
					--if westsideGetElementData ( player, "playingtime" )/60 > westsideGetElementData ( haus, "mintime" ) then
						if not MySQL_DatasetExist ( "buyit", "Hoechstbietender LIKE '"..pname.."' AND Typ LIKE 'Houses'" ) then
							if haus ~= "none" then
								if tonumber(westsideGetElementData ( player, "housekey" )) <= 0 then
									local hauskosten = tonumber(westsideGetElementData ( haus, "preis" ))
									if zahlart == "bank" then
										if getElementData(player,"bankpin") > 0 then
											local hauskosten = hauskosten*1.02
											if westsideGetElementData ( player, "bankmoney" ) >= hauskosten then
												MySQL_SetString("houses", "Besitzer", pname, "ID LIKE '"..westsideGetElementData ( haus, "id" ).."'")
												
												westsideSetElementData ( player, "bankmoney", westsideGetElementData ( player, "bankmoney" ) - hauskosten )
												
												westsideSetElementData ( player, "housekey", westsideGetElementData ( haus, "id" ) )
												westsideSetElementData ( haus, "owner", pname )
												setElementModel ( haus, 1272 )
												
												infobox(player,"Du hast dir das Haus gekauft!")
												
												datasave_remote(player)
												
												if(westsideGetElementData(player,'Erfolg_MeinZuhause')==0)then
													westsideSetElementData(player,"Erfolg_MeinZuhause",1)
													triggerClientEvent(player,'erfolgWindow',player,'Mein eigenes Zuhause')
													westsideSetElementData(player,'pokale',tonumber(westsideGetElementData(player,'pokale'))+1)
													outputLog(getPlayerName(player)..' hat den Erfolg Mein eigenes Zuhause freigeschalten!','Erfolge')
												end
												
												outputLog ("[HAUS]: "..getPlayerName ( player ).." hat ein Haus gekauft ( "..westsideGetElementData ( haus, "id" ).." )", "Haussystem" )
											else
												triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug\nGeld auf dem Konto!", 5000, 125, 0, 0 )
											end
										else
											infobox(player,"Du hast kein Konto!")
										end
									else
										if westsideGetElementData ( player, "money" ) >= hauskosten then
											if tonumber(westsideGetElementData ( player, "perso" )) == 1 then
												MySQL_SetString("houses", "Besitzer", pname, "ID LIKE '"..westsideGetElementData ( haus, "id" ).."'")

												westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - hauskosten )
												takePlayerMoney ( player, hauskosten )
											
												westsideSetElementData ( player, "housekey", westsideGetElementData ( haus, "id" ) )
												westsideSetElementData ( haus, "owner", pname )
												setElementModel ( haus, 1272 )
											
												datasave_remote(player)
												
												if(westsideGetElementData(player,'Erfolg_MeinZuhause')==0)then
													westsideSetElementData(player,"Erfolg_MeinZuhause",1)
													triggerClientEvent(player,'erfolgWindow',player,'Mein eigenes Zuhause')
													westsideSetElementData(player,'pokale',tonumber(westsideGetElementData(player,'pokale'))+1)
													outputLog(getPlayerName(player)..' hat den Erfolg Mein eigenes Zuhause freigeschalten!','Erfolge')
												end
												
												infobox(player,"Du hast dir das Haus gekauft!")
											
												outputLog ("[HAUS]: "..getPlayerName ( player ).." hat ein Haus gekauft ( "..westsideGetElementData ( haus, "id" ).." )", "Haussystem" )
											else
												infobox(player,"Du hast keinen Personalausweis!")
											end
										end
									end
									MySQL_SetString("userdata", "Hausschluessel", westsideGetElementData ( player, "housekey" ), "Name LIKE '"..getPlayerName(player).."'")
								end
							end
						end
					--end
				end
			end
		end
	end
end
addCommandHandler ( "buyhouse", buyhouse_func )

function houseBuyGUI(player, zahlart)
	executeCommandHandler('buyhouse', player, zahlart)
end
addEvent('onHouseBuyGUI', true)
addEventHandler('onHouseBuyGUI', root, houseBuyGUI)