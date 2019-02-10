fraktionMembers = {}

for i = 0, 99 do
	fraktionMembers[i] = {}
end

factionVehicles = {}
factionVehicles[1] = {}
factionVehicles[2] = {}
factionVehicles[3] = {}
factionVehicles[4] = {}
factionVehicles[5] = {}
factionVehicles[6] = {}
factionVehicles[7] = {}
factionVehicles[8] = {}
factionVehicles[9] = {}
factionVehicles[10] = {}

fraktionNames = {}
fraktionNames = { [1]="SAPD", [2]="Brigada", [3]="Triaden", [4]="Cali Kartell", [5]="Reporter", [6]="F.B.I", [7]="Grove Street", [8]="Army", [9]= "Dillimore Devils", [10]="Mechaniker" }

---- Kleiderschrank ----
addCommandHandler("fumkleide",function(player)
setElementData(player,"umkleide",false)

	if getDistanceBetweenPoints3D(-217.8996887207,1401.8452148438,27.7734375,getElementPosition(player)) < 5 or getDistanceBetweenPoints3D(-2170.6044921875,645.93798828125,1052.375,getElementPosition(player)) < 5 or getDistanceBetweenPoints3D(956.67492675781,-53.531768798828,1001.1171875,getElementPosition(player)) < 5 or getDistanceBetweenPoints3D(2196.2165527344,1671.6799316406,12.3671875,getElementPosition(player)) < 5 or getDistanceBetweenPoints3D(2505.58350, -1698.21375, 13.55437,getElementPosition(player)) < 5 or getDistanceBetweenPoints3D(257.00317, 70.26176, 1003.64063,getElementPosition(player)) < 5 or getDistanceBetweenPoints3D(1217.74255, -1823.87695, 13.67292,getElementPosition(player)) < 5 or getDistanceBetweenPoints3D(741.17877197266,-1336.5451660156,13.535906791687,getElementPosition(player)) < 5 then
		if isPedInVehicle (player) == false then
			if getElementData(player,"umkleide") == false then
				if isEvil(player) or isReporter(player) then
					local x, y, z = getElementPosition(player)
					setElementData(player, "old_pos_x", x)
					setElementData(player, "old_pos_y", y)
					setElementData(player, "old_pos_z", z)
					
					fadeElementInterior(player,18,181.39999389648,-88.199996948242,1002,90.0041198,90.0041198)
					setElementFrozen(player,true)
					setElementDimension(player,math.random(1,999999))
					setElementData(player,"umkleide",true)

					setTimer(function()
						setCameraMatrix(player,172.36540222168,-88.186698913574,1002.7529296875,173.36262512207,-88.184173583984,1002.6784057617)
						triggerClientEvent(player,"openumkleide",player)
					end,4000,1)
				elseif isCop(player) or isFBI(player) then
					if getElementData(player,"onDuty") == true then
						local x, y, z = getElementPosition(player)
						setElementData(player, "old_pos_x", x)
						setElementData(player, "old_pos_y", y)
						setElementData(player, "old_pos_z", z)
						
						for i=1,20,1 do
							fadeElementInterior(player,18,181.39999389648,-88.199996948242,1002,90.0041198,90.0041198)
							setElementFrozen(player,true)
							setElementDimension(player,i)
							setElementData(player,"umkleide",true)
						end
						setTimer(function()
							setCameraMatrix(player,172.36540222168,-88.186698913574,1002.7529296875,173.36262512207,-88.184173583984,1002.6784057617)
							triggerClientEvent(player,"openumkleide",player)
						end,4000,1)
					else
						infobox(player,"Du bist nicht im Dienst!")
					end
				end
			else
				infobox(player,"Du bist bereits in der Umkleide!")
			end
		else
			infobox(player,"Steige aus deinem Fahrzeug aus!")
		end
	end
end)

addEvent("leaveumkleide",true)
addEventHandler("leaveumkleide",root,function(player)

	local x, y, z =  getElementData(player, "old_pos_x"), getElementData(player, "old_pos_y"), getElementData(player, "old_pos_z");
	if x and y and z then
		if isCop(player) then
			fadeElementInterior(player,6,x,y,z)
			setElementDimension(player,0)
		elseif isBiker(player) then
			fadeElementInterior(player,18,x,y,z)
			setElementDimension(player,0)
		elseif isTriaden(player) then
			fadeElementInterior(player,1,x,y,z)
			setElementDimension(player,0)
		elseif isBrigada(player) then
			fadeElementInterior(player,3,x,y,z)
			setElementDimension(player,0)
		else
			fadeElementInterior(player,0,x,y,z)
			setElementDimension(player,0)
		end
		setTimer(function()
			setCameraTarget(player)
			setElementFrozen(player,false)
		end,4000,1)
	end
end)

factionSkins = {}

factionSkins[1] = { [1]=280, [2]=281, [3]=282, [4]=283, [5]=284, [6]=285, [7]=288, [8]=265, [9]=266, [10]=267 }
factionSkins[2] = { [1]=111, [2]=112, [3]=113, [4]=124, [5]=125, [6]=43, [7]=127, [8]=272 }
factionSkins[3] = { [1]=227, [2]=225, [3]=294, [4]=120, [5]=118, [6]=59, [7]=49, [8]=123, [9]=141 }
factionSkins[4] = { [1]=46, [2]=98, [3]=185, [4]=223, [5]=47, [6]=184, 214 }
factionSkins[5] = { [1]=59, [2]=141, [3]=187, [4]=188, [5]=189, [6]=296 }
factionSkins[6] = { [1]=285, [2]=286, [3]=165, [4]=164, [5]=163, [6]=295 }
factionSkins[7] = { [1]=105, [2]=106, [3]=107, [4]=269, [5]=270, [6]=271, [7]=65 }
factionSkins[9] = { [1]=100, [2]=181, [3]=230, [4]=298, [5] = 299 }

addEvent("nextumkleide",true)
addEventHandler("nextumkleide",root,function(player)
	if getElementData(player,"umkleide") == true then
		local curskin = getElementModel(player)
		local faction = getPlayerFaction(player)
		local val = false
		
		if faction == 1 and getElementData(player,"onDuty") == true and getElementModel(player) ~= 285 then
			for i, skin in pairs (factionSkins[1]) do
				if skin == getElementModel(player) then
					val = i
					break
				end
			end
			
			if val == false or val == #factionSkins[1] then
				setElementModel(player,factionSkins[1][1])
				return
			elseif val == 5 then
				setElementModel(player,factionSkins[1][7])
				return
			else
				setElementModel(player,factionSkins[1][val+1])
				westsideSetElementData(player,'skinid',factionSkins[faction][val+1])
				return
			end
		elseif faction == 6 and getElementData(player,"onDuty") == true and getElementModel(player) ~= 285 then
			for i, skin in pairs (factionSkins[6]) do
				if skin == getElementModel(player) then
					val = i
					break
				end
			end
			
			if val == false or val == #factionSkins[6] then
				setElementModel(player,factionSkins[6][2])
				return
			else
				setElementModel(player,factionSkins[6][val+1])
				return
			end
		elseif faction >= 1 and faction ~=1 and faction ~= 6 then
			for i, skin in pairs (factionSkins[faction]) do
				if skin == getElementModel(player) then
					val = i
					break
				end
			end
			
			if val == false or val == #factionSkins[faction] then
				setElementModel(player,factionSkins[faction][1])
				return
			else
				setElementModel(player,factionSkins[faction][val+1])
				westsideSetElementData(player,'skinid',factionSkins[faction][val+1])
				return
			end
		end
	end
end)

---------------------------------------------

function isPDCar ( car )
	if factionVehicles[1][car] then return true else return false end
end

function isBrigadaCar ( car )
	if factionVehicles[2][car] then return true else return false end
end

function isTriadenCar ( car )
	if factionVehicles[3][car] then return true else return false end
end

function isKartellCar ( car )
	if factionVehicles[4][car] then return true else return false end
end

function isReporterCar ( car )
	if factionVehicles[5][car] then return true else return false end
end

function isFBICar ( car )
	if factionVehicles[6][car] then return true else return false end
end

function isGroveCar ( car )
	if factionVehicles[7][car] then return true else return false end
end

function isArmyCar ( car )
	if factionVehicles[8][car] then return true else return false end
end

function isBikerCar ( car )
	if factionVehicles[9][car] then return true else return false end
end

function isMechanikerCar ( car )
	if factionVehicles[10][car] then return true else return false end
end

function isFederalCar ( car )
	if isArmyCar( car ) or isFBICar( car ) or isPDCar ( car ) then
		return true
	else
		return false
	end
end

function isEvilCar ( car )
	if isBrigadaCar( car ) or isTriadenCar( car ) or isKartellCar ( car ) or isGroveCar ( car ) or isBikerCar ( car ) then
		return true
	else
		return false
	end
end

function getPlayerFaction ( player )

	local fac = westsideGetElementData ( player, "fraktion" )
	
	if fac then
	
		return tonumber(fac)
	
	else

		return false
	
	end

end

function getPlayerRank ( player )

	local ran = westsideGetElementData ( player, "rang" )
	
	if ran then
	
		return tonumber(ran)
	
	else
	
		return false
	
	end

end

function getPlayerRankName ( player )

	local ran = getPlayerRank ( player )
	local fac = getPlayerFaction ( player )
	
	if ran then
	
		return factionRankNames[fac][ran]
	
	else
	
		return false
	
	end

end

-----------------------------------

function isCop(player)
	if tonumber(westsideGetElementData ( player, "fraktion" )) == 1 then return true else return false end
end

function isBrigada(player)
	if tonumber(westsideGetElementData ( player, "fraktion" )) == 2 then return true else return false end
end

function isTriaden(player)
	if tonumber(westsideGetElementData ( player, "fraktion" )) == 3 then return true else return false end
end

function isKartell(player)
	if tonumber(westsideGetElementData ( player, "fraktion" )) == 4 then return true else return false end
end

function isReporter(player)
	if tonumber(westsideGetElementData ( player, "fraktion" )) == 5 then return true else return false end
end

function isFBI(player)
	if tonumber(westsideGetElementData ( player, "fraktion" )) == 6 then return true else return false end
end

function isGrove(player)
	if tonumber(westsideGetElementData ( player, "fraktion" )) == 7 then return true else return false end
end

function isArmy(player)
	if tonumber(westsideGetElementData ( player, "fraktion" )) == 8 then return true else return false end
end

function isBiker(player)
	if tonumber(westsideGetElementData ( player, "fraktion" )) == 9 then return true else return false end
end

function isMechaniker(player)
	if tonumber(westsideGetElementData ( player, "fraktion" )) == 10 then return true else return false end
end
------------------------------------

function isStateFaction(player)
	if isArmy(player) or isCop(player) or isFBI(player) then return true else return false end
end

function isEvil(player)
	if isBrigada(player) or isTriaden(player) or isKartell(player) or isGrove(player) or isBiker(player) then return true else return false end
end
---------------------------------

function sendMSGForFaction ( msg, faction, r, g, b )

	if not r then
		local r, g, b = 200, 200, 100
	end
	
	for playeritem, key in pairs ( fraktionMembers[faction] ) do
		outputChatBox ( msg, playeritem, r, g, b )
	end
	
end

function getFactionMembersOnline ( faction )

	if faction then
		counter = 0
		for playeritem, index in pairs ( fraktionMembers[faction] ) do
			counter = counter + 1
		end
		return counter
	else
		return false
	end
	
end

function policeComputer(player)
 if(getElementData(player,'onDuty')==true)and(isFederalCar(getPedOccupiedVehicle(player)))and(getElementModel(getPedOccupiedVehicle(player))~=520)then
  triggerClientEvent(player,'showPDComputer',player)
 end
end

function createFactionVehicle ( model, x, y, z, rx, ry, rz, faction, c1, c2, c3, c4, numberplate )

	if not c3 then
		c3 = 0
	end
	
	if not c4 then
		c4 = 0
	end
	
	if not numberplate then
		numberplate = fraktionNames[faction]
	end
	
	local veh = createVehicle ( model, x, y, z, rx, ry, rz, numberplate )
	
	setVehicleColor ( veh, c1, c2, c3, c4 )
	setVehiclePaintjob ( veh, 3 )
	toggleVehicleRespawn ( veh, true )
	setVehicleRespawnDelay ( veh, FCarDestroyRespawn * 1000 * 60 )
	setVehicleIdleRespawnDelay ( veh, FCarIdleRespawn * 1000 * 60 )
	factionVehicles[faction][veh] = true
	
	westsideSetElementData ( veh, "owner", fraktionNames[faction] )
	westsideSetElementData ( veh, "ownerfraktion", faction )
	
	--setElementFrozen(veh,true)
	
	if faction == 1 then -- Cops
		
		addEventHandler("onVehicleEnter",veh,function(player,seat)
			local veh = source
			
			if getPedOccupiedVehicleSeat(player) == 0 then
				if getElementData(player,"onDuty") == true then
					if isCop(player) then
						bindKey(player,'num_add','down',policeComputer)
					else
						opticExitVehicle(player)
						infobox(player,"Du bist nicht befugt!",4000,255,0,0)
					end
				else
					opticExitVehicle(player)
					infobox(player,"Du bist nicht befugt!",4000,255,0,0)
				end
			end
		end)
			
	elseif faction == 6 then -- FBI
	
		addEventHandler("onVehicleEnter",veh,function(player,seat)
			local veh = source
			
			if getPedOccupiedVehicleSeat(player) == 0 then
				if getElementData(player,"onDuty") == true then
					if isFBI(player) then
						bindKey(player,'num_add','down',policeComputer)
					else
						opticExitVehicle(player)
						infobox(player,"Du bist nicht befugt!",4000,255,0,0)
					end
				else
					opticExitVehicle(player)
					infobox(player,"Du bist nicht befugt!",4000,255,0,0)
				end
			end
		end)
			
	elseif faction == 10 then -- Mechaniker
	
		addEventHandler("onVehicleEnter",veh,function(player,seat)
			local veh = source
			
			if getPedOccupiedVehicleSeat(player) == 10 then
				if getElementData(player,"onDuty") == true then
					if(not(isMechaniker(player)))then
						opticExitVehicle(player)
						infobox(player,"Du bist nicht befugt!",4000,255,0,0)
					end
				else
					opticExitVehicle(player)
					infobox(player,"Du bist nicht befugt!",4000,255,0,0)
				end
			end
		end)
			
	elseif faction == 8 then -- Army
		
		addEventHandler("onVehicleEnter",veh,function(player,seat)
			local veh = source
			
			if getPedOccupiedVehicleSeat(player) == 8 then
				if getElementData(player,"onDuty") == true then
					if isArmy(player) then
						bindKey(player,'num_add','down',policeComputer)
					else
						opticExitVehicle(player)
						infobox(player,"Du bist nicht befugt!",4000,255,0,0)
					end
				else
					opticExitVehicle(player)
					infobox(player,"Du bist nicht befugt!",4000,255,0,0)
				end
			end
		end)
	
	else
	
		addEventHandler ( "onVehicleEnter", veh,function ( player, seat )
			local veh = source
			
			if getPedOccupiedVehicleSeat ( player ) == 0 then
				if westsideGetElementData ( player, "fraktion" ) ~= faction then
					opticExitVehicle ( player )
					infobox(player,"Du bist nicht befugt!",4000,255,0,0)
				else
					--setElementFrozen(veh,false)
				end
			end
		end)
		
	end
		
	return veh
	
end

function block_tie_cmds ( cmd )
	cancelEvent()
end

-- Fesseln
addCommandHandler("tie",function(player,cmd,target)
	local target = findPlayerByName( target )
	
	if target and target ~= player and getPedOccupiedVehicle ( target ) then
	
		if isEvil(player) or getElementData(player,"onDuty") == true then
		
			if getVehicleOccupant( getPedOccupiedVehicle ( player ) ) ~= target and getPedOccupiedVehicleSeat ( target ) > 0 then
			
				local x1, y1, z1 = getElementPosition ( player )
				local x2, y2, z2 = getElementPosition ( target )
				
				if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 5 then
				
					local boolean = not westsideGetElementData ( target, "tied" )
					westsideSetElementData ( target, "tied", boolean )
					toggleAllControls ( target, boolean )
					if boolean then fix = "ent" else fix = "ge" end
					
					if fix == "ge" then
					
						addEventHandler( "onPlayerCommand", target, block_tie_cmds )
							
					elseif fix == "ent" then
					
						removeEventHandler ( "onPlayerCommand", target, block_tie_cmds )
					
					end
					
					if fix == "ent" then
					
						fadeCamera ( target, true, 0.5, 0, 0, 0 )
						
					elseif isEvil ( player ) then
					
						fadeCamera ( target, false, 0.5, 0, 0, 0 )
						
					end
					
					infobox(player,"Du hast "..getPlayerName(target).." "..fix.."fesselt!",4000,0,255,0)
					infobox(target,"Du wurdest von "..getPlayerName(player).." "..fix.."fesselt!",4000,255,0,0)
					
				else
					infobox(player,"Du bist zu weit weg!",4000,255,0,0)
				end
			else
				infobox(player,"Ungültiges Ziel!",4000,255,0,0)
			end
		end
	end
end)

function getchangestate_func ( player, cmd, target )

	local target = findPlayerByName( target )
	
	if isElement ( target ) then
	
		if westsideGetElementData ( player, "adminlvl" ) >= 3 then
		
			outputChatBox ( "Letzter Uninvite: "..tostring ( MySQL_GetString ( "userdata", "LastFactionChange", "Name LIKE '"..getPlayerName(target).."'") ), player, 0,255,0)
			
		else
		
			infobox(player,"Du bist nicht befugt!",4000,255,0,0)
			
		end
		
	else
	
		infobox(player,"Der Spieler ist nicht online!",4000,255,0,0)
		
	end
	
end
addCommandHandler ( "lastuninvite", getchangestate_func )

addEvent("fleave",true)
addEventHandler("fleave",root,function(player)
	local faction = getPlayerFaction ( player )
	local rank = getPlayerRank ( player )
	
	if westsideGetElementData(player,"rang") < 5 then
		if getElementData(player,"leaveSicher") == false then
			if faction > 0 then
				infobox(player,"Bist du dir sicher?\nFalls ja, klicke erneut auf den Button.")
				setElementData(player,"leaveSicher",true)
			else
				infobox(player,"Du bist in keiner Fraktion!",4000,255,0,0)
			end
		else
			setElementData(player,"leaveSicher",false)
			
			local model = malehomeless[math.random ( 1, 5 )]
			setElementModel ( player, model )
			westsideSetElementData ( player, "skinid", model )
			
			westsideSetElementData ( player, "rang", 0 )
			fraktionMembers[faction][player] = nil
			westsideSetElementData ( player, "fraktion", 0 )
			infobox(player,"Du hast deine Fraktion verlassen!",4000,255,0,0)
			MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName(player).."'")
			
			triggerClientEvent(player,"showfmenuefalse",player)
		end
	else
		infobox(player,"Rang 5er können die Fraktion\nnicht einfach verlassen! Melde dich\nbei einem Teammitglied!")
	end
end)

-- Spieler aus einem Fahrzeug werfen
function kickout_func ( player, cmd, nick )

	if getPedOccupiedVehicleSeat ( player ) == 0 then
		local target = getPlayerFromName ( nick )
		local veh = getPedOccupiedVehicle ( player )
		if target and target ~= player then
			if getPedOccupiedVehicle ( target ) == veh then
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast "..nick.." aus\ndeinem Fahrzeug geworfen!", 4000,255,0,0 )
				triggerClientEvent ( target, "infobox_start", getRootElement(), "Du wurdest aus\ndem Fahrzeug geworfen!", 4000,255,0,0 )
				opticExitVehicle ( target )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Spieler sitzt nicht\nin deinem Fahrzeug!", 4000, 255, 0, 0 )
			end
		elseif nick == "all" then
			for i = 1, 4 do
				_G["seat"..i] = getVehicleOccupant ( veh, i )
				if _G["seat"..i] then 
					opticExitVehicle ( _G["seat"..i] )
				end
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Ungültiger Spieler!", 4000,255,0,0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist kein Fahrer!", 4000,255,0,0 )
	end
end
addCommandHandler ( "kickout", kickout_func )

function carEject ( player )

	setPedAnimation ( player )
end

-- Gang / Cops online Abfrage
function getEvilFactionMembersOnline()
	local valueBrigada = getFactionMembersOnline(2)
	local valueTriaden = getFactionMembersOnline(3)
	local valueKartell = getFactionMembersOnline(4)
	local valueGrove = getFactionMembersOnline(7)
	local valueBiker = getFactionMembersOnline(9)
	
	local all = valueBrigada + valueTriaden + valueGrove + valueBiker + valueKartell
	return all
end

function getStateFactionMembersOnline()
	local valueCop = getFactionMembersOnline(1)
	local valueFBI = getFactionMembersOnline(6)
	local valueArmy = getFactionMembersOnline(8)
	
	local all = valueCop + valueFBI + valueArmy
	return all
end

----- Handy abnehmen -----
addCommandHandler('takehandy',function(player,cmd,target)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(isEvil(player))then
			if(westsideGetElementData(player,'rang')>=5)then
				if(target)then
					local tplayer = getPlayerFromName(target)
					
					local x,y,z    = getElementPosition(player)
					local px,py,pz = getElementPosition(tplayer)
					
					if(getDistanceBetweenPoints3D(px,py,pz,x,y,z)<=5)then
						if(getElementData(tplayer,'handyAbgenommen')==false)then
							infobox(tplayer,'Dir wurde dein Handy\nabgenommen!')
							infobox(player,'Du hast '..getPlayerName(tplayer)..'\nsein Handy abgenommen!')
							setElementData(tplayer,'handyAbgenommen',true)
						else
							infobox(player,'Der Spieler hat kein Handy!')
						end
					else
						infobox(player,'Du bist nicht nah\ngenug am Spieler!')
					end
				else
					infobox(player,'Kein Spieler angegeben!')
				end
			else
				infobox(player,'Du benötigst Rang 5!')
			end
		end
	end
end)

----- Klos -----
local TriadenPissmarker=createMarker(853.6162109375,-1635.8208007813,13.5546875,'corona',1,0,0,200)
setElementAlpha(TriadenPissmarker,50)
local BikerPissmarker=createMarker(679.05926513672,-445.12069702148,16.333156585693,'corona',1,0,0,200)
setElementAlpha(BikerPissmarker,50)
local PDPissmarker=createMarker(221.10925292969,66.779281616211,1005.0390625,'corona',1,0,0,200)
setElementAlpha(PDPissmarker,50)
setElementInterior(PDPissmarker,6)

function FrakiTeamPissenY0(player)
	if(westsideGetElementData(player,'harndrang')>0)then
		infobox(player,'Das pinkeln dauert 10 Sekunden..')
		setPedAnimation ( player, "PAULNMAC", "Piss_loop")
		setTimer(function()
			setPedAnimation(player,false)
			setElementFrozen(player,false)
			westsideSetElementData(player,'harndrang',0)
			infobox(player,'Du hast deine Blase entleert.')
		end,10000,1)
	else
		infobox(player,'Du musst nicht pinkeln!')
	end
end
addEventHandler('onMarkerHit',TriadenPissmarker,FrakiTeamPissenY0)
addEventHandler('onMarkerHit',BikerPissmarker,FrakiTeamPissenY0)
addEventHandler('onMarkerHit',PDPissmarker,FrakiTeamPissenY0)