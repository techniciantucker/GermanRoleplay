----- Geschafft -----
addEvent("geschafftSound",true)
addEventHandler("geschafftSound",root,function()
	local sound = playSound("Sounds/Geschafft.mp3",false)
	setSoundVolume(sound,0.5)
end)

----- Klicken -----
addEventHandler("onClientClick",root,function()
	local sound = playSound("Sounds/Klick.mp3",false)
	setSoundVolume(sound,0.5)
end)

----- Waldsounds -----
addEventHandler('onClientResourceStart',getResourceRootElement(),function()
	--if getElementInterior(lp) == 0 then
		local birdsOne = playSound3D('Sounds/Birds.mp3',1556.59668, -318.08893, 8.89095,true)
		setSoundVolume(birdsOne,1)
		setSoundMaxDistance(birdsOne,1500)
		
		local birdsTwo = playSound3D('Sounds/Birds.mp3',395.12424, -564.02246, 41.71278,true)
		setSoundVolume(birdsTwo,1)
		setSoundMaxDistance(birdsTwo,1500)
		
		local birdsThree = playSound3D('Sounds/Birds.mp3',1102.08545, 130.15152, 35.23001,true)
		setSoundVolume(birdsThree,1)
		setSoundMaxDistance(birdsThree,1500)
		
		local RiverOne = playSound3D('Sounds/River.mp3',1990.96985, -114.03143, -0.55000,true)
		setSoundVolume(RiverOne,1)
		setSoundMaxDistance(RiverOne,1000)
		
		local RiverTwo = playSound3D('Sounds/River.mp3',-160.90915, -614.70288, 23.59667,true)
		setSoundVolume(RiverTwo,1)
		setSoundMaxDistance(RiverTwo,1000)
	--end
end)