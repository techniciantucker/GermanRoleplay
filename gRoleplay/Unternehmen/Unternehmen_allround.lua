--[[

1. Fahrschule
2. Anwalt
3. Detektiv

]]--

addCommandHandler('setunternehmen',function(player,cmd,target,unternehmen)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'adminlvl')>=4)then
			if(target)then
				local tplayer=getPlayerFromName(target)
				if(unternehmen)then
					if(unternehmen=='fahrschule')then
						westsideSetElementData(tplayer,'unternehmen',1)
						westsideSetElementData(tplayer,'unternehmenrang',3)
						outputChatBox('Du wurdest zum Leader des Unternehmens Fahrschule ernannt!',tplayer,0,200,0)
					elseif(unternehmen=='anwalt')then
						westsideSetElementData(tplayer,'unternehmen',2)
						westsideSetElementData(tplayer,'unternehmenrang',3)
						outputChatBox('Du wurdest zum Leader des Unternehmens Anwaltkanzlei ernannt!',tplayer,0,200,0)
					elseif(unternehmen=='detektiv')then
						westsideSetElementData(tplayer,'unternehmen',3)
						westsideSetElementData(tplayer,'unternehmenrang',3)
						outputChatBox('Du wurdest zum Leader des Unternehmens Detektei ernannt!',tplayer,0,200,0)
					elseif(unternehmen=='keins')then
						westsideSetElementData(tplayer,'unternehmen',0)
						westsideSetElementData(tplayer,'unternehmenrang',0)
						outputChatBox('Du wurdest aus deinem Unternehmen entfernt!',tplayer,0,200,0)
					else
						infobox(player,'Ungültiges Unternehmen!')
					end
				else
					infobox(player,'Kein Unternehmen angegeben!')
					outputChatBox('Tippe /setunternehmen [fahrschule/anwalt/detektiv]!',player,0,200,0)
				end
			else
				infobox(player,'Kein Spieler angegeben!')
			end
		end
	end
end)

addCommandHandler('uinvite',function(player,cmd,target)
	if(westsideGetElementData(player,'loggedin')==1)then
		local unternehmen=westsideGetElementData(player,'unternehmen')
		local urang=westsideGetElementData(player,'unternehmenrang')
		
		if(target)then
			local tplayer=getPlayerFromName(target)
			if(urang==3)then
				if(westsideGetElementData(tplayer,'unternehmen')==0)then
					westsideSetElementData(tplayer,'unternehmen',unternehmen)
					westsideSetElementData(tplayer,'unternehmenrang',0)
					outputChatBox('Du wurdest so eben in ein Unternehmen invitet!',tplayer,0,200,0)
					outputChatBox('Du hast '..getPlayerName(tplayer)..' in dein Unternehmen invitet!',player,0,200,0)
				else
					infobox(player,'Der Spieler ist bereits in\neinem Unternehmen!')
				end
			else
				infobox(player,'Du bist nicht befugt!')
			end
		else
			infobox(player,'Kein Spieler angegeben!')
		end
	end
end)

addCommandHandler('uuninvite',function(player,cmd,target)
	if(westsideGetElementData(player,'loggedin')==1)then
		local unternehmen=westsideGetElementData(player,'unternehmen')
		local urang=westsideGetElementData(player,'unternehmenrang')
		
		if(target)then
			local tplayer=getPlayerFromName(target)
			if(urang==3)then
				if(westsideGetElementData(tplayer,'unternehmen')==unternehmen)then
					westsideSetElementData(tplayer,'unternehmen',0)
					westsideSetElementData(tplayer,'unternehmenrang',0)
					outputChatBox('Du wurdest so eben aus deinem Unternehmen uninvitet!',tplayer,0,200,0)
					outputChatBox('Du hast '..getPlayerName(tplayer)..' aus deinem Unternehmen uninvitet!',player,0,200,0)
				else
					infobox(player,'Der Spieler ist nicht in\ndeinem Unternehmen!')
				end
			else
				infobox(player,'Du bist nicht befugt!')
			end
		else
			infobox(player,'Kein Spieler angegeben!')
		end
	end
end)

addCommandHandler('urang',function(player,cmd,target,rang)
	if(westsideGetElementData(player,'loggedin')==1)then
		local unternehmen=westsideGetElementData(player,'unternehmen')
		local urang=westsideGetElementData(player,'unternehmenrang')
		
		if(target)then
			local tplayer=getPlayerFromName(target)
			if(rang)then
				if(tonumber(rang)<3)then
					if(urang==3)then
						if(westsideGetElementData(tplayer,'unternehmen')==unternehmen)then
							westsideSetElementData(tplayer,'unternehmenrang',rang)
							outputChatBox('Dir wurde so eben auf Rang '..rang..' gesetzt!',tplayer,0,200,0)
							outputChatBox('Du hast '..getPlayerName(tplayer)..' auf Rang '..rang..' gesetzt!',player,0,200,0)
						else
							infobox(player,'Der Spieler ist nicht in\ndeinem Unternehmen!')
						end
					else
						infobox(player,'Du bist nicht befugt!')
					end
				else
					infobox(player,'Rang 3 ist nicht möglich!')
				end
			else
				infobox(player,'Kein Rang angegeben!')
			end
		else
			infobox(player,'Kein Spieler angegeben!')
		end
	end
end)

addCommandHandler('uspawn',function(player)
	if(westsideGetElementData(player,'unternehmen')==0)then
		return false
	else
		if(westsideGetElementData(player,'unternehmen')==1)then
			infobox(player,'Spawnpunkt geändert!')
			setPlayerNewSpawnpoint ( player, -2022.3433837891,-118.82856750488,1035.171875,0,3,0 )
		elseif(westsideGetElementData(player,'unternehmen')==2)then
			infobox(player,'Spawnpunkt geändert!')
			setPlayerNewSpawnpoint ( player, 1730.7725830078,-1652.5220947266,20.23470687866,0, 18,1 )
		elseif(westsideGetElementData(player,'unternehmen')==3)then
			infobox(player,'Spawnpunkt geändert!')
			setPlayerNewSpawnpoint ( player, 1730.7725830078,-1652.5220947266,20.23470687866,0, 18,2 )
		end
		MySQL_SetString("userdata", "Spawnpos_X", westsideGetElementData ( player, "spawnpos_x" ), "Name LIKE '"..pname.."'")
		MySQL_SetString("userdata", "Spawnpos_Y", westsideGetElementData ( player, "spawnpos_y" ), "Name LIKE '"..pname.."'")
		MySQL_SetString("userdata", "Spawnpos_Z", westsideGetElementData ( player, "spawnpos_z" ), "Name LIKE '"..pname.."'")
		MySQL_SetString("userdata", "Spawnrot_X", westsideGetElementData ( player, "spawnrot_x" ), "Name LIKE '"..pname.."'")
		MySQL_SetString("userdata", "SpawnInterior", westsideGetElementData ( player, "spawnint" ), "Name LIKE '"..pname.."'")
		MySQL_SetString("userdata", "SpawnDimension", westsideGetElementData ( player, "spawndim" ), "Name LIKE '"..pname.."'")
	end
end)

addEventHandler('onPlayerQuit',root,function()
	if(getElementData(source,'fduty')==true)then
		setElementData(souce,'fduty',false)
	end
	if(getElementData(source,'dduy')==true)then
		setElementData(souce,'dduty',false)
	end
	if(getElementData(source,'aduty')==true)then
		setElementData(souce,'aduty',false)
	end
end)

addEventHandler('onPedWasted',root,function()
	if(getElementData(source,'fduty')==true)then
		setElementData(souce,'fduty',false)
	end
	if(getElementData(source,'dduy')==true)then
		setElementData(souce,'dduty',false)
	end
	if(getElementData(source,'aduty')==true)then
		setElementData(souce,'aduty',false)
	end
end)