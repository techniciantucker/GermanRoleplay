local screenW, screenH = guiGetScreenSize()
local i   = 0
local hud = true
local balkenSwitch=0

function getBestFontSize(size)
	local sx, sy = 1920, 1080    
	local s = {guiGetScreenSize()}
	
	local fontsizex = (size/sx)*s[1]
	local fontsizey = (size/sy)*s[2]
	
	local mittelwert = (fontsizex+fontsizey)/2
	return mittelwert
end

function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end

function dxDrawHUD()
	if getElementData(lp,"loggedin") == 1 and getElementData(lp,"isInTut") == false and(getElementData(lp,'ElementClicked')==false)then
		if(not(isPlayerMapVisible(lp)))then
			setPlayerHudComponentVisible('ammo', false);
			setPlayerHudComponentVisible('armour', false);
			setPlayerHudComponentVisible('breath', false);
			setPlayerHudComponentVisible('clock', false);
			setPlayerHudComponentVisible('health', false);
			setPlayerHudComponentVisible('money', false);
			setPlayerHudComponentVisible('weapon', false);
			setPlayerHudComponentVisible('wanted', false);
			
			i=i+1
			
			local time = getRealTime();
			local tstr = string.format("%02d:%02d", time.hour, time.minute);
			local x, y, z = getElementPosition(localPlayer);
			local city = getZoneName(x, y, z);
			local level = getElementData(lp,"level")
			local money = getElementData(lp,"money")
			local harndrang=getElementData(lp,'harndrang')
			local hunger=getElementData(lp,'hunger')
			

			local AmmoInClip = getPedAmmoInClip( localPlayer );
			local AmmoTotalInClip = getPedTotalAmmo( localPlayer );
			local weaponID = getPedWeapon(localPlayer);
			

			dxDrawImage(screenW * 0.8021, screenH * 0.0244, screenW * 0.2042, screenH * 0.2689, "Anzeigen/Hud/Files/Hud.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			
			dxDrawImage(screenW * 0.9431, screenH * 0.0056, screenW * 0.0535, screenH * 0.0822, "Anzeigen/Hud/Files/Weapons/"..weaponID..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			dxDrawText(AmmoTotalInClip-AmmoInClip.." | "..AmmoInClip, screenW * 0.8931, screenH * 0.0411, screenW * 0.9361, screenH * 0.0633, tocolor(255, 255, 255, 255), 1.00, "default-bold", "right", "center", false, false, false, false, false)
			
			
			dxDrawText(tstr, screenW * 0.8542, screenH * 0.1433, screenW * 0.8944, screenH * 0.1656, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawText(getPlayerName(localPlayer), screenW * 0.8222, screenH * 0.0411, screenW * 0.8903, screenH * 0.0633, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawText(city, screenW * 0.8438, screenH * 0.2556, screenW * 0.9993, screenH * 0.2822, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawText(level, screenW * 0.9708, screenH * 0.1056, screenW * 0.9965, screenH * 0.1278, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
			dxDrawText(money.."$", screenW * 0.8514, screenH * 0.1022, screenW * 0.9347, screenH * 0.1244, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
			
			dxDrawImageSection(screenW, 195*screenH/1050, -(2.55*getElementHealth(localPlayer))*screenW/1720, 12, i, 0, 2.55*getElementHealth(localPlayer), 15, "Anzeigen/Hud/Files/Red_b.png");		  
			if(balkenSwitch==0)then
				dxDrawImageSection(screenW, 234*screenH/1050, -(2.84*getPedArmor(localPlayer))*screenW/1920, 14, i, 0, 2.84*getPedArmor(localPlayer), 15, "Anzeigen/Hud/Files/Blue_b.png");
			elseif(balkenSwitch==1)then
				dxDrawImageSection(screenW, 234*screenH/1050, -(2.84*harndrang)*screenW/1920, 14, i, 0, 2.84*harndrang, 15, "Anzeigen/Hud/Files/Yellow_b.png");
			elseif(balkenSwitch==2)then
				dxDrawImageSection(screenW, 234*screenH/1050, -(2.84*hunger)*screenW/1920, 14, i, 0, 2.84*hunger, 15, "Anzeigen/Hud/Files/Green_b.png");
			end
			
			dxDrawText(math.floor(getElementHealth(localPlayer)).."%", screenW * 0.8507, screenH * 0.1851, screenW * 0.9993, screenH * 0.2011, tocolor(255, 255, 255, 255), 0.9, "default-bold", "center", "center", false, false, false, false, false)
			
			if(balkenSwitch==0)then
				dxDrawText(math.floor(getPedArmor(localPlayer)).."%", screenW * 0.8514, screenH * 0.2211, screenW * 1.0000, screenH * 0.2411, tocolor(255, 255, 255, 255), 0.9, "default-bold", "center", "center", false, false, false, false, false)
			elseif(balkenSwitch==1)then
				dxDrawText(harndrang.."%", screenW * 0.8514, screenH * 0.2211, screenW * 1.0000, screenH * 0.2411, tocolor(255, 255, 255, 255), 0.9, "default-bold", "center", "center", false, false, false, false, false)
			elseif(balkenSwitch==2)then
				dxDrawText(hunger.."%", screenW * 0.8514, screenH * 0.2211, screenW * 1.0000, screenH * 0.2411, tocolor(255, 255, 255, 255), 0.9, "default-bold", "center", "center", false, false, false, false, false)
			end

			local wlvl = getPlayerWantedLevel();
			
			dxDrawText("Wanteds: "..wlvl, screenW * 0.9400, screenH * 0.2850, screenW * 0.0400, screenH * 0.0200, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false,false,false, false)
		end
	end
end
addEventHandler("onClientRender",getRootElement(),dxDrawHUD)

bindKey('b','down',function()
	if(balkenSwitch==0)then
		balkenSwitch=1
	elseif(balkenSwitch==1)then
		balkenSwitch=2
	elseif(balkenSwitch==2)then
		balkenSwitch=0
	end
end)