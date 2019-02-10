function westsideSetElementData ( element, field, value )
	return setElementData ( element, field, value )
end

function westsideGetElementData ( element, field )
	return getElementData ( element, field )
end

validGunCheatProofs = { [1]=true, [2]=true, [3]=true, [4]=true, [5]=true, [6]=true, [7]=true, [8]=true, [9]=true, [10]=true }

player = lp

function start_anticheat ()
	weapon0_ammo = 9999
	weapon1_ammo = 9999
	weapon2_ammo = 9999
	weapon3_ammo = 9999
	weapon4_ammo = 9999
	weapon5_ammo = 9999
	weapon6_ammo = 9999
	weapon7_ammo = 9999
	weapon8_ammo = 9999
	weapon9_ammo = 9999
	weapon10_ammo = 9999
	weapon11_ammo = 9999
	weapon12_ammo = 9999
	for i = 1, 12 do
		_G["weaponslot_"..i.."_banct"] = 0
	end
	player_health = getElementHealth ( lp )
	player_armor = getPedArmor ( lp )
	aCheatRun = 0
	for i = 1, 12 do
		_G["gunElementData"..i] = 0
		_G["gunElementData"..i.."Ammo"] = 0
		setElementData ( lp, "weaponInSlot"..i, _G["gunElementData"..i] )
		setElementData ( lp, "weaponInSlot"..i.."Ammo", _G["gunElementData"..i.."Ammo"] )
	end
	setTimer ( anticheat, 10000, 1 )
end
addEventHandler ( "onClientResourceStart", getRootElement(), start_anticheat )

function anticheat ()
	for i = 1, 12 do
		setElementData ( lp, "weaponInSlot"..i, 0 )
		setElementData ( lp, "weaponInSlot"..i.."Ammo", 0 )
	end
	for i = 1, 12 do
		if not ( _G["gunElementData"..i] == getPedWeapon ( lp, i ) and _G["gunElementData"..i.."Ammo"] == getPedTotalAmmo ( lp, i ) ) then
			_G["gunElementData"..i] = getPedWeapon ( lp, i )
			_G["gunElementData"..i.."Ammo"] = getPedTotalAmmo ( lp, i )
			
		end
		setElementData ( lp, "weaponInSlot"..i, getPedWeapon ( lp, i ) )
		setElementData ( lp, "weaponInSlot"..i.."Ammo", getPedTotalAmmo ( lp, i ) )
	end
	if getElementData ( lp, "loggedin" ) == 1 then
		if getGameSpeed () > 1.1 then
			triggerServerEvent ( "speedhackcheater_ban", lp, lp )
		end
		if getPlayerMoney ( lp ) ~= getElementData ( lp, "money" ) then
			if getElementData ( lp, "money" ) < getPlayerMoney ( lp ) then
				takePlayerMoney ( math.abs ( getElementData ( lp, "money" ) - getPlayerMoney ( lp ) ) )
			elseif getElementData ( lp, "money" ) > getPlayerMoney ( lp ) then
				givePlayerMoney ( math.abs ( getElementData ( lp, "money" ) - getPlayerMoney ( lp ) ) )
			end
		end
		if getElementData ( lp, "isInHighNoon" ) then
			showChat ( false )
			guiSetVisible ( gLabels["InfoTextForum"], false )
			guiSetVisible ( gLabels["InfoTextForumShadow"], false )
		else
		end
		for i = 1, 12 do
			if validGunCheatProofs[i] then
				if _G["weapon"..i.."_ammo"] < getPedTotalAmmo ( lp, i ) then
					if _G["weaponslot_"..i.."_banct"] >= 1 then
						triggerServerEvent ( "guncheater_ban", lp, lp, "Waffe "..getPedWeapon ( lp, i )..","..getPedTotalAmmo ( lp, i ).." Munition", getPedWeapon ( lp, i ) )
					else
						_G["weaponslot_"..i.."_banct"] = 1
					end
				else
					_G["weapon"..i.."_ammo"] = getPedTotalAmmo ( lp, i )
					_G["weaponslot_"..i.."_banct"] = 0
				end
			end
		end
	end
end

function onClientPlayerWeaponFireFunc(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )
	if weapon == 38 or weapon == 9 or weapon == 37 then
		for i = 1, 12 do
			triggerServerEvent ( "guncheater_ban", lp, lp, "Waffe "..getPedWeapon ( lp, i )..","..getPedTotalAmmo ( lp, i ).." Munition", getPedWeapon ( lp, i ) )
		end
    end
end
addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), onClientPlayerWeaponFireFunc )

function sec_gun_give ( weapon, ammo )
end
addEvent( "sec_gun_give", true )
addEventHandler( "sec_gun_give", getRootElement(), sec_gun_give )

function sec_health_give ( health )
	player_health = health
end
addEvent( "sec_health_give", true )
addEventHandler( "sec_health_give", getRootElement(), sec_health_give )

function sec_armor_give ( armor )
	player_armor = armor
end
addEvent( "sec_armor_give", true )
addEventHandler( "sec_armor_give", getRootElement(), sec_armor_give )

function hasPlayerLicense ( player, id )
	if cars[id] then
		if tonumber ( getElementData ( player, "carlicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif lkws[id] then
		if tonumber ( getElementData ( player, "lkwlicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif bikes[id] then
		if tonumber ( getElementData ( player, "bikelicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif helicopters[id] then
		if tonumber ( getElementData ( player, "helilicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif planea[id] then
		if tonumber ( getElementData ( player, "planelicensea" ) ) == 1 then
			return true
		else
			return false
		end
	elseif planeb[id] then
		if tonumber ( getElementData ( player, "planelicenseb" ) ) == 1 then
			return true
		else
			return false
		end
	elseif motorboats[id] then
		if tonumber ( getElementData ( player, "motorbootlicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif raftboats[id] then
		if tonumber ( getElementData ( player, "segellicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif nolicense[id] then
		return true
	else
		return true
	end
end