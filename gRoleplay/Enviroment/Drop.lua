function drugDropHit ( player )
	if not getPedOccupiedVehicle ( player ) then
		local pickup = source
		local amount = westsideGetElementData ( pickup, "amount" )
		outputChatBox("[INFO]: Du hast "..amount.."g Drogen aufgehoben!",player,0,100,150)
		westsideSetElementData ( player, "drugs", westsideGetElementData ( player, "drugs" ) + amount )
		playSoundFrontEnd ( player, 40 )
		destroyElement ( source )
	end
end

function matDropHit ( player )
	if not getPedOccupiedVehicle ( player ) then
		local pickup = source
		local amount = westsideGetElementData ( pickup, "amount" )
		outputChatBox("[INFO]: Du hast "..amount.." Materialien aufgehoben!",player,0,100,150)
		westsideSetElementData ( player, "mats", westsideGetElementData ( player, "mats" ) + amount )
		playSoundFrontEnd ( player, 40 )
		destroyElement ( source )
	end
end

function moneyDropHit ( player )
	if not getPedOccupiedVehicle ( player ) then
		local pickup = source
		local money = westsideGetElementData ( pickup, "money" )
		outputChatBox("[INFO]: Du hast "..money.."$ aufgehoben!",player,0,100,150)
		givePlayerSaveMoney ( player, money )
		destroyElement ( source )
	end
end

function deleteObject ( object )
	if getElementModel ( object ) == 1210 then
		destroyElement ( object )
	elseif getElementModel ( object ) == 1212 then
		destroyElement ( object )
	end
end

function getDropAmount ( amount )
	return math.floor ( amount / 5 )
end