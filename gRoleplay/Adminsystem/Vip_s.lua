local vipGateO   = false
local vipGate    = createObject(3055,1643.5999755859,-1714.9000244141,15.799999237061,0,0,90)
local vipGateM   = createMarker(1641,-1714.9000244141,13.699999809265,"cylinder",5,0,0,0)
setElementAlpha(vipGateM,0)

addEventHandler("onMarkerHit",vipGateM,function(player)
	if(westsideGetElementData(player,"loggedin")==1)then
		if(getElementData(player,"vip")>=1)then
			if(vipGateO==false)then
				vipGateO = true
				moveObject(vipGate,3000,1643.5999755859,-1714.9000244141,8.799999237061)
				
				setTimer(function()
					vipGateO = false
					moveObject(vipGate,3000,1643.5999755859,-1714.9000244141,15.799999237061)
				end,10000,1)
			end
		end
	end
end)

local vipClubIn  = createPickup(1654.03711, -1654.75647, 22.51563,3,1318,50)
local vipClubOut = createPickup(1691.84119, -1703.37329, -90.47387,3,1318,50)

addEventHandler("onPickupHit",vipClubIn,function(player)
	if(westsideGetElementData(player,"loggedin")==1)then
		if(getElementData(player,"vip")>=1)then
			setElementData(player,"vipClub",true)
			fadeElementInterior(player,0,1689.18665, -1703.52087, -90.47387)
		else
			infobox(player,"Nur für Vip's!",4000,255,0,0)
		end
	end
end)

addEventHandler("onPickupHit",vipClubOut,function(player)
	if(westsideGetElementData(player,"loggedin")==1)then
		if(getElementData(player,"vip")>=1)then
			setElementData(player,"vipClub",false)
			fadeElementInterior(player,0,1653.91919, -1657.58691, 22.51563)
		else
			infobox(player,"Nur für Vip's!",4000,255,0,0)
		end
	end
end)

addCommandHandler("p",function(player,cmd,...)
    local parametersTable = {...}
    local text = table.concat(parametersTable," ")
   
   if(westsideGetElementData(player,"loggedin")==1)then
		if(getElementData(player,"vip")>=1)then
			if(not(text==""))then
				for i,pi in ipairs(getElementsByType("player")) do
					if(getElementData(pi,"vip")>=1)then
						outputChatBox("Premium-Spieler: "..getPlayerName(player)..": "..text,pi,0,255,0)
					end
				end
			else
				infobox(player,"Nichts eingetragen!",4000,255,0,0)
			end
		end
	end
end)

addCommandHandler("status",function(player,cmd,status)
	if(westsideGetElementData(player,"loggedin")==1)then
		if(getElementData(player,"vip")>=1)then
			if(getElementData(player,"vipClub")==true)then
				if(status)then
					westsideSetElementData(player,"socialState",status)
					infobox(player,"Du hast deinen Status zu\n"..status.." geändert!",4000,0,255,0,0)
				else
					infobox(player,"Du hast keinen Status eingetragen!",4000,255,0,0)
				end
			else
				infobox(player,"Du bist nicht im Vip Club!",4000,255,0,0)
			end
		end
	end
end)

addCommandHandler("nummer",function(player,cmd,nummer)
	if(westsideGetElementData(player,"loggedin")==1)then
		if(getElementData(player,"vip")>=2)then
			if(getElementData(player,"vipClub")==true)then
				if(nummer)then
					westsideSetElementData(player,"telenr",nummer)
					infobox(player,"Du hast deine Nummer zu\n"..nummer.." geändert!",4000,0,255,0)
				else
					infobox(player,"Du hast keine Nummer eingetragen!",4000,255,0,0)
				end
			else
				infobox(player,"Du bist nicht im Vip Club!",4000,255,0,0)
			end
		end
	end
end)

local xendomGitter=createObject(2990,1534.8000488281,-1451.3000488281,20.60000038147,0,0,0)
local xendomGate=createObject(3037,1534.6999511719,-1451.3000488281,14.60000038147,0,0,90)
local xendomGateOpen=false

addCommandHandler('gate',function(player)
	if(getPlayerSerial(player)=='14752D0DB7F127914E61C4571B0EB043')then
		if(getDistanceBetweenPoints3D(1534.6999511719,-1451.3000488281,14.60000038147,getElementPosition(player))<=10)then
			if(xendomGateOpen==false)then
				xendomGateOpen=true
				moveObject(xendomGate,3000,1534.6999511719,-1451.3000488281,9.60000038147)
				setTimer(function()
					moveObject(xendomGate,3000,1534.6999511719,-1451.3000488281,14.60000038147)
					setTimer(function()
						xendomGateOpen=false
					end,3000,1)
				end,10000,1)
			end
		end
	end
end)