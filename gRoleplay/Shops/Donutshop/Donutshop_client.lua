createBlip ( 1036.5, -1349.5999755859, 19.99, 17, 2, 255, 0, 0, 255, 0, 200, getRootElement() )

-- Donutfenster
Donut = {
  button = {},
  staticimage = {}
 }

function DonutWindow()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,'ElementClicked',true)
	
		Donut.staticimage[1] = guiCreateStaticImage(0.38, 0.01, 0.24, 0.32, "Images/Background.png", true)

		DonutButton1 = guiCreateButton(0.25, 0.11, 0.51, 0.13, "2 Donuts + Kaffee - 25$", true, Donut.staticimage[1])
		guiSetProperty(DonutButton1, "NormalTextColour", "FFAAAAAA")

		DonutButton2 = guiCreateButton(0.25, 0.28, 0.51, 0.13, "5 Donuts + Kaffee 50$", true, Donut.staticimage[1])
		guiSetProperty(DonutButton2, "NormalTextColour", "FFAAAAAA")

		DonutButton3 = guiCreateButton(0.25, 0.45, 0.51, 0.13, "10 Donuts + Kaffee - 75$", true, Donut.staticimage[1])
		guiSetProperty(DonutButton3, "NormalTextColour", "FFAAAAAA")

		DonutButton4 = guiCreateButton(0.25, 0.62, 0.51, 0.13, "25 Donuts + Kaffee - 100$", true, Donut.staticimage[1])
		guiSetProperty(DonutButton4, "NormalTextColour", "FFAAAAAA")

		DonutButton5 = guiCreateButton(0.25, 0.80, 0.51, 0.12, "Verlassen", true, Donut.staticimage[1])
		guiSetProperty(DonutButton5, "NormalTextColour", "FFAAAAAA")    
		
		addEventHandler("onClientGUIClick",DonutButton1,function(button)
			triggerServerEvent("KleinesDonutMenue",getLocalPlayer(), getLocalPlayer() )
		end,false)

		addEventHandler("onClientGUIClick",DonutButton2,function(button)
			triggerServerEvent("MittleresDonutMenue",getLocalPlayer(), getLocalPlayer() )
		end,false)

		addEventHandler("onClientGUIClick",DonutButton3,function(button)
			triggerServerEvent("GrosesDonutMenue",getLocalPlayer(), getLocalPlayer() )
		end,false)

		addEventHandler("onClientGUIClick",DonutButton4,function(button)
			triggerServerEvent("BigDonutMenue",getLocalPlayer(), getLocalPlayer() )
		end,false)
		
		addEventHandler("onClientGUIClick",DonutButton5,function(button)
			destroyElement(Donut.staticimage[1])
			showCursor(false)
			setElementData ( lp, "ElementClicked", false, true )
		end,false)
	else
		infobox('Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!')
	end
end

addEvent('donutWindow',true)
addEventHandler('donutWindow',root,function()
	DonutWindow()
end)