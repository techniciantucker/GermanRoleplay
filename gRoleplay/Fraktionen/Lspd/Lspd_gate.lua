-- Vorgergate
pd_tiefgarage_gate = createObject (3055,1588.5,-1637.9000244141,14.60000038147,0,0,0)

pdgarageGateLSMoving = false
pdgarageGateLSMoved = false

function pd_garage_gate_func ( thePlayer )
if (getElementType (thePlayer) == "player") then
 if isCop(thePlayer) or isFBI(thePlayer) then
  if getDistanceBetweenPoints3D (1588.5,-1637.9000244141,14.60000038147, getElementPosition ( thePlayer ) ) < 10 then
   if pdgarageGateLSMoving == false then
    pdgarageGateLSMoving = true
     if pdgarageGateLSMoved == false then
     moveObject ( pd_tiefgarage_gate, 2500,1588.5,-1639.5999755859,16.5,89.747314453125, 0,0 )
     setTimer ( triggerpdGategarageVarb, 2500, 1 )
     pdgarageGateLSMoved = true
	else
	 moveObject ( pd_tiefgarage_gate, 2500,1588.5,-1637.9000244141,14.60000038147, -89.747314453125, 0, 0 )
	 setTimer ( triggerpdGategarageVarb, 2500, 1 )
	 pdgarageGateLSMoved = false
	 end
	end
   end
  end
 end
end
addCommandHandler ( "move", pd_garage_gate_func )

function triggerpdGategarageVarb ()
	pdgarageGateLSMoving = false
end

-- Hofgate
SFPDgate1 = createObject ( 968, 1544.7, -1630.8, 13, 0, 88, 90.25 )

SFPDgate1Moving = false
SFPDgate1Moved = false

function mv_func ( player )

	if isFBI(player) or isArmy(player) or isCop(player) then
		if getDistanceBetweenPoints3D ( 1544.7, -1630.8, 13, getElementPosition ( player ) ) < 17 then
			if SFPDgate1Moving == false then
				SFPDgate1Moving = true
				if SFPDgate1Moved == false then
					moveObject ( SFPDgate1, 1500, 1544.7, -1630.8, 13, 0, -88, 0 )
					setTimer ( triggerSFPDgate1Varb, 1500, 1 )
					SFPDgate1Moved = true
				else
					moveObject ( SFPDgate1, 1500, 1544.7, -1630.8, 13, 0, 88, 0 )
					setTimer ( triggerSFPDgate1Varb, 1500, 1 )
					SFPDgate1Moved = false
				end
			end
		end
	end
end
addCommandHandler ( "move", mv_func )

function triggerSFPDgate1Varb ()

	SFPDgate1Moving = false
end

-- Tür im Interior
pd_interior_gate = createObject ( 3089,250.5,62.400001525879,1003.799987793,0,0,90)
setElementInterior (pd_interior_gate, 6)

pdGateLSMoving = false
pdGateLSMoved = false

function pd_interior_gate_func ( thePlayer )
if (getElementType (thePlayer) == "player") then
 if isCop(thePlayer) or isFBI(thePlayer) then
  if getDistanceBetweenPoints3D (250.5,62.400001525879,1003.799987793, getElementPosition ( thePlayer ) ) < 10 then
   if pdGateLSMoving == false then
    pdGateLSMoving = true
     if pdGateLSMoved == false then
     moveObject ( pd_interior_gate, 1500, 250.5,62.400390625,1003.799987793, 0, 0, -90 )
     setTimer ( triggerpdGateVarb, 1500, 1 )
     pdGateLSMoved = true
	else
	 moveObject ( pd_interior_gate, 1500,250.5,62.400001525879,1003.799987793, 0, 0, 90 )
	 setTimer ( triggerpdGateVarb, 1500, 1 )
	 pdGateLSMoved = false
	 end
	end
   end
  end
 end
end
addCommandHandler ( "move", pd_interior_gate_func )

function triggerpdGateVarb ()
	pdGateLSMoving = false
end

tuer = createObject (3089, 250.5, 63.900001525879, 1003.799987793, 0, 0, 90)
setElementInterior (tuer, 6)


-- Hintere Tür am Hof
LspdKeyDoor = createObject(3089,1582.5999755859,-1637.9000244141,13.699999809265,0,0,0)