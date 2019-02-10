function onPlayerSpawn_func ()
	if westsideGetElementData ( source, "fskin" ) ~= 0 then
		setPedSkin ( source, westsideGetElementData ( source, "fskin") )
		takeWeapon (source, 42)
		giveWeapon ( source, 42, 10500 )
	else
		setPedSkin ( source, westsideGetElementData ( source, "skinid") )
	end
	showPlayerHudComponent ( source, "radar", true )
	setTimer ( ShowWanteds_func, 250, 1, source )
end
addEventHandler("onPlayerSpawn", getRootElement(), onPlayerSpawn_func )

function ShowWanteds_func ( player )
	setPlayerWantedLevel ( player, tonumber(westsideGetElementData ( player, "wanteds" )) )
end