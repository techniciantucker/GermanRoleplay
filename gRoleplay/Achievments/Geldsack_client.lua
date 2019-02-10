local x,y = guiGetScreenSize()

function rendergeldsackWindow()
    dxDrawRectangle(4*(x/1440), 277*(y/900), 1436*(x/1440), 61*(y/900), tocolor(0, 0, 0, 200), false)
    dxDrawText("Du hast einen Geldsack gefunden! Insgesamt gibt es 25.", 14*(x/1440), 292*(y/900), 1430*(y/900), 321*(x/1440), tocolor(37, 130, 1, 200), 1.00, "bankgothic", "center", "top", false,false, false, false, false)
end

addEvent("geldsackWindow",true)
addEventHandler("geldsackWindow",root,function()
	addEventHandler("onClientRender",root,rendergeldsackWindow)
	setTimer(function()
		removeEventHandler("onClientRender",root,rendergeldsackWindow)
	end,7500,1)
end)

addEvent("hidePackages",true)
addEventHandler("hidePackages",root,function(package)
	setElementDimension(package,1)
end)