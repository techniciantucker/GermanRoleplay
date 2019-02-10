local x,y,z = 1363.7078857422,-1283.8206787109,13.546875

function Waffenschein()
	local px,py,pz = getElementPosition(lp)
	local dist = getDistanceBetweenPoints3D(px,py,pz,x,y,z)
	if(dist < 10) then
		local screenX,screenY = getScreenFromWorldPosition(x,y,z)
		if(screenX and screenY) then
			dxDrawText("Waffenschein",screenX,screenY,screenX,screenY,tocolor(255,255,255,255),1,"default-bold","center","center",false,false,true,true,false)
		end
	end
end
addEventHandler("onClientRender",root,Waffenschein)

addEvent("WaffenscheinWindow",true)
addEventHandler("WaffenscheinWindow",root,function()
	if(getElementData(lp,'ElementClicked')==false)then
		showCursor(true)
		setElementData(lp,'ElementClicked',true)
	
        Waffenschein = guiCreateStaticImage(0.36, 0.01, 0.31, 0.29, "Images/Background.png", true)

        WaffenscheinC = guiCreateButton(0.02, 0.84, 0.95, 0.12, "Waffenschein C kaufen | 50.000$", true, Waffenschein)
        WaffenscheinB = guiCreateButton(0.02, 0.68, 0.95, 0.12, "Waffenschein B kaufen | 30.000$", true, Waffenschein)
        WaffenscheinA = guiCreateButton(0.02, 0.52, 0.95, 0.12, "Waffenschein A kaufen | 10.000$", true, Waffenschein)
        WaffenscheinClose = guiCreateButton(0.86, 0.09, 0.12, 0.13, "[ X ]", true, Waffenschein)
        WaffenscheinInfo = guiCreateLabel(0.02, 0.09, 0.80, 0.30, "Wenn du LEGAL Waffen erwerben möchtest benötigst du für diese Scheine. Um einen Schein beantragen zu können benötigst du das Geld und keine Wanteds.", true, Waffenschein)
        guiSetFont(WaffenscheinInfo, "default-bold-small")
        guiLabelSetHorizontalAlign(WaffenscheinInfo, "center", true)
        guiLabelSetVerticalAlign(WaffenscheinInfo, "center")    
		
		addEventHandler('onClientGUIClick',WaffenscheinC,function()
			triggerServerEvent('waffenscheinc',getLocalPlayer(),getLocalPlayer())
		end,false)
		addEventHandler('onClientGUIClick',WaffenscheinB,function()
			triggerServerEvent('waffenscheinb',getLocalPlayer(),getLocalPlayer())
		end,false)
		addEventHandler('onClientGUIClick',WaffenscheinA,function()
			triggerServerEvent('waffenscheina',getLocalPlayer(),getLocalPlayer())
		end,false)
		addEventHandler('onClientGUIClick',WaffenscheinClose,function()
			destroyElement(Waffenschein)
			showCursor(false)
			setElementData(lp,'ElementClicked',false)
		end,false)
	else
		infobox("Es ist nicht möglich, mehrere\nFenster gleichzeitig zu öffnen!")
	end
end)