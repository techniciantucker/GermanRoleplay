local x,y=guiGetScreenSize()
local pl={}
local scroll=0
local updateTimer
local player=getLocalPlayer()
local alpha=0
local maxplayers=40

local fraktionNames={
[0]='Zivilist',
[1]='Police',
[2]='Brigada',
[3]='Triaden',
[4]='Cali Kartell',
[5]='Reporter',
[6]='F.B.I',
[7]='Grove Street',
[8]='Army',
[9]='Dillimore Devils',
[10]='Mechaniker'
}

local unternehmenNames={
[0]='- Keins -',
[1]='Fahrschule',
[2]='Anwaltskanzlei',
[3]='Detektei'
}

local adminNames={
[0]='Spieler',
[1]='Ticketbeauftragter',
[2]='Supporter',
[3]='Moderator',
[4]='Administrator',
[5]='Servermanager',
[6]='Stellv. Projektleiter',
[7]='Projektleiter'
}

function isCursorOnElement(x,y,w,h)
	if isCursorShowing() then
		local mx,my = getCursorPosition ()
		local fullx,fully = guiGetScreenSize()
		cursorx,cursory = mx*fullx,my*fully
		if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
			return true
		else
			return false
		end
	end
end

function getFraktionMembersOnline(fraktionid)
	local online=0
	for _,p in pairs(getElementsByType("player"))do 
		if(getElementData(p,"fraktion")==fraktionid)then
			online=online+1
		end
	end
	return online
end

function getUnternehmenMembersOnline(unternehmenid)
	local uonline=0
	for _,p in pairs(getElementsByType('player'))do
		if(getElementData(p,'unternehmen')==unternehmenid)then
			uonline=uonline+1
		end
	end
	return uonline
end

bindKey('tab','down',function()
	if(getElementData(lp,'loggedin')==1)and(getElementData(lp,'isInTut')==false)and(getElementData(lp,'ElementClicked')==false)then
		setPlayerHudComponentVisible('radar', false)
		setElementData(lp,'inScoreboard',true)
		addEventHandler('onClientRender',root,drawScoreboard)
		updateScoreboard()
		if(isTimer(updateTimer))then
			killTimer(updateTimer)
		end
		updateTimer=setTimer(updateScoreboard,10000,0)
		bindKey('mouse_wheel_down','down',scrollDown)
		bindKey('mouse_wheel_up','down',scrollUp)
		toggleControl('next_weapon',false)
		toggleControl('previous_weapon',false)
		toggleControl('fire',false)
		alpha=0
	end
end)

bindKey('tab','up',function()
	setPlayerHudComponentVisible('radar', true)
	setElementData(lp,'inScoreboard',false)
	unbindKey('mouse_wheel_down','down',scrollDown)
	unbindKey('mouse_wheel_up','down',scrollUp)
	removeEventHandler('onClientRender',root,drawScoreboard)
	toggleControl('next_weapon',true)
	toggleControl('previous_weapon',true)
	toggleControl('fire',true)
	alpha=0
end)

function scrollDown()
	if(#getElementsByType('player')-scroll<=2)then
		scroll=#getElementsByType('player')
	else
		scroll=scroll+2
	end
end

function scrollUp()
	if(scroll<=2)then
		scroll=0
	else
		scrol=scroll-2
	end
end

function formString(text)
	if(string.len(text)==1)then
		text='0'..text
	end
	return text
end

function updateScoreboard()
	pl={}
	local i=1
	for id,p in pairs(getElementsByType('player'))do
		local name=getPlayerName(p)
		name=string.gsub(name,'#%x%x%x%x%x%x','')
		local spielzeit='-'
		local nr='-'
		local ping=getPlayerPing(p)
		local color={255,255,255}
		local fname='-'
		local frak=0
		local status='-'
		local r,g,b=255,255,255
		local job='-'
		local telenr='-'
		local uname='-'
		local unternehm=0
		
		if(getElementData(p,'loggedin')==1)then
			nr=tostring(getElementData(p,'telenr'))
			local ptime=tonumber(getElementData(p,'playingtime'))
			local hour=math.floor(ptime/60)
			local minute=ptime-hour*60
			spielzeit=formString(hour)..':'..formString(minute)
			local fac=tonumber(getElementData(p,'fraktion'))
			frak=fac
			local unternehmen=tonumber(getElementData(p,'unternehmen'))
			unternehm=unternehmen
			local adminlvl=tonumber(getElementData(p,'adminlvl'))
			admin=adminlvl
			local viplevel=tonumber(getElementData(p,'vip'))
			if(adminlvl==0)then
				if(viplevel==1)then
					admin='Vip Level 1'
				elseif(viplevel==2)then
					admin='Vip Level 2'
				elseif(viplevel==3)then
					admin='Vip Level 3'
				elseif(viplevel==4)then
					admin='Vip Level 4'
				end
			end
			local job=getElementData(p,'job')
			if(job=='none')then
				job='Arbeitslos'
			end
			r,g,b=factionColors[fac][1],factionColors[fac][2],factionColors[fac][3]
			local status=getElementData(p,'socialState')
			if(status=='Neu auf Ger-Roleplay')then
				status='Neuling'
			end
			if(getElementData(p,'adminlvl'))then
				if(getElementData(p,'adminlvl')>0)then
					name='[gR]'..name
				end
			end
			pl[i]={}
			pl[i].telenr=nr
			pl[i].name=name
			pl[i].spielzeit=spielzeit
			pl[i].ping=ping
			pl[i].color=color
			pl[i].frak=frak
			pl[i].admin=admin
			pl[i].job=job
			pl[i].unternehm=unternehm
			pl[i].status=status
			pl[i].r=r
			pl[i].g=g
			pl[i].b=b
			i=i+1
		end
		table.sort(pl,function(a,b)
			return a.frak<b.frak
		end)
	end
end

function getPingColor(ping)
	if(ping>100)then
		return 150,150,150
	elseif(ping<100)then
		return 20,200,20
	else
		return 200,20,20
	end
end

function drawScoreboard()
	alpha = 255

	-- Hintergrund
	dxDrawRectangle(317*(x/1440), 245*(y/900), 793*(x/1440), 399*(y/900), tocolor(0, 0, 0, 200), false)
    dxDrawRectangle(219*(x/1440), 245*(y/900), 98*(x/1440), 399*(y/900), tocolor(0, 0, 0, 200), false)
	-- Linien
    dxDrawLine(316*(x/1440), 245*(y/900), 316*(x/1440), 644*(y/900), tocolor(255, 255, 255, 255), 1, false)
    dxDrawLine(220*(x/1440), 270*(y/900), 317*(x/1440), 270*(y/900), tocolor(255, 255, 255, 255), 1, false)
    dxDrawLine(220*(x/1440), 551*(y/900), 317*(x/1440), 551*(y/900), tocolor(255, 255, 255, 255), 1, false)
    dxDrawLine(316*(x/1440), 270*(y/900), 1111*(x/1440), 270*(y/900), tocolor(255, 255, 255, 255), 1, false)
    dxDrawLine(317*(x/1440), 574*(y/900), 1112*(x/1440), 574*(y/900), tocolor(255, 255, 255, 255), 1, false)
	dxDrawLine(317*(x/1440), 551*(y/900), 1112*(x/1440), 551*(y/900), tocolor(255, 255, 255, 255), 1, false)
	dxDrawLine(457*(x/1440), 246*(y/900), 457*(x/1440), 551*(y/900), tocolor(255, 255, 255, 255), 1, false)
	dxDrawLine(562*(x/1440), 245*(y/900), 562*(x/1440), 550*(y/900), tocolor(255, 255, 255, 255), 1, false)
	dxDrawLine(663*(x/1440), 246*(y/900), 663*(x/1440), 551*(y/900), tocolor(255, 255, 255, 255), 1, false)
	dxDrawLine(817*(x/1440), 246*(y/900), 817*(x/1440), 551*(y/900), tocolor(255, 255, 255, 255), 1, false)
	dxDrawLine(893*(x/1440), 246*(y/900), 893*(x/1440), 551*(y/900), tocolor(255, 255, 255, 255), 1, false)
	dxDrawLine(1023*(x/1440), 245*(y/900), 1023*(x/1440), 550*(y/900), tocolor(255, 255, 255, 255), 1, false)
	-- Obrige Informationen
	dxDrawText("Spielzeit", 229*(x/1440), 250*(y/900), 307*(x/1440), 265*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
	dxDrawText("Username", 326*(x/1440), 250*(y/900), 394*(x/1440), 267*(y/900), tocolor(255, 255, 255, 200), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText("Fraktion", 467*(x/1440), 250*(y/900), 535*(x/1440), 267*(y/900), tocolor(255, 255, 255, 200), 1.00, "default-bold", "left", "top", false, false, false, false, false)
	dxDrawText("Unternehmen", 572*(x/1440), 249*(y/900), 653*(x/1440), 265*(y/900), tocolor(255, 255, 255, 200), 1.00, "default-bold", "left", "top", false, false, false, false, false)
	dxDrawText("Status", 673*(x/1440), 249*(y/900), 713*(x/1440), 265*(y/900), tocolor(255, 255, 255, 200), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText("Nummer", 827*(x/1440), 249*(y/900), 883*(x/1440), 265*(y/900), tocolor(255, 255, 255, 200), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText("Information", 903*(x/1440), 249*(y/900), 1015*(x/1440), 265*(y/900), tocolor(255, 255, 255, 200), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText("Ping", 1033*(x/1440), 249*(y/900), 1089*(x/1440), 265*(y/900), tocolor(255, 255, 255, 200), 1.00, "default-bold", "left", "top", false, false, false, false, false)
	-- Fraktionen
	dxDrawText("Staatsfraktionen", 319*(x/1440), 556*(y/900), 478*(x/1440), 572*(y/900), tocolor(255, 255, 255, 200), 1.00, "default-bold", "left", "top", false, false, false, false, false)
	dxDrawText("Neutrale Fraktionen", 488*(x/1440), 556*(y/900), 601*(x/1440), 572*(y/900), tocolor(255, 255, 255, 200), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText("Gangs", 611*(x/1440), 556*(y/900), 649*(x/1440), 572*(y/900), tocolor(255, 255, 255, 200), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText("Unternehmen", 831*(x/1440), 556*(y/900), 915*(x/1440), 572*(y/900), tocolor(255, 255, 255, 200), 1.00, "default-bold", "left", "top", false, false, false, false, false)
	-- Bild
	dxDrawImage(512*(x/1440), 138*(y/900), 418*(x/1440), 97*(y/900), "Images/Logo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	
    dxDrawText(#getElementsByType("player")..' Spieler online', 1004*(x/1440), 624*(y/900), 1100*(x/1440), 640*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
	
    dxDrawText("Fahrschule: "..getUnternehmenMembersOnline(1), 831*(x/1440), 582*(y/900), 936*(x/1440), 598*(y/900), tocolor(118, 120, 3, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText("Anwaltskanzlei: "..getUnternehmenMembersOnline(2), 831*(x/1440), 603*(y/900), 936*(x/1440), 619*(y/900), tocolor(109, 12, 39, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText("Detektei: "..getUnternehmenMembersOnline(3), 831*(x/1440), 624*(y/900), 936*(x/1440), 640*(y/900), tocolor(45, 121, 0, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
	
    dxDrawText("Police Department: "..getFraktionMembersOnline(1), 319*(x/1440), 582*(y/900), 447*(x/1440), 597*(y/900), tocolor(0, 200, 0, 200), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText("Brigada: "..getFraktionMembersOnline(2), 611*(x/1440), 603*(y/900), 716*(x/1440), 619*(y/900), tocolor(100, 100, 100, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText("Triaden: "..getFraktionMembersOnline(3), 611*(x/1440), 582*(y/900), 716*(x/1440), 598*(y/900), tocolor(18, 67, 193, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText("Cali Kartell: "..getFraktionMembersOnline(4), 611*(x/1440), 624*(y/900), 716*(x/1440), 640*(y/900), tocolor(224, 122, 59, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
	dxDrawText("Reporter: "..getFraktionMembersOnline(5), 488*(x/1440), 603*(y/900), 601*(x/1440), 619*(y/900), tocolor(250, 150, 0, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText("FBI: "..getFraktionMembersOnline(6), 319*(x/1440), 603*(y/900), 447*(x/1440), 619*(y/900), tocolor(51, 59, 229, 200), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText("Grove Street: "..getFraktionMembersOnline(7), 716*(x/1440), 582*(y/900), 821*(x/1440), 598*(y/900), tocolor(0, 125, 0, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText("Army: "..getFraktionMembersOnline(8), 319*(x/1440), 624*(y/900), 447*(x/1440), 639*(y/900), tocolor(0, 255, 0, 200), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText("Dillimore Devils: "..getFraktionMembersOnline(9), 716*(x/1440), 603*(y/900), 821*(x/1440), 619*(y/900), tocolor(112, 38, 12, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText("Mechaniker: "..getFraktionMembersOnline(10), 488*(x/1440), 582*(y/900), 601*(x/1440), 598*(y/900), tocolor(205, 132, 141, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText("Level: "..getElementData(lp,'level'), 230*(x/1440), 583*(y/900), 307*(x/1440), 603*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false,false, false, false)
	di=1
	for i=1+scroll,13+scroll do
		if(pl[i])then
			dxDrawText(pl[i].name, 326*(x/1440), 265*(y/900)+(13*di)+4, 394*(x/1440), 267*(y/900)+(13*di)+4,tocolor(pl[i].r,pl[i].g,pl[i].b,alpha), 1.00, "default-bold", "left", "top", false, false, false, false, false)
			dxDrawText(fraktionNames[pl[i].frak], 467*(x/1440), 265*(y/900)+(13*di)+4, 535*(x/1440), 267*(y/900)+(13*di)+4, tocolor(pl[i].r,pl[i].g,pl[i].b,alpha), 1.00, "default-bold", "left", "top", false, false, false, false, false)
			dxDrawText(unternehmenNames[pl[i].unternehm], 572*(x/1440), 265*(y/900)+(13*di)+4, 653*(x/1440), 265*(y/900)+(13*di)+4, tocolor(pl[i].r,pl[i].g,pl[i].b,alpha), 1.00, "default-bold", "left", "top", false, false, false, false, false)
			dxDrawText(pl[i].status, 673*(x/1440), 265*(y/900)+(13*di)+4, 713*(x/1440), 265*(y/900)+(13*di)+4,tocolor(pl[i].r,pl[i].g,pl[i].b,alpha), 1.00, "default-bold", "left", "top", false, false, false, false, false)
			dxDrawText(pl[i].telenr, 827*(x/1440), 265*(y/900)+(13*di)+4, 883*(x/1440), 265*(y/900)+(13*di)+4,tocolor(pl[i].r,pl[i].g,pl[i].b,alpha), 1.00, "default-bold", "left", "top", false, false, false, false, false)
			dxDrawText(adminNames[pl[i].admin], 903*(x/1440), 265*(y/900)+(13*di)+4, 1015*(x/1440), 265*(y/900)+(13*di)+4,tocolor(pl[i].r,pl[i].g,pl[i].b,alpha), 1.00, "default-bold", "left", "top", false, false, false, false, false)
			dxDrawText(pl[i].ping, 1033*(x/1440), 265*(y/900)+(13*di)+4, 1089*(x/1440), 265*(y/900)+(13*di)+4,tocolor(pl[i].r,pl[i].g,pl[i].b,alpha), 1.00, "default-bold", "left", "top", false, false, false, false, false)
			dxDrawText(pl[i].spielzeit, 229*(x/1440), 265*(y/900)+(13*di)+4, 307*(x/1440), 265*(y/900)+(13*di)+4,tocolor(pl[i].r,pl[i].g,pl[i].b,alpha), 1.00, "default-bold", "left", "top", false,false, false, false, false)
			di=di+1
		end
	end
end