addEvent('MeeresreinigungWindow',true)
addEventHandler('MeeresreinigungWindow',root,function()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,'ElementClicked',true)
	
		MeeresreinigerWindow = guiCreateStaticImage(0.38, 0.01, 0.24, 0.14, "Images/Background.png", true)

		MeeresreinigerButtonEnter = guiCreateButton(0.20, 0.26, 0.59, 0.25, "Job starten", true, MeeresreinigerWindow)
		guiSetAlpha(MeeresreinigerButtonEnter, 1)
		MeeresreinigerButtonClose = guiCreateButton(0.20, 0.65, 0.59, 0.25, "Schließen", true, MeeresreinigerWindow)
		guiSetAlpha(MeeresreinigerButtonClose, 1)

		addEventHandler('onClientGUIClick', MeeresreinigerButtonClose, function()
			destroyElement(MeeresreinigerWindow)
			showCursor(false)
			setElementData(lp,'ElementClicked',false)
		end, false)

		addEventHandler('onClientGUIClick', MeeresreinigerButtonEnter, function()
			destroyElement(MeeresreinigerWindow)
			showCursor(false)
			setElementData(lp,'ElementClicked',false)
			triggerServerEvent('meeresReinigungStart',getLocalPlayer(),getLocalPlayer())
		end,false)
	else
		infobox('Es ist nicht möglich, mehrere\nFenser gleichzeitig zu öffnen!')
	end
end)

local meeresMarker 		 = false
local meeresBlip   	     = false
local meeresClean  	     = 0
local meeresCleanLastTen = 0
local isMeeresJobActiv   = false
local meeresX 			 = 0
local meeresY			 = 0
local meeresZ 			 = 0
local x,y				 = guiGetScreenSize()

addEvent('startMeeresJob',true)
addEventHandler('startMeeresJob',root,function()
	meeresMarker = createMarker(2499.8017578125,-2268.44140625,-0.16085433959961)
	
	addEventHandler('onClientMarkerHit',meeresMarker,function(player)
		if(player == localPlayer)then
			triggerServerEvent('payForCleanMeer',getLocalPlayer(),meeresClean)
			meeresClean = 0
			meeresCleanLastTen = 0
		end
	end)
	
	meeresBlip = createBlip(2499.8017578125,-2268.44140625,-0.16085433959961)
	
	meeresX,meeresY,meeresZ = getElementPosition(localPlayer)
	
	meeresClean = 0
	meeresCleanLastTen = 0
	
	outputChatBox('~~~~~ Meeresreiniger ~~~~~',255,255,255)
	outputChatBox('Fahre über das Meer, um dieses zu reinigen. Solltest',0,200,0)
	outputChatBox('du genug Dreck eingesammelt haben, kehre zurück zum',0,200,0)
	outputChatBox('Marker und gebe den Dreck ab.',0,200,0)
	
	isMeeresJobActiv = true
end)

addEvent('stopMeeresJob',true)
addEventHandler('stopMeeresJob',root,function()
	if(isElement(meeresBlip))then destroyElement(meeresBlip) end
	if(isElement(meeresMarker))then destroyElement(meeresMarker) end
	
	isMeeresJobActiv = false
end)

addEventHandler('onClientPlayerWasted',root,function()
	if(localPlayer == source)then
		meeresClean = 0
		
		if(isElement(meeresBlip))then destroyElement(meeresBlip) end
		if(isElement(meeresMarker))then destroyElement(meeresMarker) end
		
		isMeeresJobActiv = false
	end
end)

function startTimer_Meer()
	setTimer(startTimer_Meer,1000,1)
	
	if(isMeeresJobActiv and not(tonumber(getElementData(localPlayer,'AFK')==1)))then
		meeresXNew,meeresYNew,meeresZNew = getElementPosition(localPlayer)
		distance = getDistanceBetweenPoints3D(meeresXNew,meeresYNew,meeresZNew,meeresX,meeresY,meeresZ)
		
		meeresClean = meeresClean + (distance/2)
		meeresX,meeresY,meeresZ = meeresXNew,meeresYNew,meeresZNew
	end
end

addEventHandler('onClientResourceStart',getResourceRootElement(getThisResource()),function()
	startTimer_Meer()
end)

addEventHandler("onClientRender", root,function()
	if(isMeeresJobActiv)then
        dxDrawRectangle(1160*(x/1440), 489*(y/900), 270*(x/1440), 39*(y/900), tocolor(0, 0, 0, 150), false)
        dxDrawText("Eingesammelter Dreck:", 1160*(x/1440), 455*(y/900), 1374*(x/1440), 479*(y/900), tocolor(255, 255, 255, 255), 1.50, "default-bold", "left", "top", false, false, false, false,false)
        dxDrawText(math.floor(meeresClean).." Kilo", 1170*(x/1440), 499*(y/900), 1420*(x/1440), 518*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "top", false, false, false, false,false)
	end
end)