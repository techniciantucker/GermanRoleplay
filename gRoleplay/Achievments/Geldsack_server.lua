packageNo1  = createPickup ( 1688.4683837891, -1974.5439453125, 8.8203125, 3, 1550, 0 )
packageNo2  = createPickup ( 1540.9713134766,-1366.8725585938,326.2109375, 3, 1550, 0 )
packageNo3  = createPickup ( 1497.9815673828,-1664.8236083984,34.046875, 3, 1550, 0 )
packageNo4  = createPickup ( 383.4267578125,-1880.8194580078,2.5627036094666, 3, 1550, 0 )
packageNo5  = createPickup ( 2613.1862792969,-2511.8273925781,33.384326934814, 3, 1550, 0 )
packageNo6  = createPickup ( 1575.08203125,-1897.7878417969,13.560832023621, 3, 1550, 0 )
packageNo7  = createPickup ( 1094.4064941406,-2036.96875,82.759895324707, 3, 1550, 0 )
packageNo8  = createPickup ( 2111.6945800781,-1996.6905517578,13.786606788635, 3, 1550, 0 )
packageNo9  = createPickup ( 1663.9453125,-987.66473388672,29.388244628906, 3, 1550, 0 )
packageNo10 = createPickup ( 1971.3211669922,-1284.2987060547,28.488073348999, 3, 1550, 0 )
packageNo11 = createPickup ( 1964.3402099609,-1515.4293212891,22.2421875, 3, 1550, 0 )
packageNo12 = createPickup ( 1654.8544921875,-1636.1636962891,83.78125, 3, 1550, 0 )
packageNo13 = createPickup ( 1413.7697753906,-1459.3533935547,20.428630828857, 3, 1550, 0 )
packageNo14 = createPickup ( 1134.6657714844,-747.517578125,97.162223815918, 3, 1550, 0 )
packageNo15 = createPickup ( 2650.2172851563,-2044.8409423828,13.550000190735, 3, 1550, 0 )
packageNo16 = createPickup ( 2838.0876464844,-2363.208984375,31.003940582275, 3, 1550, 0 )
packageNo17 = createPickup ( 2867.88671875,-2125.4714355469,5.4389295578003, 3, 1550, 0 )
packageNo18 = createPickup ( 2789.6352539063,-1426.2266845703,36.09375, 3, 1550, 0 )
packageNo19 = createPickup ( 2677.0102539063,-1145.3503417969,71.09375, 3, 1550, 0 )
packageNo20 = createPickup ( 2217.3991699219,-1047.4294433594,57.625144958496, 3, 1550, 0 )
packageNo21 = createPickup ( 1233.1910400391,-1261.2086181641,13.619552612305, 3, 1550, 0 )
packageNo22 = createPickup ( 1129.6162109375,-1489.4807128906,22.769031524658, 3, 1550, 0 )
packageNo23 = createPickup ( 291.46539306641,-1503.4194335938,24.921875, 3, 1550, 0 )
packageNo24 = createPickup ( 154.39225769043,-1958.4368896484,3.7734375, 3, 1550, 0 )
packageNo25 = createPickup ( -91.358238220215,-1576.1461181641,2.6171875, 3, 1550, 0 )

function packageSettings ()
	for i = 1, 25 do
		setElementData ( _G["packageNo"..i], "number", i )
	end
end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), packageSettings )

function packageLoad ( player )
	local pname = getPlayerName ( player )
	westsideSetElementData ( player, "foundpackages", 0 )
	if not MySQL_GetString("packages", "Name", "Name LIKE '"..pname.."'") then
		local result = mysql_query(handler, "INSERT INTO packages (Name, Paket1, Paket2, Paket3, Paket4, Paket5, Paket6, Paket7, Paket8, Paket9, Paket10, Paket11, Paket12, Paket13, Paket14, Paket15, Paket16, Paket17, Paket18, Paket19, Paket20, Paket21, Paket22, Paket23, Paket24, Paket25) VALUES ('"..pname.."','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0' )")
		if( not result) then
			outputDebugString("Error executing the query: ("		.. mysql_errno(handler) .. ") " .. mysql_error(handler))
		else
			mysql_free_result(result)
		end
	end
	local dsatz
	local result = mysql_query ( handler, "SELECT * from packages WHERE Name LIKE '"..pname.."'" )
	if result then
		if ( mysql_num_rows ( result ) > 0 ) then
			dsatz = mysql_fetch_assoc ( result )
			mysql_free_result ( result )
		end
	end
	for i = 1, 25 do
		local paket = tonumber ( dsatz["Paket"..i] )
		westsideSetElementData ( player, "package"..i, paket )
		if paket == 1 then
			triggerClientEvent ( player, "hidePackages", getRootElement(), _G["packageNo"..i] )
			westsideSetElementData ( player, "foundpackages", westsideGetElementData ( player, "foundpackages" ) + 1 )
		end
	end
end

addEventHandler("onPickupHit",root,function(player,dim)
	local package=source
	local number=getElementData(source,"number")
	if(isPedInVehicle(player)==false)then
		if(number)then
			if(tonumber(westsideGetElementData(player,"package"..number))==0)then
				local pname=getPlayerName(player)
				westsideSetElementData(player,"package"..number,1)
				westsideSetElementData(player,"foundpackages",westsideGetElementData(player,"foundpackages")+1)
				givePlayerSaveMoney(player,math.random(100,200))
				westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")+200))
				MySQL_SetString("packages","Paket"..number,westsideGetElementData(player,"package"..number),"Name LIKE '"..pname.."'")
				triggerClientEvent(player,"hidePackages",root,package)
				triggerClientEvent(player,"geldsackWindow",player)
				triggerClientEvent(player,"geschafftSound",player)
			end
		end
	end
end)