-- Blips --

function QuestBlipsAufderKarte()
	outputDebugString('Quest Blips auf der Karte wurden erstellt!')
	if(not(Quest1BlipAufderKarte))then
		Quest1BlipAufderKarte = createBlip(1546.9000244141,-1679.9000244141,12.10000038147,0,2,0,200,200,255,0,200,getRootElement())
	end
	if(not(Quest2BlipAufderKarte))then
		Quest2BlipAufderKarte = createBlip(1789.40259,-2303.75464,-2.59774,0,2,0,200,200,255,0,200,getRootElement())
	end
end
setTimer(QuestBlipsAufderKarte,5000,1)

-- Variablen --

local Quest1 = false
local Quest1Green = false
local Quest1Yellow = false
local Koffer = {}

local Quest2 = false
local Kokssaecke = 0

-- Info Marker --

Quest1PedMarker = createMarker(1546.9000244141,-1679.9000244141,13.10000038147,"cylinder",1,0,100,150)
setElementAlpha(Quest1PedMarker,0)
Quest1HausMarker = createMarker(992.40002441406,-2148.6999511719,12.89999961853,"cylinder",1,0,100,150)
setElementAlpha(Quest1HausMarker,0)

Quest2PedMarker = createMarker(1789.40259,-2303.75464,-2.59774,"cylinder",1,0,100,150)
setElementAlpha(Quest2PedMarker,0)

addEventHandler("onMarkerHit",Quest1PedMarker,function(player)
	if isPedInVehicle (player) == false then
		if Quest1 == false then
			infobox(player,"Lust auf eine Quest? Tippe /quest1!")
		end
	end
end)
addEventHandler("onMarkerHit",Quest1HausMarker,function(player)
	if isPedInVehicle (player) == false then
		outputChatBox("Alte Lady: Hau ab, du Hippi!",player,255,255,255)
	end
end)

addEventHandler("onMarkerHit",Quest2PedMarker,function(player)
	if isPedInVehicle (player) == false then
		if Quest2 == false then
			infobox(player,"Lust auf eine Quest? Tippe /quest2!")
		end
	end
end)

-- Quest 1 --

DrugGreen1 = createObject(1578,1002.0999755859,-2143.5,12.60000038147,0,0,0)
DrugGreen2 = createObject(1578,1001.9000244141,-2143.1000976563,12.60000038147,0,0,0)
DrugGreen3 = createObject(1578,1001.700012207,-2142.6999511719,12.60000038147,0,0,0)
DrugGreen4 = createObject(1578,1001.5,-2142.3000488281,12.60000038147,0,0,0)
DrugGreen5 = createObject(1578,1001.299987793,-2141.8999023438,12.60000038147,0,0,0)
DrugGreen6 = createObject(1578,1001.5,-2143.5,12.60000038147,0,0,0)
DrugGreen7 = createObject(1578,1001.299987793,-2143.1000976563,12.60000038147,0,0,0)
DrugGreen8 = createObject(1578,1001.0999755859,-2142.6999511719,12.60000038147,0,0,0)
DrugGreen9 = createObject(1578,1000.9000244141,-2142.3000488281,12.60000038147,0,0,0)

DrugsYellow1 = createObject(1577,1004.700012207,-2145.6999511719,12.60000038147,0,0,0)
DrugsYellow2 = createObject(1577,1004.5999755859,-2146.1000976563,12.60000038147,0,0,349.99664306641)
DrugsYellow3 = createObject(1577,1004,-2145.8000488281,12.60000038147,0,0,26)
DrugsYellow4 = createObject(1577,1003.4000244141,-2145.6999511719,12.60000038147,0,0,284)
DrugsYellow5 = createObject(1577,1002.9000244141,-2145.6999511719,12.60000038147,0,0,32)

Quest1Marker1 = createMarker(1003.9000244141,-2144.8999023438,12.10000038147,"cylinder",1,0,100,150)
setElementAlpha(Quest1Marker1,100)
Quest1Marker2 = createMarker(1002.5,-2142.3999023438,12.10000038147,"cylinder",1,0,100,150)
setElementAlpha(Quest1Marker2,100)
Quest1Blip = createBlip(1003.9000244141,-2144.8999023438,12.10000038147,19)
Quest1AbgebenBlip = createBlip(1546.9000244141,-1679.9000244141,12.10000038147,19)
Quest1Abgeben = createMarker(1546.9000244141,-1679.9000244141,13.10000038147,"cylinder",1,0,100,150)
setElementAlpha(Quest1Abgeben,100)

setElementVisibleTo(Quest1Marker1,getRootElement(),false)
setElementVisibleTo(Quest1Marker2,getRootElement(),false)
setElementVisibleTo(Quest1Blip,getRootElement(),false)
setElementVisibleTo(Quest1AbgebenBlip,getRootElement(),false)
setElementVisibleTo(Quest1Abgeben,getRootElement(),false)

addEventHandler("onMarkerHit",Quest1Marker1,function(player)
	if Quest1 == true then
		if getElementData(player,"inQuest1") == true then
			infobox(player,"Tippe /drugsYellow, zum\neinstecken der Drogen!",4000,0,255,0)
		end
	end
end)
addEventHandler("onMarkerHit",Quest1Marker2,function(player)
	if Quest1 == true then
		if getElementData(player,"inQuest1") == true then
			infobox(player,"Tippe /drugsGreen, zum\neinstecken der Drogen!",4000,0,255,0)
		end
	end
end)

addCommandHandler("quest1",function(player)
	if westsideGetElementData(player,"loggedin") == 1 then
		if isPedInVehicle (player) == false then
			if getDistanceBetweenPoints3D(1546.9000244141,-1679.9000244141,13.10000038147,getElementPosition(player)) < 5 then
				if getElementData(player,"inQuest") == false then
					if Quest1 == false then
						infobox(player,"Quest angenommen!",4000,0,255,0)
						outputChatBox("[INFO]: Gehe zum Drogenhaus der alten Lady (Rote Flagge auf der Karte),",player,0,100,150)
						outputChatBox("und bringe dem Beamten alle Drogen! Als Belohnung erhälst du EP!",player,0,100,200)
						
						setElementVisibleTo(Quest1Marker1,player,true)
						setElementVisibleTo(Quest1Marker2,player,true)
						setElementVisibleTo(Quest1Blip,player,true)
						
						setElementData(player,"inQuest1",true)
						setElementData(player,"inQuest",true)
						Quest1 = true
						destroyElement(Quest1BlipAufderKarte)
					else
						infobox(player,"Die Quest kann nur alle\n4 Stunden erledigt werden!",4000,255,0,0)
					end
				else
					infobox(player,"Du bist bereits in\neiner anderen Quest!",4000,255,0,0)
				end
			else
				infobox(player,"Du bist nicht an der\nrichtigen Stelle!")
			end
		end
	end
end)

addCommandHandler("drugsGreen",function(player,cmd)
	if westsideGetElementData(player,"loggedin") == 1 then
		if isPedInVehicle (player) == false then
			if getDistanceBetweenPoints3D(1002.5,-2142.3999023438,12.10000038147,getElementPosition(player)) < 5 then
				if getElementData(player,"inQuest1") == true then
					if Quest1Green == false then
						infobox(player,"Das einsammeln dauert 3 Minuten!",4000,0,255,0)
						setElementFrozen(player,true)
						Quest1Green = true
						setPedAnimation(player,"DEALER","DRUGS_BUY")
						noDM(player)
						
						setTimer(function()
							destroyElement(DrugGreen1)
							destroyElement(DrugGreen2)
							destroyElement(DrugGreen3)
							destroyElement(DrugGreen4)
							destroyElement(DrugGreen5)
							destroyElement(DrugGreen6)
							destroyElement(DrugGreen7)
							destroyElement(DrugGreen8)
							destroyElement(DrugGreen9)
							
							setPedAnimation(player,false)
							endfroze(player)
							yesDM(player)
							setElementVisibleTo(Quest1Marker2,player,false)
							infobox(player,"Du hast alle Drogen von\ndiesem Tisch eingesammelt!",4000,0,255,0)
							
							if Quest1Yellow == true then
								Koffer[player] = createObject(1210, 0, 0, 0 )
								exports.bone_attach:attachElementToBone(Koffer[player],player,12,0,0,0.3,0,180,0)
									
								setElementVisibleTo(Quest1Blip,player,false)
								setElementVisibleTo(Quest1AbgebenBlip,player,true)
								setElementVisibleTo(Quest1Abgeben,player,true)
									
								infobox(player,"Bring die Drogen zum Beamten!",4000,0,255,0)
							end
						end,180000,1)
					end
				end
			else
				infobox(player,"Du bist nicht am\nHaus der alten Lady!",4000,255,0,0)
			end
		else
			infobox(player,"Steige aus deinem Fahrzeug!")
		end
	end
end)

addCommandHandler("drugsYellow",function(player,cmd)
	if westsideGetElementData(player,"loggedin") == 1 then
		if isPedInVehicle (player) == false then
			if getDistanceBetweenPoints3D(1003.9000244141,-2144.8999023438,12.10000038147,getElementPosition(player)) < 5 then
				if getElementData(player,"inQuest1") == true then
					if Quest1Yellow == false then
						infobox(player,"Das einsammeln dauert 2 Minuten!",4000,0,255,0)
						setElementFrozen(player,true)
						Quest1Yellow = true
						setPedAnimation(player,"DEALER","DRUGS_BUY")
						noDM(player)
						
						setTimer(function()
							destroyElement(DrugsYellow1)
							destroyElement(DrugsYellow2)
							destroyElement(DrugsYellow3)
							destroyElement(DrugsYellow4)
							destroyElement(DrugsYellow5)
												
							setPedAnimation(player,false)
							endfroze(player)
							yesDM(player)
							setElementVisibleTo(Quest1Marker1,player,false)
							infobox(player,"Du hast alle Drogen von\ndiesem Tisch eingesammelt!",4000,0,255,0)
							
							if Quest1Green == true then
								Koffer[player] = createObject(1210, 0, 0, 0 )
								exports.bone_attach:attachElementToBone(Koffer[player],player,12,0,0,0.3,0,180,0)
								
								setElementVisibleTo(Quest1Blip,player,false)
								setElementVisibleTo(Quest1AbgebenBlip,player,true)
								setElementVisibleTo(Quest1Abgeben,player,true)
								
								infobox(player,"Bring die Drogen zum Beamten!",4000,0,255,0)
							end
						end,120000,1)
					end
				end
			else
				infobox(player,"Du bist nicht am\nHaus der alten Lady!",4000,255,0,0)
			end
		else
			infobox(player,"Steige aus deinem Fahrzeug!")
		end
	end
end)

addEventHandler("onMarkerHit",Quest1Abgeben,function(player)
	if isPedInVehicle (player) == false then
		if getElementData(player,"inQuest1") == true then
			if Quest1Green == true and Quest1Yellow == true then
				giveEP = math.random(2000,2500)
				
				destroyElement(Koffer[player])
				westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + giveEP)
				
				outputChatBox("Beamter: Zum Glück, du hast es geschafft! Hier hast du "..giveEP.." EP!",player,255,255,255)
				
				setElementData(player,"inQuest",false)
				setElementData(player,"inQuest1",false)
				
				setElementVisibleTo(Quest1AbgebenBlip,player,false)
				setElementVisibleTo(Quest1Abgeben,player,false)
				
				setTimer(function()
					Quest1 = false
					QuestBlipsAufderKarte()
					
					DrugGreen1 = createObject(1578,1002.0999755859,-2143.5,12.60000038147,0,0,0)
					DrugGreen2 = createObject(1578,1001.9000244141,-2143.1000976563,12.60000038147,0,0,0)
					DrugGreen3 = createObject(1578,1001.700012207,-2142.6999511719,12.60000038147,0,0,0)
					DrugGreen4 = createObject(1578,1001.5,-2142.3000488281,12.60000038147,0,0,0)
					DrugGreen5 = createObject(1578,1001.299987793,-2141.8999023438,12.60000038147,0,0,0)
					DrugGreen6 = createObject(1578,1001.5,-2143.5,12.60000038147,0,0,0)
					DrugGreen7 = createObject(1578,1001.299987793,-2143.1000976563,12.60000038147,0,0,0)
					DrugGreen8 = createObject(1578,1001.0999755859,-2142.6999511719,12.60000038147,0,0,0)
					DrugGreen9 = createObject(1578,1000.9000244141,-2142.3000488281,12.60000038147,0,0,0)

					DrugsYellow1 = createObject(1577,1004.700012207,-2145.6999511719,12.60000038147,0,0,0)
					DrugsYellow2 = createObject(1577,1004.5999755859,-2146.1000976563,12.60000038147,0,0,349.99664306641)
					DrugsYellow3 = createObject(1577,1004,-2145.8000488281,12.60000038147,0,0,26)
					DrugsYellow4 = createObject(1577,1003.4000244141,-2145.6999511719,12.60000038147,0,0,284)
					DrugsYellow5 = createObject(1577,1002.9000244141,-2145.6999511719,12.60000038147,0,0,32)
				end,14400000,1)
			end
		end
	end
end)

-- Quest 2 --
Quest2MarkerRein = createMarker(263.54019,2882.29956,12.58628,"corona",1,0,100,150)
setElementAlpha(Quest2MarkerRein,100)
Quest2MarkerRaus = createMarker(315.79998779297,1037.6999511719,1947.0999755859,"cylinder",1,0,100,150)
setElementAlpha(Quest2MarkerRaus,100)
setElementInterior(Quest2MarkerRaus,9)
Quest2Blip = createBlip(263.54019,2882.29956,12.58628,19)
Quest2AbgabeBlip = createBlip(1789.40259,-2303.75464,-2.59774,19)
Quest2AbgabeMarker = createMarker(1789.40259,-2303.75464,-2.59774,"cylinder",1,0,100,150)
setElementAlpha(Quest2AbgabeMarker,100)

setElementVisibleTo(Quest2Blip,getRootElement(),false)
setElementVisibleTo(Quest2MarkerRein,getRootElement(),false)
setElementVisibleTo(Quest2MarkerRaus,getRootElement(),false)
setElementVisibleTo(Quest2AbgabeBlip,getRootElement(),false)
setElementVisibleTo(Quest2AbgabeMarker,getRootElement(),false)

addEventHandler("onMarkerHit",Quest2MarkerRein,function(player)
	if isPedInVehicle (player) == false then
		if getElementData(player,"inQuest2") == true then
			fadeElementInterior(player,9,315.79998779297,1035.3000488281,1948,180)
			outputChatBox("[INFO]: Klicke auf die Kokssäcke, um sie einzusammeln!",player,0,100,200)
			outputChatBox("Du hast 3 Minuten Zeit, bis das Flugzeug explodiert!",player,0,100,150)
			
			Quest2FlugzeugExplodeFunk = setTimer(function()
				fadeElementInterior(player,0,259.5,2881.1000976563,13.39999961853,180)
				setElementHealth(player,5)
				setPedArmor(player,0)
				outputChatBox("[INFO]: Das Flugzeug ist in die Luft gegangen! Du konntest "..Kokssaecke.." Kokssäcke retten!",player,0,100,200)
				outputChatBox("Kehre nun zurück zum Dealer!",player,0,100,200)
						
				setElementVisibleTo(Quest2AbgabeBlip,player,true)
				setElementVisibleTo(Quest2AbgabeMarker,player,true)
						
				setElementVisibleTo(Quest2Blip,getRootElement(),false)
				setElementVisibleTo(Quest2MarkerRein,getRootElement(),false)
				setElementVisibleTo(Quest2MarkerRaus,getRootElement(),false)
			end,180000,1)
		end
	end
end)
addEventHandler("onMarkerHit",Quest2MarkerRaus,function(player)
	if isPedInVehicle (player) == false then
		if getElementData(player,"inQuest2") == true then
			fadeElementInterior(player,0,259.5,2881.1000976563,13.39999961853,180)
			if Kokssaecke < 12 then
				outputChatBox("[INFO]: Du hast erst "..Kokssaecke.." Kokssäcke! Insgesamt gibt es 12!",player,0,100,150)
				outputChatBox("Kehre zurück, wenn du mehr EP erhalten möchtest!",player,0,100,200)
				
				setElementVisibleTo(Quest2AbgabeBlip,player,true)
				setElementVisibleTo(Quest2AbgabeMarker,player,true)
			else
				outputChatBox("[INFO]: Du konntest 12 Kokssäcke retten! Kehre zurück zum Dealer!",player,0,100,150)
				
				setElementVisibleTo(Quest2AbgabeBlip,player,true)
				setElementVisibleTo(Quest2AbgabeMarker,player,true)
				
				setElementVisibleTo(Quest2Blip,getRootElement(),false)
				setElementVisibleTo(Quest2MarkerRein,getRootElement(),false)
				setElementVisibleTo(Quest2MarkerRaus,getRootElement(),false)
				
				killTimer(Quest2FlugzeugExplodeFunk)
			end
		end
	end
end)

Quest2KoksPositionen = {
	{2060,313.79998779297,984.29998779297,1958.1999511719},
	{2060,313.79998779297,983.70001220703,1958.3000488281},
	{2060,313.79998779297,983.09997558594,1958.4000244141},
	{2060,312.5,983.09997558594,1958.4000244141},
	{2060,312.5,983.70001220703,1958.3000488281},
	{2060,312.5,984.29998779297,1958.1999511719},
	{2060,317.70001220703,983.09997558594,1958.4000244141},
	{2060,317.70001220703,983.70001220703,1958.3000488281},
	{2060,317.70001220703,984.29998779297,1958.1999511719},
	{2060,319,984.29998779297,1958.1999511719},
	{2060,319,983.70001220703,1958.3000488281},
	{2060,319,983.09997558594,1958.4000244141},
}

addCommandHandler("quest2",function(player)
	if westsideGetElementData(player,"loggedin") == 1 then
		if isPedInVehicle (player) == false then
			if getDistanceBetweenPoints3D(1789.40259,-2303.75464,-2.59774,getElementPosition(player)) < 5 then
				if getElementData(player,"inQuest") == false then
					if Quest2 == false then
						infobox(player,"Quest angenommen!",4000,0,255,0)
						outputChatBox("[INFO]: Fahre zum abgestürtzten Flugzeug (Rote Flagge auf der Karte),",player,0,100,150)
						outputChatBox("und sammel so viele Kokssäcke wie möglich ein! Als Belohnung erhälst du EP!",player,0,100,200)
						
						setElementVisibleTo(Quest2Blip,player,true)
						setElementVisibleTo(Quest2MarkerRein,player,true)
						setElementVisibleTo(Quest2MarkerRaus,player,true)
						
						Quest2KoksBags = {}
						for i = 1,#Quest2KoksPositionen do
							Quest2KoksBags[i] = createObject(Quest2KoksPositionen[i][1],Quest2KoksPositionen[i][2],Quest2KoksPositionen[i][3],Quest2KoksPositionen[i][4])
							setElementInterior(Quest2KoksBags[i],9)
							addEventHandler("onElementClicked",Quest2KoksBags[i],Quest2KoksKlick)
						end
						
						setElementData(player,"inQuest2",true)
						setElementData(player,"inQuest",true)
						
						Quest2 = true
						destroyElement(Quest2BlipAufderKarte)
					else
						infobox(player,"Die Quest kann nur alle\n4 Stunden erledigt werden!",4000,255,0,0)
					end
				else
					infobox(player,"Du bist bereits in\neiner anderen Quest!",4000,255,0,0)
				end
			else
				infobox(player,"Du bist nicht an der\nrichtigen Stelle!")
			end
		else
			infobox(player,"Steige aus deinem Fahrzeug!")
		end
	end
end)

function Quest2KoksKlick(button,state,player)
	if button == "left" and state == "down" then
		local x,y,z = getElementPosition(player) local x1,y1,z1 = getElementPosition(source)
		if getElementData(player,"inQuest2") == true then
			if getDistanceBetweenPoints3D(x,y,z,x1,y1,z1) < 5 then
				if getElementData(player,"Quest2KoksAufheben") == false then
					local elem = source
					
					setPedAnimation(player, "BOMBER", "BOM_Plant_Loop", -1, true, false, false)
					setElementData(player,"Quest2KoksAufheben",true)
					noDM(player)
					
					setTimer(function()
						infobox(player,"Du hast 1 Kokssack aufgehoben!",4000,0,255,0)
						destroyElement(elem)
						setPedAnimation(player,false)
						setElementData(player,"Quest2KoksAufheben",false)
						yesDM(player)
						
						Kokssaecke = Kokssaecke + 1
					end,10000,1)
				else
					infobox(player,"Du hebst bereits\neinen Sack auf!",4000,255,0,0)
				end
			else
				infobox(player,"Du bist zu weit entfernt!",4000,255,0,0)
			end
		end
	end
end

addEventHandler("onMarkerHit",Quest2AbgabeMarker,function(player)
	if isPedInVehicle (player) == false then
		if getElementData(player,"inQuest2") == true then
			if Kokssaecke > 0 and Kokssaecke < 3 then
				infobox(player,"Du hast dem Dealer "..Kokssaecke.." Kokssäcke gegeben!",4000,0,255,0)
				outputChatBox("Dealer: Willst du mich verarschen?! "..Kokssaecke.." Säcke?! Hau ab, Spast!",player,255,255,255)
				outputChatBox("** Der Dealer steckt dir 400EP zu! **",player,50,200,50)
				westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 400)
			elseif Kokssaecke > 3 and Kokssaecke < 6 then
				infobox(player,"Du hast dem Dealer "..Kokssaecke.." Kokssäcke gegeben!",4000,0,255,0)
				outputChatBox("Dealer: Willst du mich verarschen?! "..Kokssaecke.." Säcke?! Hau ab, Spast!",player,255,255,255)
				outputChatBox("** Der Dealer steckt dir 800EP zu! **",player,50,200,50)
				westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 800)
			elseif Kokssaecke > 6 and Kokssaecke < 9 then
				infobox(player,"Du hast dem Dealer "..Kokssaecke.." Kokssäcke gegeben!",4000,0,255,0)
				outputChatBox("Dealer: Naja, wenigstens mehr als die Hälfte!",player,255,255,255)
				outputChatBox("** Der Dealer steckt dir 1500EP zu! **",player,50,200,50)
				westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 1500)
			elseif Kokssaecke > 9 and Kokssaecke < 12 then
				infobox(player,"Du hast dem Dealer "..Kokssaecke.." Kokssäcke gegeben!",4000,0,255,0)
				outputChatBox("Dealer: Was, du konntest so viele Säcke retten? Perfekt!",player,255,255,255)
				outputChatBox("** Der Dealer steckt dir 2000EP zu! **",player,50,200,50)
				westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 2000)
			elseif Kokssaecke == 12 then
				infobox(player,"Du hast dem Dealer "..Kokssaecke.." Kokssäcke gegeben!",4000,0,255,0)
				outputChatBox("Dealer: Was geeht Bro, alle Säcke?! Perfekt, hier haste ne fette Belohnung!",player,255,255,255)
				outputChatBox("** Der Dealer steckt dir 3000EP zu! **",player,50,200,50)
				westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 3000)
			end
			westsideSetElementData(player,"inQuest",false)
			westsideSetElementData(player,"inQuest2",false)
			
			setElementVisibleTo(Quest2AbgabeBlip,getRootElement(),false)
			setElementVisibleTo(Quest2AbgabeMarker,getRootElement(),false)
			
			setTimer(function()
				Quest2 = false
				QuestBlipsAufderKarte()
			end,14400000,1)
		end
	end
end)

-- Funktionen --

function endfroze(player)
	setElementFrozen(player,false)
end

function noDM(player)
	toggleControl(player,"fire",false)
	toggleControl(player,"jump",false)
end

function yesDM(player)
	toggleControl(player,"fire",true)
	toggleControl(player,"jump",true)
end