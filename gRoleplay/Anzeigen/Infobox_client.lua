local screenx, screeny = guiGetScreenSize()
local xs, ys = screenx/1366, screeny/768

local infoboxen = {}

local ids = {}

local dxfont0_harabara = dxCreateFont("Anzeigen/Harabara.ttf", 25*xs)
local dxfont1_harabara = dxCreateFont("Anzeigen/Harabara.ttf", 16*xs)

function createNewInfo(text, typ, time1)
	if(getElementData(lp,'loggedin')==1)then
		local time = time1
		if not time then time = 7000 end
		local data = {text = text, h = 0}
		local typ = "info"
		for i = 1,#infoboxen do
			infoboxen[i].h = infoboxen[i].h+115*ys
			setDxAnimation(infoboxen[i].h, 0, infoboxen[i].h+115*ys, 0, "OutBounce", 1000, 454654546454 ..i)
		end
		local id = 0
		for i = 1,100 do
			if not infoboxen[i] then
				infoboxen[i] = data
				id = i
				break
			end
		end
		setDxAnimation(0, 0, 0, 0, "OutBounce", 50, 454654546454 ..id)
		setDxAnimation(screenx+15*xs, 0, 1105*xs, 0, "OutBounce", 1500, 454654546 ..id)
		function data.render()
			local ex, ey = getAnimationValue(454654546 ..id)
			local ex1, ey1 = getAnimationValue(454654546454 ..id)
			dxDrawRectangle(ex, 651*ys-ex1, 261*xs, 102*ys, tocolor(0, 0, 0, 87), false)
			dxDrawText("Information", ex+59*xs, 651*ys-ex1, ex+236*xs, 682*ys-ex1, tocolor(0,200,200, 255), 0.50, dxfont0_harabara, "center", "top", false, false, false, false, false)
			dxDrawText(text, ex+75*xs, 663*ys-ex1, ex+217*xs, 749*ys-ex1, tocolor(255, 255, 255, 255), 0.50, dxfont1_harabara, "center", "center", false, false, false, false, false)
			dxDrawImage(ex, 651*ys-ex1, 39*xs, 36*ys, "Images/Info.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
		onRender(data.render, true)
		local sound = playSound("DX_KLASSE/Infobox.mp3", false)
		setSoundVolume(sound, 0.1)
		setTimer(function()
			setDxAnimation( 1105*xs, 0, screenx+15*xs, 0, "OutBounce", 1500, 454654546 ..id)
			setTimer(function()
				onRender(data.render, false)
				data = nil
			end, 1500, 1)
		end, time, 1)
	end
end

addEvent("infobox_start", true)
addEventHandler("infobox_start", root, function(text, typ, time)
	createNewInfo(text, "normal", 7000)
end)

function infobox( text, typ, time)
	createNewInfo(text, typ, time)
end