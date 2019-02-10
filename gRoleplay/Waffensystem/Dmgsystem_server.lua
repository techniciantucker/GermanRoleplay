-- Rifle --
setWeaponProperty(33, "poor", "weapon_range", 200)
setWeaponProperty(33, "std", "weapon_range",  200)
setWeaponProperty(33, "pro", "weapon_range",  200)

setWeaponProperty(24, "poor", "weapon_range", 75)  -- Deagle
setWeaponProperty(31, "poor", "weapon_range", 100) -- M4
setWeaponProperty(29, "poor", "weapon_range", 30)  -- Mp5
setWeaponProperty(30, "poor", "weapon_range", 100) -- Ak 47
setWeaponProperty(25, "poor", "weapon_range", 50)  -- Shotgun
setWeaponProperty(23, "poor", "weapon_range", 20)  -- 9mm
setWeaponProperty(28, "poor", "weapon_range", 50)  -- Uzi
setWeaponProperty(27, "poor", "weapon_range", 25)  -- Combat



local weaponDamages = {}
	weaponDamages[8] = 35
	
	weaponDamages[22] = 10
	weaponDamages[23] = 5  -- 9mm
	weaponDamages[24] = 48 -- Deagle
	
	weaponDamages[26] = 10 -- Sawn-Off
	weaponDamages[25] = 8  -- Shotgun
	
	weaponDamages[27] = 10 -- Combat
	weaponDamages[28] = 5  -- Uzi
	weaponDamages[29] = 6  -- Mp5
	weaponDamages[32] = 5
		
	weaponDamages[30] = 7  -- Ak 47
	weaponDamages[31] = 5  -- M4
	
	weaponDamages[33] = 25 -- Rifle
	weaponDamages[34] = 65 -- Sniper
	
	weaponDamages[51] = 50

function damageCalcServer_func ( attacker, weapon, bodypart, loss, player )
	if attacker and weapon and bodypart and loss then
		if not westsideGetElementData ( attacker, "spawnProtection" ) and not westsideGetElementData (player, "spawnProtection" ) and getElementType ( player ) == "player" then
			if getElementData (player, "jailtime" ) == 0 then

				local x1, y1, z1 = getElementPosition ( attacker )
				local x2, y2, z2 = getElementPosition ( player )
				
				if weapon == 34 and bodypart == 9 and getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2) >= 20 then
					setPedHeadless ( player, true )
					killPed ( player, attacker, weapon, bodypart )
					outputLog ( getPlayerName ( attacker ).." hat "..getPlayerName ( player ).." mit der Sniper einen Headshot gegeben", "Kills" )
				else
					local basicDMG = weaponDamages[weapon]
					local dontDealDamage = false
					if rangedWeapons[getPedWeapon ( attacker )] then
						if ammoTyp and ammoTyp > 0 then
							if ammoTyp == 1 and westsideGetElementData ( attacker, "ammoTyp1" ) then
								if not getPedOccupiedVehicle (player ) then
									setPedOnFire (player, true )
									setTimer ( setPedOnFire, 350, 1,player, false )
								end
							elseif ammoTyp == 2 and westsideGetElementData ( attacker, "ammoTyp2" ) then
								if getPedArmor ( player ) == 0 then
									basicDMG = basicDMG * 1.3
										
								end
							elseif ammoTyp == 3 and westsideGetElementData ( attacker, "ammoTyp3" ) then
								if getPedArmor ( player ) > 0 then
									basicDMG = basicDMG * 1.3
										
								end
							elseif ammoTyp == 4 and semiAutomatic[weapon] and westsideGetElementData ( attacker, "ammoTyp4" ) then
								dontDealDamage = true
							elseif ammoTyp == 5 and westsideGetElementData ( attacker, "ammoTyp5" ) then
								if westsideGetElementData ( player, "hitByChokeAmmo" ) then
									killTimer ( westsideGetElementData ( player, "stopChokeTimer" ) )
								end
								setPedChoking ( player, true )
								westsideSetElementData ( player, "hitByChokeAmmo", true )
								triggerClientEvent ( player, "smokeAmmoHit", player )
								triggerClientEvent ( attacker, "smokeAmmoHit", player )
								local stopChokeTimer = setTimer (
									function ( player )
										if westsideGetElementData ( player, "hitByChokeAmmo" ) then
											westsideSetElementData ( player, "hitByChokeAmmo", false )
											setPedChoking ( player, false )
										end
									end,
								1000, 1, player )
								westsideSetElementData ( player, "stopChokeTimer", stopChokeTimer )
								dontDealDamage = true
							elseif ammoTyp == 6 and westsideGetElementData ( attacker, "ammoTyp6" ) then
								setPedHeadless  ( player, true )
								dontDealDamage = true
									
								setTimer ( 
									function ( playerid )
										setPedHeadless  ( playerid, false )
									end,
								600000, 1, player )
							end
						end
					end
											
					if not dontDealDamage then
						if weapon == 0 then
							if getPedFightingStyle ( attacker ) == 7 or getPedFightingStyle ( attacker ) == 15 or getPedFightingStyle ( attacker ) == 16 then
								loss = loss / 2
							end
						end
						local multiply = 1
						if bodypart == 3 or bodypart == 4 then
							multiply = 1.5
						elseif bodypart == 5 or bodypart == 6 then
							multiply = 0.8
						elseif bodypart == 7 or bodypart == 8 then
							multiply = 1.2
						elseif bodypart == 9 then
							multiply = 2
						end
						if weapon == 24 and getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2) <= 1 then
							multiply = 0.5
						end
							
						local dadmg = 0
						if ( weaponDamages[weapon] ) then
							local aval = basicDMG * multiply
							if aval >= getElementHealth ( player ) + getPedArmor ( player ) then
								dadmg = math.floor ( getElementHealth ( player ) + getPedArmor ( player ) )
							else
								dadmg = math.floor ( basicDMG * multiply )
							end
							damagePlayer ( player, basicDMG * multiply, attacker, weapon )
							outputLog ( "[DMG]: "..getPlayerName ( attacker ).." hat "..getPlayerName ( player ).." mit Waffe "..weapon.." an Part "..bodypart.." getroffen, Schaden: "..aval, "Damage" )
						else
							if loss >= getElementHealth ( player ) + getPedArmor ( player ) then
								dadmg = math.floor ( getElementHealth ( player ) + getPedArmor ( player ) )
							else
								dadmg = math.floor ( loss )
							end
							damagePlayer ( player, loss, attacker, weapon )
							outputLog ( "[DMG]: "..getPlayerName ( attacker ).." hat "..getPlayerName ( player ).." mit Waffe "..weapon.." an Part "..bodypart.." getroffen, Schaden: "..loss, "Damage" )
						end
						
						if bodypart == 2 then
							headlessPed ( player )
						end
							
						if attacker then
							westsideSetElementData ( attacker, "lastcrime", "westsidelance" )
						end
					end	
				end
			end
		end
	end
end
addEvent ( "damageCalcServer", true )
addEventHandler ( "damageCalcServer", getRootElement(), damageCalcServer_func )

function headlessPed ( player )

	if isPedDead ( player ) then
		setPedHeadless ( player, true )
	end
end

function sniperPlayerKill ( attacker, weapon, bodypart )

	if weapon and isElement ( attacker ) and bodypart then
		if not westsideGetElementData ( attacker, "spawnProtection" ) and not westsideGetElementData ( source, "spawnProtection" ) then
			if weapon == 34 and bodypart == 9 then
				setPedHeadless ( source, true )
				killPed ( source, attacker, weapon, bodypart )
			end
		end
	end
end
addEvent ( "onPlayerDamage", true )
addEventHandler ( "onPlayerDamage", getRootElement(), sniperPlayerKill )

addEventHandler ( "onPlayerSpawn", getRootElement(),function ()
	westsideSetElementData ( source, "spawnProtection", true )
	setTimer ( westsideSetElementData, 10000, 1, source, "spawnProtection", false )
end)

--[[

    3: Torso
    4: Ass
    5: Left Arm
    6: Right Arm
    7: Left Leg
    8: Right leg
    9: Head
	
]]