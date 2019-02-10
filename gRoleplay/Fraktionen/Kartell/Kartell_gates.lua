KartellGate1 = createObject(980,2096.1982421875,1720.7001953125,9.8807897567749,0,0,242.23754882813)
KartellGate2 = createObject(980,2087.3564453125,1645.623046875,9.8807897567749,0,0,270)

KartellGate1Open = false
KartellGate2Open = false

function KartellGateEins_func(player,cmd)
	if isKartell(player) then
		if getDistanceBetweenPoints3D(2096.1982421875,1720.7001953125,9.8807897567749,getElementPosition(player)) < 15 then
			if KartellGate1Open == false then
				moveObject(KartellGate1,3000,2096.1982421875,1720.7001953125,6.8807897567749)
				KartellGate1Open = true
			else
				moveObject(KartellGate1,3000,2096.1982421875,1720.7001953125,9.8807897567749)
				KartellGate1Open = false
			end
		end
	end
end
addCommandHandler("move",KartellGateEins_func)

function KartellGateZwei_func(player,cmd)
	if isKartell(player) then
		if getDistanceBetweenPoints3D(2087.3564453125,1645.623046875,9.8807897567749,getElementPosition(player)) < 15 then
			if KartellGate2Open == false then
				moveObject(KartellGate2,3000,2087.3564453125,1645.623046875,6.8807897567749)
				KartellGate2Open = true
			else
				moveObject(KartellGate2,3000,2087.3564453125,1645.623046875,9.8807897567749)
				KartellGate2Open = false
			end
		end
	end
end
addCommandHandler("move",KartellGateZwei_func)