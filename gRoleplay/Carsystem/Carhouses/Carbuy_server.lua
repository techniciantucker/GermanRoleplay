CarbuyTable = {
    {vehicleID = 405, vehicleMarkerX = -87.5, vehicleMarkerY = -1132, vehicleMarkerZ = 1.078125, carhouse_id = 2},                                        -- Sentinel Wang Cars
	{vehicleID = 576, vehicleMarkerX = -84.099998474121, vehicleMarkerY = -1133.3000488281, vehicleMarkerZ = 1.078125, carhouse_id = 2},                  -- Tornado Wang Cars
	{vehicleID = 567, vehicleMarkerX = -80.699996948242, vehicleMarkerY = -1134.3000488281, vehicleMarkerZ = 1.078125, carhouse_id = 2},                  -- Savanna Wang Cars
	{vehicleID = 518, vehicleMarkerX = -77.300003051758, vehicleMarkerY = -1136.3000488281, vehicleMarkerZ = 1.078125, carhouse_id = 2},                  -- Buccaner Wang Cars
	{vehicleID = 534, vehicleMarkerX = -74.099998474121, vehicleMarkerY = -1137.5, vehicleMarkerZ = 1.078125, carhouse_id = 2},                           -- Remington Wang Cars
	{vehicleID = 542, vehicleMarkerX = -70.900001525879, vehicleMarkerY = -1139.3000488281, vehicleMarkerZ = 1.078125, carhouse_id = 2},                  -- Clover Wang Cars
	{vehicleID = 439, vehicleMarkerX = -67.699996948242, vehicleMarkerY = -1141.0999755859, vehicleMarkerZ = 1.078125, carhouse_id = 2},                  -- Stallion Wang Cars
	{vehicleID = 549, vehicleMarkerX = -64.800003051758, vehicleMarkerY = -1142.5, vehicleMarkerZ = 1.078125, carhouse_id = 2},                           -- Tampa Wang Cars
	----------------------
	{vehicleID = 522, vehicleMarkerX = 1163.8452148438, vehicleMarkerY = -1637.9978027344, vehicleMarkerZ = 14, carhouse_id = 3},                         -- NRG Bike Shop
	{vehicleID = 461, vehicleMarkerX = 1166.6298828125, vehicleMarkerY = -1637.9520263672, vehicleMarkerZ = 14, carhouse_id = 3},                         -- PCJ Bike Shop
	{vehicleID = 463, vehicleMarkerX = 1169, vehicleMarkerY = -1638.0612792969, vehicleMarkerZ = 14, carhouse_id = 3},                                    -- Freeway Bike Shop
	{vehicleID = 468, vehicleMarkerX = 1171.7487792969, vehicleMarkerY = -1637.9273681641, vehicleMarkerZ = 14, carhouse_id = 3},                         -- Sanchez Bike Shop
	{vehicleID = 521, vehicleMarkerX = 1174.4665527344, vehicleMarkerY = -1637.9598388672, vehicleMarkerZ = 14, carhouse_id = 3},                         -- FCR Bike Shop
	{vehicleID = 586, vehicleMarkerX = 1177.0201416016, vehicleMarkerY = -1637.9899902344, vehicleMarkerZ = 14, carhouse_id = 3},                         -- Wayfarer Bike Shop
	{vehicleID = 462, vehicleMarkerX = 1179.7783203125, vehicleMarkerY = -1637.9736328125, vehicleMarkerZ = 14, carhouse_id = 3},                         -- Faggio Bike Shop
	----------------------
	{vehicleID = 487, vehicleMarkerX = 1804.9000244141, vehicleMarkerY = -1383.5, vehicleMarkerZ = 29.234375, carhouse_id = 1},                           -- Maverick Flugzeugladen
	{vehicleID = 469, vehicleMarkerX = 1807, vehicleMarkerY = -1373, vehicleMarkerZ = 29.234375, carhouse_id = 1},                                        -- Sparrow Flugzeugladen
	{vehicleID = 513, vehicleMarkerX = 1794.5999755859, vehicleMarkerY = -1362.3000488281, vehicleMarkerZ = 29.234375, carhouse_id = 1},                  -- Stuntplane Flugzeugladen
	{vehicleID = 519, vehicleMarkerX = 1800.5, vehicleMarkerY = -1406.1999511719, vehicleMarkerZ = 29.234375, carhouse_id = 1},                           -- Shamal Flugzeugladen
	----------------------
	{vehicleID = 411, vehicleMarkerX = 1985.8000488281, vehicleMarkerY = -2073.1999511719, vehicleMarkerZ = 13.52399, carhouse_id = 4},             	  -- Infernus Sportautohaus
	{vehicleID = 415, vehicleMarkerX = 1985.8000488281, vehicleMarkerY = -2080.1000976563, vehicleMarkerZ = 13.52399, carhouse_id = 4},                   -- Cheetah Sportautohaus
	{vehicleID = 541, vehicleMarkerX = 1985.5, vehicleMarkerY = -2087, vehicleMarkerZ = 13.52399, carhouse_id = 4},            					  	      -- Bullet Sportautohaus
	{vehicleID = 560, vehicleMarkerX = 1979, vehicleMarkerY = -2073.1000976563, vehicleMarkerZ = 13.52399, carhouse_id = 4},            			  	  -- Sultan Sportautohaus
	{vehicleID = 429, vehicleMarkerX = 1979.4000244141, vehicleMarkerY = -2080.3000488281, vehicleMarkerZ = 13.52399, carhouse_id = 4},            		  -- Banshee Sportautohaus
	{vehicleID = 402, vehicleMarkerX = 1979.4000244141, vehicleMarkerY = -2087.5, vehicleMarkerZ = 13.52399, carhouse_id = 4},            		  		  -- Buffalo Sportautohaus
	{vehicleID = 506, vehicleMarkerX = 1979.5, vehicleMarkerY = -2094.3999023438, vehicleMarkerZ = 13.52399, carhouse_id = 4},              	          -- Super GT Sportautohaus
	}

local CarbuyMarker = {}

function loadVehicleSystem()
	for key, data in pairs(CarbuyTable) do 
		local id 		  = tonumber(data.vehicleID);
		local price 	  = tonumber(carprices[data.vehicleID]);
		local mPosX		  = tonumber(data.vehicleMarkerX);
		local mPosY 	  = tonumber(data.vehicleMarkerY);
		local mPosZ 	  = tonumber(data.vehicleMarkerZ);
		local carhouse_id = tonumber(data.carhouse_id);
		CarbuyMarker[key] = createPickup(mPosX, mPosY, mPosZ, 3, 1239, 500);
		setElementData(CarbuyMarker[key], 'veh_Id', id);
		setElementData(CarbuyMarker[key], 'veh_Price', price);
		setElementData(CarbuyMarker[key], 'veh_Carhouse', carhouse_id);
	end
end
loadVehicleSystem();

function hitVehicleSystemMarker(element)
	if(getElementType(element) == "player")then
		if isPedInVehicle(element) == false then
			if(getElementData(source, 'veh_Id'))then
				local vehid = tonumber(getElementData(source, 'veh_Id'));
				local price = tonumber(getElementData(source, 'veh_Price'));
				local carhouse_id = tonumber(getElementData(source, 'veh_Carhouse'));
				triggerClientEvent(element, 'onLoadClientVehicleWindow', element, vehid, price);
				westsideSetElementData(element, 'carHouse', carhouse_id);
				westsideSetElementData(element, 'veh_ID', vehid);
			end
		end
	end
end
addEventHandler('onPickupHit', root, hitVehicleSystemMarker);

function buyVehicleSystem(player)
	local carid		 = tonumber(westsideGetElementData(player, 'veh_ID'));
	local carprice	 = tonumber(carprices[carid]);
	local id 		 = tonumber(westsideGetElementData(player, 'carHouse'));
	local sx, sy, sz, rx, ry, rz = MySQLCarhouses[id]["sx"], MySQLCarhouses[id]["sy"], MySQLCarhouses[id]["sz"], MySQLCarhouses[id]["srx"], MySQLCarhouses[id]["sry"], MySQLCarhouses[id]["srz"]
	carbuy(player, carprice, carid, sx, sy, sz, rx, ry, rz);
end
addEvent('doBuyVehicle', true);
addEventHandler('doBuyVehicle', root, buyVehicleSystem);