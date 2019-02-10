TowingMarker = createMarker(1631.41016, -1845.13855, 12.5,"cylinder",3,255,0,0);

function HitTowing(hitElement)
	if(getElementType(hitElement) == "vehicle")then
		local veh    = hitElement;
		local player = getVehicleOccupant(hitElement);
		if(isElement(player))then
			if getElementData(player,"onDuty") == true and isMechaniker(player) then
				if(getElementModel(veh) == 525)then
					local vehicleTowing = getVehicleTowedByVehicle(veh);
					if(vehicleTowing ~= false)then
						if(getElementData(vehicleTowing, 'owner') ~= nil and getElementData(vehicleTowing, 'owner') ~= false)then
							local owner = westsideGetElementData(vehicleTowing, 'owner');
							local slot  = westsideGetElementData(vehicleTowing, 'carslotnr_owner');
							if(slot ~= false and slot ~= nil)then
								local towingQuery = mysql_query(handler, "INSERT INTO `towing` (`Name`, `Slot`, `VehId`) VALUES ('"..owner.."','"..slot.."','"..getElementModel(vehicleTowing).."')");
								setElementDimension(vehicleTowing, 99999);
								if(towingQuery)then
									infobox(player,"Das Auto wurde abgeschleppt!",4000,0,255,0)
									westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 100)
								else
									outputDebugString('Towing-Vehicle Error: '..mysql_errno(handler))
								end
							else
								infobox(player,"Du kannst nur Autos\nvon Usern abschleppen!",4000,255,0,0)
							end
						else
							infobox(player,"Du kannst nur Autos\nvon Usern abschleppen!",4000,255,0,0)
						end
					end
				end
			end
		end
	end
end
addEventHandler('onMarkerHit', TowingMarker, HitTowing);

TowingPlayerMarker = createPickup(1615.68372, -1863.37598, 13.53908,3,1239,500);

function HitPlayerTowing(hitElement)
	if not isPedInVehicle(hitElement) then
		if(getElementType(hitElement) == "player")then
			local towingTable    = {};
			local player 		 = hitElement;
			local towingVehicles = mysql_query(handler, "SELECT * FROM towing WHERE Name LIKE '"..getPlayerName(player).."'");
			if(towingVehicles)then
			local row			 = mysql_fetch_assoc(towingVehicles);
				while(row)do 
					table.insert(towingTable, {row['Slot'], row['VehId']});
					row = mysql_fetch_assoc(towingVehicles);
				end
				triggerClientEvent(player, 'LoadTowingList', player, towingTable);
			end
		end
	end
end
addEventHandler('onPickupHit', TowingPlayerMarker, HitPlayerTowing, false);

function BuyFree(player, slot)
	if(tonumber(westsideGetElementData(player, 'money')) >= 3000)then
		local towingQuery = mysql_query(handler, "DELETE FROM `towing` WHERE Name LIKE '"..getPlayerName(player).."' AND Slot LIKE '"..tonumber(slot).."'")
		if(towingQuery)then
			westsideSetElementData(player, 'money', westsideGetElementData(player, 'money') - 3000);
			infobox(player,"Auto freigekauft!",4000,0,255,0)
			outputChatBox("[INFO]: Benutze /respawnen "..slot..", um es wieder zu respawnen!", player, 0,100,150);
			triggerClientEvent(player, 'closeTowedWindow', player);
		else
			outputDebugString('Towing-Vehicle Error: '..mysql_errno(handler))
		end
	else
		infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
	end
end
addEvent('onTowedVehicleBuyFree', true)
addEventHandler('onTowedVehicleBuyFree', root, BuyFree)