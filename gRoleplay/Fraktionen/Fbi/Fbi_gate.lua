FbiGate1 = createObject ( 980, 1213.7001953125, -1842, 14.199999809265, 0, 0, 180 )

FBIGateMoving = false
FBIGateMoved = false

function mv_func ( player )
	if isFBI(player) then
		if getDistanceBetweenPoints3D ( 1213.7001953125, -1842, 14.199999809265, getElementPosition ( player ) ) < 17 then
			if FBIGateMoving == false then
				FBIGateMoving = true
				if FBIGateMoved == false then
					moveObject ( FbiGate1, 3000, 1213.6999511719, -1842, 9.5 )
					setTimer ( triggerFBIGateVarb, 3000, 1 )
					FBIGateMoved = true
				else
					moveObject ( FbiGate1, 3000, 1213.7001953125, -1842, 14.199999809265 )
					setTimer ( triggerFBIGateVarb, 3000, 1 )
					FBIGateMoved = false
				end
			end
		end
	end
end
addCommandHandler ( "move", mv_func )

function triggerFBIGateVarb ()
	FBIGateMoving = false
end

----------------------------------

FbiGate2 = createObject ( 980, 1270, -1842.099609375, 14.199999809265, 0, 0, 180 )

FBIGateMoving = false
FBIGateMoved = false

function mv_func ( player )
	if isFBI(player) then
		if getDistanceBetweenPoints3D ( 1270, -1842.099609375, 14.199999809265, getElementPosition ( player ) ) < 17 then
			if FBIGateMoving == false then
				FBIGateMoving = true
				if FBIGateMoved == false then
					moveObject ( FbiGate2, 3000, 1270, -1842.0999755859, 9.5 )
					setTimer ( triggerFBIGateVarb, 3000, 1 )
					FBIGateMoved = true
				else
					moveObject ( FbiGate2, 3000, 1270, -1842.099609375, 14.199999809265 )
					setTimer ( triggerFBIGateVarb, 3000, 1 )
					FBIGateMoved = false
				end
			end
		end
	end
end
addCommandHandler ( "move", mv_func )

function triggerFBIGateVarb ()
	FBIGateMoving = false
end