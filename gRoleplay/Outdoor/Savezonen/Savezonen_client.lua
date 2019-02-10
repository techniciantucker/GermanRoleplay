addEvent("showSafezone", true)
addEventHandler("showSafezone", root, function(typ)
	
	if typ then
		addEventHandler("onClientRender", root, showSafezone)
	else
		removeEventHandler("onClientRender", root, showSafezone)
	end
end);

addEventHandler("onClientPlayerDamage", root, function(attacker, ...)
	if attacker then
		if getElementData(source, "player.inSaveZone") then
			return cancelEvent();
		end
	end
end)

local screenW, screenH = guiGetScreenSize()
function showSafezone()
	if(getElementData(lp,'inScoreboard')==false)then
		dxDrawText("German Roleplay", (screenW * 0.3667) - 1, (screenH * 0.0000) - 1, (screenW * 0.6006) - 1, (screenH * 0.0562) - 1, tocolor(0,200,200, 255), 2.00, "default", "center", "center", false, false, false, false, false)
		dxDrawText("German Roleplay", (screenW * 0.3667) + 1, (screenH * 0.0000) - 1, (screenW * 0.6006) + 1, (screenH * 0.0562) - 1, tocolor(0,200,200, 255), 2.00, "default", "center", "center", false, false, false, false, false)
		dxDrawText("German Roleplay", (screenW * 0.3667) - 1, (screenH * 0.0000) + 1, (screenW * 0.6006) - 1, (screenH * 0.0562) + 1, tocolor(0,200,200, 255), 2.00, "default", "center", "center", false, false, false, false, false)
		dxDrawText("German Roleplay", (screenW * 0.3667) + 1, (screenH * 0.0000) + 1, (screenW * 0.6006) + 1, (screenH * 0.0562) + 1, tocolor(0,200,200, 255), 2.00, "default", "center", "center", false, false, false, false, false)
		dxDrawText("German Roleplay", screenW * 0.3667, screenH * 0.0000, screenW * 0.6006, screenH * 0.0562, tocolor(255, 255, 255, 255), 2.00, "default", "center", "center", false, false, false, false, false)
		dxDrawText("Deathmatchfreie Zone", screenW * 0.4298, screenH * 0.0467, screenW * 0.5357, screenH * 0.0800, tocolor(255,255,255, 255), 2.00, "default", "center", "center", false, false, false, false, false)
	end
end