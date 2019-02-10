Chicken = {
    button = {},
    staticimage = {}
}

function ChickenWindow()
	if(getElementData(lp,'ElementClicked')==false)then
		Chicken.staticimage[1] = guiCreateStaticImage(0.38, 0.01, 0.24, 0.32, "Images/Background.png", true)

		ChickenButton1 = guiCreateButton(0.25, 0.11, 0.51, 0.13, "Kleines Menü - 25$", true, Chicken.staticimage[1])
		guiSetProperty(ChickenButton1, "NormalTextColour", "FFAAAAAA")

		ChickenButton2 = guiCreateButton(0.25, 0.28, 0.51, 0.13, "Mittleres Menü 50$", true, Chicken.staticimage[1])
		guiSetProperty(ChickenButton2, "NormalTextColour", "FFAAAAAA")

		ChickenButton3 = guiCreateButton(0.25, 0.45, 0.51, 0.13, "Großes Menü - 75$", true, Chicken.staticimage[1])
		guiSetProperty(ChickenButton3, "NormalTextColour", "FFAAAAAA")

		ChickenButton4 = guiCreateButton(0.25, 0.62, 0.51, 0.13, "Double Big Menü - 100$", true, Chicken.staticimage[1])
		guiSetProperty(ChickenButton4, "NormalTextColour", "FFAAAAAA")

		ChickenButton5 = guiCreateButton(0.25, 0.80, 0.51, 0.12, "Verlassen", true, Chicken.staticimage[1])
		guiSetProperty(ChickenButton5, "NormalTextColour", "FFAAAAAA") 

		-- Buttons --
		addEventHandler("onClientGUIClick",ChickenButton1,function(button)
			triggerServerEvent("KleinesChickenMenue",getLocalPlayer(), getLocalPlayer() )
		end,false)

		addEventHandler("onClientGUIClick",ChickenButton2,function(button)
			triggerServerEvent("MittleresChickenMenue",getLocalPlayer(), getLocalPlayer() )
		end,false)

		addEventHandler("onClientGUIClick",ChickenButton3,function(button)
			triggerServerEvent("GrosesChickenMenue",getLocalPlayer(), getLocalPlayer() )
		end,false)

		addEventHandler("onClientGUIClick",ChickenButton4,function(button)
			triggerServerEvent("BigChickenMenue",getLocalPlayer(), getLocalPlayer() )
		end,false)

		addEventHandler("onClientGUIClick",ChickenButton5,function(button)
			destroyElement(Chicken.staticimage[1])
			showCursor(false)
			setElementData ( lp, "ElementClicked", false, true )
		end,false)		
	else
		infobox('Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!')
	end
end

-- Öffnen --
function Chickenopen_func()
	ChickenWindow()
	showCursor(true)
	setElementData ( lp, "ElementClicked", true, true )
end
addEvent("show_Chicken_GUI",true)
addEventHandler("show_Chicken_GUI",getRootElement(),Chickenopen_func)