local screenwidth, screenheight = guiGetScreenSize();

addEvent("showProgressBar",true)
addEventHandler("showProgressBar",localPlayer,function( time )
	local progress = 0
	local hospitalValue = 60
	local hospitalValue2 = 0
	setTimer(function()
		hospitalValue = hospitalValue - 1
		hospitalValue2 = hospitalValue2 + 1.6
	end,1000,60)
	inrender = function()
	    showChat(false)
		dxDrawRectangle(652*screenwidth/1680, 353*screenheight/1050, 373*screenwidth/1680, 416*screenheight/1050, tocolor(187, 0, 0, 136), false)
        dxDrawText("Du bist gestorben und musst\nnun im Krankenhaus wieder zusammen-\ngeflickt werden.\n", 669*screenwidth/1680, 368*screenheight/1050, 939*screenwidth/1680, 458*screenheight/1050, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, true, false, false)
        dxDrawImage(708*screenwidth/1680, 450*screenheight/1050, 248*screenwidth/1680, 180*screenheight/1050, "Images/Krankenhaus.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawRectangle(689*screenwidth/1680, 686*screenheight/1050, 286*screenwidth/1680, 51*screenheight/1050, tocolor(201, 201, 201, 167), true)
        dxDrawRectangle(691*screenwidth/1680, 688*screenheight/1050, (2.82*hospitalValue2)*screenwidth/1680, 47*screenheight/1050, tocolor(139, 0, 0, 254), true)
        dxDrawText("Du respawnst in "..hospitalValue.." Sekunden!", 733*screenwidth/1680, 655*screenheight/1050, 941*screenwidth/1680, 682*screenheight/1050, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
	end
	addEventHandler("onClientRender",getRootElement(),inrender)
	removeEventHandler("onClientRender",getRootElement(),dxDrawHUD)
end)


function updateDeathBar_func ( new )
	local newBarSize = new
	if newBarSize >= 100 then
		hideUpdateBar ()
		showChat(true)
	end
end
addEvent ( "updateDeathBar", true )
addEventHandler ( "updateDeathBar", getRootElement(), updateDeathBar_func )

function hideUpdateBar ()
	removeEventHandler("onClientRender",getRootElement(),inrender)
	addEventHandler("onClientRender",getRootElement(),dxDrawHUD)
end
addEvent("deathbarclose",true)
addEventHandler("deathbarclose",root,hideUpdateBar)