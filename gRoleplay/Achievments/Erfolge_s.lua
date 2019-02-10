----- Schwimmen & Laufen -----
function checkAddLaufUndSchwimm()
    setTimer(checkAddLaufUndSchwimm,1000,1)
    for theKey,thePlayer in ipairs(getElementsByType("player"))do
        if(westsideGetElementData(thePlayer,'loggedin')==1)then
            if(not isPedInVehicle(thePlayer) and getElementInterior(thePlayer)==0)then
                if(isElementInWater ( thePlayer ))then
                   local x,y,z=getElementPosition(thePlayer)
                   if(westsideGetElementData(thePlayer,"lastSwimRunState")=="water")then
                       local oldKoord=westsideGetElementData(thePlayer,"lastSwimRunKoords")
                       local dis=getDistanceBetweenPoints3D(oldKoord[1],oldKoord[2],oldKoord[3],x,y,z)
                       westsideSetElementData(thePlayer,"Punkte_Rekordschwimmer",westsideGetElementData(thePlayer,"Punkte_Rekordschwimmer")+dis)
                       if(westsideGetElementData(thePlayer,"Punkte_Rekordschwimmer")>10000)then
                           if(westsideGetElementData(thePlayer,"Erfolg_Rekordschwimmer")~=1)then
                               westsideSetElementData(thePlayer,"Erfolg_Rekordschwimmer",1)
                               triggerClientEvent(thePlayer,'erfolgWindow',thePlayer,'Rekordschwimmer')
							   westsideSetElementData(thePlayer,'pokale',tonumber(westsideGetElementData(thePlayer,'pokale'))+1)
							   outputLog(getPlayerName(thePlayer)..' hat den Erfolg Rekordschwimmer freigeschalten!','Erfolge')
                           end
                       end
                   end
                   westsideSetElementData(thePlayer,"lastSwimRunKoords",{x,y,z})
                   westsideSetElementData(thePlayer,"lastSwimRunState","water")
                elseif(isPedOnGround ( thePlayer))then
                    local x,y,z=getElementPosition(thePlayer)
                    if(westsideGetElementData(thePlayer,"lastSwimRunState")=="ground")then
                        local oldKoord=westsideGetElementData(thePlayer,"lastSwimRunKoords")
                        local dis=getDistanceBetweenPoints3D(oldKoord[1],oldKoord[2],oldKoord[3],x,y,z)
                        westsideSetElementData(thePlayer,"Punkte_Langlaeufer",westsideGetElementData(thePlayer,"Punkte_Langlaeufer")+dis)
                        if(westsideGetElementData(thePlayer,"Punkte_Langlaeufer")>1000000)then
                            if(westsideGetElementData(thePlayer,"Erfolg_Langlaeufer")~=1)then
                                westsideSetElementData(thePlayer,"Erfolg_Langlaeufer",1)
                                triggerClientEvent(thePlayer,'erfolgWindow',thePlayer,'Langläufer')
								westsideSetElementData(thePlayer,'pokale',tonumber(westsideGetElementData(thePlayer,'pokale'))+1)
								outputLog(getPlayerName(thePlayer)..' hat den Erfolg Langläufer freigeschalten!','Erfolge')
                            end
                        end
                    end
                    westsideSetElementData(thePlayer,"lastSwimRunKoords",{x,y,z})
                    westsideSetElementData(thePlayer,"lastSwimRunState","ground")
                end
            end
        end
    end
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),checkAddLaufUndSchwimm)

----- Pokale zeigen -----
addCommandHandler('showpokale',function(player,cmd,target)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(not(target))then
			infobox(player,'Keinen Spieler angegeben!')
		else
			local tplayer=getPlayerFromName(target)
			local tx,ty,tz=getElementPosition(tplayer)
			local x,y,z=getElementPosition(player)
			if(getDistanceBetweenPoints3D(tx,ty,tz,x,y,z)<10)then
				infobox(player,'Du hast '..getPlayerName(tplayer)..'\ndeine Pokale gezeigt.')
				outputChatBox('Pokale von '..getPlayerName(player)..':',tplayer,0,200,0)
				if(westsideGetElementData(player,'Erfolg_Rekordschwimmer')==1)then
					outputChatBox('Rekordschwimmer',tplayer,0,150,0)
				end
				if(westsideGetElementData(player,'Erfolg_Langlaeufer')==1)then
					outputChatBox('Langläufer',tplayer,0,150,0)
				end
				if(westsideGetElementData(player,'Erfolg_Busfahrer')==1)then
					outputChatBox('Haltestellensammler',tplayer,0,150,0)
				end
				if(westsideGetElementData(player,'Erfolg_Eisfahrer')==1)then
					outputChatBox('Schleck ma',tplayer,0,150,0)
				end
				if(westsideGetElementData(player,'Erfolg_Hotdog')==1)then
					outputChatBox('Wurst ins Brot',tplayer,0,150,0)
				end
				if(westsideGetElementData(player,'Erfolg_Meeresreiniger')==1)then
					outputChatBox('Umweltfreundlich',tplayer,0,150,0)
				end
				if(westsideGetElementData(player,'Erfolg_Pilot')==1)then
					outputChatBox('Ein echter Flieger',tplayer,0,150,0)
				end
				if(westsideGetElementData(player,'Erfolg_Pizzalieferant')==1)then
					outputChatBox('Gesund? Kenne ich nicht',tplayer,0,150,0)
				end
				if(westsideGetElementData(player,'Erfolg_Strassenreiniger')==1)then
					outputChatBox('Ein echter Müllman',tplayer,0,150,0)
				end
				if(westsideGetElementData(player,'Erfolg_Trucker')==1)then
					outputChatBox('Lieferant des Jahres',tplayer,0,150,0)
				end
				if(westsideGetElementData(player,'Erfolg_MeinZuhause')==1)then
					outputChatBox('Mein erstes Zuhause',tplayer,0,150,0)
				end
				if(westsideGetElementData(player,'Erfolg_MeinErstesFahrzeug')==1)then
					outputChatBox('Mein erstes Fahrzeug',tplayer,0,150,0)
				end
				if(westsideGetElementData(player,'Erfolg_MeinErstesGeld')==1)then
					outputChatBox('Mein erstes Geld',tplayer,0,150,0)
				end
				if(westsideGetElementData(player,'Erfolg_Millionaer')==1)then
					outputChatBox('Millionär',tplayer,0,150,0)
				end
				if(westsideGetElementData(player,'Erfolg_Fahrzeugsammler')==1)then
					outputChatBox('Fahrzeugsammler',tplayer,0,150,0)
				end
				if(westsideGetElementData(player,'Erfolg_EndlichLevel25')==1)then
					outputChatBox('Endlich Level 25',tplayer,0,150,0)
				end
				if(westsideGetElementData(player,'Erfolg_250Spielstunden')==1)then
					outputChatBox('250 Spielstunden',tplayer,0,150,0)
				end
				if(westsideGetElementData(player,'Erfolg_Bergwerkarbeiter')==1)then
					outputChatBox('Überschüttet von Steinen',tplayer,0,150,0)
				end
			else
				infobox(player,'Du bist zu weit entfernt!')
			end
		end
	end
end)