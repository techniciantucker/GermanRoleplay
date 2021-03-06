﻿function getVariableTyp ( var )

	if isString ( var ) then
		return 0
	elseif tostring ( var ) == "true" or tostring ( var ) == "false" then
		return 1
	elseif tonumber ( var ) then
		return 2
	end
	return 0
end

function isReallyInsideRadarArea ( theArea, x, y )
	local posX, posY = getElementPosition ( theArea )
	local sizeX, sizeY = getRadarAreaSize ( theArea )
	return (x >= posX) and (x <= posX + sizeX) and (y >= posY) and (y <= posY + sizeY)
end

freeDimensions = {}

function sortArray ( tbl )

	local array = {}
	local size = table.size ( tbl )
	
	local curBiggest = 0
	local curID = 0
	
	for k = 1, size do
		for i = 1, size do
			if tbl[i] > curBiggest then
				curBiggest = tbl[i]
				curID = i
			end
		end
		array[k] = curBiggest
		tbl[curID] = 0
		curBiggest = 0
	end
	
	return array
end

function outputArray ( table )

	for i = 1, 5 do
		outputServerLog ( "Value: "..table[i] )
	end
end

function isPedAiming ( ped )

	if getLocalPlayer then
		return getPedControlState ( ped, "aim_weapon" )
	else
		return getControlState ( ped, "aim_weapon" )
	end
	return false
end

function damagePlayer ( player, amount, damager, weapon )

	if isElement ( player ) then
		local armor = getPedArmor ( player )
		local health = getElementHealth ( player )
		if armor > 0 then
			if armor >= amount then
				setPedArmor ( player, armor - amount )
			else
				setPedArmor ( player, 0 )
				amount = math.abs ( armor - amount )
				setElementHealth ( player, health - amount )
				if getElementHealth ( player ) - amount <= 0 then
					killPed ( player, damager, weapon, 3, false )
				end
			end
		else
			if getElementHealth ( player ) - amount <= 0 then
				killPed ( player, damager, weapon, 3, false )
			end
			setElementHealth ( player, health - amount )
		end
	end
end

function formNumberToMoneyString ( value )

	if tonumber ( value ) then
		value = tostring ( value )
		if string.sub ( value, 1, 1 ) == "-" then
			return "-"..setDotsInNumber ( string.sub ( value, 2, #value ) ).." $"
		else
			return setDotsInNumber ( value ).." $"
		end
	end
	return false
end

function setDotsInNumber ( value )

	if #value > 3 then
		return setDotsInNumber ( string.sub ( value, 1, #value - 3 ) ).."."..string.sub ( value, #value - 2, #value )
	else
		return value
	end
end

function isPlayerUnarmed ( player )

	for i = 2, 8 do
		if getPedWeapon ( player, i ) > 0 then
			if getPedTotalAmmo ( player, i ) > 0 then
				return false
			end
		end
	end
	return true
end

function getFreeDimension ()

	for i = 1, 10 do
		local rnd = math.random ( 10, 65000 )
		if not freeDimensions[rnd] then
			freeDimensions[rnd] = true
			return rnd
		end
	end
	return 0
end

function setMoveable ( player, bool )

	if lp then
		bool = player
	elseif isElement ( player ) then
		
	end
end

function timestampOptical ()

	local regtime = getRealTime()
	local year = regtime.year + 1900
	local month = regtime.month
	local day = regtime.monthday
	local hour = regtime.hour
	local minute = regtime.minute
			
	return tostring(day.."."..month.."."..year..", "..hour..":"..minute)
end

monthDays = {
 [1]=31,
 [2]=28,
 [3]=31,
 [4]=30,
 [5]=31,
 [6]=30,
 [7]=31,
 [8]=31,
 [9]=30,
 [10]=31,
 [11]=30,
 [12]=31
 }

function getDaysInMonth ( month, year )

	local leap = isYearALeapYear ( year )
	if month == 2 and leap then
		return 29
	else
		return monthDays[month]
	end
end

function isYearALeapYear(year)
    if (not year) then year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end

function toggleVehicleTrunk ( veh )

	if westsideGetElementData ( veh, "stuning1" ) then
		local vx, vy, vz = getElementVelocity ( veh )
		local x, y, z = getElementPosition ( veh )
		setElementFrozen ( veh, true )
		setElementPosition ( veh, x, y, z - 50 )
		local state = westsideGetElementData ( veh, "trunkState" )
		if westsideGetElementData ( veh, "trunkState" ) == nil then
			westsideSetElementData ( veh, "trunkState", false )
			setVehicleDoorState ( veh, 1, 0 )
			state = false
		end
		westsideSetElementData ( veh, "trunkState", not state )
		if state then
			setVehicleDoorState ( veh, 1, 0 )
		else
			setVehicleDoorState ( veh, 1, 4 )
		end
		setElementFrozen ( veh, false )
		setElementPosition ( veh, x, y, z )
		setElementVelocity ( veh, vx, vy, vz )
	end
end

function getVehicleTrunkState ( veh )

	if westsideGetElementData ( veh, "trunkState" ) then
		return true
	end
	return false
end

function getDistanceBetweenMinutes ( m1, h1, m2, h2 )

	local t1 = m1 + h1 * 60
	local t2 = m2 + h2 * 60
	if t2 == t1 then
		return 0
	elseif t2 > t1 then
		return t2 - t1
	else
		return math.abs ( 1440 - t1 + t2 )
	end
end

function attachElementsInCorrectWay ( element1, element2 )

	local x1, y1, z1 = getElementPosition ( element1 )
	local x2, y2, z2 = getElementPosition ( element2 )
	attachElements ( element1, element2, x1-x2, y1-y2, z1-z2 )
end
function attachElementsInVeryCorrectWay ( element1, element2 )

	local x1, y1, z1 = getElementPosition ( element1 )
	local rx1, ry1, rz1 = getElementRotation ( element1 )
	local x2, y2, z2 = getElementPosition ( element2 )
	local rx2, ry2, rz2 = getElementRotation ( element1 )
	attachElements ( element1, element2, x1-x2, y1-y2, z1-z2, rx2, ry2, rz2 )
end

function table.copy(tab)
    local ret = {}
    for key, value in pairs(tab) do
        if ( type ( value ) == "table" ) then
			ret [ key ] = table.copy ( value )
        else
			ret [ key ] = value
		end
    end
    return ret
end

function table.size ( tab )
    local length = 0
    for _ in pairs ( tab ) do length = length + 1 end
    return length
end

function getPointFromDistanceRotation ( x, y, dist, angle )

	local a = math.rad ( 90 - angle )
	local dx = math.cos ( a ) * dist
	local dy = math.sin ( a ) * dist
	return x + dx, y + dy
end

function isString ( text )

	if not tonumber ( text ) and tostring ( text ) ~= "true" and tostring ( text ) ~= "false" and tostring ( text ) ~= "nil" then
		return true
	else
		return false
	end
end

function timestamp ()

	local regtime = getRealTime()
	local year = regtime.year + 1900
	local month = regtime.month + 1
	local day = regtime.monthday
	local hour = regtime.hour + winterzeit
	if hour == 24 then hour = 0 end
	local minute = regtime.minute
	local timestamp = tostring(day.."."..month.."."..year..", "..hour..":"..minute)
	return timestamp
end

function timestampDays ( add )

	local regtime = getRealTime()
	local day = regtime.monthday + add
	local year = regtime.year + 1900
	while day > 365 do
		day = day - 365
		year = year + 1
	end
	local month = regtime.month + 1
	local hour = regtime.hour + winterzeit
	if hour == 24 then hour = 0 end
	local minute = regtime.minute
	local timestamp = day.."."..month.."."..year
	return timestamp
end

function setVehicleStatic ( vehicle, boolean )

	if boolean then
		local x, y, z = getElementPosition ( vehicle )
		local rx, ry, rz = getElementRotation ( vehicle )
		local master = createObject ( 1337, x, y, z )
		setElementRotation ( master, rx, ry, rz )
		setElementAlpha ( master, 0 )
		attachElementsInCorrectWay ( vehicle, master )
		setVehicleDamageProof ( vehicle, true )
		setVehicleDoorsUndamageable ( vehicle, true )
		setVehicleLocked ( vehicle, true )
	end
end

function isWithinNightTime ()

	local time = getRealTime()
	local hour = time.hour
	if hour >= 20 or hour <= 8 then
		return true
	else
		return false
	end
end

function fadeElementInterior ( player, int, intx, inty, intz, rot, dim )

	if getElementType ( player ) == "player" then
		if not westsideGetElementData ( player, "intchange" ) then
			westsideSetElementData ( player, "intchange", true )
			if lp then
				fadeCamera ( false, 1, 0, 0, 0 )
				setTimer ( fadeCamera, 1000, 1, true )
				setTimer ( setElementInterior, 1000, 1, player, int )
				setTimer ( setElementDimension, 1000, 1, player, dim )
				setTimer ( setElementPosition, 1000, 1, player, intx, inty, intz )
				if rot then
					setTimer ( setPedRotation, 1000, 1, player, rot )
				end
				setTimer ( westsideSetElementData, 2000, 1, player, "intchange", false )
			else
				fadeCamera ( player, false, 1, 0, 0, 0 )
				setTimer ( fadeCamera, 1000, 1, player, true )
				setTimer ( setElementInterior, 1000, 1, player, int )
				setTimer ( setElementPosition, 1000, 1, player, intx, inty, intz )
				if rot then
					setTimer ( setPedRotation, 1000, 1, player, rot )
				end
				setTimer ( westsideSetElementData, 2000, 1, player, "intchange", false )
			end
		end
	end
end

function vanishElement ( element )

	if isElement ( element ) then
		for i = 1, 25 do
			setTimer ( setElementAlpha, 100 * i, 1, element, 255 / 25 * ( 25 - i ) )
		end
		setTimer ( destroyElement, 2500, 1, element )
	end
end

function addPlayerHealth ( player, value )

	if isElement ( player ) then
		local total = getElementHealth ( player ) + value
		if total > 100 then
			setElementHealth ( player, 100 )
		else
			setElementHealth ( player, total )
		end
	end
end

function toggleChatControls ( bool )

	toggleControl ( "chatbox", bool )
end

function getSecTime ( duration )

	if not duration then
		duration = 0
	end
	local time = getRealTime()
	local year = time.year
	local day = time.yearday
	local hour = time.hour
	local minute = time.minute
	
	local total = year * 365 * 24 * 60 + day * 24 * 60 + ( hour + duration ) * 60 + minute
	
	return total
end

function getMinTime ()

	return getSecTime ( 0 )
end

function getSecondTime ( duration )

	local time = getRealTime ()
	local year = time.year
	local day = time.yearday
	local hour = time.hour
	local minute = time.minute
	local seconds = time.second
	
	local total = 0
	total = year * 365 * 24 * 60 * 60
	total = total + day * 24 * 60 * 60
	total = total + hour * 60 * 60
	total = total + minute * 60
	total = total + seconds + duration
	
	return total
end

-- // Übergang
function fadeElementInterior ( player, int, intx, inty, intz, rot, dim )
	if getElementType ( player ) == "player" then
		if getElementData(player,"intchange") == false then
			setElementData(player,"intchange",true)
			
			triggerClientEvent(player,"newuebergang",player)
			
			setTimer(function()
				setElementInterior(player,int)
				setElementPosition(player, intx, inty, intz)
				if dim then setElementDimension(player,dim) end
				if rot then setElementRotation(player,0,0,rot) end
			end,3000,1)
			setTimer ( function()
				setElementData(player,"intchange",false)
			end, 5000, 1)
		end
	end
end