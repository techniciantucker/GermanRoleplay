-- Bloodscreen
damageImage = guiCreateStaticImage(0,0,1,1,"Waffensystem/Blood.png",true)
guiSetAlpha ( damageImage, 0 )
guiSetEnabled ( damageImage, false )

function onPlayerDamage ( attacker, weapon, bodypart, loss )

    if source == getLocalPlayer() then
    
            if not ( isPlayerDead ( source ) ) then
            
                showBloodFlash ()
        end
    end
end
addEventHandler ( "onClientPlayerDamage", getRootElement(), onPlayerDamage )

function showBloodFlash ()

    guiSetEnabled ( damageImage, true )
    if isTimer ( bloodTimer ) then
        killTimer ( bloodTimer )
    end
    bloodTimer = setTimer ( bloodFlash, 50, 0 )
    guiSetAlpha ( damageImage, 1 )
end

function bloodFlash()

    alpha = guiGetAlpha ( damageImage )
    if alpha == 0 then
    
        killTimer ( bloodTimer )
        guiSetEnabled ( damageImage, false )
    else
    
        guiSetAlpha ( damageImage, alpha - 0.1 )
    end
end

FireingEnabled = false

function smokeAmmoHit ()

	local x, y, z = getElementPosition ( source )
	for a = -2, 2 do
		for b = -2, 2 do
			for c = -2, 2 do
				fxAddTyreBurst ( x + a * 0.15, y + b * 0.15, z + c * 0.15, 0, 0, 0 )
			end
		end
	end
end
addEvent ( "smokeAmmoHit", true )
addEventHandler ( "smokeAmmoHit", getRootElement(), smokeAmmoHit )

weaponDamages = {}
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

semiAutomatic = {}
	semiAutomatic[22] = true
	semiAutomatic[23] = true
	semiAutomatic[24] = true
	
	semiAutomatic[33] = true
	semiAutomatic[34] = true

function chokecheck ( weapon, player )

	if source == lp then
		if getElementModel ( source ) == 285 then
			cancelEvent()
		end
	end
end
addEventHandler ( "onClientPlayerChoke", getRootElement(), chokecheck )

function onPlayerDamage ( attacker, weapon, bodypart, loss )

	if source == lp then
		if not isPedDead ( source ) then
		end
		if attacker then
			local x, y, z = getElementPosition ( source )
			if getDistanceBetweenPoints3D ( x, y, z, -2458.288085, 774.354492, 35.171875 ) <= 20 then
				cancelEvent()
			else
				if weapon == 39 then
					setElementHealth ( source, getElementHealth ( source ) - loss * 2 )
				end
			end
		end
	end
end
addEventHandler ( "onClientPlayerDamage", getRootElement(), onPlayerDamage )

-- // Reddot
function reddot_func ()

	if not reddotEnabled then
		reddotEnabled = true
		addEventHandler ( "onClientRender", getRootElement(), reddot_render )
		infobox("Rotpunktvisier aktiviert!")
	else
		reddotEnabled = false
		removeEventHandler ( "onClientRender", getRootElement(), reddot_render )
		infobox("Rotpunktvisier deaktiviert!")
	end
end
addCommandHandler ( "reddot", reddot_func )

fireWeaponSlots = {
[2]=true,
[3]=true,
[4]=true,
[5]=true,
[6]=true,
[7]=true
}

function reddot_render ()

	if fireWeaponSlots[getPedWeaponSlot ( lp )] then
		if getPedControlState ( lp, "aim_weapon" ) then
			local x1, y1, z1 = getPedWeaponMuzzlePosition ( lp )
			x1 = x1 + 0.01
			y1 = y1 + 0.01
			z1 = z1 + 0.01
			local x2, y2, z2 = getPedTargetEnd ( lp )
			local x3,y3,z3 = getPedTargetCollision ( lp )
			if x3 then
				dxDrawLine3D ( x1, y1, z1, x3, y3, z3, tocolor ( 200, 0, 0, 200 ), 4, false )
			else
				dxDrawLine3D ( x1, y1, z1, x2, y2, z2, tocolor ( 200, 0, 0, 200 ), 4, false )
			end
		end
	end
end