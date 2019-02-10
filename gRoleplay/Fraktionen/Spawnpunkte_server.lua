function spawnchange_func ( player, cmd, place, sType )
	local pname = getPlayerName ( player )
	if place == "house" then
		if westsideGetElementData ( player, "housekey" ) ~= 0 then
			local dim = math.abs ( tonumber ( westsideGetElementData ( player, "housekey" ) ) )
			local hint = westsideGetElementData ( houses["pickup"][dim], "curint" )
			local int, intx, inty, intz = getInteriorData ( hint )
			
			if hint == 0 then
				int = 0
				dim = 0
				intx, inty, intz = getElementPosition ( houses["pickup"][dim] )
			end
			westsideSetElementData ( player, "spawndim", dim )
			westsideSetElementData ( player, "spawnint", int )
			westsideSetElementData ( player, "spawnpos_x", intx )
			westsideSetElementData ( player, "spawnpos_y", inty )
			westsideSetElementData ( player, "spawnpos_z", intz )
			infobox(player,"Spawnpunkt geändert!",4000,0,100,150)
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist Obdachlos!", 4000,255,0,0 )
		end
	elseif place == "faction" then
		local faction = westsideGetElementData ( player, "fraktion" )
		if faction > 0 then
			if faction == 1 then
				if sType == "lspd" then
					westsideSetElementData ( player, "spawnpos_x", 252.04697 )
					westsideSetElementData ( player, "spawnpos_y", 69.18114 )
					westsideSetElementData ( player, "spawnpos_z", 1003.64063 )
					westsideSetElementData ( player, "spawnrot_x", 90 )
					westsideSetElementData ( player, "spawnint", 6 )
					westsideSetElementData ( player, "spawndim", 0 )
					infobox(player,"Spawnpunkt geändert!",4000,0,100,150)
				end
			end
			if faction == 2 then
				if sType == "brigada" then
					westsideSetElementData ( player, "spawnpos_x", 960.93555 )
					westsideSetElementData ( player, "spawnpos_y",  -59.68959 )
					westsideSetElementData ( player, "spawnpos_z", 1001.11719 )
					westsideSetElementData ( player, "spawnrot_x", 0 )
					westsideSetElementData ( player, "spawnint", 3 )
					westsideSetElementData ( player, "spawndim", 0 )
					infobox(player,"Spawnpunkt geändert!",4000,0,100,150)
				end
			end
			if faction == 3 then
				if sType == "triaden" then
					westsideSetElementData ( player, "spawnpos_x", -2160.2456054688 )
					westsideSetElementData ( player, "spawnpos_y", 642.27325439453 )
					westsideSetElementData ( player, "spawnpos_z", 1057.2429199219 )
					westsideSetElementData ( player, "spawnrot_x", 90 )
					westsideSetElementData ( player, "spawnint", 1 )
					westsideSetElementData ( player, "spawndim", 0 )
					infobox(player,"Spawnpunkt geändert!",4000,0,100,150)
				end
			end
			if faction == 4 then
				westsideSetElementData ( player, "spawnpos_x", 2196.95532 )
				westsideSetElementData ( player, "spawnpos_y", 1677.19141 )
				westsideSetElementData ( player, "spawnpos_z", 12.36719 )
				westsideSetElementData ( player, "spawnrot_x", 0 )
				westsideSetElementData ( player, "spawnint", 0)
				westsideSetElementData ( player, "spawndim", 0 )
				infobox(player,"Spawnpunkt geändert!",4000,0,100,150)
			end
			if faction == 5 then
			    if sType == "reporterLS" then
				    westsideSetElementData ( player, "spawnpos_x", 737.30804443359 )
					westsideSetElementData ( player, "spawnpos_y", -1330.7425537109 )
					westsideSetElementData ( player, "spawnpos_z", 13.54866027832 )
					westsideSetElementData ( player, "spawnrot_x", 0.00274658 )
					westsideSetElementData ( player, "spawnint", 0 )
					westsideSetElementData ( player, "spawndim", 0 )
					infobox(player,"Spawnpunkt geändert!",4000,0,100,150)
				else
					setPlayerNewSpawnpoint ( player, 737.30804443359,-1330.7425537109,13.54866027832, 0, 0, 0 )
				end
			end
			if faction == 6 then
				if sType == "fbiLS" then
					westsideSetElementData ( player, "spawnpos_x", 1218.0723876953 )
					westsideSetElementData ( player, "spawnpos_y", -1818.8544921875 )
					westsideSetElementData ( player, "spawnpos_z", 13.672917366028 )
					westsideSetElementData ( player, "spawnrot_x", 0 )
					westsideSetElementData ( player, "spawnint", 0 )
					westsideSetElementData ( player, "spawndim", 0 )
					infobox(player,"Spawnpunkt geändert!",4000,0,100,150)
				else
					setPlayerNewSpawnpoint ( player, 1218.0723876953,-1818.8544921875,13.672917366028, -90, 3, 0 )
				end
			end
			if faction == 7 then
				if sType == "grovestreet" then
					westsideSetElementData ( player, "spawnpos_x", 2496.1000976563 )
					westsideSetElementData ( player, "spawnpos_y", -1709.0999755859 )
					westsideSetElementData ( player, "spawnpos_z", 1014.700012207 )
					westsideSetElementData ( player, "spawnrot_x", 0.00274658 )
					westsideSetElementData ( player, "spawnint", 3 )
					westsideSetElementData ( player, "spawndim", 0 )
					infobox(player,"Spawnpunkt geändert!",4000,0,100,150)
				end
			end
			if faction == 8 then
				if sType == "sf" then
					westsideSetElementData ( player, "spawnpos_x", -1346.1706542969 )
					westsideSetElementData ( player, "spawnpos_y", 492.36785888672 )
					westsideSetElementData ( player, "spawnpos_z", 10.851915359497 )
					westsideSetElementData ( player, "spawnrot_x", 90 )
					westsideSetElementData ( player, "spawnint", 0 )
					westsideSetElementData ( player, "spawndim", 0 )
					infobox(player,"Spawnpunkt geändert!",4000,0,100,150)
				elseif sType == "lv" then
					westsideSetElementData ( player, "spawnpos_x", 247.46310424805 )
					westsideSetElementData ( player, "spawnpos_y", 1859.85546875 )
					westsideSetElementData ( player, "spawnpos_z", 13.733238220215 )
					westsideSetElementData ( player, "spawnrot_x", 90 )
					westsideSetElementData ( player, "spawnint", 0 )
					westsideSetElementData ( player, "spawndim", 0 )
					infobox(player,"Spawnpunkt geändert!",4000,0,100,150)
				end
			end
			if faction == 9 then
				if sType == "bikerLS" then
					westsideSetElementData ( player, "spawnpos_x", -226.52116394043 )
					westsideSetElementData ( player, "spawnpos_y", 1410.9595947266 )
					westsideSetElementData ( player, "spawnpos_z", 27.7734375 )
					westsideSetElementData ( player, "spawnrot_x", 90 )
					westsideSetElementData ( player, "spawnint", 18 )
					westsideSetElementData ( player, "spawndim", 0 )
					infobox(player,"Spawnpunkt geändert!",4000,0,100,150)
				end
			end
			if faction == 10 then
				if sType == "mechaniker" then
					westsideSetElementData ( player, "spawnpos_x", 1646.61035 )
					westsideSetElementData ( player, "spawnpos_y", -1792.98193 )
					westsideSetElementData ( player, "spawnpos_z", 13.53269 )
					westsideSetElementData ( player, "spawnrot_x", 90 )
					westsideSetElementData ( player, "spawnint", 0 )
					westsideSetElementData ( player, "spawndim", 0 )
					infobox(player,"Spawnpunkt geändert!",4000,0,100,150)
				end
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist in keiner Fraktion!", 4000, 255, 0, 0 )
		end
		infobox(player,"Spawnpunkt geändert!",4000,0,100,150)
	elseif(place=='fahrschuleLS')then
		if(westsideGetElementData(player,'unternehmen')==1)then
			infobox(player,'Spawnpunkt geändert!')
			setPlayerNewSpawnpoint ( player, -2022.3433837891,-118.82856750488,1035.171875,0,3,0 )
		end
	elseif(place=='anwaltLS')then
		if(westsideGetElementData(player,'unternehmen')==2)then
			infobox(player,'Spawnpunkt geändert!')
			setPlayerNewSpawnpoint ( player, 1730.7725830078,-1652.5220947266,20.23470687866,0, 18,1 )
		end
	elseif(place=='detektivLS')then
		if(westsideGetElementData(player,'unternehmen')==3)then
			infobox(player,'Spawnpunkt geändert!')
			setPlayerNewSpawnpoint ( player, 1730.7725830078,-1652.5220947266,20.23470687866,0, 18,2 )
		end
	elseif place == "streetLS" then
		westsideSetElementData ( player, "spawnpos_x", 1568.0203857422 )
		westsideSetElementData ( player, "spawnpos_y", -1898.0130615234 )
		westsideSetElementData ( player, "spawnpos_z", 13.560887336731 )
		westsideSetElementData ( player, "spawnrot_x", 0.00274658 )
		westsideSetElementData ( player, "spawnint", 0 )
		westsideSetElementData ( player, "spawndim", 0 )
		infobox(player,"Spawnpunkt geändert!",4000,0,100,150)
	elseif place == "hier" then
		if(getElementData(player,"vip")>=2)then
			if getElementInterior(player) == 0 then
				local x, y, z = getElementPosition ( player )
				westsideSetElementData ( player, "spawnpos_x", x )
				westsideSetElementData ( player, "spawnpos_y", y )
				westsideSetElementData ( player, "spawnpos_z", z )
				westsideSetElementData ( player, "spawnrot_x", getPedRotation ( player ) )
				westsideSetElementData ( player, "spawnint", getElementInterior ( player ) )
				westsideSetElementData ( player, "spawndim", getElementDimension ( player ) )
						
				infobox(player,"Spawnpunkt geändert!",4000,0,100,150)
			else
				infobox(player,"Nur außerhalb von Interiors\nmöglich!",4000,255,0,0)
			end
		end
	elseif place == "boat" then
		local pname = getPlayerName ( player )
		local model = false
		local veh
		for i = 1, 10 do
			veh = _G[getPrivVehString ( pname, i )]
			if isElement ( veh ) then
				veh = getElementModel ( veh )
				if veh == 454 or veh == 484 then
					if veh == 484 then
						model = "marquis"
					elseif veh == 454 then
						model = "tropic"
					end
					nexti = i
					break
				end
			end
		end
		if not model then
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast keine Yacht!", 5000, 125, 0, 0 )
		else
			westsideSetElementData ( player, "spawnpos_x", model )
			westsideSetElementData ( player, "spawnpos_y", getPrivVehString ( pname, nexti ) )
			westsideSetElementData ( player, "spawnpos_z", 0 )
			westsideSetElementData ( player, "spawnrot_x", 0 )
			westsideSetElementData ( player, "spawnint", 0 )
			westsideSetElementData ( player, "spawndim", 0 )
			infobox(player,"Spawnpunkt geändert!",4000,0,100,150)
		end
	elseif place == "wohnmobil" then
		local wohnmobil = false
		
		for i = 1, 10 do
			veh = _G[getPrivVehString ( pname, i )]
			if isElement ( veh ) then
				if camper [ getElementModel ( veh ) ] then
					wohnmobil = true
				end
			end
		end
		--[[ if wohnmobil then
			westsideSetElementData ( player, "spawnpos_x", "wohnmobil" )
			westsideSetElementData ( player, "spawnpos_y", 0 )
			westsideSetElementData ( player, "spawnpos_z", 0 )
			westsideSetElementData ( player, "spawnrot_x", 0 )
			westsideSetElementData ( player, "spawnint", 0 )
			westsideSetElementData ( player, "spawndim", 0 )
			infobox(player,"Spawnpunkt geändert!",4000,0,100,150)
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast kein Wohnmobil!", 4000, 255,0,0 )
		end ]]--
	end
	MySQL_SetString("userdata", "Spawnpos_X", westsideGetElementData ( player, "spawnpos_x" ), "Name LIKE '"..pname.."'")
	MySQL_SetString("userdata", "Spawnpos_Y", westsideGetElementData ( player, "spawnpos_y" ), "Name LIKE '"..pname.."'")
	MySQL_SetString("userdata", "Spawnpos_Z", westsideGetElementData ( player, "spawnpos_z" ), "Name LIKE '"..pname.."'")
	MySQL_SetString("userdata", "Spawnrot_X", westsideGetElementData ( player, "spawnrot_x" ), "Name LIKE '"..pname.."'")
	MySQL_SetString("userdata", "SpawnInterior", westsideGetElementData ( player, "spawnint" ), "Name LIKE '"..pname.."'")
	MySQL_SetString("userdata", "SpawnDimension", westsideGetElementData ( player, "spawndim" ), "Name LIKE '"..pname.."'")
end

function changeSpawnPosition_func ( arg1, arg2 )

	spawnchange_func ( client, "", arg1, arg2 )
end
addEvent ( "changeSpawnPosition", true )
addEventHandler ( "changeSpawnPosition", getRootElement(), changeSpawnPosition_func )

function setPlayerNewSpawnpoint ( player, x, y, z, rot, int, dim )

	westsideSetElementData ( player, "spawnpos_x", x )
	westsideSetElementData ( player, "spawnpos_y", y )
	westsideSetElementData ( player, "spawnpos_z", z )
	westsideSetElementData ( player, "spawnrot_x", rot )
	westsideSetElementData ( player, "spawnint", int )
	westsideSetElementData ( player, "spawndim", dim )
end