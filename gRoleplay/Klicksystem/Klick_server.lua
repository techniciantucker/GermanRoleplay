addCommandHandler('number',function(player,cmd,target)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(target)then
			local tplayer = getPlayerFromName(target)
			
			outputChatBox('Handynummer von '..getPlayerName(tplayer)..': '..westsideGetElementData(tplayer,'telenr'),player,0,200,0)
		else
			infobox(player,'Keinen Spieler angegeben!')
		end
	end
end)

addCommandHandler('showlicense',function(player,cmd,target)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(target)then
			local tplayer = getPlayerFromName(target)
			
			infobox(player,'Du hast '..getPlayerName(tplayer)..'\ndeine Lizenzen gezeigt.')
			outputChatBox('Lizenzen von '..getPlayerName(player),tplayer,0,200,0)
			
			if westsideGetElementData ( player, "carlicense" ) == 1 then
				outputChatBox('Fahrzeugschein',tplayer,0,150,0)
			end
			if westsideGetElementData ( player, "bikelicense" ) == 1 then
				outputChatBox('Motorbootschein',tplayer,0,150,0)
			end
			if westsideGetElementData ( player, "gunlicense" ) == 1 then
				outputChatBox('Waffenschein A',tplayer,0,150,0)
			end
			if westsideGetElementData ( player, "motorbootlicense" ) == 1 then
				outputChatBox('Motorbootschein',tplayer,0,150,0)
			end
			if westsideGetElementData ( player, "segellicense" ) == 1 then
				outputChatBox('Segelschein',tplayer,0,150,0)
			end
			if westsideGetElementData ( player, "planelicenseb" ) == 1 then
				outputChatBox('Flugschein B',tplayer,0,150,0)
			end
			if westsideGetElementData ( player, "planelicensea" ) == 1 then
				outputChatBox('Flugschein A',tplayer,0,150,0)
			end
			if westsideGetElementData ( player, "helilicense" ) == 1 then
				outputChatBox('Helikopterschein',tplayer,0,150,0)
			end
			if(westsideGetElementData(player,'gunlicenseB')==1)then
				outputChatBox('Waffenschein B',tplayer,0,150,0)
			end
			if(westsideGetElementData(player,'gunlicenseC')==1)then
				outputChatBox('Waffenschein C',tplayer,0,150,0)
			end
		else
			infobox(player,'Keinen Spieler angegeben!')
		end
	end
end)