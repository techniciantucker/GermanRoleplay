local Help = createPickup(2545.54175, -1512.86365, -12.32031, 3, 1239, 1);

function hilfe_pickup(player)
   infobox(player,"Tippe /hilfe, um ein\nTeammitglied zu kontaktieren!",4000,0,100,150)
end
addEventHandler("onPickupHit",Help,hilfe_pickup)

----- Teleportieren -----
addCommandHandler("report", function(player)
	if getElementData(player, "loggedin") then
		if getElementInterior(player) == 0 then
			if not isPedInVehicle(player) then
				if westsideGetElementData(player,"inReportHalle") == false then
					local x, y, z = getElementPosition(player);
					setElementData(player, "old_position_x", x);
					setElementData(player, "old_position_y", y);
					setElementData(player, "old_position_z", z);
					if tonumber(westsideGetElementData(player, "adminlvl")) > 0 then
						triggerClientEvent(player,"newloadscreen",player)
						
						setTimer(function()
						setElementPosition(player, 2547.79175, -1520.68982, -12.32031);
						outputChatBox("[INFO]: Tippe /leavereport, um die Reporthalle wieder zu verlassen!",player,0,100,150)
						westsideSetElementData ( player, "inReportHalle", true)
						toggleControl( player, "fire", false )
						end,3000,1)
						
						outputLog("[REPORT]: "..getPlayerName(player).." hat die Reporthalle betreten!","Reportsystem")
					else
						triggerClientEvent(player,"newloadscreen",player)
						
						setTimer(function()
						setElementPosition(player, 2570.48926, -1523.93347, -12.32031);
						outputChatBox("[INFO]: Tippe /leavereport, um die Reporthalle wieder zu verlassen!",player,0,100,150)
						westsideSetElementData ( player, "inReportHalle", true)
						toggleControl( player, "fire", false )
						end,3000,1)
						
						outputLog("[REPORT]: "..getPlayerName(player).." hat die Reporthalle betreten!","Reportsystem")
					end
				else
					infobox(player,"Du bist bereits in\nder Reporthalle!",4000,255,0,0)
				end
			else	
				infobox(player,"Steige vorher aus\ndeinem Fahrzeug aus!",4000,255,0,0)
			end
		else
			infobox(player,"Verlasse zu erst dein Interior!",4000,255,0,0)
		end
	end
end)

----- Hilfe -----
addCommandHandler("hilfe", function(player)
	local x, y, z = getElementPosition(player)
	if getDistanceBetweenPoints3D(2545.54175, -1512.86365, -12.32031,getElementPosition(player)) < 5 then
		for _, p in pairs(getElementsByType("player")) do 
			if getElementData(p, "loggedin") then
				if tonumber(westsideGetElementData(p, "adminlvl")) > 0 then
				    infobox(player,"Alle Teammitglieder, welche online\nsind, wurde benachrichtig!",4000,0,255,0)
					outputChatBox("[ADMIN]: "..getPlayerName(player).." benötigt Hilfe! Tippe /acceptReport und dann /report!", p, 255,255,0);
					
					outputLog("[REPORT]: "..getPlayerName(player).." hat Hilfe angefordert!","Reportsystem")
				end
			end
		end
	end
end)

----- Accept Report -----
addCommandHandler('acceptReport',function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'adminlvl')>=1)then
			for i,pi in ipairs(getElementsByType("player")) do
				if(getElementData(pi,"inReportHalle")==true)then
					outputChatBox('[REPORT]: Ein Admin hat seine Anwesenheit bestätigt und kommt gleich!',pi,0,100,150)
				end
			end
			infobox(player,'Der User weiß nun bescheid!')
		end
	end
end)

---- Verlassen -----
addCommandHandler("leavereport", function(player)
    if westsideGetElementData ( player, "inReportHalle" ) == true then
	    local x, y, z =  getElementData(player, "old_position_x"), getElementData(player, "old_position_y"), getElementData(player, "old_position_z");
	    if x and y and z then
			triggerClientEvent(player,"newloadscreen",player)
		
			setTimer(function()
		    setElementPosition(player, x, y, z);
		    westsideSetElementData ( player, "inReportHalle", false)
			toggleControl( player, "fire", true )
			end,3000,1)
			
			outputLog("[REPORT]: "..getPlayerName(player).." hat die Reporthalle verlassen!","Reportsystem")
		end
	end
end)