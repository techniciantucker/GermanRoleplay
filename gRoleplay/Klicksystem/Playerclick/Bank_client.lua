kontopin = {button = {},window = {},label = {},edit={}}

addEvent("showCashPoint",true)
addEventHandler("showCashPoint",root,function()
	if(getElementData(lp,'ElementClicked')==false)then
		setElementData(lp,"ElementClicked",true,true)
		showCursor(true)
		
        kontopin.window[1] = guiCreateStaticImage(0.36, 0.01, 0.28, 0.17, "Images/Background.png", true)

        kontopin.edit[1] = guiCreateEdit(0.02, 0.16, 0.95, 0.21, "", true, kontopin.window[1])
        kontopin.label[1] = guiCreateLabel(0.02, 0.44, 0.95, 0.14, "Tippe deinen Pin ein, und klicke anschließend auf Einloggen.", true, kontopin.window[1])
        kontopin.button[1] = guiCreateButton(0.02, 0.64, 0.40, 0.19, "Einloggen", true, kontopin.window[1])
        guiSetProperty(kontopin.button[1], "NormalTextColour", "FFAAAAAA")
        kontopin.button[2] = guiCreateButton(0.58, 0.64, 0.40, 0.19, "Schließen", true, kontopin.window[1])
        guiSetProperty(kontopin.button[2], "NormalTextColour", "FFAAAAAA")
		
		addEventHandler("onClientGUIClick",kontopin.button[2],function()
			showCursor(false)
			destroyElement(kontopin.window[1])
			setElementData(lp,"ElementClicked",false)
		end,false)
		
		addEventHandler("onClientGUIClick",kontopin.button[1],function()
			local bankpin = getElementData(lp,"bankpin")
			local getpin = tonumber(guiGetText(kontopin.edit[1]))
			
			if getpin == bankpin then
				showCashPoint_func()
				destroyElement(kontopin.window[1])
			else
				infobox("Der Pin stimmt nicht!")
			end
		end,false)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)

function showCashPoint_func ()
	gWindow["cashPoint"] = guiCreateStaticImage(0.36, 0.01, 0.28, 0.44, "Images/Background.png", true)
		
	gButton["cashPointClose"] = guiCreateButton(0.32, 0.89, 0.37, 0.08, "Ausloggen", true,gWindow["cashPoint"])
	guiSetFont(gButton["cashPointClose"],"default-bold-small")
	addEventHandler ( "onClientGUIClick", gButton["cashPointClose"],function ()
		destroyElement(gWindow['cashPoint'])
		setElementData ( lp, "ElementClicked", false )
		showCursor ( false )
	end,false )

	gTabPanel["cashPoint"] = guiCreateTabPanel(0.02, 0.14, 0.95, 0.73, true,gWindow["cashPoint"])

	gTab["cashPointPayOut"] = guiCreateTab("Guthaben",gTabPanel["cashPoint"])
		
	gButton["cashPointPayOut"] = guiCreateButton(0.02, 0.84, 0.39, 0.11, "Auszahlen", true,gTab["cashPointPayOut"])
	gButton["cashPointPayIn"] = guiCreateButton(0.59, 0.84, 0.39, 0.11, "Einzahlen", true,gTab["cashPointPayOut"])
	gEdit["cashPointPayAmount"] = guiCreateEdit(0.27, 0.04, 0.46, 0.14, "", true,gTab["cashPointPayOut"])
	gLabel[98] = guiCreateLabel(0.27, 0.24, 0.46, 0.08, "Guthaben: 12305$", true,gTab["cashPointPayOut"])
	guiLabelSetVerticalAlign(gLabel[98],"top")
	guiLabelSetHorizontalAlign(gLabel[98],"center",false)
	gLabel[2] = guiCreateLabel(0.74, 0.06, 0.04, 0.09, "$", true,gTab["cashPointPayOut"])
	guiLabelSetColor(gLabel[2],0,125,0)
	guiLabelSetVerticalAlign(gLabel[2],"top")
	guiLabelSetHorizontalAlign(gLabel[2],"left",false)
	guiSetFont(gLabel[2],"default-bold-small")

	addEventHandler ( "onClientGUIClick", gButton["cashPointPayIn"],function ()
		local amount = tonumber ( guiGetText ( gEdit["cashPointPayAmount"] ) )
		triggerServerEvent ( "cashPointPayIn", lp, amount )
		setTimer ( refreshStatementLabels, 2000, 1, 1 )
	end,false )
	addEventHandler ( "onClientGUIClick", gButton["cashPointPayOut"],function ()
		local amount = tonumber ( guiGetText ( gEdit["cashPointPayAmount"] ) )
		triggerServerEvent ( "cashPointPayOut", lp, amount )
		setTimer ( refreshStatementLabels, 2000, 1, 1 )
	end,false )

	gTab["cashPointTransfer"] = guiCreateTab("Überweisung",gTabPanel["cashPoint"])
			
	gLabel[4] = guiCreateLabel(0.02, 0.05, 0.34, 0.09, "Spieler:", true,gTab["cashPointTransfer"])
	guiLabelSetColor(gLabel[4],255,255,255)
	guiLabelSetVerticalAlign(gLabel[4],"top")
	guiLabelSetHorizontalAlign(gLabel[4],"left",false)
	gLabel[5] = guiCreateLabel(0.02, 0.27, 0.34, 0.09, "Summe:", true,gTab["cashPointTransfer"])
	guiLabelSetColor(gLabel[5],255,255,255)
	guiLabelSetVerticalAlign(gLabel[5],"top")
	guiLabelSetHorizontalAlign(gLabel[5],"left",false)
	gLabel[7] = guiCreateLabel(0.02, 0.45, 0.34, 0.09, "Verwendung:", true,gTab["cashPointTransfer"])
	guiLabelSetColor(gLabel[7],255,255,255)
	guiLabelSetVerticalAlign(gLabel[7],"top")
	guiLabelSetHorizontalAlign(gLabel[7],"left",false)
	gEdit["cashPointTransferTo"] = guiCreateEdit(0.38, 0.02, 0.59, 0.16, "", true,gTab["cashPointTransfer"])
	gEdit["cashPointTransferAmount"] = guiCreateEdit(0.38, 0.22, 0.59, 0.16, "", true,gTab["cashPointTransfer"])
	gMemo["cashPointTransferReason"] = guiCreateEdit(0.38, 0.43, 0.59, 0.16, "", true,gTab["cashPointTransfer"])
	gButton["cashPointTransferSend"] = guiCreateButton(0.26, 0.85, 0.49, 0.11, "Überweisen", true,gTab["cashPointTransfer"])
	guiSetFont(gButton["cashPointTransferSend"],"default-bold-small")
				
	addEventHandler ( "onClientGUIClick", gButton["cashPointTransferSend"],function ()
		local amount = tonumber ( guiGetText ( gEdit["cashPointTransferAmount"] ) )
		local target = guiGetText ( gEdit["cashPointTransferTo"] )
		local reason = guiGetText ( gMemo["cashPointTransferReason"] )
		triggerServerEvent ( "cashPointTransfer", lp, amount, target, false, reason )
		setTimer(refreshStatementLabels,2000,1)
	end,false )
	refreshStatementLabels ( 0 )
end

function refreshStatementLabels ( page )
	local money = getElementData ( lp, "bankmoney" )

	if(money>0)then
		guiSetText ( gLabel[98], "+ Guthaben: "..money)
	else
		guiSetText ( gLabel[98], "- Guthaben: "..money)
	end
end

function getDateAsOneString ()
	local time = getRealTime()
	local day = time.monthday
	local month = time.month + 1
	local year = time.year + 1900
	return day.."."..month.."."..year
end

local BankPed_SF=createPed(189,359.70001220703,173.60000610352,1008.4000244141,270)
local BankPed_LV=createPed(189,359.70001220703,173.60000610352,1008.4000244141,270)
setElementInterior(BankPed_SF,3)
setElementInterior(BankPed_LV,3)
setElementDimension(BankPed_SF,1)
setElementDimension(BankPed_LV,2)

function noPedDamageBank()
	cancelEvent()
end
addEventHandler('onClientPedDamage',BankPed_SF,noPedDamageBank)
addEventHandler('onClientPedDamage',BankPed_LV,noPedDamageBank)