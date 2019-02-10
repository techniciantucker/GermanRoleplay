create_level = {button = {},window = {},label = {}}

function levelWindow()
	showCursor(true)
	setElementData(lp,"ElementClicked",true)
	
	local levelTable = {
	[1]  =  5000,
	[2]  = 10000,
	[3]  = 15000,
	[4]  = 20000,
	[5]  = 25000,
	[6]  = 30000,
	[7]  = 35000,
	[8]  = 40000,
	[9]  = 45000,
	[10] = 50000,
	[11] = 55000,
	[12] = 60000,
	[13] = 65000,
	[14] = 70000,
	[15] = 75000,
	[16] = 80000,
	[17] = 85000,
	[18] = 90000,
	[19] = 95000,
	[20] = 100000,
	[21] = 115000,
	[22] = 135000,
	[23] = 150000,
	[24] = 170000,
	[25] = 200000,
	}
	
	local lvl = getElementData(lp,"level")
	local ep = getElementData(lp,"erfahrungspunkte")
	local price = levelTable[tonumber(getElementData(lp,"level")) +1]
	
	if(getElementData(lp,'level')<=25)then
		outputChatBox('[INFO]: Das nächste Level kostet dich '..price..'$ und 1000 Erfahrungspunkte.',0,100,150)
	else
		outputChatBox('[INFO]: Du hast das maximal Level erreicht!',0,100,150)
	end

    create_level.window[1] = guiCreateStaticImage(0.38, 0.01, 0.24, 0.24, "Images/Background.png", true)

    create_level.label[1] = guiCreateLabel(0.11, 0.22, 0.79, 0.14, "Dein Level: "..lvl, true, create_level.window[1])
    guiSetFont(create_level.label[1], "default-bold-small")
    create_level.label[2] = guiCreateLabel(0.11, 0.41, 0.79, 0.14, "Deine Erfahrungspunkte: "..ep, true, create_level.window[1])
    guiSetFont(create_level.label[2], "default-bold-small")
    create_level.button[1] = guiCreateButton(0.30, 0.60, 0.40, 0.15, "Level Up kaufen", true, create_level.window[1])
    guiSetProperty(create_level.button[1], "NormalTextColour", "FFAAAAAA")
    create_level.button[2] = guiCreateButton(0.30, 0.80, 0.40, 0.15, "Schließen", true, create_level.window[1])
    guiSetProperty(create_level.button[2], "NormalTextColour", "FFAAAAAA")
	
	addEventHandler("onClientGUIClick",create_level.button[1],function()
		destroyElement(create_level.window[1])
		showCursor(false)
		setElementData(lp,"ElementClicked",false)
		triggerServerEvent("levelKaufen",getLocalPlayer(),getLocalPlayer())
		
		setTimer(function()
			levelWindow()
		end,50,1)
	end)
	
	addEventHandler("onClientGUIClick",create_level.button[2],function()
		destroyElement(create_level.window[1])
		showCursor(false)
		setElementData(lp,"ElementClicked",false)
	end,false)
end

addCommandHandler("level",function()
	if(getElementData(lp,'ElementClicked')==false)then
		levelWindow()
	else
		infobox('Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!')
	end
end)