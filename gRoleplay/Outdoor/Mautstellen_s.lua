----- Mautstellen -----
local MautstellenPreis = 15

local Mautstellen_LSBrueckeRausAbfrage = false
local Mautstellen_LSBrueckeReinAbfrage = false

local Mautstellen_LSBrueckeRaus = createObject(968,65.900001525879,-1529.9000244141,4.6999998092651,0,269.75,263)
local Mautstellen_LSBrueckeRein = createObject(968,60.099998474121,-1536.6999511719,4.6999998092651,0,269.74731445313,83.246215820313)

local Mautstellen_LSBrueckeRausMarker = createMarker(69.400001525879,-1526.9000244141,4,'cylinder',6,200,200,200)
setElementAlpha(Mautstellen_LSBrueckeRausMarker,0)
local Mautstellen_LSBrueckeReinMarker = createMarker(56,-1539.5,4,'cylinder',6,200,200,200)
setElementAlpha(Mautstellen_LSBrueckeReinMarker,0)

addEventHandler('onMarkerHit',Mautstellen_LSBrueckeRausMarker,function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(Mautstellen_LSBrueckeRausAbfrage==false)then
			if(westsideGetElementData(player,'money')>=MautstellenPreis)then
				takePlayerSaveMoney(player,MautstellenPreis)
			
				if(westsideGetElementData(player,'wanteds')>0)then
					sendMSGForFaction('Der Gesuchte '..getPlayerName(player)..' wurde an der Mautstellen Los Santos Brücke gesichtet!',1,200,0,0)
				end
			
				Mautstellen_LSBrueckeRausAbfrage = true
				
				moveObject(Mautstellen_LSBrueckeRaus,3000,65.900001525879,-1529.9000244141,4.6999998092651,0,90,0)
				
				setTimer(function()
					moveObject(Mautstellen_LSBrueckeRaus,3000,65.900001525879,-1529.9000244141,4.6999998092651,0,-90,0)
					
					setTimer(function()
						Mautstellen_LSBrueckeRausAbfrage = false
					end,3000,1)
				end,10000,1)
			else
				infobox(player,'Du benötigst 15$!')
			end
		end
	end
end)

addEventHandler('onMarkerHit',Mautstellen_LSBrueckeReinMarker,function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(Mautstellen_LSBrueckeReinAbfrage==false)then
			if(westsideGetElementData(player,'money')>=MautstellenPreis)then
				takePlayerSaveMoney(player,MautstellenPreis)
			
				if(westsideGetElementData(player,'wanteds')>0)then
					sendMSGForFaction('Der Gesuchte '..getPlayerName(player)..' wurde an der Mautstellen Los Santos Brücke gesichtet!',1,200,0,0)
				end
				
				Mautstellen_LSBrueckeReinAbfrage = true
				
				moveObject(Mautstellen_LSBrueckeRein,3000,60.099998474121,-1536.6999511719,4.6999998092651,0,90,0)
				
				setTimer(function()
					moveObject(Mautstellen_LSBrueckeRein,3000,60.099998474121,-1536.6999511719,4.6999998092651,0,-90,0)
					
					setTimer(function()
						Mautstellen_LSBrueckeReinAbfrage = false
					end,3000,1)
				end,10000,1)
			end
		else
			infobox(player,'Du benötigst 15$!')
		end
	end
end)

function openAllMaustellenForTrucks()
	if(allMautstellenOpen==false)then
		allMautstellenOpen = true
	
		moveObject(Mautstellen_LSBrueckeRaus,3000,65.900001525879,-1529.9000244141,4.6999998092651,0,90,0)
		moveObject(Mautstellen_LSBrueckeRein,3000,60.099998474121,-1536.6999511719,4.6999998092651,0,90,0)
		
		setTimer(function()
			moveObject(Mautstellen_LSBrueckeRaus,3000,65.900001525879,-1529.9000244141,4.6999998092651,0,-90,0)
			moveObject(Mautstellen_LSBrueckeRein,3000,60.099998474121,-1536.6999511719,4.6999998092651,0,-90,0)
		end,600000,1)
	end
end