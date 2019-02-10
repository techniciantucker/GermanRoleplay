-- Mechaniker Duty
MechanikerDutyPickup = createPickup (1637.38965, -1795.36182, 13.52286,3,1239,500)

function MechanikerDutyPickupHit_func(player)
	if isMechaniker(player) then
		triggerClientEvent(player,"openDuty",player)
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end
addEventHandler("onPickupHit",MechanikerDutyPickup,MechanikerDutyPickupHit_func)