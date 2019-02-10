function openLocatePanel(player)
	local vehicleTriggerList = {};
	local vehicles = getPlayerVehicles(player);
	for k, v in pairs(vehicles) do 
		local veh  = v[1];
		local slot = tonumber(westsideGetElementData(veh, 'carslotnr_owner'));
		local name = tostring(getVehicleNameFromModel(getElementModel(veh)));
		table.insert(vehicleTriggerList, {slot, name});
	end
	triggerClientEvent(player, 'onLoadVehicleList', player, vehicleTriggerList);
end
addEvent('runningVehiclePanel', true)
addEventHandler('runningVehiclePanel', root, openLocatePanel)

function getPlayerVehicles(player)
	local vehicleList = {}
	local resultVehicle = mysql_query (handler, "SELECT * FROM `vehicles` WHERE `Besitzer` = '"..getPlayerName(player).."'");
	if(resultVehicle)then
		local result = mysql_fetch_assoc(resultVehicle);
		while(result)do 
			local vehicle = _G[getPrivVehString(getPlayerName(player), result['Slot'])];
			table.insert(vehicleList, {vehicle});
			result  = mysql_fetch_assoc(resultVehicle);
		end
	else
		outputDebugString('Error with `getPlayerVehicles` MySQL: '..mysql_errno(handler))
	end
	return vehicleList;
end