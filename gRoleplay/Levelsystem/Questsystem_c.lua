-- Peds --

Quest1Ped = createPed(280,1546.9000244141,-1679.5,13.60000038147,180)
setElementFrozen(Quest1Ped,true)
addEventHandler("onClientPedDamage",Quest1Ped,cancelEvent)

Quest2Ped = createPed(29,1788.6999511719,-2303.8000488281,-2.5999999046326,270)
setElementFrozen(Quest2Ped,true)
addEventHandler("onClientPedDamage",Quest2Ped,cancelEvent)

-- Texte --
addEventHandler("onClientRender", root, function()
	local lx,ly,lz = getPedBonePosition(localPlayer,8)
	local x,y,z = getPedBonePosition(Quest1Ped,8)
	local sx,sy = getScreenFromWorldPosition(x,y,z)
	if getElementData(lp,"loggedin") == 1 then
		if getDistanceBetweenPoints3D(lx,ly,lz,x,y,z) < 5 then
			if sx or sy then
				if isLineOfSightClear(x,y,z+1,lx,ly,lz+1) == true then
					dxDrawText("Officer Brian",sx,sy,sx,sy,tocolor(255,255,255),1,"bankgothic","center","bottom",false,false,false,true)
				end
			end
		end
	end
end)

addEventHandler("onClientRender", root, function()
	local lx,ly,lz = getPedBonePosition(localPlayer,8)
	local x,y,z = getPedBonePosition(Quest2Ped,8)
	local sx,sy = getScreenFromWorldPosition(x,y,z)
	if getElementData(lp,"loggedin") == 1 then
		if getDistanceBetweenPoints3D(lx,ly,lz,x,y,z) < 5 then
			if sx or sy then
				if isLineOfSightClear(x,y,z+1,lx,ly,lz+1) == true then
					dxDrawText("Dealer",sx,sy,sx,sy,tocolor(255,255,255),1,"bankgothic","center","bottom",false,false,false,true)
				end
			end
		end
	end
end)