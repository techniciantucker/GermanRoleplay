local BOMBE_TIMER =false
local BOMBE_AKTIV =false
local BOMBE_MONEY =10000
local AM_DEFUSEN  =false
local BOMBE_BEFEHL=false

function BOMBE_LEGEN(thePlayer)
	if(westsideGetElementData(thePlayer,'loggedin')==1)then
		if(isEvil(thePlayer))then
			if(tonumber(westsideGetElementData(thePlayer,'bomben'))>=1)then
				if(BOMBE_TIMER==false)then
					if(BOMBE_AKTIV==false)then
						BOMBE_AKTIV=true
						local x,y,z=getElementPosition(thePlayer)
						local frak =westsideGetElementData(thePlayer,'fraktion')
						westsideSetElementData(thePlayer,'bomben',tonumber(westsideGetElementData(thePlayer,'bomben'))-1)
						setElementFrozen(thePlayer,true)
						setPedAnimation(thePlayer,'BOMBER','BOM_Plant_Loop')
						DIE_BOMBE=createObject(1654,x-.5,y,z-.85,-90,0,0)
						setTimer(function()
							setElementFrozen(thePlayer,false)
							setPedAnimation(thePlayer)
							BOMBEN_MARKER=createMarker(x-.5,y,z-.85,'corona',0.3,255,0,0)
							outputChatBox('WARNUNG: Eine Bombe wurde gelegt!',root,125,0,0)
							sendMSGForFaction(getPlayerName(thePlayer)..' hat eine Bombe gelegt, beschützt sie 10 Minuten lang.',frak,255,255,0)
							BOMBE_RADAR=createRadarArea(x-55,y-55,105,105,150,0,0,200,root)
							setRadarAreaFlashing(BOMBE_RADAR,true)
							setElementCollisionsEnabled(DIE_BOMBE,false)
							BOMBEN_MONEY_FOR_PLAYER=thePlayer
							setTimer(function()
								local bx,by,bz=getElementPosition(DIE_BOMBE)
								createExplosion(bx,by,bz+1,10)
								destroyElement(DIE_BOMBE)
								destroyElement(BOMBEN_MARKER)
								if(BOMBEN_MONEY_FOR_PLAYER)then
									givePlayerSaveMoney(BOMBEN_MONEY_FOR_PLAYER,10000)
									outputChatBox('Die Bombe ist explodiert!',root,125,0,0)
									outputChatBox('Du erhälst '..BOMBE_MONEY..'$, weil die Bombe hochgegangen ist!',thePlayer,0,255,0)
									if(BOMBE_BEFEHL==false)then
										BOMBE_BEFEHL=true
									end
								end
							end,600000,1)
							RESET_BOMBE = setTimer(function()
								BOMBE_TIMER=false
								BOMBE_AKTIV=false
								outputChatBox('Eine Bombe kann wieder gelegt werden!',0,100,150)
								if(BOMBE_BEFEHL==true)then
									BOMBE_BEFEHL=false
								end
							end,3600000,1)
						end,7000,1)
					else
						outputChatBox('Es liegt bereits eine aktive Bombe/Du musst noch warten!',thePlayer,255,0,0)
					end
				else
					outputChatBox('Es kann nur jede 60 Minuten eine Bombe gelegt werden!',thePlayer,255,0,0)
				end
			else
				outputChatBox('Du hast keine Bombe!',thePlayer,255,0,0)
			end
		end
	end
end
addCommandHandler('bombe',BOMBE_LEGEN)

function DEFUSE_BOMBE(thePlayer)
	if(westsideGetElementData(thePlayer,'loggedin')==1)then
		if(isCop(thePlayer))or(isFBI(thePlayer))or(isArmy(thePlayer))and(getElementData(thePlayer,'onDuty')==true)then
			if(not(isPedInVehicle(thePlayer)))then
				local x,y,z=getElementPosition(thePlayer)
				local bx,by,bz=getElementPosition(DIE_BOMBE)
				if(getDistanceBetweenPoints3D(bx,by,bz,x,y,z)<5)then
					if(AM_DEFUSEN==false)then
						setElementFrozen(thePlayer,true)
						setPedAnimation(thePlayer,'BOMBER','BOM_Plant_Loop')
						outputChatBox('Die Bombe wird entschärft, dies dauert 30 Sekunden!',thePlayer,125,125,0)
						toggleControl(thePlayer,'fire',false)
						amDefusen=true
						setElementData(thePlayer,'theDefuser',true)
						DEFUSE_TIMER=setTimer(function()
							if(DEFUSE_TIMER)then
								killTimer(DEFUSE_TIMER)
							end
							destroyElement(DIE_BOMBE)
							destroyElement(BOMBEN_MARKER)
							destroyElement(BOMBE_RADAR)
							outputChatBox('Die Bombe wurde entschärft!',root,0,125,0)
							toggleControl(thePlayer,'fire',true)
							outputChatBox('Für das erfolgreiche entschärfen erhälst du '..BOMBE_MONEY..'$!.',thePlayer,0,255,0)
							givePlayerSaveMoney(thePlayer,10000)
							amDefusen=false
							setElementFrozen(thePlayer,false)
							setPedAnimation(thePlayer)
							setElementData(thePlayer,'theDefuser',false)
							if(BOMBE_BEFEHL==false)then
								BOMBE_BEFEHL=true
							end
						end,30000,1)
					end
				end
			end
		end
	end
end
addCommandHandler('delbomb',DEFUSE_BOMBE)

addEventHandler('onPlayerWasted',root,function()
	if(getElementData(source,'theDefuser')==true)then
		if(DEFUSE_TIMER)then
			killTimer(DEFUSE_TIMER)
		end
		setElementFrozen(source,false)
		setElementData(source,'theDefuser',false)
		toggleControl(source,'fire',true)
		AM_DEFUSEN=false
		outputChatBox('Entschärfen fehlgeschlagen, du bist gestorben!',source,255,0,0)
	end
end)

addCommandHandler('resetbomb',function(thePlayer)
	if(westsideGetElementData(thePlayer,'loggedin')==1)then
		if(westsideGetElementData(thePlayer,'adminlvl')>=3)then
			if(BOMBE_BEFEHL==true)then
				BOMBE_BEFEHL=false
				BOMBE_TIMER=false
				BOMBE_AKTIV=false
				killTimer(RESET_BOMBE)
				outputChatBox('Der Bombentimer wurde von einem Admin auf 0 gesetzt!',root,0,125,0)
			end
		end
	end
end)