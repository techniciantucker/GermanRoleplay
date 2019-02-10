addEventHandler("onClientPlayerDamage", getRootElement(),function(attacker)
	if attacker == localPlayer then
		if getElementData(attacker, "gangwarsoundon") == true then
			hitsound = playSound("Fraktionen/Hitsound/Hitsound.mp3")   
			setSoundVolume(hitsound, 0.3)
		end
	end
end)