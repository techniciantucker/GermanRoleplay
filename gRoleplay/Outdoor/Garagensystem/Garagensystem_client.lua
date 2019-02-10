GaragenGUI = {button = {},window = {},label = {}}

clickedID=nil

function garagenGui(tor)
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,"ElementClicked",true,true)
	
        GaragenGUI.window[1] = guiCreateStaticImage(0.35, 0.01, 0.29, 0.30, "Images/Background.png", true)

        GaragenGUI.label[2] = guiCreateLabel(0.03, 0.11, 0.95, 0.22,"", true, GaragenGUI.window[1])
		guiSetFont(GaragenGUI.label[2], "default-bold-small")
		
        GaragenGUI.button[1] = guiCreateButton(0.26, 0.38, 0.47, 0.14, "Kaufen", true, GaragenGUI.window[1])
		addEventHandler("onClientGUIClick",GaragenGUI.button[1],function ()
			triggerServerEvent("buyTor",getLocalPlayer(),clickedID)
		end,false)
	
        GaragenGUI.button[2] = guiCreateButton(0.26, 0.56, 0.47, 0.14, "Verkaufen", true, GaragenGUI.window[1])
		addEventHandler("onClientGUIClick",GaragenGUI.button[2],function ()
			triggerServerEvent("sellTor",getLocalPlayer(),clickedID)
		end,false)
		
		GaragenGUI.button[3] =  guiCreateButton(0.26, 0.75, 0.47, 0.14, "Schließen", true, GaragenGUI.window[1])
		addEventHandler("onClientGUIClick",GaragenGUI.button[3],function ()
			destroyElement(GaragenGUI.window[1])
			showCursor(false)
			setElementData(getLocalPlayer(),"ElementClicked",false)
		end,false)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end

function showGaragenGUI(tor)
	guiSetText(GaragenGUI.label[2],"Preis: "..getElementData(tor,"Preis").."\nOrt: "..getElementData(tor,"Ort").."\nBesitzer: "..getElementData(tor,"Besitzer"))
	clickedID= getElementData(tor,"ID")
	garagenGui()
end
addEvent("showGaragenGUI",true)
addEventHandler("showGaragenGUI",getRootElement(),showGaragenGUI)