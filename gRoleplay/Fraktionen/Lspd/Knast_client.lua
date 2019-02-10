function startJailTimeRender()
	if getElementData(getLocalPlayer(),"jailtime") then
		local jailtime = tonumber(getElementData(getLocalPlayer(),"jailtime"))
		if jailtime > 0 then
			addEventHandler("onClientRender",getRootElement(),jailTimeRender)
		end
	end
end
addEvent("startJailTimeRenderEvent",true)
addEventHandler("startJailTimeRenderEvent",getRootElement(),startJailTimeRender)

function stopJailTimeRender()
	removeEventHandler("onClientRender",getRootElement(),jailTimeRender)
end

local sx,sy = guiGetScreenSize()

function jailTimeRender()
	if getElementData(getLocalPlayer(),"jailtime") then
		local jailtime = tonumber(getElementData(getLocalPlayer(),"jailtime"))
		if jailtime > 0 then
			dxDrawText("Knastzeit: "..jailtime.." Minuten!",0,10,sx,75,tocolor(255,0,0,255),1,"bankgothic","center","center",false,false,true)
		else
			stopJailTimeRender()
		end
	else
		stopJailTimeRender()
	end
end