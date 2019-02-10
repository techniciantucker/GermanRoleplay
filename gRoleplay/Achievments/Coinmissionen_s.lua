local coinMissionenAmTag=0
local aktiveCoinMission=false

function startCoinMission()
	if(aktiveCoinMission==false)then
		if(coinMissionenAmTag<11)then
			local coinMissionen=math.random(1,10)
			
			if(coinMissionen==1)then
				coinX,coinY,coinZ = 2276.3000488281,-1625.8000488281,14.300000190735
			elseif(coinMissionen==2)then
				coinX,coinY,coinZ = 2006.5,-1984.5999755859,12.699999809265
			elseif(coinMissionen==3)then
				coinX,coinY,coinZ = 1732.4000244141,-1841.6999511719,12.699999809265
			elseif(coinMissionen==4)then
				coinX,coinY,coinZ = 1339,-1777.0999755859,12.699999809265
			elseif(coinMissionen==5)then
				coinX,coinY,coinZ = 681.09997558594,-1574.1999511719,17.10000038147
			elseif(coinMissionen==6)then
				coinX,coinY,coinZ = 329.10000610352,-1146.8000488281,80.699996948242
			elseif(coinMissionen==7)then
				coinX,coinY,coinZ = 616.40002441406,-1329.5999755859,12.800000190735
			elseif(coinMissionen==8)then
				coinX,coinY,coinZ = 856.90002441406,-1385.9000244141,-1.3999999761581
			elseif(coinMissionen==9)then
				coinX,coinY,coinZ = 402.79998779297,-1618.6999511719,33.299999237061
			elseif(coinMissionen==10)then
				coinX,coinY,coinZ = 2803.8999023438,-1244.4000244141,45
			end
			aktiveCoinMission=true
			coinMissionenAmTag=coinMissionenAmTag+1
			
			outputChatBox('[COIN]: Der Coin wurde auf der Karte markiert!',root,255,255,0)
			coinBlip=createBlip(coinX,coinY,coinZ,0,2,255,255,0)
			coinMarker=createMarker(coinX,coinY,coinZ,'cylinder',1,255,255,0)
			
			addEventHandler('onMarkerHit',coinMarker,function(source)
				if(westsideGetElementData(source,'loggedin')==1)then
					westsideSetElementData(source,'coins',tonumber(westsideGetElementData(source,'coins'))+1)
					infobox(source,'Du erhälst einen Coin.')
					destroyElement(coinBlip)
					destroyElement(coinMarker)
					aktiveCoinMission=false
					outputChatBox('[COIN]: Der Coin wurde von '..getPlayerName(source)..' eingesammelt.',root,255,255,0)
					outputLog('Der Coin wurde von '..getPlayerName(source)..' eingesammelt.','Coins')
				end
			end)
		end
	end
end
setTimer(startCoinMission,3600000,0)