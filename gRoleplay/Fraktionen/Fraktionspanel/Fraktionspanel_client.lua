function FraktionsWindow()
	FraktionWindow = guiCreateStaticImage(0.34, 0.01, 0.32, 0.74, "Images/Background.png", true)

	FraktionPlayersGridlist = guiCreateGridList(0.02, 0.10, 0.95, 0.26, true, FraktionWindow)
	FraktionName = guiGridListAddColumn(FraktionPlayersGridlist, "Name", 0.3)
	FraktionRang = guiGridListAddColumn(FraktionPlayersGridlist, "Rang", 0.3)
	FraktionStatus = guiGridListAddColumn(FraktionPlayersGridlist, "Status", 0.3)
	F1_Label = guiCreateLabel(0.02, 0.06, 0.95, 0.04, "Fraktionisten:", true, FraktionWindow)
	guiSetFont(F1_Label, "default-bold-small")
	guiLabelSetColor(F1_Label, 255,255,255)
	UninviteButton = guiCreateButton(0.67, 0.71, 0.31, 0.05, "Uninviten", true, FraktionWindow)
	guiSetProperty(UninviteButton, "NormalTextColour", "FFAAAAAA")
	RangUPButton = guiCreateButton(0.02, 0.78, 0.31, 0.05, "Rang Up", true, FraktionWindow)
	guiSetProperty(RangUPButton, "NormalTextColour", "FFAAAAAA")
	RangDOWNButton = guiCreateButton(0.67, 0.78, 0.31, 0.05, "Rang Down", true, FraktionWindow)
	guiSetProperty(RangDOWNButton, "NormalTextColour", "FFAAAAAA")
	PlayersOnlineGridlist = guiCreateGridList(0.02, 0.43, 0.95, 0.26, true, FraktionWindow)
	PlayersName = guiGridListAddColumn(PlayersOnlineGridlist, "Name", 0.9)
	F2_Label = guiCreateLabel(0.02, 0.38, 0.95, 0.04, "Zivilisten:", true, FraktionWindow)
	guiSetFont(F2_Label, "default-bold-small")
	guiLabelSetColor(F2_Label, 255,255,255)
	InviteButton = guiCreateButton(0.02, 0.71, 0.31, 0.05, "Inviten", true, FraktionWindow)
	guiSetProperty(InviteButton, "NormalTextColour", "FFAAAAAA")
	RespawnVehicleButton = guiCreateButton(0.34, 0.71, 0.32, 0.05, "Base respawnen", true, FraktionWindow)

	F4_Label = guiCreateLabel(0.34, 0.92, 0.64, 0.04, "Fraktionskasse:", true, FraktionWindow)
	guiSetFont(F4_Label, "clear-normal")
	GiveMoneyButton = guiCreateButton(0.02, 0.85, 0.31, 0.05, "Einzahlen", true, FraktionWindow)
	guiSetProperty(GiveMoneyButton, "NormalTextColour", "FFAAAAAA")
	RentMoneyButton = guiCreateButton(0.02, 0.92, 0.31, 0.05, "Auszahlen", true, FraktionWindow)
	guiSetProperty(RentMoneyButton, "NormalTextColour", "FFAAAAAA")
	MoneyEdit = guiCreateEdit(0.34, 0.85, 0.32, 0.05, "", true, FraktionWindow)

	frakiverlassen = guiCreateButton(0.34, 0.78, 0.32, 0.05, "Fraktion verlassen", true, FraktionWindow)
	guiSetProperty(frakiverlassen, "NormalTextColour", "FFAAAAAA")
	
	addEventHandler('onClientGUIClick', RentMoneyButton, moneyPayOff, false)
	addEventHandler('onClientGUIClick', GiveMoneyButton, moneyDeposit, false)
	addEventHandler('onClientGUIClick', RangDOWNButton, setPlayerRangDOWN, false);
	addEventHandler('onClientGUIClick', UninviteButton, uninvitePlayer, false);
	addEventHandler('onClientGUIClick', InviteButton, invitePlayer, false);
	addEventHandler('onClientGUIClick', RangUPButton, setPlayerRangUP, false);
	addEventHandler('onClientGUIClick', RespawnVehicleButton, respawnFraktionCars, false)
	
	addEventHandler("onClientGUIClick",frakiverlassen,function()
		triggerServerEvent("fleave",getLocalPlayer(),getLocalPlayer())
	end,false)
end

addEvent("showfmenuefalse",true)
addEventHandler("showfmenuefalse",root,function()
	showCursor(false)
	setElementData(lp,"ElementClicked",false)
	destroyElement(FraktionWindow)
end)

-- Fraktions-Kasse --

addEvent('clientLoadFraktionPanel', true)
addEventHandler('clientLoadFraktionPanel', localPlayer, function(frakPlayers, ziviPlayers, cash)
	if(getElementData(lp,"ElementClicked")==false)then
		setElementData ( lp, "ElementClicked", true, true )
		showCursor(true);
		FraktionsWindow()
		guiGridListClear(PlayersOnlineGridlist);
		guiGridListClear(FraktionPlayersGridlist);
		if(#frakPlayers > 0)then
			for k, v in pairs(frakPlayers) do 
				local row = guiGridListAddRow(FraktionPlayersGridlist);
				guiGridListSetItemText(FraktionPlayersGridlist, row, FraktionName, v[1], false, false);
				guiGridListSetItemText(FraktionPlayersGridlist, row, FraktionRang, v[2], false, false);
				guiGridListSetItemText(FraktionPlayersGridlist, row, FraktionStatus, v[3], false, false);
			end 
		end
		if(#ziviPlayers > 0)then
			for k, v in pairs(ziviPlayers) do 
				local row = guiGridListAddRow(PlayersOnlineGridlist);
				guiGridListSetItemText(PlayersOnlineGridlist, row, PlayersName, v[1], false, false);
			end 
		end
		guiSetText(F4_Label, 'Fraktions-Kasse: '..cash..'$');
		guiSetText(F1_Label, 'Fraktionisten: '..(#frakPlayers));
		guiSetText(F2_Label, 'Zivilisten: '..(#ziviPlayers));
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)

addEvent('clientUnloadFraktionPanel', true)
addEventHandler('clientUnloadFraktionPanel', localPlayer, function()
	showCursor(false);
	if(FraktionsWindow)then
		destroyElement(FraktionWindow)
	end
	setElementData ( lp, "ElementClicked", false, true );
end)

addEvent('clientRefreshFraktionPanel', true)
addEventHandler('clientRefreshFraktionPanel', localPlayer, function(frakPlayers, ziviPlayers, cash)
	guiGridListClear(PlayersOnlineGridlist);
	guiGridListClear(FraktionPlayersGridlist);
	if(#frakPlayers > 0)then
		for k, v in pairs(frakPlayers) do 
			local row = guiGridListAddRow(FraktionPlayersGridlist);
			guiGridListSetItemText(FraktionPlayersGridlist, row, FraktionName, v[1], false, false);
			guiGridListSetItemText(FraktionPlayersGridlist, row, FraktionRang, v[2], false, false);
			guiGridListSetItemText(FraktionPlayersGridlist, row, FraktionStatus, v[3], false, false);
		end 
	end
	if(#ziviPlayers > 0)then
		for k, v in pairs(ziviPlayers) do 
			local row = guiGridListAddRow(PlayersOnlineGridlist);
			guiGridListSetItemText(PlayersOnlineGridlist, row, PlayersName, v[1], false, false);
		end 
	end
	guiSetText(F4_Label, 'Fraktions-Kasse: '..cash..'$');
end)

function refreshPanel()
	unloadFraktionItems();
	fillPlayersList();
	fillFraktionPlayersList();
end

function unloadFraktionItems()
	guiGridListClear(PlayersOnlineGridlist);
	guiGridListClear(FraktionPlayersGridlist);
end

function setPlayerRangUP()
	local gridlistSelect = guiGridListGetItemText(FraktionPlayersGridlist, guiGridListGetSelectedItem(FraktionPlayersGridlist), 1);
	if(gridlistSelect ~= -1)then
		triggerServerEvent('onFraktionSetPlayerRang', localPlayer, localPlayer, gridlistSelect, '+');
	end
end

function respawnFraktionCars()
	triggerServerEvent('onRespawnVehicles', localPlayer, localPlayer);
end

function setPlayerRangDOWN()
	local gridlistSelect = guiGridListGetItemText(FraktionPlayersGridlist, guiGridListGetSelectedItem(FraktionPlayersGridlist), 1);
	if(gridlistSelect ~= -1)then
		triggerServerEvent('onFraktionSetPlayerRang', localPlayer, localPlayer, gridlistSelect, '-');
	end
end

function uninvitePlayer()
	local gridlistSelect = guiGridListGetItemText(FraktionPlayersGridlist, guiGridListGetSelectedItem(FraktionPlayersGridlist), 1);
	if(gridlistSelect ~= -1)then
		triggerServerEvent('onFraktionUninvite', localPlayer, localPlayer, gridlistSelect);
	end
end

function invitePlayer()
	local gridlistSelect = guiGridListGetItemText(PlayersOnlineGridlist, guiGridListGetSelectedItem(PlayersOnlineGridlist), 1);
	if(gridlistSelect ~= -1)then
		triggerServerEvent('onFraktionInvite', localPlayer, localPlayer, gridlistSelect);
	else
		infobox("Wähle einen Spieler aus!")
	end
end

----- Fraktionskasse -----
function moneyDeposit()
	local moneyEdit = guiGetText(MoneyEdit);
	if(string.find(moneyEdit,'-',1,true))then
		infobox('Ungültige Zahl!')
	else
		if(tonumber(moneyEdit))then
			triggerServerEvent('FraktionDepot', localPlayer, localPlayer, tonumber(moneyEdit), '+');
		else
			infobox("Ungültiger Wert!")
		end
	end
end

function moneyPayOff()
	local moneyEdit = guiGetText(MoneyEdit);
	if(string.find(moneyEdit,'-',1,true))then
		infobox('Ungültige Zahl!')
	else
		if(tonumber(moneyEdit))then
			triggerServerEvent('FraktionDepot', localPlayer, localPlayer, tonumber(moneyEdit), '-');
		else
			infobox("Ungültiger Wert!")
		end
	end
end