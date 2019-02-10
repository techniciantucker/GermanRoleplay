Knasthack = {
    button = {},
    window = {},
    label = {}
}

function knastHackWindow()
	if(getElementData(lp,'ElementClicked')==false)then
		Knasthack.window[1] = guiCreateStaticImage(0.38, 0.01, 0.24, 0.20, "Images/Background.png", true)

		Knasthack.button[1] = guiCreateButton(0.27, 0.54, 0.47, 0.16, "Hacken", true, Knasthack.window[1])
		guiSetProperty(Knasthack.button[1], "NormalTextColour", "FFAAAAAA")
		Knasthack.button[2] = guiCreateButton(0.27, 0.75, 0.47, 0.16, "Schließen", true, Knasthack.window[1])
		guiSetProperty(Knasthack.button[2], "NormalTextColour", "FFAAAAAA")
		Knasthack.label[1] = guiCreateLabel(0.03, 0.15, 0.94, 0.34, "Starte einen Knasthack, und hol deine kriminellen Freunde frühzeitig aus dem Knast!", true, Knasthack.window[1])
		guiLabelSetHorizontalAlign(Knasthack.label[1], "left", true)   
		guiSetFont(Knasthack.label[1], "clear-normal")
		
		addEventHandler("onClientGUIClick",Knasthack.button[1],function()
			triggerServerEvent("Knasthackstart",getLocalPlayer(),getLocalPlayer())
		end,false)

		addEventHandler("onClientGUIClick",Knasthack.button[2],function()
			destroyElement(Knasthack.window[1])
			showCursor(false)
			setElementData(lp,"ElementClicked",false)
		end,false)
	else
		infobox('Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!')
	end
end

-- Öffnen
function Knasthackopen_func()
	knastHackWindow()
	showCursor(true)
	setElementData(lp,"ElementClicked",true,true)
end
addEvent("Knasthackopen",true)
addEventHandler("Knasthackopen",getRootElement(),Knasthackopen_func)