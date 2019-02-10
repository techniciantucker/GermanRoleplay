SWTAbgabe = createMarker(1529.69312,-1671.38062,13.38281,"checkpoint",3,200,0,0)
setElementVisibleTo(SWTAbgabe,getRootElement(),false)

SWTAbgabeBlip = createBlip(1529.69312,-1671.38062,13.38281,19,2,255,0,0,255,0,200,getRootElement())
setElementVisibleTo(SWTAbgabeBlip,getRootElement(),false)

Rearms = 25

addCommandHandler("rearms",function(player,cmd)
	if isCop(player) or isFBI(player) then
		outputChatBox("[INFO]: Es sind noch "..Rearms.." Rearms verfügbar!",player,0,100,150)
	end
end)

addEvent("rearm",true)
addEventHandler("rearm",getRootElement(),function(player)
	if isCop(player) or isFBI(player) and getElementData(player,"onDuty") == true then
		if Rearms > 0 then
			Rearms = Rearms - 1
			outputChatBox("[INFO]: Du hast dich neu ausgerüstet! Nun sind noch "..Rearms.." Rearms verfügbar.",player,0,100,150)
			westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 25)
				
			if westsideGetElementData(player,"rang") < 1 then
				giveWeapon(player,24,200) -- Desert Eagle
			else
				giveWeapon(player,24,200) -- Desert Eagle
				giveWeapon(player,29,500) -- Mp5
				giveWeapon(player,31,500) -- M4
			end
				
			setElementHealth(player,100)
			setPedArmor(player,100)
		else
			infobox(player,"Ihr habt keine Rearms mehr zu Verfügung!",4000,255,0,0)
		end
	end
end)

----------

SWTAktiv = false

SWTPickup = createPickup(127.54526,1942.57324,19.32528,3,1239,500)

addEventHandler("onPickupHit",SWTPickup,function(player)
	if isCop(player) or isFBI(player) then
		if isPedInVehicle (player) == false then
			outputChatBox("[INFO]: Tippe /swt, um einen Staatswaffen-Transporter zu starten!",player,0,100,150)
		end
	end
end)

addCommandHandler("swt",function(player,cmd)
	if isCop(player) or isFBI(player) then
		if isPedInVehicle (player) == false then
			if getElementData(player,"onDuty") == true then
				if (getEvilFactionMembersOnline() >= 2) then
					if getDistanceBetweenPoints3D(127.54526,1942.57324,19.32528,getElementPosition(player)) < 5 then
						if SWTAktiv == false then
							SWTAktiv = true
							setTimer(ResetSWT,3600000,1)
							
							outputChatBox("[INFO]: Bringe den Transporter zur Flagge auf der Karte!",player,0,100,150)
							
							sendMSGForFaction('[STAAT]: Ein Staatswaffen-Transporter wurde an der Area beladen!',1,0,200,0)
							sendMSGForFaction('[STAAT]: Ein Staatswaffen-Transporter wurde an der Area beladen!',2,0,200,0)
							sendMSGForFaction('[STAAT]: Ein Staatswaffen-Transporter wurde an der Area beladen!',3,0,200,0)
							sendMSGForFaction('[STAAT]: Ein Staatswaffen-Transporter wurde an der Area beladen!',4,0,200,0)
							sendMSGForFaction('[STAAT]: Ein Staatswaffen-Transporter wurde an der Area beladen!',6,0,200,0)
							sendMSGForFaction('[STAAT]: Ein Staatswaffen-Transporter wurde an der Area beladen!',7,0,200,0)
							sendMSGForFaction('[STAAT]: Ein Staatswaffen-Transporter wurde an der Area beladen!',8,0,200,0)
							sendMSGForFaction('[STAAT]: Ein Staatswaffen-Transporter wurde an der Area beladen!',9,0,200,0)
							
							westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 25)
							
							setElementVisibleTo(SWTAbgabeBlip,player,true)
							setElementVisibleTo(SWTAbgabe,player,true)
							
							SWT = createVehicle(455,132.24240,1951.44653,20.43594,0,0,0)
							SWTBlip = createBlipAttachedTo(SWT,51)
							
							warpPedIntoVehicle(player,SWT)
							
							outputLog("Ein SWT wurde von "..getPlayerName(player).." gestartet.","Robs")
							
							addEventHandler("onVehicleExplode",SWT,SWTExplodiert)
						else
							infobox(player,"Nur jede Stunde möglich!",4000,255,0,0)
						end
					else
						infobox(player,"Du bist nicht am SWT Pickup!")
					end
				else
					infobox(player,"Hierfür müssen mindestens\n2 Gangler online sein!",4000,255,0,0)
				end
			else
				infobox(player,"Du bist nicht im Dienst!",4000,255,0,0)
			end
		else
			infobox(player,"Steige aus deinem Fahrzeug!")
		end
	end
end)

function SWTExplodiert()
	destroyElement(SWT)
	destroyElement(SWTBlip)
	setElementVisibleTo(SWTAbgabeBlip,player,false)
	setElementVisibleTo(SWTAbgabe,player,false)
	
	outputChatBox("[STAAT]: Der Staatswaffen-Transporter ist explodiert!",root,255,0,0)
	
	outputLog("Ein SWT ist explodiert.","Robs")
end

function SWTAbgegeben(player,veh)
	if isCop(player) or isFBI(player) then
		if getElementData(player,"onDuty") == true then
			if SWTAktiv == true then
				local veh = getPedOccupiedVehicle ( player )
				if veh == SWT then
					outputChatBox("[STAAT]: Der Staatswaffen-Transporter wurde abgegeben!",root,0,150,0)
					sendMSGForFaction("[INFO]: Der Staatswaffen-Transporter wurde abgegeben! Ihr erhaltet 50 Rearms.",1,200,200,0)
					
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 250)
					
					destroyElement(SWT)
					destroyElement(SWTBlip)
					setElementVisibleTo(SWTAbgabe,player,false)
					setElementVisibleTo(SWTAbgabeBlip,player,false)
					
					Rearms = Rearms + 50
					
					outputLog("Ein SWT wurde von "..getPlayerName(player).." abgegeben.","Robs")
				else
					--infobox(player,"Falsches Fahrzeug!",4000,255,0,0)
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",SWTAbgabe,SWTAbgegeben)

function ResetSWT()
	outputChatBox("[STAAT]: Ein Staatswaffen-Transporter kann wieder beladen werden!",root,0,150,0)
	
	SWTAktiv = false
end

--

addCommandHandler("setrearms",function(player,cmd,rearms)
	if isAdminLevel ( player, 5 ) then
		if rearms == nil then
			infobox(player,"/setrearms [Menge]",4000,0,100,200)
		else
			infobox(player,rearms.." Rearms gesetzt!",4000,0,200,0)
			Rearms = Rearms + rearms
		end
	end
end)