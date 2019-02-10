function puffWindow()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,'ElementClicked',true)
	
		PuffWindow = guiCreateStaticImage(0.37, 0.01, 0.26, 0.26, "Images/Background.png", true)

		Info = guiCreateLabel(0.03, 0.12, 0.94, 0.21, "Dir gefällt was du siehst? Dann steck mir doch ein paar Moneten zu! ;)", true, PuffWindow)
		guiSetFont(Info, "clear-normal")
		guiLabelSetHorizontalAlign(Info, "left", true)
		GeldGeben = guiCreateButton(0.03, 0.77, 0.44, 0.15, "Geld zustecken", true, PuffWindow)
		guiSetProperty(GeldGeben, "NormalTextColour", "FFAAAAAA")
		Puffclose = guiCreateButton(0.53, 0.77, 0.44, 0.15, "Schließen", true,PuffWindow)

		Geld1 = guiCreateRadioButton(0.03, 0.35, 0.94, 0.09, "25$", true, PuffWindow)
		Geld2 = guiCreateRadioButton(0.03, 0.49, 0.94, 0.09, "50$", true, PuffWindow)
		Geld3 = guiCreateRadioButton(0.03, 0.63, 0.94, 0.09, "100$", true, PuffWindow)
		
		-- Zahlen --
		addEventHandler("onClientGUIClick",GeldGeben,function()
			if guiRadioButtonGetSelected (Geld1) then
				triggerServerEvent("Geld1",lp,lp)
			elseif guiRadioButtonGetSelected (Geld2) then
				triggerServerEvent("Geld2",lp,lp)
			elseif guiRadioButtonGetSelected (Geld3) then
				triggerServerEvent("Geld3",lp,lp)
			else
				infobox("Wähle einen Betrag aus!")
			end
		end,false)

		-- Schließen --
		addEventHandler("onClientGUIClick",Puffclose,function()
			destroyElement(PuffWindow)
			setElementData(lp,'ElementClicked',false)
			showCursor(false)
		end,false)
	end
end

-- Öffnen --
function OpenPuffWindow()
	puffWindow()
	showCursor(true)
end
addEvent("openPuff",true)
addEventHandler("openPuff",getRootElement(),OpenPuffWindow)