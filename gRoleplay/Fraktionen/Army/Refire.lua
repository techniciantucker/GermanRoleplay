﻿function vehFire1 ()

	local lv = getPedOccupiedVehicle ( lp )
	if getElementModel ( lv ) == 432 then
		if not isTimer ( reEnableFireTime ) then
			reEnableFireTime = setTimer ( reEnableFire, 15000, 1 )
			toggleControl ( "vehicle_fire", false )
			toggleControl ( "vehicle_secondary_fire", false )
			setControlState ( "vehicle_fire", true )
			setTimer ( setControlState, 100, 1, "vehicle_fire", false )
		end
	elseif getElementModel ( lv ) == 425 then
		if not isTimer ( reEnableFireTime ) then
			reEnableFireTime = setTimer ( reEnableFire, 5000, 1 )
			toggleControl ( "vehicle_fire", false )
			setControlState ( "vehicle_fire", true )
			setTimer ( setControlState, 100, 1, "vehicle_fire", false )
		end
	end
end
function vehFire2 ()

	local lv = getPedOccupiedVehicle ( lp )
	if getElementModel ( lv ) == 432 or getElementModel ( lv ) == 520 then
		if not isTimer ( reEnableFireTime ) then
			reEnableFireTime = setTimer ( reEnableFire, 15000, 1 )
			toggleControl ( "vehicle_fire", false )
			toggleControl ( "vehicle_secondary_fire", false )
			setControlState ( "vehicle_secondary_fire", true )
			setTimer ( setControlState, 100, 1, "vehicle_secondary_fire", false )
		end
	end
end

function reEnableFire ()

	toggleControl ( "vehicle_fire", true )
	toggleControl ( "vehicle_secondary_fire", true )
end