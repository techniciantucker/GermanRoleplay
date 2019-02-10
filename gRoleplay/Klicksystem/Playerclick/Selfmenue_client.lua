local gWindows = {}

function hideall ()

	if isElement ( gWindows["selfclick"] ) then
	end
	if isElement ( Handy1 ) then
		destroyElement(Handy1)
	end
	if isElement (HandyNews) then
		destroyElement(HandyNews)
	end
	if isElement (HandyAnrufen) then
		destroyElement(HandyAnrufen)
	end
	if isElement (HandySMS) then
		destroyElement(HandySMS)
	end
	if isElement ( gWindow["spawnPointSelection"] ) then
		destroyElement(gWindow['spawnPointSelection'])
	end
	if isElement(gWindows["selfLizenzen"])then
		destroyElement(gWindows["selfLizenzen"])
	end
	if isElement(gWindows["selfInformation"])then
		destroyElement(gWindows["selfInformation"])
	end
	if(isElement(VehicleWindow))then
		destroyElement(VehicleWindow)
	end
	guiSetInputEnabled ( true )
end

function SelfOptionBtn ()

	showSettingsMenue ()
end

function SelfCancelBtn ()

	hideall ()
	guiSetVisible ( gWindows["selfclick"], false )
	showCursor(false)
	setElementData(lp,"ElementClicked",false)
end

function SelfStateBtn ()

	hideall ()
end

local gLabel = {}

function selfSpielerInformationen()
	hideall()
	fraktion = tonumber ( getElementData ( lp, "fraktion" ) )
	rang	 = tonumber ( getElementData ( lp, "rang" ) )
	fraktion = fraktionsNamen[fraktion]
	if not fraktion then
		fraktion = "Zivilist"
	end
	if not job then
		job = "Arbeitslos"
	end
	local playtime = getElementData ( lp, "playingtime" )
	local playtimehours = math.floor(playtime/60)
	local playtimeminutes = playtime-playtimehours*60
		
	if playtimeminutes < 10 then
		playtimeminutes = "0"..playtimeminutes
	end
	local playtime = playtimehours..":"..playtimeminutes
	local geld = getElementData ( lp, "money" );
	local bankmoney = getElementData ( lp, "bankmoney" );
	local stvo = getElementData ( lp, "stvo" ) or '-';
	geldsaecke = getElementData(lp,"foundpackages")
	
	local tode = getElementData(lp,'deaths')
	local kills = getElementData(lp,'kills')

	gWindows["selfInformation"] = guiCreateStaticImage(0.22, 0.19, 0.19, 0.47, "Images/Background.png", true)

	gLabel["Name"] = guiCreateLabel(0.04, 0.04, 0.93, 0.04, "Name: "..getPlayerName(localPlayer), true, gWindows["selfInformation"] )
	guiSetFont(gLabel["Name"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Name"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Name"], "center")
	gLabel["Playtime"] = guiCreateLabel(0.04, 0.10, 0.93, 0.04, "Spielstunden: 2300", true, gWindows["selfInformation"] )
	guiSetFont(gLabel["Playtime"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Playtime"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Playtime"], "center")
	gLabel["Fraktion"] = guiCreateLabel(0.04, 0.16, 0.93, 0.04, "Fraktion: Dildo-Experten", true, gWindows["selfInformation"] )
	guiSetFont(gLabel["Fraktion"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Fraktion"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Fraktion"], "center")
	gLabel["Rang"] = guiCreateLabel(0.04, 0.22, 0.93, 0.04, "Rang: 0", true, gWindows["selfInformation"] )
	guiSetFont(gLabel["Rang"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Rang"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Rang"], "center")
	gLabel["Job"] = guiCreateLabel(0.04, 0.28, 0.93, 0.04, "Job: Ponyfänger", true, gWindows["selfInformation"] )
	guiSetFont(gLabel["Job"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Job"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Job"], "center")
	gLabel["Geld"] = guiCreateLabel(0.04, 0.34, 0.93, 0.04, "Bargeld: 50000$", true, gWindows["selfInformation"] )
	guiSetFont(gLabel["Geld"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Geld"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Geld"], "center")
	gLabel["Bankgeld"] = guiCreateLabel(0.04, 0.40, 0.93, 0.04, "Bankgeld: 30000$", true, gWindows["selfInformation"] )
	guiSetFont(gLabel["Bankgeld"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Bankgeld"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Bankgeld"], "center")
	gLabel["Geldsaecke"] = guiCreateLabel(0.04, 0.46, 0.93, 0.04, "0/25", true, gWindows["selfInformation"] )
	guiSetFont(gLabel["Geldsaecke"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Geldsaecke"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Geldsaecke"], "center")
	gLabel["STVO"] = guiCreateLabel(0.04, 0.52, 0.93, 0.04, "STVO Punkte: 12", true, gWindows["selfInformation"] )
	guiSetFont(gLabel["STVO"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["STVO"], "center", false)
	guiLabelSetVerticalAlign(gLabel["STVO"], "center")
	gLabel['Stats'] = guiCreateLabel(0.04, 0.58, 0.93, 0.04, "Kills: "..kills.."/ Tode: "..tode, true, gWindows["selfInformation"] )
	guiSetFont(gLabel["Stats"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Stats"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Stats"], "center")
	
	guiSetText(gLabel["Playtime"], "Spielstunden: "..playtime);
	guiSetText(gLabel["Fraktion"], "Fraktion: "..fraktion);
	guiSetText(gLabel["Rang"], "Rang: "..rang or (0));
	guiSetText(gLabel["Job"], "Job: "..job);
	guiSetText(gLabel["Geld"], "Geld: "..geld.."$");
		
	if getElementData(lp,"bankpin") > 0 then
		guiSetText(gLabel["Bankgeld"], "Bankgeld: "..bankmoney.."$");
	else
		guiSetText(gLabel["Bankgeld"], "Bankgeld: Du hast kein Konto!");
	end
	
	guiSetText(gLabel["Geldsaecke"], "Geldsaecke: "..geldsaecke.."/25");
	guiSetText(gLabel["STVO"], "STVO Punkte: "..stvo);
end

function selfSpielerLizenzen()
	hideall()
	
	if getElementData ( lp, "carlicense" ) == 1 then cl = "✔" else cl = "✘" end
	if getElementData ( lp, "bikelicense" ) == 1 then bl = "✔" else bl = "✘" end
	if getElementData ( lp, "helilicense" ) == 1 then ll = "✔" else ll = "✘" end
	if getElementData ( lp, "planelicenseb" ) == 1 then pbl = "✔" else pbl = "✘" end
	if getElementData ( lp, "planelicensea" ) == 1 then pal = "✔" else pal = "✘" end
	if getElementData ( lp, "segellicense" ) == 1 then sl = "✔" else sl = "✘" end
	if getElementData ( lp, "motorbootlicense" ) == 1 then mbl = "✔" else mbl = "✘" end
	if getElementData ( lp, "gunlicense" ) == 1 then gl = "✔" else gl = "✘" end
	if getElementData ( lp,"worklicense" ) == 1 then wk="✔" else wk="✘" end
	if getElementData ( lp,"perso" ) == 1 then per="✔" else per="✘" end
	if getElementData ( lp, "gunlicenseB" ) == 1 then glb = "✔" else glb = "✘" end
	if getElementData ( lp, "gunlicenseC" ) == 1 then glc = "✔" else glc = "✘" end

	gWindows["selfLizenzen"] = guiCreateStaticImage(0.22, 0.19, 0.19, 0.47, "Images/Background.png", true)

	-- Fahrzeugschein
	gLabel["Autoschein"] = guiCreateLabel(0.04, 0.04, 0.93, 0.04, "Fahrzeugschein", true, gWindows["selfLizenzen"])
	guiSetFont(gLabel["Autoschein"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Autoschein"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Autoschein"], "center")
	-- Motorradschein
	gLabel["Motoradschein"] = guiCreateLabel(0.04, 0.10, 0.93, 0.04, "Motorradschein", true, gWindows["selfLizenzen"])
	guiSetFont(gLabel["Motoradschein"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Motoradschein"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Motoradschein"], "center")
	-- Helikopterschein
	gLabel["Helikopterschein"] = guiCreateLabel(0.04, 0.16, 0.93, 0.04, "Helikopterschein", true, gWindows["selfLizenzen"])
	guiSetFont(gLabel["Helikopterschein"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Helikopterschein"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Helikopterschein"], "center")
	-- Flugschein A
	gLabel["FlugscheinA"] = guiCreateLabel(0.04, 0.22, 0.93, 0.04, "Flugschein A", true, gWindows["selfLizenzen"])
	guiSetFont(gLabel["FlugscheinA"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["FlugscheinA"], "center", false)
	guiLabelSetVerticalAlign(gLabel["FlugscheinA"], "center")
	-- Flugschein B
	gLabel["FlugscheinB"] = guiCreateLabel(0.04, 0.28, 0.93, 0.04, "Flugschein B", true, gWindows["selfLizenzen"])
	guiSetFont(gLabel["FlugscheinB"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["FlugscheinB"], "center", false)
	guiLabelSetVerticalAlign(gLabel["FlugscheinB"], "center")
	-- Selgelschein
	gLabel["Segelschein"] = guiCreateLabel(0.04, 0.34, 0.93, 0.04, "Segelschein", true, gWindows["selfLizenzen"])
	guiSetFont(gLabel["Segelschein"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Segelschein"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Segelschein"], "center")
	-- Motorbootschein
	gLabel["Motorbootschein"] = guiCreateLabel(0.04, 0.40, 0.93, 0.04, "Motorbootschein", true, gWindows["selfLizenzen"])
	guiSetFont(gLabel["Motorbootschein"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Motorbootschein"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Motorbootschein"], "center")
	-- Waffenschein
	gLabel["Waffenschein"] = guiCreateLabel(0.04, 0.46, 0.93, 0.04, "Waffenschein", true, gWindows["selfLizenzen"])
	guiSetFont(gLabel["Waffenschein"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Waffenschein"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Waffenschein"], "center")
	-- Arbeitslizenz
	gLabel["Arbeitslizenz"] = guiCreateLabel(0.04, 0.52, 0.93, 0.04, "Arbeitslizenz", true, gWindows["selfLizenzen"])
	guiSetFont(gLabel["Arbeitslizenz"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Arbeitslizenz"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Arbeitslizenz"], "center")
	-- Personalausweis
	gLabel["Personalausweis"] = guiCreateLabel(0.04, 0.58, 0.93, 0.04, "Personalausweis", true, gWindows["selfLizenzen"])
	guiSetFont(gLabel["Personalausweis"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Personalausweis"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Personalausweis"], "center")
	----- Waffenschein B -----
	gLabel["Waffenscheinb"] = guiCreateLabel(0.04, 0.64, 0.93, 0.04, "Waffenschein B", true, gWindows["selfLizenzen"])
	guiSetFont(gLabel["Waffenscheinb"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Waffenscheinb"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Waffenscheinb"], "center")
	----- Waffenschein C -----
	gLabel["Waffenscheinc"] = guiCreateLabel(0.04, 0.70, 0.93, 0.04, "Waffenschein C", true, gWindows["selfLizenzen"])
	guiSetFont(gLabel["Waffenscheinc"], "default-bold-small")
	guiLabelSetHorizontalAlign(gLabel["Waffenscheinc"], "center", false)
	guiLabelSetVerticalAlign(gLabel["Waffenscheinc"], "center")

	guiSetText(gLabel["Autoschein"], "Fahrzeugschein "..cl);
	guiSetText(gLabel["Motoradschein"], "Motorradschein "..bl);
	guiSetText(gLabel["Helikopterschein"], "Helikopterschein "..ll);
	guiSetText(gLabel["FlugscheinA"], "Flugschein A "..pal);
	guiSetText(gLabel["FlugscheinB"], "Flugschein B "..pbl);
	guiSetText(gLabel["Segelschein"], "Segelschein "..sl);
	guiSetText(gLabel["Motorbootschein"], "Motorbootschein "..mbl);
	guiSetText(gLabel["Waffenschein"], "Waffenschein "..gl);
	guiSetText(gLabel["Arbeitslizenz"],"Arbeitsgenehmigung: "..wk)
	guiSetText(gLabel["Personalausweis"],"Personalausweis: "..per)
	guiSetText(gLabel["Waffenscheinb"],"Waffenschein B: "..glb)
	guiSetText(gLabel["Waffenscheinc"],"Waffenschein C: "..glc)
end

function ShowSelfClickMenue_func()
	
	if(getElementData(lp,"ElementClicked")==false)then
		guiSetInputEnabled ( false )
		setElementData(lp,"ElementClicked",true)
	
		gWindows["selfclick"] = guiCreateStaticImage(0.02, 0.19, 0.20, 0.47, "Images/Background.png", true)
			
		gButtons["selfstatus"] = guiCreateButton(0.04, 0.07, 0.93, 0.06, "Spieler Informationen", true,gWindows["selfclick"]) 					-- Spieler Informationen
		gButtons["selflizenzen"] = guiCreateButton(0.04, 0.16, 0.93, 0.06, "Lizenzen", true, gWindows["selfclick"]) 							-- Lizenzen
		gButtons["selfspawn"] = guiCreateButton(0.04, 0.25, 0.93, 0.06, "Spawnpunkte", true, gWindows["selfclick"]) 							-- Spawnpunkt 
		gButtons["selfhandy"] = guiCreateButton(0.04, 0.34, 0.93, 0.06, "Handy", true,gWindows["selfclick"]) 									-- Handy		
		gButtons["selfcarsystem"] = guiCreateButton(0.04, 0.42, 0.93, 0.06, "Fahrzeuge", true, gWindows["selfclick"]) 							-- Fahrzeugpanel		
		gButtons["selfcancel"] = guiCreateButton(0.04, 0.51, 0.93, 0.06, "Schließen", true,gWindows["selfclick"]) 								-- Abbrechen

		addEventHandler("onClientGUIClick", gButtons["selfcancel"], SelfCancelBtn, false)
		addEventHandler("onClientGUIClick", gButtons["selfstatus"], selfSpielerInformationen, false)
		addEventHandler('onClientGUIClick', gButtons['selfcarsystem'], SelfRunCarSystem, false);
		
		addEventHandler("onClientGUIClick", gButtons["selfhandy"],function()
			if(getElementData(lp,'handyAbgenommen')==false)then
				hideall()
					
				HandyHauptseite()
				--showCursor(true)
			else
				infobox('Du hast kein Handy!')
			end
		end,false )

		addEventHandler('onClientGUIClick',gButtons["selflizenzen"], selfSpielerLizenzen, false);
		addEventHandler('onClientGUIClick', gButtons['selfspawn'], showSpawnSelection, false);
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end
addEvent ( "ShowSelfClickMenue", true)
addEventHandler ( "ShowSelfClickMenue", getLocalPlayer(),  ShowSelfClickMenue_func)

function SelfRunCarSystem()
	triggerServerEvent('runningVehiclePanel', localPlayer, localPlayer)
	hideall()
end

----- Handy -----

--- Seite 1 ---

function HandyHauptseite()
	Handy1 = guiCreateStaticImage(0.72, 0.42, 0.38, 0.59, "Images/Handy1.png", true)																				-- Seite 1

	AnAus = guiCreateButton(0.45, 0.79, 0.10, 0.09, "an/aus", true, Handy1)																							 -- An und Ausschalten des Handy
	guiSetProperty(AnAus, "NormalTextColour", "FFAAAAAA")
	guiSetAlpha(AnAus,0)
	SMS = guiCreateButton(0.35, 0.22, 0.10, 0.11, "sms", true, Handy1)																							     -- Sms versenden
	guiSetProperty(SMS, "NormalTextColour", "FFAAAAAA")
	guiSetAlpha(SMS,0)
	ANRUF = guiCreateButton(0.55, 0.22, 0.10, 0.11, "anruf", true, Handy1)																							 -- Eine Person anrufen
	guiSetProperty(ANRUF, "NormalTextColour", "FFAAAAAA")
	guiSetAlpha(ANRUF,0)
	YOUTUBE = guiCreateButton(0.35, 0.66, 0.10, 0.11, "youtube", true, Handy1)																						 -- YouTube öffnen
	guiSetProperty(YOUTUBE, "NormalTextColour", "FFAAAAAA")
	guiSetAlpha(YOUTUBE,0)
	NEWS = guiCreateButton(0.55, 0.66, 0.10, 0.11, "news", true, Handy1)																							 -- News öffnen
	guiSetProperty(NEWS, "NormalTextColour", "FFAAAAAA")
	guiSetAlpha(NEWS,0)

	addEventHandler("onClientGUIClick",SMS,function()
		if(getElementData(lp,'handystate')=='on')then
			destroyElement(Handy1)
			HandySMSseite()
		else
			outputChatBox('Dein Handy ist aus!',255,0,0)
		end
	end,false)

	addEventHandler("onClientGUIClick",NEWS,function()
		if(getElementData(lp,'handystate')=='on')then
			destroyElement(Handy1)
			HandyNewsseite()
		else
			outputChatBox('Dein Handy ist aus!',255,0,0)
		end
	end,false)

	addEventHandler("onClientGUIClick",ANRUF,function()
		if(getElementData(lp,'handystate')=='on')then
			destroyElement(Handy1)
			HandyAnrufenseite()
		else
			outputChatBox('Dein Handy ist aus!',255,0,0)
		end
	end,false)

	addEventHandler("onClientGUIClick",AnAus,function()
		triggerServerEvent("handychange",getLocalPlayer(),getLocalPlayer())
	end,false)
end

--- News ---

function HandyNewsseite()
	HandyNews = guiCreateStaticImage(0.72, 0.42, 0.38, 0.59, "Images/Handy2.png", true)																				  -- News Seite

	Handyback = guiCreateButton(0.45, 0.79, 0.10, 0.09, "an/aus", true, HandyNews)																					  -- Zurück zur Seite 1
	guiSetAlpha(Handyback,0)
	guiSetProperty(Handyback, "NormalTextColour", "FFAAAAAA")
	HandyNewsLabel = guiCreateLabel(0.34, 0.22, 0.32, 0.54, "Aktuelle News:\n\n\nZwilling vom Xendom am 02.12.2015 um 19:32 Uhr im Wald gesichtet.", true, HandyNews) -- News
	guiSetFont(HandyNewsLabel, "clear-normal")
	guiLabelSetHorizontalAlign(HandyNewsLabel, "left", true)    

	addEventHandler("onClientGUIClick",Handyback,function()
		if isElement(HandyNews) then
			destroyElement(HandyNews)
		end
		HandyHauptseite()
	end)
end

--- Anrufen ---

function HandyAnrufenseite()
	HandyAnrufen = guiCreateStaticImage(0.72, 0.42, 0.38, 0.59, "Images/Handy2.png", true)																			  -- Anruf Seite

	Handyback2 = guiCreateButton(0.45, 0.79, 0.10, 0.09, "an/aus", true,HandyAnrufen)                                                                                 -- Zurück zur Seite 1
	guiSetAlpha(Handyback2,0)
	Anrufen = guiCreateButton(0.35, 0.72, 0.31, 0.04, "Anrufen", true,HandyAnrufen)                                                                                   -- Anrufen
	Nummer = guiCreateEdit(0.35, 0.24, 0.31, 0.04,"",true,HandyAnrufen)                                                                                               -- Nummer

	addEventHandler("onClientGUIClick", Anrufen,function ()
		if guiGetText ( Nummer ) ~= "" and tonumber ( guiGetText ( Nummer ) ) then
			triggerServerEvent ( "callSomeone", getLocalPlayer(), getLocalPlayer(), guiGetText ( Nummer ) )
			hideall ()
		end
	end)
	
	addEventHandler("onClientGUIClick",Handyback2,function()
		if isElement(HandyAnrufen) then
			destroyElement(HandyAnrufen)
		end
		HandyHauptseite()
	end,false)
end

--- Sms schreiben ---

function HandySMSseite()
	HandySMS = guiCreateStaticImage(0.72, 0.42, 0.38, 0.59, "Images/Handy2.png", true)																				  -- SMS Seite

	Handyback3 = guiCreateButton(0.45, 0.79, 0.10, 0.09, "an/aus", true,HandySMS)                                                                                 	  -- Zurück zur Seite 1
	guiSetAlpha(Handyback3,0)
	SMSNR = guiCreateEdit(0.35, 0.24, 0.31, 0.04,"",true,HandySMS)																							      	  -- Nummer
	SMSTEXT = guiCreateMemo(0.35, 0.29, 0.31, 0.41,"",true,HandySMS)																							      -- Text
	SMSSENDEN = guiCreateButton(0.35, 0.72, 0.31, 0.04,"Senden",true,HandySMS)																					      -- Versenden
	
	addEventHandler("onClientGUIClick",Handyback3,function()
		if isElement(HandySMS) then
			destroyElement(HandySMS)
		end
		HandyHauptseite()
	end,false)

	addEventHandler("onClientGUIClick", SMSSENDEN,function ()
		if guiGetText ( SMSNR ) ~= "" and tonumber ( guiGetText ( SMSNR ) ) then
			if guiGetText (  SMSTEXT ) ~= "" then
				local sendnr = tonumber ( guiGetText ( SMSNR ) )
				local sendtext = guiGetText ( SMSTEXT )
				triggerServerEvent ( "SMS", getLocalPlayer(), getLocalPlayer(), sendnr, sendtext )
			end
		end
	end)
end