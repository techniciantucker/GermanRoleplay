Armypickup = createPickup(242.13252, 1861.61194, 14.08401,3,1242,500)

addEventHandler("onPickupHit",Armypickup,function(player)
	if isArmy(player) then
		triggerClientEvent(player,"openDuty",player)
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end)