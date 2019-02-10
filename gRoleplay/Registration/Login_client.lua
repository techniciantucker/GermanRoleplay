gButtons = {}
gEdit = {}
gImage = {}

showPlayerHudComponent("radar", false)
setPlayerHudComponentVisible('area_name',false)

function SubmitPasswortLoginEdit(button)
	if button == "left" then
		if guiGetText ( gEdit["passwort_login"] ) == "******" then
			guiSetText ( gEdit["passwort_login"], "" )
		end
	end
end

function guiShowLoginAgain_func ()
	guiSetVisible ( LoginWindow, true )
	guiSetText ( gEdit["passwort_login"], "" )
end
addEvent ( "guiShowLoginAgain", true )
addEventHandler ( "guiShowLoginAgain", getRootElement(), guiShowLoginAgain_func )

function SubmitEinloggenBtn()

	if guiGetVisible ( LoginWindow ) then
		guiSetVisible ( LoginWindow, false )
		local passwort = tostring(guiGetText (gEdit["passwort_login"]))
		triggerServerEvent ( "einloggen", lp, lp, passwort )
	end
end

bindKey("enter","down",function()
	if getElementData(lp,"loggedin") == 0 then
		SubmitEinloggenBtn()
	end
end)

function _CreateLoginWindow()
	
	if LoginWindow then
		guiSetVisible ( LoginWindow, true )
	else
		addEventHandler('onClientRender',root,renderBalkenRegisterLogin)

		LoginSound = playSound("Registration/1.mp3", true)
		setSoundVolume(LoginSound,1)
		
		LoginWindow = guiCreateStaticImage(0.29, 0.29, 0.43, 0.40, "Images/Background.png", true)
		
		logininfolabel = guiCreateLabel(0.02, 0.08, 0.97, 0.12, "Willkommen zurück auf German Roleplay, "..getPlayerName(localPlayer).."! Um dich einzuloggen fülle alle unteren Felder aus.", true, LoginWindow)
        guiSetFont(logininfolabel, "default-bold-small")
        guiLabelSetHorizontalAlign(logininfolabel, "center", true)
		
		gLabel['infoTextName'] = guiCreateLabel(0.24, 0.37, 0.52, 0.06, "Passwort:", true, LoginWindow)
        guiSetFont(gLabel['infoTextName'], "default-bold-small")
        guiLabelSetHorizontalAlign(gLabel['infoTextName'], "center", true)
        guiLabelSetVerticalAlign(gLabel['infoTextName'], "center")
		
		gEdit["passwort_login"] = guiCreateEdit(0.24, 0.45, 0.52, 0.09, "", true, LoginWindow)
		guiEditSetMasked(gEdit["passwort_login"], true)
		
		gButtons["Einloggen"] = guiCreateButton(0.30, 0.89, 0.41, 0.08, "Einloggen", true, LoginWindow)
        guiSetProperty(gButtons["Einloggen"], "NormalTextColour", "FFAAAAAA")
		guiSetAlpha(gButtons["Einloggen"],1)
		
        loginYOPlatzhalter = guiCreateLabel(0.02, 0.30, 0.97, 0.04, "______________________________________________________________________________________", true, LoginWindow)
        guiSetFont(loginYOPlatzhalter, "default-bold-small")
        guiLabelSetHorizontalAlign(loginYOPlatzhalter, "center", true)
		
		guiSetAlpha(gEdit["passwort_login"],1)
		guiSetVisible ( LoginWindow, false )
		addEventHandler("onClientGUIClick", gEdit["passwort_login"], SubmitPasswortLoginEdit, false)
		addEventHandler("onClientGUIClick", gButtons["Einloggen"], SubmitEinloggenBtn, false)
	end
end

function GUI_ShowLoginWindow()

	guiSetVisible(LoginWindow, true)
	showCursor(true)
	bindKey ( "enter", "down", SubmitEinloggenBtn )
end
addEvent ( "ShowLoginWindow", true)
addEventHandler ( "ShowLoginWindow", getRootElement(), GUI_ShowLoginWindow)

function GUI_DisableLoginWindow()
	removeEventHandler('onClientRender',root,renderBalkenRegisterLogin)
	guiSetVisible(LoginWindow, false)
	destroyElement(LoginSound)
	showCursor(false)
end
addEvent ( "DisableLoginWindow", true )
addEventHandler ( "DisableLoginWindow", getRootElement(), GUI_DisableLoginWindow)

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), function ()
	local player = getLocalPlayer()
	_CreateLoginWindow()
	for i = 1, 100 do
		outputChatBox (" ")
	end
	triggerServerEvent ( "regcheck", getLocalPlayer(), player )
end)