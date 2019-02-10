drivingSchoolMarkers = {
 ["x"] = {
  [1]=1124.5554199219,
  [2]=1039.8621826172,
  [3]=1090.5563964844,
  [4]=1147.7645263672,
  [5]=1147.4201660156
 },
 ["y"] = {
  [1]=-1709.8487548828,
  [2]=-1633.4322509766,
  [3]=-1574.3781738281,
  [4]=-1607.2624511719,
  [5]=-1694.5161132813
 },
 ["z"] = {
  [1]=13.3828125,
  [2]=13.3828125,
  [3]=13.375,
  [4]=13.78125,
  [5]=13.78125
 }
}

function startDrivingSchoolTheory_func ()
	local player = client
	setElementDimension ( player, tonumber ( westsideGetElementData ( player, "playerid" ) ) )
	setElementPosition ( player, -2026.8765869141,-114.54772186279,1035.171875)
	setElementInterior (player, 3)
	setPedRotation ( player, 180 )
	triggerClientEvent ( player, "startDrivingLicenseTheory", player )
	showCursor ( player, true )
	setElementData ( player, "ElementClicked", true )
end

function showNextDrivingSchoolMarker ( player )
	if westsideGetElementData ( player, "drivingSchoolPractise" ) then
		local old = westsideGetElementData ( player, "drivingSchoolMarker" )
		if old then
			if isElement ( old ) then
				destroyElement ( old )
				destroyElement ( westsideGetElementData ( player, "drivingSchoolBlip" ) )
			end
		end
		local new = westsideGetElementData ( player, "drivingSchoolCur" ) + 1
		westsideSetElementData ( player, "drivingSchoolCur", new )
		if new <= table.size ( drivingSchoolMarkers["x"] ) then
			local x, y, z = drivingSchoolMarkers["x"][new], drivingSchoolMarkers["y"][new], drivingSchoolMarkers["z"][new]
			local marker = createMarker ( x, y, z, "checkpoint", 3, 125,0,125,0, player )
			local blip = createBlip ( x, y, z, 0, 2, 255, 0, 0, 255, 0, 99999.0, player )
			local dim = getElementDimension ( player )
			westsideSetElementData ( player, "drivingSchoolMarker", marker )
			westsideSetElementData ( player, "drivingSchoolBlip", blip )
			setElementDimension ( marker, dim )
			setElementDimension ( blip, dim )
			addEventHandler ( "onMarkerHit", marker, showNextDrivingSchoolMarker )
		else
			triggerClientEvent(player,"newloadscreen",player)
		
			setTimer(function()
			infobox(player,"Du hast die Fahrprüfung bestanden!",4000,0,255,0)
		
			triggerClientEvent ( player, "drivingSchoolFinished", player )
			spawnAfterDrivingSchool ( player )
			westsideSetElementData ( player, "carlicense", 1 )
			playSoundFrontEnd ( player, 40 )
			westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - westsideGetElementData ( player, "drivingLicensePrice" ) )
			MySQL_SetString ( "userdata", "Autofuehrerschein", westsideGetElementData ( player, "carlicense" ), "Name LIKE '"..getPlayerName ( player ).."'")
			
			westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 50)
			end,3000,1)
			
			outputLog("[FAHRSCHULE]: "..getPlayerName(player).." hat die Fahrprüfung bestanden!","Fahrschule")
		end
	end
end

function drivingSchoolTheoryComplete_func ( correct )
	local player = client
	if correct >= 6 then
		triggerClientEvent(player,"newloadscreen",player)
	
		setTimer(function()
		showCursor ( player, false )
		westsideSetElementData ( player, "ElementClicked", false )
		
		setElementInterior ( player, 0 )
		local dim = getElementDimension ( player )
		local veh = createVehicle ( 560, 1148.2303466797,-1694.626953125,13.190926551819, 0, 0, 180 )
		local ped = createPed ( 17, 0, 0, 0 )
		warpPedIntoVehicle ( player, veh, 0 )
		warpPedIntoVehicle ( ped, veh, 1 )
		setVehicleDamageProof ( veh, true )
		setElementDimension ( veh, dim )
		setElementDimension ( ped, dim )
		westsideSetElementData ( player, "drivingSchoolVeh", veh )
		westsideSetElementData ( player, "drivingSchoolPed", ped )
		westsideSetElementData ( player, "drivingSchoolCur", 0 )
		westsideSetElementData ( player, "drivingSchoolPractise", true )
		
		westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 50)
		
		toggleControl ( player, "enter_exit", false )
		outputChatBox("Fahre nun alle Marker ab! Achte darauf, dass du /limit 80 eintippst, bevor",player)
		outputChatBox("du losfährst, damit du die maximal Geschwindigkeit nicht überschreitest!",player)
		setTimer ( triggerClientEvent, 1000, 1, player, "checkDrivingSchoolSpeed", player )
		showNextDrivingSchoolMarker ( player )
		addEventHandler ( "onVehicleExit", veh,function ( player )
			infobox ( player, "Du hast das Fahrzeug verlassen!", 4000,255,0,0 )
			spawnAfterDrivingSchool ( player )
		end)
		addEventHandler ( "onPlayerQuit", player, drivingSchoolQuit )
		
		end,3000,1)
	else
		infobox ( player, "Du bist durchgefallen!", 4000,255,0,0 )
		showCursor(player,false)
		spawnAfterDrivingSchool ( player )
	end
end
addEvent ( "drivingSchoolTheoryComplete", true )
addEventHandler ( "drivingSchoolTheoryComplete", getRootElement(), drivingSchoolTheoryComplete_func )

function drivingSchoolQuit ()
	local player = source
	if westsideGetElementData ( player, "drivingSchoolPractise" ) then
		spawnAfterDrivingSchool ( player )
	end
end

function drivingSchoolToFast_func ()
	local client = player
	if westsideGetElementData ( player, "drivingSchoolPractise" ) then
		triggerClientEvent(player,"newloadscreen",player)
		
		setTimer(function()
		spawnAfterDrivingSchool ( player )
		infobox ( player, "Du bist zu schnell gefahren!", 4000,255,0,0 )
		end,3000,1)
	end
end
addEvent ( "drivingSchoolToFast", true )
addEventHandler ( "drivingSchoolToFast", getRootElement(), drivingSchoolToFast_func )

function spawnAfterDrivingSchool ( player )
	if westsideGetElementData ( player, "drivingSchoolPractise" ) then
		westsideSetElementData ( player, "drivingSchoolPractise", false )
		local veh = westsideGetElementData ( player, "drivingSchoolVeh" )
		if veh then
			if isElement ( veh ) then
				removePedFromVehicle ( player )
				destroyElement ( veh )
			end
		end
		local ped = westsideGetElementData ( player, "drivingSchoolPed" )
		if ped then
			if isElement ( ped ) then
				destroyElement ( ped )
			end
		end
		local old = westsideGetElementData ( player, "drivingSchoolMarker" )
		if old then
			if isElement ( old ) then
				destroyElement ( old )
				destroyElement ( westsideGetElementData ( player, "drivingSchoolBlip" ) )
			end
		end
		if isElement ( player ) then
			triggerClientEvent(player,"newloadscreen",player)
			
			setTimer(function()
			setElementInterior ( player, 0 )
			toggleControl ( player, "enter_exit", true )
			setElementPosition ( player, -2023.6306152344,-118.86651611328,1035.171875 )
			setElementInterior ( player, 3)
			setPedRotation ( player, 90 )
			setCameraTarget ( player )
			setElementDimension ( player, 0 )
			showCursor ( player, false )
			setElementData ( player, "ElementClicked", false )
			triggerClientEvent ( player, "drivingSchoolFinished", player )
			end,3000,1)
		end
	end
end