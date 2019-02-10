BrigadaGate = createObject(971,263.8671875,-1333.1787109375,52.52368927002,0,0,34.03564453125)

local BrigadaGatee = false

function brigadagatemote_func(player,cmd)
	if isBrigada(player) then
		if getDistanceBetweenPoints3D(263.8671875,-1333.1787109375,52.52368927002,getElementPosition(player)) < 15 then
			if BrigadaGatee == false then
				moveObject(BrigadaGate,3000,263.89999389648,-1333.1999511719,46.799999237061)
				BrigadaGatee = true
			else
				moveObject(BrigadaGate,3000,263.8671875,-1333.1787109375,52.52368927002)
				BrigadaGatee = false
			end
		end
	end
end
addCommandHandler("move",brigadagatemote_func)