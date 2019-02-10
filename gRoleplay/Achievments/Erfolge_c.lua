local Erfolge = {button = {},window = {},label = {}}
local ErfolgeZweiyo = {button = {},window = {},label = {},gridlist={}}

function erfolgWindow(achievment)
	if(getElementData(lp,'ElementClicked')==false)then
		Erfolge.window[1] = guiCreateStaticImage(0.37, 0.01, 0.27, 0.15, "Images/Background.png", true)

		Erfolge.button[1] = guiCreateButton(0.03, 0.77, 0.94, 0.16, "Ok", true, Erfolge.window[1])
		Erfolge.label[1] = guiCreateLabel(0.03, 0.18, 0.94, 0.48, "Du hast den Erfolg '"..achievment.."' freigeschaltet! Als Belohnung erhälst du einen Pokal.", true, Erfolge.window[1])
		guiSetFont(Erfolge.label[1], "default-bold-small")
		guiLabelSetHorizontalAlign(Erfolge.label[1], "left", true)
		destroyErfolgWindow=setTimer(function()
			destroyElement(Erfolge.window[1])
			if(isCursorShowing)then
				showCursor(false)
			end
		end,20000,1)
		addEventHandler('onClientGUIClick',Erfolge.button[1],function()
			destroyElement(Erfolge.window[1])
			if(isCursorShowing)then
				showCursor(false)
			end
			if(destroyErfolgWindow)then
				killTimer(destroyErfolgWindow)
			end
		end,false)
	else
		outputChatBox('Du hast den Erfolg: '..achievment..' freigeschalten! Als Belohnung erhälst du einen Pokal',0,255,0)
	end
end
addEvent('erfolgWindow',true)
addEventHandler('erfolgWindow',root,erfolgWindow)

addCommandHandler('erfolge',function()
	if(getElementData(lp,'ElementClicked')==false)then
		setElementData(lp,'ElementClicked',true)
		showCursor(true)
		local geschwommen=getElementData(lp,'Punkte_Rekordschwimmer')
		local gelaufen=getElementData(lp,'Punkte_Langlaeufer')
		local busfahrer=getElementData(lp,'Punkte_Busfahrer')
		local eisverkauft=getElementData(lp,'Punkte_Eisfahrer')
		local hotdogverkauft=getElementData(lp,'Punkte_Hotdog')
		local meeresreiniger=getElementData(lp,'Punkte_Meeresreiniger')
		local pilot=getElementData(lp,'Punkte_Pilot')
		local pizza=getElementData(lp,'Punkte_Pizzalieferant')
		local muellmann=getElementData(lp,'Punkte_Strassenreiniger')
		local trucker=getElementData(lp,'Punkte_Trucker')
		local meinzuhause=getElementData(lp,'Erfolg_MeinZuhause')
		local erstefahrzeug=getElementData(lp,'Erfolg_MeinErstesFahrzeug')
		local erstesgeld=getElementData(lp,'Erfolg_MeinErstesGeld')
		local millionaer=getElementData(lp,'Erfolg_Millionaer')
		local fahrzeugsammler=getElementData(lp,'Erfolg_Fahrzeugsammler')
		local level25=getElementData(lp,'Erfolg_EndlichLevel25')
		local stunden=getElementData(lp,'Erfolg_250Spielstunden')
		local bergwerkarbeiter=getElementData(lp,'Punkte_Bergwerkarbeiter')
		local gym=getElementData(lp,'Erfolg_Gym')
		local zugjob=getElementData(lp,'Punkte_Zugjob')
		
        ErfolgeZweiyo.window[1] = guiCreateStaticImage(0.33, 0.02, 0.36, 0.41, "Images/Background.png", true)

        ErfolgeZweiyo.gridlist[1] = guiCreateGridList(0.02, 0.08, 0.87, 0.90, true, ErfolgeZweiyo.window[1])
        guiGridListAddColumn(ErfolgeZweiyo.gridlist[1], "Erfolg", 0.8)
        guiGridListAddColumn(ErfolgeZweiyo.gridlist[1], "Freigeschalten?", 0.2)
        for i = 1, 50 do
            guiGridListAddRow(ErfolgeZweiyo.gridlist[1])
        end
		----- Geschwommen -----
		if(geschwommen<10000)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 0, 1, "Rekordschwimmer: "..math.floor(geschwommen).."/10000 geschwommen", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 0, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 0, 1, "Rekordschwimmer: 10000/10000 geschwommen", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 0, 2, "Nein", false, false)
		end
		if(gelaufen<1000000)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 1, 1, "Langläufer: "..math.floor(gelaufen).."/1000000 Meter gelaufen", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 1, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 1, 1, "Langläufer: 1000000/1000000 Meter gelaufen", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 1, 2, "Ja", false, false)
		end
		if(busfahrer<1000)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 2, 1, "Haltestellensammler: "..busfahrer.."/1000 Haltestellen abgefahren", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 2, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 2, 1, "Haltestellensammler: 1000/1000 Haltestellen abgefahren", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 2, 2, "Ja", false, false)
		end
		if(eisverkauft<100)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 3, 1, "Schleck ma: "..eisverkauft.."/100 Eis verkauft", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 3, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 3, 1, "Schleck ma: 100/100 Eis verkauft", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 3, 2, "Ja", false, false)
		end
		if(hotdogverkauft<100)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 4, 1, "Wurst ins Brot: "..hotdogverkauft.."/100 Hotdogs verkauft", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 4, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 4, 1, "Wurst ins Brot: 100/100 Hotdogs verkauft", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 4, 2, "Ja", false, false)
		end
		if(meeresreiniger<1000000)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 5, 1, "Umweltfreundlich: "..meeresreiniger.."/1000000 Kilo Dreck aus dem Meer gefischt", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 5, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 5, 1, "Umweltfreundlich: 1000000/1000000 Kilo Dreck aus dem Meer gefischt", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 5, 2, "Nein", false, false)
		end
		if(pilot<500)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 6, 1, "Ein echter Flieger: "..pilot.."/500 mal Passagiere transportiert", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 6, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 6, 1, "Ein echter Flieger: 500/500 mal Passagiere transportiert", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 6, 2, "Nein", false, false)
		end
		if(pizza<3000)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 7, 1, "Gesund? Kenne ich nicht: "..pizza.."/3000 mal Pizza ausgelifert", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 7, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 7, 1, "Gesund? Kenne ich nicht: 3000/3000 mal Pizza ausgelifert", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 7, 2, "Ja", false, false)
		end
		if(muellmann<500)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 8, 1, "Ein echter Müllman: "..muellmann.."/500 Mülltonnen geleert", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 8, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 8, 1, "Ein echter Müllman: 500/500 Mülltonnen geleert", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 8, 2, "Ja", false, false)
		end
		if(trucker<500)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 9, 1, "Lieferant des Jahres: "..trucker.."/500 mal Ware ausgeliefert", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 9, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 9, 1, "Lieferant des Jahres: 500/500 mal Ware ausgeliefert", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 9, 2, "Ja", false, false)
		end
		if(meinzuhause==0)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 10, 1, "Mein eigenes Zuhause: Kaufe dein erstes Haus", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 10, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 10, 1, "Mein eigenes Zuhause: Kaufe dein erstes Haus", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 10, 2, "Ja", false, false)
		end
		if(erstefahrzeug==0)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 11, 1, "Mein erstes Fahrzeug: Kaufe dein erstes Fahrzeug", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 11, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 11, 1, "Mein erstes Fahrzeug: Kaufe dein erstes Fahrzeug", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 11, 2, "Ja", false, false)
		end
		if(erstesgeld==0)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 12, 1, "Mein erstes Geld: Erhalte deinen ersten Payday", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 12, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 12, 1, "Mein erstes Geld: Erhalte deinen ersten Payday", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 12, 2, "Ja", false, false)
		end
		if(millionaer==0)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 13, 1, "Millionär: Habe 1.000.000$ auf dem Konto", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 13, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 13, 1, "Millionär: Habe 1.000.000$ auf dem Konto", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 13, 2, "Ja", false, false)
		end
		if(fahrzeugsammler==0)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 14, 1, "Fahrzeugsammler: Habe 10 Fahrzeuge gleichzeitig", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 14, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 14, 1, "Fahrzeugsammler: Habe 10 Fahrzeuge gleichzeitig", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 14, 2, "Ja", false, false)
		end
		if(level25==0)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 15, 1, "Endlich Level 25: Erreiche Level 25", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 15, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 15, 1, "Endlich Level 25: Erreiche Level 25", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 15, 2, "Ja", false, false)
		end
		if(stunden==0)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 16, 1, "Durchgesuchtet: Erreiche 250 Spielstunden", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 16, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 16, 1, "Durchgesuchtet: Erreiche 250 Spielstunden", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 16, 2, "Ja", false, false)
		end
		if(bergwerkarbeiter<1999)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 17, 1, "Überschüttet von Steinen: "..bergwerkarbeiter.."/2000 Steinge weggeräumt", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 17, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 17, 1, "Überschüttet von Steinen: 2000/2000 Steinge weggeräumt", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 17, 2, "Ja", false, false)
		end
		if(gym==0)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 18, 1, "44er Bizeps: Betrete ein Fitnessstudio", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 18, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 18, 1, "44er Bizeps: Betrete ein Fitnessstudio", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 18, 2, "Ja", false, false)
		end
		if(zugjob<750)then
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 19, 1, "Streckenmeister: "..zugjob.."/750 mal den Bahnhof gewechselt", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 19, 2, "Nein", false, false)
		else
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 19, 1, "Streckenmeister: 750/750 mal den Bahnhof gewechselt", false, false)
			guiGridListSetItemText(ErfolgeZweiyo.gridlist[1], 19, 2, "Ja", false, false)
		end
		
        ErfolgeZweiyo.button[1] = guiCreateButton(0.90, 0.08, 0.08, 0.90, "[X]", true, ErfolgeZweiyo.window[1])
		addEventHandler('onClientGUIClick',ErfolgeZweiyo.button[1],function()
			destroyElement(ErfolgeZweiyo.window[1])
			showCursor(false)
			setElementData(lp,'ElementClicked',false)
		end,false)
	else
		infobox('Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!')
	end
end)