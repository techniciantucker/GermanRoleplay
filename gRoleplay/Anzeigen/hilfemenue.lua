local Hilfepanel = {tab = {},tabpanel = {},label = {},button = {},window = {}}
local HilfemenueOpen=false

function HilfemenueWindow()
	if(HilfemenueOpen==false)then
		if(getElementData(lp,'ElementClicked')==false)then
			HilfemenueOpen=true
			setElementData(lp,'ElementClicked',true)
			showCursor(true)
		
			Hilfepanel.window[1] = guiCreateStaticImage(0.01, 0.02, 0.53, 0.61, "Images/Background.png", true)
			
			Hilfepanel.label[1] = guiCreateLabel(0.42, 0.05, 0.56, 0.93, "Herzlich Willkommen im Hilfemenü von German Roleplay. Hier erhälst du zu allen wichtigen Dingen auf unserem Server ausführlich geschriebene Informationen, welche bei Bedarf immer mal wieder eneuert werden.", true, Hilfepanel.window[1])

			Hilfepanel.tabpanel[1] = guiCreateTabPanel(0.01, 0.05, 0.39, 0.93, true, Hilfepanel.window[1])

			Hilfepanel.tab[1] = guiCreateTab("Allgemeines", Hilfepanel.tabpanel[1])

			Hilfepanel.button[1] = guiCreateButton(0.03, 0.03, 0.94, 0.06, "Scheine und Ausweise", true, Hilfepanel.tab[1])
			Hilfepanel.button[2] = guiCreateButton(0.03, 0.10, 0.94, 0.06, "Jobs", true, Hilfepanel.tab[1])
			Hilfepanel.button[3] = guiCreateButton(0.03, 0.18, 0.94, 0.06, "Inventar", true, Hilfepanel.tab[1])
			Hilfepanel.button[4] = guiCreateButton(0.03, 0.26, 0.94, 0.06, "Erfolge", true, Hilfepanel.tab[1])
			Hilfepanel.button[5] = guiCreateButton(0.03, 0.34, 0.94, 0.06, "Fahrzeuge", true, Hilfepanel.tab[1])
			Hilfepanel.button[6] = guiCreateButton(0.03, 0.42, 0.94, 0.06, "Häuser", true, Hilfepanel.tab[1])
			Hilfepanel.button[7] = guiCreateButton(0.03, 0.49, 0.94, 0.06, "Konto", true, Hilfepanel.tab[1])
			Hilfepanel.button[8] = guiCreateButton(0.03, 0.57, 0.94, 0.06, "Geld", true, Hilfepanel.tab[1])
			Hilfepanel.button[9] = guiCreateButton(0.03, 0.65, 0.94, 0.06, "Blips", true, Hilfepanel.tab[1])
			Hilfepanel.button[10] = guiCreateButton(0.03, 0.73, 0.94, 0.06, "Befehle", true, Hilfepanel.tab[1])
			Hilfepanel.button[11] = guiCreateButton(0.03, 0.81, 0.94, 0.06, "Levelsystem", true, Hilfepanel.tab[1])
			Hilfepanel.button[12] = guiCreateButton(0.03, 0.88, 0.94, 0.06, "Harndrang & Hunger", true, Hilfepanel.tab[1])
			
			addEventHandler('onClientGUIClick',Hilfepanel.button[1],function()
				guiSetText(Hilfepanel.label[1],'In der Stadthalle und der Fahrschule können Scheine und Ausweise beantragt werden, welche für viele Dinge auf dem Server benötigt werden. In der Stadthalle kann man seinen Personalausweis sowie seine Arbeitsgenehmigung beantragen. Zudem hat man in der Stadthalle die Möglichkeit, Hartz 7 anzumelden, welches einem einen Paydaybonus von 2.500$ bringt. Mit Hartz 7 kann man allerdings keiner Fraktion beitreten und auch keine Jobs ausführen.  In der Fahrschule gibt es alle Scheine welche zum ausführen von Jobs und zum kauf von Autos benötigt werden.')
			end,false)
			addEventHandler('onClientGUIClick',Hilfepanel.button[2],function()
				guiSetText(Hilfepanel.label[1],'Welche Jobs wir anbieten, kann man in der Stadthalle erfahren. Dort gibt es einen Marker, wo man sich alle vorhanden Jobs inklusive Lohn anzeigen lassen kann. Wie viel Lohn man bei einem Job bekommt hängt davon ab, wie hoch das eigene Level ist.')
			end,false)
			addEventHandler('onClientGUIClick',Hilfepanel.button[3],function()
				guiSetText(Hilfepanel.label[1],'Das Inventar, welches unter "I" aufzurufen sowie zu schließen ist, bietet die Möglichkeit, die Anzahl seiner Items einzusehen.')
			end,false)
			addEventHandler('onClientGUIClick',Hilfepanel.button[4],function()
				guiSetText(Hilfepanel.label[1],'Erfolge bekommt man, wenn man bestimmte Aufgaben erledigt. Welche Erfolge es alles gibt und was für sie benötigt werden, kann man unter /erfolge nachschauen. Für jeden Erfolg gibt es einen Pokal, welche einem anschließend extra Geld beim Payday bringt.')
			end,false)
			addEventHandler('onClientGUIClick',Hilfepanel.button[5],function()
				guiSetText(Hilfepanel.label[1],'Fahrzeuge dienen zur schnellen Fortbewegung und können an Autos und Flugzeugen auf der Karte erworben werden. Es gibt Fahrzeuge in verschiedenen Preisklassen sowie Motorräder und Flugobjekte. Mit dem Kauf eines Fahrzeuges wird ein Slot eingenommen. Insgesamt kann man bis zu 10 Slots haben, welche einen 10 Fahrzeuge gleichzeitig ermöglichen. Zu Beginn hat man 3 Stück. 7 weitere kann man sich ab Level 5 für Erfahrungspunkte im Levelshop kaufen. Jedes Fahrzeug kostet Fahrzeugsteuer beim Payday.')
			end,false)
			addEventHandler('onClientGUIClick',Hilfepanel.button[6],function()
				guiSetText(Hilfepanel.label[1],'Solltest du keine Lust mehr haben, an Noobspawn zu spawnen, so kannst du dir ein Haus kaufen. Häuser welche kaufbar sind, haben einen grünen Hausmarker vor der Tür. Sollte der Marker blau sind, ist das Haus bereits von einem anderen Spieler gekauft worden. Sollte es dir dennoch gefallen, kannst du dich einmieten, wenn der Mieter dies aktiviert hat.')
			end,false)
			addEventHandler('onClientGUIClick',Hilfepanel.button[7],function()
				guiSetText(Hilfepanel.label[1],'Um dein Geld korrekt verwalten zu können, benötigst du ein Konto, welches du in der Bank beantragen kannst. Nach dem du dies getan hast, erhältst du einen Bankpin, welche du immer eintippen musst, wenn du dich an einem Automaten einloggen möchtest.')
			end,false)
			addEventHandler('onClientGUIClick',Hilfepanel.button[8],function()
				guiSetText(Hilfepanel.label[1],'Geld wird für sehr viele Dinge auf dem Server benötigt, weshalb du immer etwas dabei haben solltest. Geld verdienen kannst du, wenn du Jobs ausführst, Aktionen in Fraktionen durchführst oder deine Dienste als Unternehmer anbietest. Natürlich kannst du auch Fahrzeuge an & verkaufen oder illegaller Drogendealer werden. Wie du dein Geld verdienst, ist dir überlassen. Du musst nur aufpassen, dass die Cops dich bei illegalen Aktivitäten nicht packen.')
			end,false)
			addEventHandler('onClientGUIClick',Hilfepanel.button[9],function()
				guiSetText(Hilfepanel.label[1],"Die ganzen Icons auf der Karte nennen sich Blips und markieren die wichtigsten Orte.\n\nGraues T: Tankstellen\nSpraydose: Pay'n Spray'S\nBurger: Burgershots\nPizza: Pizzaläden\nWaffe: Ammunations\nRotes 'S': 24/7 Shops\nSchraubenschlüssel: Tuningwerkstätte\nWeißes 'S' in der grünen Zone: Fahrschule\nWeißes 'S' unten rechts in Los Santos: Spezialtuningwerkstatt\nFahrzeug: Autohäuser/Bikeshop\nFlugzeug: Flugzeugladen\nT-Shirt: Skinshop\nHerz: Puff & Sexshop\nGelber Punkt: Stadthalle\nGrünes Männchen: Gartenshop\nLilane Männchen: Aktionen für Gangs\nGelbe Männchen: Aktionen für Cops\nGetränk: Donutladen\nBlaue Sirene: Police Department\nTotenkopf: Bar\nDollarzeichen: Bank\nHellblaue Punkte: Quests")
			end,false)
			addEventHandler('onClientGUIClick',Hilfepanel.button[10],function()
				guiSetText(Hilfepanel.label[1],"Vieles wird per Fenster geregelt, jedoch gibt es auch einige wichtige Befehle, welche benötigt werden.\n\n/level: Levelmenü\n/levelshop: Levelshop\n/self: Eigenmenü\n/smoke: Zigarette rauchen\n/pay [Name] [Spieler]: Geld vergeben\n/admins: Teamliste\n/dice: Würfel benutzen\n/grow weed: Hanfsamen anfplanzen\n/pizza: Pizza bestellen\n/bombe: Bombe legen\n/report: Reporthalle betreten\n/leavereport: Reporthalle verlassen\n'X': Motor an/ausschalten\n'L': Licht an/ausschalten\n/showlicense [Spieler]: Lizenzen zeigen\nF1: Hilfemenü\n/animlist: Liste aller möglichen Animationen\n/piss:  Blase entleeren\n/showpokale [Spieler]: Einem Spieler seine Pokale zeigen\n/cgun: Mit Mats Waffen herstellen")
			end,false)
			addEventHandler('onClientGUIClick',Hilfepanel.button[11],function()
				guiSetText(Hilfepanel.label[1],'Viele Aktionen, wo es keine Möglichkeit gibt, auf eine unfaire Weise Erfahrungspunkte zu sammeln, geben Erfahrungspunkte. Erfahrungspunkte werden benötigt, um sich Level-Ups und Dinge im Levelshop, welcher ab Level 5 unter /levelshop zugänglich ist, zu kaufen. Sein eigenes Level beeinflust ebenfalls einiges auf dem Server. z.B können bestimmte Jobs erst ab einem bestimmten Level ausgeführt werde und geben auch je nach Level ein anderes Gehalt.')
			end,false)
			addEventHandler('onClientGUIClick',Hilfepanel.button[12],function()
				guiSetText(Hilfepanel.label[1],'Regelmäßg die Blase entleeren und etwas essen ist notwendig, damit man am leben bleibt. In Restaurants sowie an Tankstellen und Snackwägen kann man sich etwas zu Essen kaufen. Seine Blase kann man mit /piss, welches nicht legal ist, oder auf öffentlichen Toiletten entleeren, welche man in Burgershots und in der Stadthalle findet.')
			end,false)

			guiSetFont(Hilfepanel.label[1], "default-bold-small")
			guiLabelSetColor(Hilfepanel.label[1], 42, 174, 242)
			guiLabelSetHorizontalAlign(Hilfepanel.label[1], "left", true)
		else
			infobox('Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!')
		end
	else
		if(Hilfepanel.window[1])then
			destroyElement(Hilfepanel.window[1])
			setElementData(lp,'ElementClicked',false)
			showCursor(false)
		end
		HilfemenueOpen=false
	end
end
bindKey('f1','down',HilfemenueWindow)