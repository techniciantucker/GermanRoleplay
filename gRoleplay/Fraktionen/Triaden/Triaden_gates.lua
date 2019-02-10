TriadenGate1 = createObject(980,2797.45703125,1313.2060546875,12.530389785767,0,0,270)
TriadenGate2 = createObject(980,2827.1689453125,1382.4541015625,12.523389816284,0,0,180)

TriadenGate1Open = false
TriadenGate2Open = false

function TriadenGate1_func(player,cmd)
	if isTriaden(player) then
		if getDistanceBetweenPoints3D(2797.45703125,1313.2060546875,12.530389785767,getElementPosition(player)) < 15 then
			if TriadenGate1Open == false then
				moveObject(TriadenGate1,3000,2797.45703125,1313.2060546875,6.9000000953674)
				TriadenGate1Open = true
			else
				moveObject(TriadenGate1,3000,2797.45703125,1313.2060546875,12.530389785767)
				TriadenGate1Open = false
			end
		end
	end
end
addCommandHandler("move",TriadenGate1_func)

function TriadenGate2_func(player,cmd)
	if isTriaden(player) then
		if getDistanceBetweenPoints3D(2827.1689453125,1382.4541015625,12.523389816284,getElementPosition(player)) < 15 then
			if TriadenGate2Open == false then
				moveObject(TriadenGate2,3000,2827.1689453125,1382.4541015625,6.5)
				TriadenGate2Open = true
			else
				moveObject(TriadenGate2,3000,2827.1689453125,1382.4541015625,12.523389816284)
				TriadenGate2Open = false
			end
		end
	end
end
addCommandHandler("move",TriadenGate2_func)