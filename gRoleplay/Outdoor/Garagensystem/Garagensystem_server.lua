Garagen = {}

local torxml = xmlLoadFile("Tore.xml")
local tore = xmlNodeGetChildren(torxml)
local count = 0
for i,node in ipairs(tore) do
    _G["GaragenTor"..tonumber(xmlNodeGetAttribute(node,"ID"))] = createObject(xmlNodeGetAttribute(node,"Modell"),xmlNodeGetAttribute(node,"X"),xmlNodeGetAttribute(node,"Y"),xmlNodeGetAttribute(node,"Z"),0,0,xmlNodeGetAttribute(node,"Rot"))
	setElementData(_G["GaragenTor"..tonumber(xmlNodeGetAttribute(node,"ID"))],"ID",xmlNodeGetAttribute(node,"ID"))
	setElementData(_G["GaragenTor"..tonumber(xmlNodeGetAttribute(node,"ID"))],"Ort",xmlNodeGetAttribute(node,"Ort"))
	setElementData(_G["GaragenTor"..tonumber(xmlNodeGetAttribute(node,"ID"))],"Preis",tonumber(xmlNodeGetAttribute(node,"Preis")))
	setElementData(_G["GaragenTor"..tonumber(xmlNodeGetAttribute(node,"ID"))],"Besitzer",xmlNodeGetAttribute(node,"Besitzer"))
	setElementData(_G["GaragenTor"..tonumber(xmlNodeGetAttribute(node,"ID"))],"Z",tonumber(xmlNodeGetAttribute(node,"Z")))
	Garagen[_G["GaragenTor"..tonumber(xmlNodeGetAttribute(node,"ID"))]]=true
	count = count + 1
	local col = createColSphere(xmlNodeGetAttribute(node,"X"),xmlNodeGetAttribute(node,"Y"),xmlNodeGetAttribute(node,"Z"),10)
	setElementData(col,"Tor",_G["GaragenTor"..tonumber(xmlNodeGetAttribute(node,"ID"))])
	addEventHandler("onColShapeHit",col,function ( player )
		local Gate = getElementData(source,"Tor")
		if getElementType(player) == "player" then
			if getPlayerName(player) == "Keiner" then return end
			if getElementData(Gate,"Besitzer") == getPlayerName(player) then
				local x,y,_ = getElementPosition(Gate)
				local z = getElementData(Gate,"Z")
				moveObject(Gate,2000,x,y,z-15)
			end
		end
	end)
	addEventHandler("onColShapeLeave",col,function ( player )
		local Gate = getElementData(source,"Tor")
		if getElementType(player) == "player" then
			if getPlayerName(player) == "Keiner" then return end
			if getElementData(Gate,"Besitzer") == getPlayerName(player) then
				local x,y,_ = getElementPosition(Gate)
				local z = getElementData(Gate,"Z")
				moveObject(Gate,2000,x,y,z)
			end
		end
	end)
end
outputServerLog("[Garagensystem] Es wurde(n) "..count.. " Garage gefunden!")
xmlUnloadFile(torxml)

function onGarageClick ( _1,_2,object )
	if Garagen[object] then
		triggerClientEvent(source,"showGaragenGUI",source,object)
		setElementData(source,"ElementClicked",true)
	end
end
addEventHandler("onPlayerClick",getRootElement(),onGarageClick)

addEvent("buyTor",true)
addEventHandler("buyTor",getRootElement(),function ( id)
	if getPlayerName(source) == "Keiner" then return end
	if getElementData(_G["GaragenTor"..id],"Besitzer") == "Keiner" then
		if westsideGetElementData(source,"money") >= getElementData(_G["GaragenTor"..id],"Preis") then
			setElementData(_G["GaragenTor"..id],"Besitzer",getPlayerName(source))
			local torxml = xmlLoadFile("Tore.xml")
			local tore = xmlNodeGetChildren(torxml)
			for i,node in ipairs(tore) do
				if tonumber(xmlNodeGetAttribute(node,"ID")) == tonumber(id) then
					xmlNodeSetAttribute(node,"Besitzer",getPlayerName(source))
				end
			end
			westsideSetElementData(source,"money",westsideGetElementData(source,"money") - tonumber(getElementData(_G["GaragenTor"..id],"Preis")) )
			setPlayerMoney(source,westsideGetElementData(source,"money"))
			xmlSaveFile(torxml)
			xmlUnloadFile(torxml)
			triggerClientEvent ( source, "infobox_start", getRootElement(), "Garage gekauft!", 4000, 0,255,0 )
		else
			triggerClientEvent ( source, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000, 255,0,0 )
		end
	else
		triggerClientEvent ( source, "infobox_start", getRootElement(), "Nicht möglich!", 4000, 255,0,0 )
	end
end)

addEvent("sellTor",true)
addEventHandler("sellTor",getRootElement(),function ( id)
	if getPlayerName(source) == "Keiner" then return end
	if getElementData(_G["GaragenTor"..id],"Besitzer") == getPlayerName(source) then
		setElementData(_G["GaragenTor"..id],"Besitzer","Keiner")
		local torxml = xmlLoadFile("Tore.xml")
		local tore = xmlNodeGetChildren(torxml)
		for i,node in ipairs(tore) do
			if tonumber(xmlNodeGetAttribute(node,"ID")) == tonumber(id) then
				xmlNodeSetAttribute(node,"Besitzer","Keiner")
			end
		end
		xmlSaveFile(torxml)
		xmlUnloadFile(torxml)
		westsideSetElementData(source,"money",westsideGetElementData(source,"money") + tonumber(getElementData(_G["GaragenTor"..id],"Preis")) )
		setPlayerMoney(source,westsideGetElementData(source,"money"))
		triggerClientEvent ( source, "infobox_start", getRootElement(), "Garage verkauft!", 4000, 0,255,0)
	else
		triggerClientEvent ( source, "infobox_start", getRootElement(), "Nicht möglich!", 4000, 255,0,0 )
	end
end)

addEvent("closeTor",true)
addEventHandler("closeTor",getRootElement(),function ( id)
	if getPlayerName(source) == "Keiner" then return end
	if getElementData(_G["GaragenTor"..id],"Besitzer") == getPlayerName(source) then
		if getElementData(_G["GaragenTor"..id],"Open") == true then
			local x,y,_ = getElementPosition(_G["GaragenTor"..id])
			local z = getElementData(_G["GaragenTor"..id],"Z")
			moveObject(_G["GaragenTor"..id],2000,x,y,z)
			setElementData(_G["GaragenTor"..id],"Open",false)
		else
			triggerClientEvent ( source, "infobox_start", getRootElement(), "Das Tor ist bereits zu!", 4000, 255,0,0 )
		end
	else
		triggerClientEvent ( source, "infobox_start", getRootElement(), "Nicht möglich!", 4000, 255,0,0 )
	end
end)