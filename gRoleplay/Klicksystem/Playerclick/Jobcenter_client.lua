JobBlipWirdAngezeigt = false

jobcenter = {gridlist = {},window = {},button = {}}

addEvent("jobcenter",true)
addEventHandler("jobcenter",root,function()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,"ElementClicked",true,true)
		
        jobcenter.window[1] = guiCreateStaticImage(0.37, 0.01, 0.27, 0.45, "Images/Background.png", true)

        jobcenter.gridlist[1] = guiCreateGridList(0.03, 0.07, 0.94, 0.76, true, jobcenter.window[1])
        guiGridListAddColumn(jobcenter.gridlist[1], "Job", 0.5)
        guiGridListAddColumn(jobcenter.gridlist[1], "Spielerbasiert", 0.5)
        for i = 1, 999 do
            guiGridListAddRow(jobcenter.gridlist[1])
        end
        guiGridListSetItemText(jobcenter.gridlist[1], 0, 1, "Busfahrer", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 0, 2, "Nein", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 1, 1, "Pizzalieferant", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 1, 2, "Nein", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 2, 1, "Pilot", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 2, 2, "Nein", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 3, 1, "Lieferant", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 3, 2, "Nein", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 4, 1, "Strassenreiniger", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 4, 2, "Nein", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 5, 1, "Meeresreiniger", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 5, 2, "Nein", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 6, 1, "Hotdog-Verkäufer", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 6, 2, "Ja", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 7, 1, "Eisverkäufer", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 7, 2, "Ja", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 8, 1, "Bergwerkarbeiter", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 8, 2, "Nein", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 9, 1, "Zugführer", false, false)
        guiGridListSetItemText(jobcenter.gridlist[1], 9, 2, "Nein", false, false)

        jobcenter.button[1] = guiCreateButton(0.03, 0.89, 0.41, 0.07, "Job anzeigen", true, jobcenter.window[1])
        guiSetProperty(jobcenter.button[1], "NormalTextColour", "FFAAAAAA")
		addEventHandler("onClientGUIClick",jobcenter.button[1],function()
			
			selectedText = guiGridListGetItemText ( jobcenter.gridlist[1],  guiGridListGetSelectedItem ( jobcenter.gridlist[1] ),1 )
		
			if JobBlipWirdAngezeigt == false then
				if selectedText == "Busfahrer" then
					jobBlipCityhall = createBlip ( 1769.29016, -1889.94202, 13.56071, 41, 1 )									-- Busfahrer
					JobBlipWirdAngezeigt = true
					infobox("Mittels /destroyblip kannst du den\nBlip wieder löschen!")
					outputChatBox('~~~~~ Job Informationen: Busfahrer ~~~~~',255,255,255)
					outputChatBox('Benötigtes Level für diesen Job: 5',0,100,150)
					outputChatBox('Gehalt pro Marker: Lvl 5-10: 250$, Lvl 11-20: 400$, Lvl 21-25: 500$',0,100,150)
				elseif selectedText == "Pizzalieferant" then
					jobBlipCityhall = createBlip ( 2105.10352, -1802.85693, 13.55469, 41, 1 )					                -- Pizzalieferant
					JobBlipWirdAngezeigt = true
					infobox("Mittels /destroyblip kannst du den\nBlip wieder löschen!")
					outputChatBox('~~~~~ Job Informationen: Pizzalieferant ~~~~~',255,255,255)
					outputChatBox('Benötigtes Level für diesen Job: 0',0,100,150)
					outputChatBox('Gehalt pro Marker: Lvl 0-10: 50$, Lvl 11-20: 100$, Lvl 21-25: 150$',0,100,150)
				elseif selectedText == "Pilot" then
					jobBlipCityhall = createBlip ( 1642.4000244141,-2237.8000488281,13.5, 41, 1 )		                        -- Pilot
					JobBlipWirdAngezeigt = true
					infobox("Mittels /destroyblip kannst du den\nBlip wieder löschen!")
					outputChatBox('~~~~~ Job Informationen: Pilot ~~~~~',255,255,255)
					outputChatBox('Benötigtes Level für diesen Job: 5',0,100,150)
					outputChatBox('Gehalt pro Marker: Lvl 5-10: 500$, Lvl 11-20: 1000$, Lvl 21-25: 1500$',0,100,150)
				elseif selectedText == "Lieferant" then
					jobBlipCityhall = createBlip ( 2280.26465, -2315.21802, 13.54688, 41, 1 ) 	                                -- Lieferant
					JobBlipWirdAngezeigt = true
					infobox("Mittels /destroyblip kannst du den\nBlip wieder löschen!")
					outputChatBox('~~~~~ Job Informationen: Lieferant ~~~~~',255,255,255)
					outputChatBox('Benötigtes Level für diesen Job: 5',0,100,150)
					outputChatBox('Gehalt pro Marker: Lvl 5-10: 250$, Lvl 11-20: 400$, Lvl 21-25: 650$',0,100,150)
				elseif selectedText == "Strassenreiniger" then
					jobBlipCityhall = createBlip ( 2137.60107, -1906.95129, 13.54688, 41, 1 )		                            -- Strassenreiniger
					JobBlipWirdAngezeigt = true
					infobox("Mittels /destroyblip kannst du den\nBlip wieder löschen!")
					outputChatBox('~~~~~ Job Informationen: Strassenreiniger ~~~~~',255,255,255)
					outputChatBox('Benötigtes Level für diesen Job: 0',0,100,150)
					outputChatBox('Gehalt pro Marker: Lvl 0-10: 200$, Lvl 11-20: 350$, Lvl 21-25: 500$',0,100,150)
				elseif selectedText == "Meeresreiniger" then
					jobBlipCityhall = createBlip ( 2494.30542, -2258.43457, 3.00000, 41, 1 )		                            -- Meeresreiniger
					JobBlipWirdAngezeigt = true
					infobox("Mittels /destroyblip kannst du den\nBlip wieder löschen!")
					outputChatBox('~~~~~ Job Informationen: Meeresreiniger ~~~~~',255,255,255)
					outputChatBox('Benötigtes Level für diesen Job: 0',0,100,150)
					outputChatBox('Gehalt: Lvl 0-10: Kilo, Lvl 11-20: Kilo * 1.5, Lvl 21-25: Kilo * 2 (In $$$)',0,100,150)
				elseif selectedText == "Hotdog-Verkäufer" then
					jobBlipCityhall = createBlip ( 1326.7032470703,-878.76916503906,39.578125, 41, 1 )		                     -- Hotdog-Verkäufer
					JobBlipWirdAngezeigt = true
					infobox("Mittels /destroyblip kannst du den\nBlip wieder löschen!")
					outputChatBox('~~~~~ Job Informationen: Hotdog-Verkäufer ~~~~~',255,255,255)
					outputChatBox('Benötigtes Level für diesen Job: 0',0,100,150)
					outputChatBox('Gehalt: Bis zu 100$ pro Hotdog.',0,100,150)
				elseif selectedText == "Eisverkäufer" then
					jobBlipCityhall = createBlip ( 1326.7032470703,-878.76916503906,39.578125, 41, 1 )		                     -- Eisverkäufer
					JobBlipWirdAngezeigt = true
					infobox("Mittels /destroyblip kannst du den\nBlip wieder löschen!")
					outputChatBox('~~~~~ Job Informationen: Eisverkäufer ~~~~~',255,255,255)
					outputChatBox('Benötigtes Level für diesen Job: 0',0,100,150)
					outputChatBox('Gehalt: Bis zu 100$ pro Eis.',0,100,150)
				elseif(selectedText=='Bergwerkarbeiter')then
					jobBlipCityhall=createBlip(816.55212402344,857.05157470703,12.7890625,41,1)
					JobBlipWirdAngezeigt=true																					 -- Eisverkäufer
					outputChatBox('~~~~~ Job Informationen: Bergwerkarbeiter ~~~~~',255,255,255)
					outputChatBox('Benötigtes Level für diesen Job: 0',0,100,150)
					outputChatBox('Gehalt: Lvl 0-10: 90$, Lvl 11-20: 140$, Lvl 21-25: 200$ (pro Marker)',0,100,150)
				elseif(selectedText=='Zugführer')then
					jobBlipCityhall=createBlip(1751.17639, -1943.75940, 13.56912,41,1)
					JobBlipWirdAngezeigt=true																					 -- Zugführer
					outputChatBox('~~~~~ Job Informationen: Zugführer ~~~~~',255,255,255)
					outputChatBox('Benötigtes Level für diesen Job: 0',0,100,150)
					outputChatBox('Gehalt: Lvl 0-10: 300-500$, Lvl 11-20: 600-800$, Lvl 21-25: 900-1200$ (pro Marker)',0,100,150)
				else
					infobox("Keinen Job ausgewählt!")
				end
			else
				infobox("Entferne zu erst dein bereits\nvorhandenes Blip mit /destroyblip!")
			end
		end,false)
        jobcenter.button[2] = guiCreateButton(0.57, 0.89, 0.41, 0.07, "Schließen", true, jobcenter.window[1])
        guiSetProperty(jobcenter.button[2], "NormalTextColour", "FFAAAAAA")
		addEventHandler("onClientGUIClick",jobcenter.button[2],function()
			destroyElement(jobcenter.window[1])
			showCursor(false)
			setElementData(lp,"ElementClicked",false)
		end,false)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)

function destroyJobBlip_func()
	if JobBlipWirdAngezeigt == true then
		destroyElement(jobBlipCityhall)
		JobBlipWirdAngezeigt = false
		infobox("Das Blip wurde entfernt!")
	end
end
addCommandHandler("destroyblip",destroyJobBlip_func)