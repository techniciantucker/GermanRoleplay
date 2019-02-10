-- Carrest

addCommandHandler("carrest",function(player,cmd,target)
	if target ~= nil then
		target = getPlayerFromName(target)
		local x, y, z = getElementPosition ( player )
		local tx, ty, tz = getElementPosition ( target )
		if isCop(player) or isFBI(player) or isArmy(player) and getElementData(player,"onDuty") == true then
			if getDistanceBetweenPoints3D ( 1568.5802001953,-1694.2972412109,5.890625, x, y, 0 ) < 6.5 or bool then
				if getDistanceBetweenPoints3D ( 1568.5802001953,-1694.2972412109,5.890625, tx, ty, 0 ) < 6.5 or bool then
					if westsideGetElementData ( target, "wanteds" ) >= 1 then
						if westsideGetElementData(target,"wanteds") == 1 then
							removePedFromVehicle ( target )
							arrestPlayer ( player, target, 3)
						elseif westsideGetElementData(target,"wanteds") == 2 then
							removePedFromVehicle ( target )
							arrestPlayer ( player, target, 6)
						elseif westsideGetElementData(target,"wanteds") == 3 then
							removePedFromVehicle ( target )
							arrestPlayer ( player, target, 9)
						elseif westsideGetElementData(target,"wanteds") == 4 then
							removePedFromVehicle ( target )
							arrestPlayer ( player, target, 12)
						elseif westsideGetElementData(target,"wanteds") == 5 then
							removePedFromVehicle ( target )
							arrestPlayer ( player, target, 15)
						elseif westsideGetElementData(target,"wanteds") == 6 then
							removePedFromVehicle ( target )
							arrestPlayer ( player, target, 20)
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Bürger hat kein\nVerbrechen begangen!", 4000, 255, 0, 0 )
					end
				end
			end
		end
	end
end)

-- Stellen

StellenMarker = createMarker ( 249.69999694824,68.300003051758,1002.700012207,"cylinder",1,0,0,200 )
setElementInterior(StellenMarker,6)

addEventHandler("onMarkerHit",StellenMarker,function(player)
	if westsideGetElementData(player,"wanteds") > 0 then
		infobox(player,"Tippe /stellen, um dich\nzu Stellen! (2 Min pro Wanted)",4000,0,255,0)
	else
		infobox(player,"Solltest du Wanteds haben,\nkannst du dich hier stellen!",4000,0,255,0)
	end
end)

addCommandHandler("stellen",function(player,cmd)
	if getDistanceBetweenPoints3D(249.69999694824,68.300003051758,1002.700012207,getElementPosition(player)) < 5 then
		if westsideGetElementData(player,"wanteds") > 0 and westsideGetElementData(player,"wanteds") < 4 then
			if westsideGetElementData(player,"wanteds") == 1 then
				westsideSetElementData(player,"jailtime",2)
			elseif westsideGetElementData(player,"wanteds") == 2 then
				westsideSetElementData(player,"jailtime",4)
			elseif westsideGetElementData(player,"wanteds") == 3 then
				westsideSetElementData(player,"jailtime",6)
			end
			putPlayerInJail(player)
			infobox(player,"Du hast dich gestellt!",4000,0,255,0)
			outputChatBox("Der Spieler "..getPlayerName(player).." hat sich gestellt!",root,115,115,115)
		else
			infobox(player,"Du hast keine Wanteds\noder mehr als 3!",4000,255,0,0)
		end
	end
end)

-- Spieler nach Knast spawnen lassen

function freePlayerFromJail ( player )
	westsideSetElementData ( player, "jailtime", 0 )
	toggleControl ( player, "enter_exit", true )
	toggleControl ( player, "fire", true )
	toggleControl ( player, "jump", true )
	toggleControl ( player, "action", true )
	if westsideGetElementData ( player, "heaventime" ) == 0 then
		setElementInterior ( player, 0 )
		setElementPosition ( player, 1544.4622802734,-1670.4765625,13.558456420898 )
	end
end