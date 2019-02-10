Pizzaria = {
    button = {},
    staticimage = {}
}

function PizzariaWindow()
	if(getElementData(lp,'ElementClicked')==false)then
		Pizzaria.staticimage[1] = guiCreateStaticImage(0.38, 0.01, 0.24, 0.32, "Images/Background.png", true)

		PizzariaButton1 = guiCreateButton(0.25, 0.11, 0.51, 0.13, "Kleines Menü - 25$", true, Pizzaria.staticimage[1])
		guiSetProperty(PizzariaButton1, "NormalTextColour", "FFAAAAAA")

		PizzariaButton2 = guiCreateButton(0.25, 0.28, 0.51, 0.13, "Mittleres Menü 50$", true, Pizzaria.staticimage[1])
		guiSetProperty(PizzariaButton2, "NormalTextColour", "FFAAAAAA")

		PizzariaButton3 = guiCreateButton(0.25, 0.45, 0.51, 0.13, "Großes Menü - 75$", true, Pizzaria.staticimage[1])
		guiSetProperty(PizzariaButton3, "NormalTextColour", "FFAAAAAA")

		PizzariaButton4 = guiCreateButton(0.25, 0.62, 0.51, 0.13, "Double Big Menü - 100$", true, Pizzaria.staticimage[1])
		guiSetProperty(PizzariaButton4, "NormalTextColour", "FFAAAAAA")

		PizzariaButton5 = guiCreateButton(0.25, 0.80, 0.51, 0.12, "Verlassen", true, Pizzaria.staticimage[1])
		guiSetProperty(PizzariaButton5, "NormalTextColour", "FFAAAAAA")    
		
		addEventHandler("onClientGUIClick",PizzariaButton1,function(button)
			triggerServerEvent("KleinesPizzariaMenue",getLocalPlayer(), getLocalPlayer() )
		end,false)

		addEventHandler("onClientGUIClick",PizzariaButton2,function(button)
			triggerServerEvent("MittleresPizzariaMenue",getLocalPlayer(), getLocalPlayer() )
		end,false)

		addEventHandler("onClientGUIClick",PizzariaButton3,function(button)
			triggerServerEvent("GrosesPizzariaMenue",getLocalPlayer(), getLocalPlayer() )
		end,false)

		addEventHandler("onClientGUIClick",PizzariaButton4,function(button)
			triggerServerEvent("BigPizzariaMenue",getLocalPlayer(), getLocalPlayer() )
		end,false)

		addEventHandler("onClientGUIClick",PizzariaButton5,function(button)
			destroyElement(Pizzaria.staticimage[1])
			showCursor(false)
			setElementData ( lp, "ElementClicked", false, true )
		end,false)
	else
		infobox('Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!')
	end
end

-- Öffnen --
function Pizzariaopen_func()
	PizzariaWindow()
	showCursor(true)
	setElementData ( lp, "ElementClicked", true, true )
end
addEvent("show_Pizzaria_GUI",true)
addEventHandler("show_Pizzaria_GUI",getRootElement(),Pizzariaopen_func)