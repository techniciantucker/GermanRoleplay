function privVehExplode ()
	if westsideGetElementData ( source, "ownerfraktion" ) then
	else
		local oname = westsideGetElementData ( source, "owner" )
		if oname == nil or not oname then
		elseif westsideGetElementData ( source, "Gang" ) ~= 0 then
		local slot = westsideGetElementData(source, "carslotnr_owner" )
		local pname = MySQL_GetString ( "vehicles", "Besitzer", "Slot LIKE '"..slot.."'")
		setTimer ( respawnPrivVeh, 5000, 1, slot, pname )
		else
			local owner = getPlayerFromName ( oname )
			local x1, y1, z1 = getElementPosition ( owner )
			local x2, y2, z2 = getElementPosition ( source )
			if westsideGetElementData ( owner, "loggedin" ) == 1 and getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) < 7.5 then
				setTimer ( respawnPrivVeh, 5000, 1, slot, pname )
			end
		end
		destroyElement ( source )
	end
	setTimer ( killRests, 3000, 1, source )
end
addEventHandler ( "onVehicleExplode", getRootElement(), privVehExplode )

function killRests ( veh )
	if not isElement ( veh ) then
		return
	end
	setElementPosition ( veh, 999999, 999999, -50 )
end

function armoredRespawn ()
	if isEvilCar ( source ) then
		setElementHealth ( source, 2000 )
	elseif isFederalCar ( source ) then
		if getElementModel ( source ) == 601 then
			setElementHealth ( source, 5000 )
		elseif getElementModel ( source ) == 523 then
			setElementHealth ( source, 1000 )
		elseif getElementModel ( source ) == 599 then
			setElementHealth ( source, 2500 )
		elseif getElementModel ( source ) == 525 then
			setElementHealth ( source, 1000 )
		elseif getElementModel ( source ) == 427 then
			setElementHealth ( source, 5000 )
		elseif getElementModel ( source ) == 609 then
			setElementHealth ( source, 5000 )
		elseif getElementModel ( source ) == 490 then
			setElementHealth ( source, 2500 )
		elseif getElementModel ( source ) == 470 or getElementModel ( source ) == 548 or getElementModel ( source ) == 425 or getElementModel ( source ) == 520 or getElementModel ( source ) == 563 then
			setElementHealth ( source, 3000 )
		elseif getElementModel ( source ) == 433 then
			setElementHealth ( source, 5000 )
		else
			setElementHealth ( source, 2000 )
		end
	elseif getElementModel ( source ) == 432 then
		setElementHealth ( source, 8000 )
	end
end
addEventHandler ( "onVehicleRespawn", getRootElement(), armoredRespawn )