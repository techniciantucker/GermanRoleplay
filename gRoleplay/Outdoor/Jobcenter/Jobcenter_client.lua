-- // Peds

JobPed = createPed(240,356.29998779297,180.69999694824,1008.4000244141,270.001373)
setElementInterior(JobPed,3)
setElementFrozen(JobPed,true)
addEventHandler("onClientPedDamage",JobPed,cancelEvent)

StatusPed = createPed(240,356.39999389648,167.60000610352,1008.4000244141,268.001464)
setElementInterior(StatusPed,3)
setElementFrozen(StatusPed,true)
addEventHandler("onClientPedDamage",StatusPed,cancelEvent)

InfoPed = createPed(12,359.60000610352,173.60000610352,1008.4000244141,272.000915)
setElementInterior(InfoPed,3)
setElementFrozen(InfoPed,true)
addEventHandler("onClientPedDamage",InfoPed,cancelEvent)

-- // Verwaltung

verwaltung = {button = {},window = {},label = {}}

addEvent("verwaltung",true)
addEventHandler("verwaltung",root,function()
	if(getElementData(lp,'ElementClicked')==false)then
		local perso = getElementData(lp,"perso")
		local workl = getElementData(lp,"worklicense")
		local hartz = getElementData(lp,"hartzseven")

		showCursor(true)
		setElementData(lp,"ElementClicked",true,true)
		
        verwaltung.window[1] = guiCreateStaticImage(0.33, 0.01, 0.34, 0.37, "Images/Background.png", true)

        verwaltung.button[1] = guiCreateButton(0.02, 0.45, 0.48, 0.10, "Personalausweis beantragen", true, verwaltung.window[1])
        guiSetProperty(verwaltung.button[1], "NormalTextColour", "FFAAAAAA")
        verwaltung.label[1] = guiCreateLabel(0.02, 0.09, 0.96, 0.34, "Kaufe dir einen Personalausweis, damit du eine Identität hast. Ohne Identität kriegst du kaum Geld am Payday, kannst keine Jobs ausführen, und keiner Fraktion beitreten. Eine Arbeitsgenehmigung benötigst du zum ausführen unserer Jobs. Solltest du in keiner Fraktion sein, und nicht Jobben gehen wollen, so kannst du Harz 7 beantragen!", true, verwaltung.window[1])
        guiSetFont(verwaltung.label[1], "clear-normal")
        guiLabelSetHorizontalAlign(verwaltung.label[1], "left", true)
        verwaltung.button[2] = guiCreateButton(0.02, 0.59, 0.48, 0.10, "Arbeitsgenehmigung beantragen", true, verwaltung.window[1])
        guiSetProperty(verwaltung.button[2], "NormalTextColour", "FFAAAAAA")
		
		if hartz == 0 then
			verwaltung.button[3] = guiCreateButton(0.02, 0.72, 0.48, 0.10, "Hartz 7 beantragen",true, verwaltung.window[1])
			guiSetProperty(verwaltung.button[3], "NormalTextColour", "FFAAAAAA")
		else
			verwaltung.button[3] = guiCreateButton(0.02, 0.72, 0.48, 0.10, "Hartz 7 abmelden",true, verwaltung.window[1])
			guiSetProperty(verwaltung.button[3], "NormalTextColour", "FFAAAAAA")
		end
        verwaltung.button[4] = guiCreateButton(0.02, 0.85, 0.48, 0.10, "Schließen", true, verwaltung.window[1])
        guiSetProperty(verwaltung.button[4], "NormalTextColour", "FFAAAAAA")
		
		if perso == 0 then
			verwaltung.label[2] = guiCreateLabel(0.52, 0.60, 0.46, 0.08, "Personalausweis: ✘", true, verwaltung.window[1])
			guiSetFont(verwaltung.label[2], "clear-normal")
		else
			verwaltung.label[2] = guiCreateLabel(0.52, 0.60, 0.46, 0.08, "Personalausweis: ✔", true, verwaltung.window[1])
			guiSetFont(verwaltung.label[2], "clear-normal")
		end
		
		if workl == 0 then
			verwaltung.label[3] = guiCreateLabel(0.52, 0.46, 0.46, 0.08, "Arbeitsgenehmigung: ✘", true, verwaltung.window[1])
			guiSetFont(verwaltung.label[3], "clear-normal")
		else
			verwaltung.label[3] = guiCreateLabel(0.52, 0.46, 0.46, 0.08, "Arbeitsgenehmigung: ✔", true, verwaltung.window[1])
			guiSetFont(verwaltung.label[3], "clear-normal")
		end
		
		if hartz == 0 then
			verwaltung.label[4] = guiCreateLabel(0.52, 0.72, 0.46, 0.08, "Hartz 7: ✘", true, verwaltung.window[1])
			guiSetFont(verwaltung.label[4], "clear-normal")
		else
			verwaltung.label[4] = guiCreateLabel(0.52, 0.72, 0.46, 0.08, "Hartz 7: ✔", true, verwaltung.window[1])
			guiSetFont(verwaltung.label[4], "clear-normal")
		end
		
		addEventHandler("onClientGUIClick",verwaltung.button[2],function()
			triggerServerEvent("worklicense",getLocalPlayer(),getLocalPlayer())
		end,false)
		
		addEventHandler("onClientGUIClick",verwaltung.button[3],function()
			triggerServerEvent("hartz7",getLocalPlayer(),getLocalPlayer())
		end,false)
		
		addEventHandler("onClientGUIClick",verwaltung.button[1],function()
			triggerServerEvent("perso",getLocalPlayer(),getLocalPlayer())
		end,false)
		
		addEventHandler("onClientGUIClick",verwaltung.button[4],function()
			destroyElement(verwaltung.window[1])
			showCursor(false)
			setElementData(lp,"ElementClicked",false)
		end,false)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)