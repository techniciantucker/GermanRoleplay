spawnBoats = { [454]=true, [484]=true }

function RemoteSpawnPlayer ( player )
	if isElement ( player ) then
		--if getElementData(player,"inDeagleArena") == false then
			local pname = getPlayerName ( player )
			toggleAllControls ( player, true )
			showPlayerHudComponent ( player, "radar", true )
			if westsideGetElementData ( player, "spawnpos_x" ) == "wohnmobil" then
				local spawned = false
				for i = 1, 10 do
					local veh = _G[getPrivVehString ( pname, i )]
					if veh then
						local model = tonumber ( MySQL_GetString("vehicles", "Typ", "Slot LIKE '"..i.."' AND Besitzer LIKE '"..pname.."'") )
						if model then
							if model == 508 then
								sx, sy, sz = getElementPosition ( veh )
									savespawn ( player, sx+4, sy+4, sz, 0, 0, 0 )
									spawned = true
								break
							end
						end
					end
				end
				if not spawned then
					savespawn ( player, -2458.288085, 774.354492, 35.171875, 0, 0, 0 )
				end
			elseif tonumber ( westsideGetElementData ( player, "spawnpos_x" ) ) then
				westsideSetElementData ( player, "spawnpos_x", tonumber(westsideGetElementData ( player, "spawnpos_x" )) )
				westsideSetElementData ( player, "spawnpos_y", tonumber(westsideGetElementData ( player, "spawnpos_y" )) )
				savespawn ( player, 0, 0, 0, 0, 0, 0 )
				local sx, sy, sz = westsideGetElementData ( player, "spawnpos_x" ), westsideGetElementData ( player, "spawnpos_y" ),westsideGetElementData ( player, "spawnpos_z" )
				setElementPosition ( player, sx, sy, sz )
				setElementInterior ( player, westsideGetElementData ( player, "spawnint" ) )
				setElementDimension ( player, westsideGetElementData ( player, "spawndim" ) )
				if not isKeyBound ( player, "F2", "down", house_func ) then
					bindKey ( player, "F2", "down", house_func )
				end
			else
				local spawned = false
				for i = 1, 10 do
					local veh = _G[getPrivVehString ( pname, i )]
					if veh then
						local model = tonumber ( MySQL_GetString("vehicles", "Typ", "Slot LIKE '"..i.."' AND Besitzer LIKE '"..pname.."'") )
						if model then
							if spawnBoats[model] then
								sx, sy, sz = getElementPosition ( veh )
									savespawn ( player, sx, sy, sz+3.8, 0, 0, 0 )
									spawned = true
								break
							end
						end
					end
				end
				if not spawned then
					savespawn ( player, -2458.288085, 774.354492, 35.171875, 0, 0, 0 )
				end
			end
			
			--[[ if westsideGetElementData ( player, "fskin" ) ~= 0 then
				setElementModel ( player, westsideGetElementData ( player, "fskin") )
				takeWeapon (player, 42)
				giveWeapon ( player, 42, 10500 )
			else
				setElementModel ( player, westsideGetElementData ( player, "skinid") )
			end ]]--
			
			--[[ if isArmy ( player ) then
				armyClassSpawn ( player )
			end ]]--
			
			fadeCamera ( player, true )
			setCameraTarget( player, player )
			setPlayerWantedLevel ( player, tonumber(westsideGetElementData ( player, "wanteds")) )
			
			if tonumber(westsideGetElementData ( player, "jailtime" )) >= 1 then
				putPlayerInJail ( player )
			end
			if tonumber ( westsideGetElementData ( player, "heaventime" ) ) >= 1 then
				endfade ( player, tonumber ( westsideGetElementData ( player, "heaventime" ) ) )
				setElementInterior ( player, 0 )
				setElementDimension ( player, 1 )
			end
		--end
	end
	triggerClientEvent ( player, "camfix", getRootElement() )
end

function savespawn ( player, x, y, z, rx, ry, rz, highNoon )
	--[[ if highNoon then
		setElementDimension ( player, 0 )
	end ]]--
	
	--triggerClientEvent ( player, "sec_health_give", getRootElement(), 999 )
	spawnPlayer ( player, x, y, z, rz )
	setElementHealth ( player, 100 )
	--triggerClientEvent ( player, "sec_health_give", getRootElement(), 999 )
	
	--[[ if westsideGetElementData ( player, "fskin" ) ~= 0 then
		setElementModel ( player, westsideGetElementData ( player, "fskin") )
		takeWeapon (player, 42)
		giveWeapon ( player, 42, 10500 )
	else
		setElementModel ( player, westsideGetElementData ( player, "skinid") )
	end ]]--
	
	fadeCamera ( player, true )
	setCameraTarget( player, player )
	if tonumber ( westsideGetElementData ( player, "fraktion" ) ) == 5 then
		local gun1 = 43
		local ammo1 = 20000
		giveWeapon ( player, gun1, ammo1, true )
		giveWeapon ( player, gun1, ammo1, true )
		giveWeapon ( player, gun1, ammo1, true )
		triggerClientEvent ( player, "sec_gun_give", getRootElement(), gun1, ammo1 )
	end
	
	----- Vip -----
	
	if(getElementData(player,"vip")==1)then
		setPedArmor(player,100)
		giveWeapon(player,24,50,true)
	elseif(getElementData(player,"vip")==2)then
		setPedArmor(player,100)
		giveWeapon(player,24,200,true)
		giveWeapon(player,29,200,true)
	elseif(getElementData(player,"vip")==3)then
		setPedArmor(player,100)
		giveWeapon(player,24,300,true)
		giveWeapon(player,29,500,true)
		giveWeapon(player,33,100,true)
	elseif(getElementData(player,"vip")==4)then
		setPedArmor(player,100)
		giveWeapon(player,24,1000,true)
		giveWeapon(player,29,1000,true)
		giveWeapon(player,31,1000,true)
		giveWeapon(player,33,1000,true)
	end
	
	if(getElementData(player,'handyAbgenommen')==true)then
		setElementData(player,'handyAbgenommen',false)
	end
	
	
	--[[ if isEvil ( player ) then
		setPedArmor(player,100)
		giveWeapon(player,24,14,true)
	end ]]--
	setPlayerWantedLevel ( player, westsideGetElementData ( player, "wanteds" ) )
end