function WalkingStyle_func(player,cmd,style,gen)
	if style == "Samp" and gen == "w" then
		setPedWalkingStyle(player,131)
		
		infobox(player,"Laufstyle: SAMP, W aktiviert!",4000,0,255,0)
	elseif style == "Samp" and gen == "m" then
		setPedWalkingStyle(player,122)
		
		infobox(player,"Laufstyle: SAMP, M aktiviert!",4000,0,255,0)
	elseif style == "Mta" then
		setPedWalkingStyle(player,0)
		
		infobox(player,"Laufstyle: MTA aktiviert!",4000,0,255,0)
	elseif style == nil then
		infobox(player,"Nutze: /walking [Samp/Mta],\n[m/w] (Nur beim Samp Style nötig)!",4000,0,100,150)
	elseif gen == nil then
		infobox(player,"Nutze: /walking [Samp/Mta],\n[m/w] (Nur beim Samp Style nötig)!",4000,0,100,150)
	end
end
addCommandHandler("walking",WalkingStyle_func)