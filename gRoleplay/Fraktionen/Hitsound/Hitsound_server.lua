addCommandHandler("hitsound", function(player)
    if (westsideGetElementData ( player, "gangwarsoundon") == false) then
	    westsideSetElementData( player, "gangwarsoundon", true)
		infobox(player,"Hitsound aktiviert!",4000,0,255,0)
	else
	    westsideSetElementData( player, "gangwarsoundon", false)
		infobox(player,"Hitsound deaktiviert!",4000,255,0,0)
	end
end)