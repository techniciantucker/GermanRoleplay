function cancelRathausMenue ( button )

	guiSetVisible(gWindow["rathausbg"], false)
	showCursor(false)
	setElementData(lp,"ElementClicked",false)
end

function beantragen ( button, state )

	if button == "left" then
		player = getLocalPlayer()
		cancelRathausMenue ( button )
		triggerServerEvent ( "LizenzKaufen", getLocalPlayer(), player, license )
	end
end

function ShowRathausMenue_func()

	_createCityhallGui()
end
addEvent ( "ShowRathausMenue", true)
addEventHandler ( "ShowRathausMenue", getLocalPlayer(),  ShowRathausMenue_func)

function _createCityhallGui()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,"ElementClicked",true,true)
	
		gWindow["rathausbg"] = guiCreateStaticImage(0.37, 0.01, 0.26, 0.46, "Images/Background.png", true)    
		gGrid["Licenses"] = guiCreateGridList(0.03, 0.07, 0.94, 0.78, true,gWindow["rathausbg"])
		guiGridListSetSelectionMode(gGrid["Licenses"],0)
		gColumn["cityhallLicense"] = guiGridListAddColumn(gGrid["Licenses"],"Schein",0.51)
		gColumn["cityhallPreis"] = guiGridListAddColumn(gGrid["Licenses"],"Preis",0.25)
		gColumn["cityhallVorhanden"] = guiGridListAddColumn(gGrid["Licenses"],"",0.04)
		guiSetAlpha(gGrid["Licenses"],1)
		gButton["beantragen"] = guiCreateButton(0.03, 0.88, 0.40, 0.09, "Schein beantragen", true,gWindow["rathausbg"])
		guiSetAlpha(gButton["beantragen"],1)
		gButton["schliessen"] = guiCreateButton(0.56, 0.88, 0.40, 0.09, "Schließen", true,gWindow["rathausbg"])
		guiSetAlpha(gButton["schliessen"],1)
		
		addEventHandler("onClientGUIClick", gButton["schliessen"], cancelRathausMenue, false)
		addEventHandler("onClientGUIClick", gButton["beantragen"], beantragen, false)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
	refreshLicenses()
end

function rathausClick ()
	if gWindow["rathausbg"] then
		local rowindex, columnindex = guiGridListGetSelectedItem ( gGrid["Licenses"] )
		local selectedText = guiGridListGetItemText ( gGrid["Licenses"], rowindex, gColumn["cityhallLicense"] )
		if selectedText == "Fahrzeugschein" then
			license = "car"
		elseif selectedText == "Flugschein B" then
			license = "planeb"
		elseif selectedText == "Flugschein A" then
			license = "planea"
		elseif selectedText == "Helikopterschein" then
			license = "heli"
		elseif selectedText == "Motorbootschein" then
			license = "motorboot"
		elseif selectedText == "Segelschein" then
			license = "raft"
		elseif selectedText == "Motorradschein" then
			license = "bike"
		end
	end
end
addEventHandler ( "onClientGUIClick", getRootElement(), rathausClick )

function refreshLicenses()

	guiGridListClear ( gGrid["Licenses"] )
	
	local row = guiGridListAddRow ( gGrid["Licenses"] )
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Fahrzeugschein", false, false )
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "750 $", false, false )
		
	if tonumber ( getElementData ( lp, "carlicense" ) ) == 1 then fix = "✔" else fix = "✘" end
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
	
	local row = guiGridListAddRow ( gGrid["Licenses"] )
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Motorradschein", false, false )
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "500 $", false, false )
	if tonumber ( getElementData ( lp, "bikelicense" ) ) == 1 then fix = "✔" else fix = "✘" end
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
	
	local row = guiGridListAddRow ( gGrid["Licenses"] )
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Flugschein A", false, false )
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "25.000 $", false, false )
	if tonumber ( getElementData ( lp, "planelicensea" ) ) == 1 then fix = "✔" else fix = "✘" end
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
	
	local row = guiGridListAddRow ( gGrid["Licenses"] )
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Flugschein B", false, false )
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "50.000 $", false, false )
	if tonumber ( getElementData ( lp, "planelicenseb" ) ) == 1 then fix = "✔" else fix = "✘" end
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
	
	local row = guiGridListAddRow ( gGrid["Licenses"] )
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Helikopterschein", false, false )
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "15.000 $", false, false )
	if tonumber ( getElementData ( lp, "helilicense" ) ) == 1 then fix = "✔" else fix = "✘" end
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
	
	local row = guiGridListAddRow ( gGrid["Licenses"] )
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Motorbootschein", false, false )
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "400 $", false, false )
	if tonumber ( getElementData ( lp, "motorbootlicense" ) ) == 1 then fix = "✔" else fix = "✘" end
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
	
	local row = guiGridListAddRow ( gGrid["Licenses"] )
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Segelschein", false, false )
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "350 $", false, false )
	if tonumber ( getElementData ( lp, "segellicense" ) ) == 1 then fix = "✔" else fix = "✘" end
	guiGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
end

----- Infos -----
local x,y,z = 1132.1558837891,-1692.7386474609,13.878098487854

function Fahrschulinfo()
	local px,py,pz = getElementPosition(lp)
	local dist = getDistanceBetweenPoints3D(px,py,pz,x,y,z)
	if(dist < 10) then
		local screenX,screenY = getScreenFromWorldPosition(x,y,z)
		if(screenX and screenY) then
			dxDrawText("Fahrschul Informationen",screenX,screenY,screenX,screenY,tocolor(255,255,255,255),1,"default-bold","center","center",false,false,true,true,false)
		end
	end
end
addEventHandler("onClientRender",root,Fahrschulinfo)

fahrschulinfos = {button = {},window = {},memo = {}}

addEvent("fahrschulinfos",true)
addEventHandler("fahrschulinfos",root,function()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,"ElementClicked",true,true)
	
        fahrschulinfos.window[1] = guiCreateStaticImage(0.31, 0.01, 0.39, 0.40, "Images/Background.png", true)

        fahrschulinfos.memo[1] = guiCreateMemo(0.02, 0.08, 0.96, 0.75, "An der Fahrschule kannst du alle nötigen Scheine beantragen. Der wichtigste Schein ist der Führerschein, da du diesen brauchst, um einer Fraktion beitreten zu können, Jobs auszuführen und dir Autos kaufen zu können.\n\nAn den auf der Karte zu sehenden Spraydosen kannst du deine Fahrzeuge jederzeit reparieren, sollte es Schaden genommen haben.\n\nAn den auf der Karte zu sehenden Schraubenschlüsseln kannst du deine Fahrzeuge tunen. Zudem gibt es noch eine Spezialtuninggarage, wo es Sportmotoren, Tieferlegungen sowie Neo Farben zu kaufen gibt. Diese wurde mit einem weißen S markiert und befindet sich unten rechts in Los Santos.\n\nUnter /self -> Fahrzeuge kannst du deine Fahrzeuge verwalten. Sollten deine Fahrzeuge als false angezeigt werden, musst du sie mittels /respawnen [Slot] spawnen lassen und das Menü aktualisieren. Unter /vehhelp erhältst du weitere Infos zu deinen Fahrzeugen.", true, fahrschulinfos.window[1])
		guiMemoSetReadOnly(fahrschulinfos.memo[1], true)
        fahrschulinfos.button[1] = guiCreateButton(0.32, 0.88, 0.35, 0.09, "Schließen", true, fahrschulinfos.window[1])
        addEventHandler("onClientGUIClick",fahrschulinfos.button[1],function()
			showCursor(false)
			setElementData(lp,"ElementClicked",false)
			destroyElement(fahrschulinfos.window[1])
		end,false)
    else
		infobox("Es ist nicht möglich, mehrere\Fenster gleichzeitig zu öffnen!")
	end
end)