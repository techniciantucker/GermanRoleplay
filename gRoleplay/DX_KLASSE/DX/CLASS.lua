local screenx, screeny = guiGetScreenSize()
local xs, ys = screenx/1366, screeny/768

function _fadeCamera(rein, zeit, r,g,b)
	local r,g,b = r,g,b
	if not r or not g or not b then
		r,g,b = 0, 0, 0
	end
	if rein == true then
		setDxAnimation(0, 1, 0, screeny/2, "OutBounce",zeit, 55)
		setDxAnimation(0, screeny, 0, screeny/2, "OutBounce", zeit, 56)
		fade_render_func = function()
			local ex,ey = getAnimationValue(55)
			local ex1,ey1 = getAnimationValue(56)
			dxDrawRectangle(0,0,screenx, ey, tocolor(r,g,b,255), true)
			dxDrawRectangle(0,ey1,screenx, screeny, tocolor(r,g,b,255), true)	
		end
		onRender(fade_render_func, true)
	else
		setDxAnimation(0, screeny/2, 0, 1, "OutBounce",zeit, 55)
		setDxAnimation(0, screeny/2, 0, screeny, "OutBounce", zeit, 56)
		setTimer(function() onRender( fade_render_func, false) end, zeit, 1)
	end
end
addEvent("camFade", true)
addEventHandler("camFade", root, _fadeCamera)

function onRender(functio, bool)
	if bool == true then
		addEventHandler("onClientRender", getRootElement(), functio)
	else
		removeEventHandler("onClientRender", getRootElement(), functio)
	end
end

-- Wird geladen
addEvent("newloadscreen",true)
addEventHandler("newloadscreen",root,function()
	_fadeCamera(true, 1000, 0, 0, 0)
	onRender(drawWaitingWindow, true)
	setTimer(function()
		_fadeCamera(false, 1000, 0, 0, 0)
		setTimer(function()
			onRender(drawWaitingWindow, false)
		end, 1000, 1)
	end, 4000, 1)
end)

local rot = 0

function drawWaitingWindow()
	rot = rot+5
	local ex1, ey1 = getAnimationValue(55)
	local ex2, ey2 = getAnimationValue(56)
	dxDrawText("Wird geladen, bitte einen Moment Geduld!", 494*xs, (287*ys-screeny/2+ey1), 892*xs, 373*ys-screeny/2+ey1, tocolor(255, 255, 255, 255), 2.00*xs, "pricedown", "center", "top",false, false, true, false, false)
end

-- Übergangs Fenster
addEvent("newuebergang",true)
addEventHandler("newuebergang",root,function()
	local bildstate = 0
	local renderFunc
	local beendeFunc = function()
		removeEventHandler("onClientRender", getRootElement(), renderFunc)
		_fadeCamera(false, 1500, 0, 0, 0)
	end
	 renderFunc = function()
		bildstate = bildstate+2
        dxDrawText("Bitte warte einen Moment, die Welt wird geladen...", 465, 531, 905, 591, tocolor(255, 255, 255, 255), 1.40, "pricedown", "center", "top", false, false, true, false, false)
		if bildstate >= 400 then
			beendeFunc()
		end
	end
	_fadeCamera(true, 1500, 0, 0, 0)
	setTimer(function()
		addEventHandler("onClientRender", getRootElement(), renderFunc)
	end, 1000, 1)
end)