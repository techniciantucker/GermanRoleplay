Burgershot = {
    button = {},
    staticimage = {}
}

function BurgershotWindow()
	if(getElementData(lp,'ElementClicked')==false)then
		Burgershot.staticimage[1] = guiCreateStaticImage(0.38, 0.01, 0.24, 0.32, "Images/Background.png", true)

		BurgershotButton1 = guiCreateButton(0.25, 0.11, 0.51, 0.13, "Kleines Menü - 25$", true, Burgershot.staticimage[1])
		guiSetProperty(BurgershotButton1, "NormalTextColour", "FFAAAAAA")

		BurgershotButton2 = guiCreateButton(0.25, 0.28, 0.51, 0.13, "Mittleres Menü 50$", true, Burgershot.staticimage[1])
		guiSetProperty(BurgershotButton2, "NormalTextColour", "FFAAAAAA")

		BurgershotButton3 = guiCreateButton(0.25, 0.45, 0.51, 0.13, "Großes Menü - 75$", true, Burgershot.staticimage[1])
		guiSetProperty(BurgershotButton3, "NormalTextColour", "FFAAAAAA")

		BurgershotButton4 = guiCreateButton(0.25, 0.62, 0.51, 0.13, "Double Big Menü - 100$", true, Burgershot.staticimage[1])
		guiSetProperty(BurgershotButton4, "NormalTextColour", "FFAAAAAA")

		BurgershotButton5 = guiCreateButton(0.25, 0.80, 0.51, 0.12, "Verlassen", true, Burgershot.staticimage[1])
		guiSetProperty(BurgershotButton5, "NormalTextColour", "FFAAAAAA") 


		-- Buttons --
		addEventHandler("onClientGUIClick",BurgershotButton1,function(button)
			triggerServerEvent("KleinesBurgershotMenue",getLocalPlayer(), getLocalPlayer() )
		end,false)

		addEventHandler("onClientGUIClick",BurgershotButton2,function(button)
			triggerServerEvent("MittleresBurgershotMenue",getLocalPlayer(), getLocalPlayer() )
		end,false)

		addEventHandler("onClientGUIClick",BurgershotButton3,function(button)
			triggerServerEvent("GrosesBurgershotMenue",getLocalPlayer(), getLocalPlayer() )
		end,false)

		addEventHandler("onClientGUIClick",BurgershotButton4,function(button)
			triggerServerEvent("BigBurgershotMenue",getLocalPlayer(), getLocalPlayer() )
		end,false)

		addEventHandler("onClientGUIClick",BurgershotButton5,function(button)
			destroyElement(Burgershot.staticimage[1])
			showCursor(false)
			setElementData ( lp, "ElementClicked", false, true )
		end,false)		
	else
		infobox('Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!')
	end
end

-- Öffnen --
function Burgershotopen_func()
	BurgershotWindow()
	showCursor(true)
	setElementData ( lp, "ElementClicked", true, true )
end
addEvent("show_Burgershot_GUI",true)
addEventHandler("show_Burgershot_GUI",getRootElement(),Burgershotopen_func)