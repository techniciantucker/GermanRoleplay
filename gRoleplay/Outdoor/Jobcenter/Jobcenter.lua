-- // Jobcenter

jobfenster = createMarker(358.60000610352,180.69999694824,1007.5,"cylinder",1,0,100,200)
setElementInterior (jobfenster, 3)

addEventHandler("onMarkerHit",jobfenster,function(player)
	if(getElementDimension(player)==0)then
		triggerClientEvent(player,"jobcenter",player)
	end
end)

----- Fahrschule -----
fahrschulPickup = createPickup ( -2033.23645, -117.34424, 1035.17188, 3, 1239, 50, 0 )
setElementInterior (fahrschulPickup, 3)

function fahrschulPickup_func (player)
    setElementFrozen ( player, true )
    setTimer ( setElementFrozen, 100, 1, player, false )
	triggerClientEvent ( player, "ShowRathausMenue", getRootElement() )
	showCursor ( player, true )
	setElementData ( player, "ElementClicked", true )
end
addEventHandler ( "onPickupHit", fahrschulPickup, fahrschulPickup_func )

-- // Verwaltung
verwaltungsMarker = createMarker(362.10000610352,173.60000610352,1007.5,"cylinder",1,0,100,200)
setElementInterior(verwaltungsMarker,3)

addEventHandler("onMarkerHit",verwaltungsMarker,function(player)
	if(getElementDimension(player)==0)then
		triggerClientEvent(player,"verwaltung",player)
	end
end)

addEvent("perso",true)
addEventHandler("perso",getRootElement(),function(player)
	local pname = getPlayerName ( player )

	if tonumber(westsideGetElementData ( player, "perso" )) == 0 then
		if tonumber(westsideGetElementData ( player, "money" )) >= 50 then
			westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - 50 )
			infobox(player,"Personalausweis erhalten!",4000,0,255,0)
			westsideSetElementData ( player, "perso", 1 )
			playSoundFrontEnd ( player, 50 )
			takePlayerMoney ( player, 50 )
				
			westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 250)
				
			MySQL_SetString("userdata", "Perso", westsideGetElementData ( player, "perso" ), "Name LIKE '"..pname.."'")	
		else
			infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
		end
	else
		infobox(player,"Du hast bereits einen\nPersonalausweis!",4000,255,0,0)
	end
end)

addEvent("worklicense",true)
addEventHandler("worklicense",getRootElement(),function(player)
	local pname = getPlayerName ( player )

	if tonumber(westsideGetElementData(player,"worklicense")) == 0 then
		infobox(player,"Arbeitsgenehmigung erhalten!",4000,0,255,0)
		westsideSetElementData(player,"worklicense",1)
		westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 250)
		MySQL_SetString("userdata", "Arbeitsgenehmigung", westsideGetElementData ( player, "worklicense" ), "Name LIKE '"..pname.."'")
	else
		infobox(player,"Du hast bereits eine\nArbeitsgenehmigung!",4000,255,0,0)
	end
end)

addEvent("hartz7",true)
addEventHandler("hartz7",getRootElement(),function(player)
	local pname = getPlayerName ( player )

	if westsideGetElementData(player,"fraktion") == 0 then
		if tonumber(westsideGetElementData(player,"hartzseven")) == 0 then
			infobox(player,"Hartz 7 angemeldet!",4000,0,255,0)
			westsideSetElementData(player,"hartzseven",1)
			MySQL_SetString("userdata", "Hartz7", westsideGetElementData ( player, "hartzseven" ), "Name LIKE '"..pname.."'")
		else
			infobox(player,"Hartz 7 abgemeldet!",4000,255,0,0)
			westsideSetElementData(player,"hartzseven",0)
			MySQL_SetString("userdata", "Hartz7", westsideGetElementData ( player, "hartzseven" ), "Name LIKE '"..pname.."'")
		end
	else
		infobox(player,"Verlasse zu erst deine Fraktion!")
	end
end)