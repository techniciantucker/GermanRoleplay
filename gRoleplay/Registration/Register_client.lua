local x,y = guiGetScreenSize()

function SubmitRegisterBtn(button)
	if button == "left" then
		local pname = getPlayerName ( lp )
		local passwort = guiGetText ( gEdit["passwort_register"] )
		local pwlaenge = #passwort
		if guiGetText ( gEdit["passwort_register2"] ) ~= passwort then
			outputChatBox('[REGISTRATION]: Die beiden Passwörter stimmen nicht überein!',255,0,0)
		elseif pwlaenge < 6 or passwort == "******" or passwort == pname or passwort == "123456" then
			outputChatBox('[REGISTRATION]: Das Passwort ist ungültig oder zu kurz! (Mind. 6 Zeichen)',255,0,0)
		elseif(not(guiCheckBoxGetSelected(gCheckbox['regeln'])))then
			outputChatBox('[REGISTRATION]: Du musst unsere Regeln akzeptieren!',255,0,0)
		else
			player = lp
			triggerServerEvent ( "register", lp, player, passwort, 29, 12, 1991, 1 )
		end
	end
end

function renderBalkenRegisterLogin()
	dxDrawRectangle(0*(x/1440), 0*(y/900), 1440*(x/1440), 71*(y/900), tocolor(0, 0, 0, 255), false)
    dxDrawRectangle(0*(x/1440), 829*(y/900), 1440*(x/1440), 71*(y/900), tocolor(0, 0, 0, 255), false)
end

function showRegisterGui_func ()
	gWindow["register"] = guiCreateStaticImage(0.29, 0.29, 0.43, 0.40, "Images/Background.png", true)
	
	showCursor ( true )
	
	----- Texte -----
	gLabel[1] = guiCreateLabel(0.02, 0.08, 0.97, 0.12, "Willkommen auf German Roleplay! Um dich bei uns zu registrieren, fülle alle unteren Felder aus und klicke anschließend auf 'Registrieren'.", true, gWindow["register"])
    guiSetFont(gLabel[1], "default-bold-small")
    guiLabelSetHorizontalAlign(gLabel[1], "center", true)
	gLabel[2] = guiCreateLabel(0.24, 0.37, 0.52, 0.06, "Passwort", true, gWindow["register"])
    guiSetFont(gLabel[2], "default-bold-small")
    guiLabelSetHorizontalAlign(gLabel[2], "center", true)
    guiLabelSetVerticalAlign(gLabel[2], "center")
	gLabel[3] = guiCreateLabel(0.24, 0.57, 0.52, 0.06, "Passwort wiederholen", true, gWindow["register"])
    guiSetFont(gLabel[3], "default-bold-small")
    guiLabelSetHorizontalAlign(gLabel[3], "center", true)
    guiLabelSetVerticalAlign(gLabel[3], "center")
	gLabel["name_edit"] = guiCreateLabel(0.24, 0.23, 0.52, 0.06, "Dein Username lautet: "..getPlayerName(localPlayer), true, gWindow["register"])
    guiSetFont(gLabel["name_edit"], "default-bold-small")
    guiLabelSetHorizontalAlign(gLabel["name_edit"], "center", true)
    guiLabelSetVerticalAlign(gLabel["name_edit"], "center")
	
    gLabel['strich'] = guiCreateLabel(0.02, 0.30, 0.97, 0.04, "______________________________________________________________________________________", true, gWindow["register"])
    guiSetFont(gLabel['strich'], "default-bold-small")
    guiLabelSetHorizontalAlign(gLabel['strich'], "center", true)
	
	----- Checkbox -----
    gCheckbox['regeln'] = guiCreateCheckBox(0.24, 0.78, 0.52, 0.05, "Ich habe die Regeln gelesen und akzeptiere sie.", false, true, gWindow["register"])
    guiSetFont(gCheckbox['regeln'], "default-bold-small")   
	
	----- Buttons -----
	gButtons["register"] = guiCreateButton(0.30, 0.89, 0.41, 0.08, "Registrieren", true, gWindow["register"])
	
	----- Editboxen Passwort -----
	gEdit["passwort_register"]  = guiCreateEdit(0.24, 0.45, 0.52, 0.09, "", true, gWindow["register"]) -- Passwort
	guiSetAlpha(gEdit["passwort_register"],1)
	guiEditSetMasked(gEdit["passwort_register"], true)
	gEdit["passwort_register2"] = guiCreateEdit(0.24, 0.66, 0.52, 0.09, "", true, gWindow["register"]) -- Passwort wiederholen
	guiSetAlpha(gEdit["passwort_register2"],1)
	guiEditSetMasked(gEdit["passwort_register2"] , true)

	addEventHandler("onClientGUIClick", gButtons["register"], SubmitRegisterBtn, false)
end
addEvent ( "ShowRegisterGui", true)
addEventHandler ( "ShowRegisterGui", getRootElement(), showRegisterGui_func )

function GUI_DisableRegisterGui()
	destroyElement ( gWindow["register"] )
	destroyElement (LoginSound)
	showCursor ( false )
	removeEventHandler('onClientRender',root,renderBalkenRegisterLogin)
end
addEvent ( "DisableRegisterGui", true )
addEventHandler ( "DisableRegisterGui", getRootElement(), GUI_DisableRegisterGui)