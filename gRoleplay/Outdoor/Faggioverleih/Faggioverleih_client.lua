faggioped = createPed(0,1563.1999511719,-1881.1999511719,13.5,0.00274658)
addEventHandler("onClientPedDamage",faggioped,function()
	cancelEvent()
end)

function faggioWinwdow()
	FaggioWindow = guiCreateStaticImage(0.37, 0.01, 0.26, 0.17, "Images/Background.png", true)

	FaggioLabel1 = guiCreateLabel(0.03, 0.19, 0.94, 0.42, "Solltest du unter 10 Spielstunden besitzen, bezahlt der Staat das Faggio. Andernfalls kostet es dich 100$", true, FaggioWindow)
	guiSetFont(FaggioLabel1, "clear-normal")
	guiLabelSetHorizontalAlign(FaggioLabel1, "left", true)

	FaggioBuyButton = guiCreateButton(0.03, 0.67, 0.39, 0.22, "Faggio ausleihen", true, FaggioWindow)
	FaggioCloseButton = guiCreateButton(0.58, 0.67, 0.39, 0.22, "Schließen", true, FaggioWindow)
	
	addEventHandler("onClientGUIClick",FaggioCloseButton,function()
		destroyElement(FaggioWindow)
		showCursor(false)
		setElementData(lp,"ElementClicked",false)
	end,false)
	
	addEventHandler("onClientGUIClick",FaggioBuyButton,function()
		destroyElement(FaggioWindow)
		showCursor(false)
		setElementData(lp,"ElementClicked",false)
		triggerServerEvent("buyfaggio",lp,lp)
	end,false)
end

addEvent("openfaggio",true)
addEventHandler("openfaggio",root,function()
	if(getElementData(lp,'ElementClicked')==false)then
		faggioWinwdow()
		showCursor(true)
		setElementData(lp,"ElementClicked",true,true)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)