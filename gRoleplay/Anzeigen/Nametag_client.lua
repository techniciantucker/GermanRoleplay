nameTagRange = 20
nameSphere = createColSphere ( 0, 0, 0, nameTagRange )

nameTagPlayers = {}
nameTagVisible = {}
nameTagHP = {}
nameTagImages = {}
nameTagAimTarget = lp

local players = getElementsByType ( "player" )
for key, index in pairs ( players ) do
	setPlayerNametagShowing ( index, false )
end
addEventHandler ( "onClientPlayerJoin", getRootElement(),function ()
	setPlayerNametagShowing ( source, false )
end)

function nameTagSpawn ()
	detachElements ( nameSphere )
	if isElement ( lp ) then
		attachElements ( nameSphere, lp )
	end
end
setTimer ( nameTagSpawn, 500, 0 )

function nameTagSphereHit ( element, dim )
	if getElementType ( element ) == "player" and not ( element == lp ) then
		nameTagPlayers[element] = true
		nameTagImages[element] = {}
		nameTagCheckPlayerSight ( element )
	end
end
addEventHandler ( "onClientColShapeHit", nameSphere, nameTagSphereHit )

function nameTagCheckPlayerSight ( player )
	if isElement ( player ) then
		local x1, y1, z1 = getPedBonePosition ( player, 8 )
		local x2, y2, z2 = getPedBonePosition ( lp, 8 )
		local hit = processLineOfSight ( x1, y1, z1, x2, y2, z2, true, false, false, true, false )
		nameTagVisible[player] = not hit
		if nameTagVisible[player] then
			nameTagHP[player] = getElementHealth ( lp )
		end
		faction = getElementData ( player, "job" )
		if not nameTagImages[player] then
			nameTagImages[player] = {}
		end
	else
		nameTagPlayers[player] = nil
		nameTagVisible[player] = nil
		nameTagHP[player] = nil
	end
end

function nameTagSphereLeave ( element )
	nameTagPlayers[element] = nil
	nameTagVisible[element] = nil
	nameTagHP[element] = nil
end
addEventHandler ( "onClientColShapeLeave", nameSphere, nameTagSphereLeave )

function nameTagRender ()
	local x, y, z, sx, sy
	local name, social
	local r, g, b, armor
	local images, drawn
	for key, index in pairs ( nameTagVisible ) do
		if isElement ( key ) then
			if nameTagVisible[key] then
				x, y, z = getElementPosition ( key )
				if x and y and z then
					sx, sy = getScreenFromWorldPosition ( x, y, z + 1.1, 1000, true )
					if sx and sy then
						r, g, b = calcRGBByHP ( key )
						name = getPlayerName ( key )
						job = 'Arbeitslos';
						if getElementData ( key, 'job' ) then
							job = getElementData(key, 'job')
							if(job == 'none')then
								job = 'Arbeitslos';
							end
						end
						local nametag = ''
						local armour = math.floor(getPedArmor(key));
					
						if getElementData(key, "adminlvl") >= 1 then
							name = '#00B9FF[gR]'..RGBToHex(r, g, b)..name;
						end
						
						if getElementData( key, 'AFK' ) == true then
							nametag = '[AFK]';
						end
						
						dxDrawText ( nametag..' '..name, sx, sy, sx, sy, tocolor ( 0, 0, 0, 255 ), 1, "bankgothic", "center", "center", false, false, false, true)
						dxDrawText ( nametag..' '..name, sx - 2, sy - 2, sx, sy, tocolor ( r, g, b, 255 ), 1, "bankgothic", "center", "center", false, false, false, true)
						dxDrawText ( job, sx, sy + 30, sx, sy, tocolor ( 190,190,190, 255 ), .5, "bankgothic", "center", "center" )
						dxDrawText ( job, sx - 2, sy - 1 + 30, sx, sy, tocolor ( 190,190,190, 255 ), .5, "bankgothic", "center", "center" )
						if(armour > 0)then
							dxDrawText( armour.."%", sx - 2, sy + 3 + 70, sx, sy, tocolor(255, 255, 255, 255), .8, "default-bold", "center", "center", false, false, true, false, false)
							
							dxDrawRectangle(sx - 70, sy + 1 + 27, 137, 16, tocolor(0, 8, 13, 255), false)
							dxDrawRectangle(sx - 70, sy + 1 + 27, (1.37*armour), 16, tocolor(0, 41, 67, 255), false)
						end
					end
				end
			end
		else
			nameTagCheckPlayerSight ( key )
		end
	end
end
addEventHandler ( "onClientRender", getRootElement(), nameTagRender )

function RGBToHex(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end

function calcRGBByHP ( player )
	local hp = getElementHealth ( player )
	if hp <= 0 then
		return 0, 0, 0
	else
		hp = math.abs ( hp - 0.01 )
		return ( 100 - hp ) * 2.55 / 2, ( hp * 2.55 ), 0
	end
end

function reCheckNameTag ()
	if ( isElement ( getCameraTarget () ) ) then
		detachElements ( nameSphere )
		attachElements ( nameSphere, getCameraTarget () )
	end
	setElementInterior ( nameSphere, getElementInterior ( lp ) )
	setElementDimension ( nameSphere, getElementDimension ( lp ) )
	if isPedAiming ( lp ) and getPedWeaponSlot ( lp ) == 6 then
		local x1, y1, z1 = getPedTargetStart ( lp )
		local x2, y2, z2 = getPedTargetEnd ( lp )
		local boolean, x, y, z, hit = processLineOfSight ( x1, y1, z1, x2, y2, z2 )
		if boolean then
			if isElement ( hit ) then
				if getElementType ( hit ) == "player" then
					nameTagAimTarget = hit
					nameTagPlayers[nameTagAimTarget] = nameTagAimTarget
				end
			end
		end
	end
	for key, index in pairs ( nameTagPlayers ) do
		nameTagCheckPlayerSight ( key )
	end
end
setTimer ( reCheckNameTag, 500, 0 )