-- Gate 1
NRGateMoving = false
NRGateMoved = false
NRGate = createObject ( 988, 778, -1384.9000244141, 13.60000038147, 0, 0, 0 )

function NRGate_func ( player )

	if isReporter(player) then
		if getDistanceBetweenPoints3D ( 778, -1384.9000244141, 13.60000038147, getElementPosition ( player ) ) < 17 then
			if not NRGateMoving then
				if NRGateMoved == false then
					moveObject ( NRGate, 3000, 778, -1384.9000244141, 8.5 )
					setTimer ( triggerNRGateVarb, 3000, 1 )
					NRGateMoved = true
				else
					moveObject ( NRGate, 3000, 778, -1384.9000244141, 13.60000038147 )
					setTimer ( triggerNRGateVarb, 3000, 1 )
					NRGateMoved = false
				end
				NRGateMoving = true
			end
		end
	end
end
addCommandHandler ( "move", NRGate_func )

function triggerNRGateVarb ()

	NRGateMoving = false
end

-- Gate 2
NRGateMoving = false
NRGateMoved = false
NRGate2 = createObject ( 988, 777.90002441406, -1330.0999755859, 13.39999961853, 0, 0, 180 )

function NRGate2_func ( player )

	if isReporter(player) then
		if getDistanceBetweenPoints3D ( 777.90002441406, -1330.0999755859, 13.39999961853, getElementPosition ( player ) ) < 17 then
			if not NRGateMoving then
				if NRGateMoved == false then
					moveObject ( NRGate2, 3000, 777.90002441406, -1330.0999755859, 8.3999996185303 )
					setTimer ( triggerNRGate2Varb, 3000, 1 )
					NRGateMoved = true
				else
					moveObject ( NRGate2, 3000, 777.90002441406, -1330.0999755859, 13.39999961853 )
					setTimer ( triggerNRGate2Varb, 3000, 1 )
					NRGateMoved = false
				end
				NRGateMoving = true
			end
		end
	end
end
addCommandHandler ( "move", NRGate2_func )

function triggerNRGate2Varb ()

	NRGateMoving = false
end