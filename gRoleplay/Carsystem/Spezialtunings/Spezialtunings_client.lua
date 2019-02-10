local screenx, screeny = guiGetScreenSize()
local valx, valy = screenx/1366, screeny/768

tieferlegungen = {
	[400] =	"1|1|1|1|0|0|0|0|0",
	[401] =	"1|1|0|0|0|0|0|0|0",
	[402] =	"1|1|1|0|0|0|0|0|0",
	[403] =	"0|0|0|0|0|0|0|0|0",
	[404] =	"1|1|0|0|0|0|0|0|0",
	[405] =	"1|1|0|0|0|0|0|0|0",
	[406] =	"0|0|0|0|0|0|0|0|0",
	[407] =	"0|0|0|0|0|0|0|0|0",
	[408] =	"0|0|0|0|0|0|0|0|0",
	[409] =	"1|0|0|0|0|0|0|0|0",
	[410] =	"1|1|0|0|0|0|0|0|0",
	[411] =	"1|1|0|0|0|0|0|0|0",
	[412] =	"1|1|1|0|0|0|0|0|0",
	[413] =	"1|1|1|0|0|0|0|0|0",
	[414] =	"0|0|0|0|0|0|0|0|0",
	[415] =	"1|1|0|0|0|0|0|0|0",
	[416] =	"0|0|0|0|0|0|0|0|0",
	[417] =	"0|0|0|0|0|0|0|0|0",
	[418] =	"1|1|1|0|0|0|0|0|0",
	[419] =	"1|1|1|0|0|0|0|0|0",
	[420] =	"0|0|0|0|0|0|0|0|0",
	[421] =	"1|1|1|0|0|0|0|0|0",
	[422] =	"1|1|1|0|0|0|0|0|0",
	[423] =	"0|0|0|0|0|0|0|0|0",
	[424] =	"1|0|0|0|0|0|0|0|0",
	[425] =	"0|0|0|0|0|0|0|0|0",
	[426] =	"1|1|1|0|0|0|0|0|0",
	[427] =	"0|0|0|0|0|0|0|0|0",
	[428] =	"0|0|0|0|0|0|0|0|0",
	[429] =	"1|1|0|0|0|0|0|0|0",
	[430] =	"0|0|0|0|0|0|0|0|0",
	[431] =	"0|0|0|0|0|0|0|0|0",
	[432] =	"0|0|0|0|0|0|0|0|0",
	[433] =	"0|0|0|0|0|0|0|0|0",
	[434] =	"1|1|0|0|0|0|0|0|0",
	[435] =	"0|0|0|0|0|0|0|0|0",
	[436] =	"1|1|0|0|0|0|0|0|0",
	[437] =	"0|0|0|0|0|0|0|0|0",
	[438] =	"0|0|0|0|0|0|0|0|0",
	[439] =	"1|1|1|0|0|0|0|0|0",
	[440] =	"1|0|0|0|0|0|0|0|0",
	[441] =	"0|0|0|0|0|0|0|0|0",
	[442] =	"1|1|0|0|0|0|0|0|0",
	[443] =	"0|0|0|0|0|0|0|0|0",
	[444] =	"0|0|0|0|0|0|0|0|0",
	[445] =	"1|1|1|0|0|0|0|0|0",
	[446] =	"0|0|0|0|0|0|0|0|0",
	[447] =	"0|0|0|0|0|0|0|0|0",
	[448] =	"0|0|0|0|0|0|0|0|0",
	[449] =	"0|0|0|0|0|0|0|0|0",
	[450] =	"0|0|0|0|0|0|0|0|0",
	[451] =	"1|1|0|0|0|0|0|0|0",
	[452] =	"0|0|0|0|0|0|0|0|0",
	[453] =	"0|0|0|0|0|0|0|0|0",
	[454] =	"0|0|0|0|0|0|0|0|0",
	[455] =	"0|0|0|0|0|0|0|0|0",
	[456] =	"0|0|0|0|0|0|0|0|0",
	[457] =	"1|0|0|0|0|0|0|0|0",
	[458] =	"1|1|0|0|0|0|0|0|0",
	[459] =	"1|1|1|0|0|0|0|0|0",
	[460] =	"0|0|0|0|0|0|0|0|0",
	[461] =	"0|0|0|0|0|0|0|0|0",
	[462] =	"0|0|0|0|0|0|0|0|0",
	[463] =	"0|0|0|0|0|0|0|0|0",
	[464] =	"0|0|0|0|0|0|0|0|0",
	[465] =	"0|0|0|0|0|0|0|0|0",
	[466] =	"1|1|1|0|0|0|0|0|0",
	[467] =	"1|1|1|0|0|0|0|0|0",
	[468] =	"0|0|0|0|0|0|0|0|0",
	[469] =	"0|0|0|0|0|0|0|0|0",
	[470] =	"0|0|0|0|0|0|0|0|0",
	[471] =	"0|0|0|0|0|0|0|0|0",
	[472] =	"0|0|0|0|0|0|0|0|0",
	[473] =	"0|0|0|0|0|0|0|0|0",
	[474] =	"1|1|1|0|0|0|0|0|0",
	[475] =	"1|1|1|0|0|0|0|0|0",
	[476] =	"0|0|0|0|0|0|0|0|0",
	[477] =	"1|1|0|0|0|0|0|0|0",
	[478] =	"1|1|1|1|0|0|0|0|0",
	[479] =	"1|1|1|0|0|0|0|0|0",
	[480] =	"1|1|1|0|0|0|0|0|0",
	[481] =	"0|0|0|0|0|0|0|0|0",
	[482] =	"1|1|1|1|0|0|0|0|0",
	[483] =	"1|0|0|0|0|0|0|0|0",
	[484] =	"0|0|0|0|0|0|0|0|0",
	[485] =	"0|0|0|0|0|0|0|0|0",
	[486] =	"0|0|0|0|0|0|0|0|0",
	[487] =	"0|0|0|0|0|0|0|0|0",
	[488] =	"0|0|0|0|0|0|0|0|0",
	[489] =	"1|1|1|1|1|0|0|0|0",
	[490] =	"0|0|0|0|0|0|0|0|0",
	[491] =	"1|1|1|0|0|0|0|0|0",
	[492] =	"1|1|1|0|0|0|0|0|0",
	[493] =	"0|0|0|0|0|0|0|0|0",
	[494] =	"1|1|1|0|0|0|0|0|0",
	[495] =	"1|1|1|0|0|0|0|0|0",
	[496] =	"1|1|0|0|0|0|0|0|0",
	[497] =	"0|0|0|0|0|0|0|0|0",
	[498] =	"0|0|0|0|0|0|0|0|0",
	[499] =	"0|0|0|0|0|0|0|0|0",
	[500] =	"1|1|1|0|0|0|0|0|0",
	[501] =	"0|0|0|0|0|0|0|0|0",
	[502] =	"1|1|1|0|0|0|0|0|0",
	[503] =	"1|1|1|0|0|0|0|0|0",
	[504] =	"1|1|1|0|0|0|0|0|0",
	[505] =	"1|1|1|1|1|0|0|0|0",
	[506] =	"1|1|0|0|0|0|0|0|0",
	[507] =	"1|1|1|0|0|0|0|0|0",
	[508] =	"0|0|0|0|0|0|0|0|0",
	[509] =	"0|0|0|0|0|0|0|0|0",
	[510] =	"0|0|0|0|0|0|0|0|0",
	[511] =	"0|0|0|0|0|0|0|0|0",
	[512] =	"0|0|0|0|0|0|0|0|0",
	[513] =	"0|0|0|0|0|0|0|0|0",
	[514] =	"0|0|0|0|0|0|0|0|0",
	[515] =	"0|0|0|0|0|0|0|0|0",
	[516] =	"1|1|0|0|0|0|0|0|0",
	[517] =	"1|1|0|0|0|0|0|0|0",
	[518] =	"1|1|0|0|0|0|0|0|0",
	[519] =	"0|0|0|0|0|0|0|0|0",
	[520] =	"0|0|0|0|0|0|0|0|0",
	[521] =	"0|0|0|0|0|0|0|0|0",
	[522] =	"0|0|0|0|0|0|0|0|0",
	[523] =	"0|0|0|0|0|0|0|0|0",
	[524] =	"0|0|0|0|0|0|0|0|0",
	[525] =	"0|0|0|0|0|0|0|0|0",
	[526] =	"1|1|0|0|0|0|0|0|0",
	[527] =	"1|1|0|0|0|0|0|0|0",
	[528] =	"0|0|0|0|0|0|0|0|0",
	[529] =	"1|1|0|0|0|0|0|0|0",
	[530] =	"0|0|0|0|0|0|0|0|0",
	[531] =	"0|0|0|0|0|0|0|0|0",
	[532] =	"0|0|0|0|0|0|0|0|0",
	[533] =	"1|1|0|0|0|0|0|0|0",
	[534] =	"1|1|0|0|0|0|0|0|0",
	[535] =	"1|1|0|0|0|0|0|0|0",
	[536] =	"1|1|0|0|0|0|0|0|0",
	[537] =	"0|0|0|0|0|0|0|0|0",
	[538] =	"0|0|0|0|0|0|0|0|0",
	[539] =	"0|0|0|0|0|0|0|0|0",
	[540] =	"1|1|1|0|0|0|0|0|0",
	[541] =	"1|1|0|0|0|0|0|0|0",
	[542] =	"1|1|1|0|0|0|0|0|0",
	[543] =	"1|1|1|0|0|0|0|0|0",
	[544] =	"0|0|0|0|0|0|0|0|0",
	[545] =	"1|1|0|0|0|0|0|0|0",
	[546] =	"1|1|0|0|0|0|0|0|0",
	[547] =	"1|1|0|0|0|0|0|0|0",
	[548] =	"0|0|0|0|0|0|0|0|0",
	[549] =	"1|1|1|0|0|0|0|0|0",
	[550] =	"1|1|0|0|0|0|0|0|0",
	[551] =	"1|1|1|0|0|0|0|0|0",
	[552] =	"0|0|0|0|0|0|0|0|0",
	[553] =	"0|0|0|0|0|0|0|0|0",
	[554] =	"1|1|1|1|1|0|0|0|0",
	[555] =	"1|1|0|0|0|0|0|0|0",
	[556] =	"0|0|0|0|0|0|0|0|0",
	[557] =	"0|0|0|0|0|0|0|0|0",
	[558] =	"1|1|0|0|0|0|0|0|0",
	[559] =	"1|1|0|0|0|0|0|0|0",
	[560] =	"1|1|1|0|0|0|0|0|0",
	[561] =	"1|1|0|0|0|0|0|0|0",
	[562] =	"1|1|0|0|0|0|0|0|0",
	[563] =	"0|0|0|0|0|0|0|0|0",
	[564] =	"0|0|0|0|0|0|0|0|0",
	[565] =	"1|1|0|0|0|0|0|0|0",
	[566] =	"1|1|1|0|0|0|0|0|0",
	[567] =	"1|1|1|0|0|0|0|0|0",
	[568] =	"1|1|1|1|0|0|0|0|0",
	[569] =	"0|0|0|0|0|0|0|0|0",
	[570] =	"0|0|0|0|0|0|0|0|0",
	[571] =	"0|0|0|0|0|0|0|0|0",
	[572] =	"1|0|0|0|0|0|0|0|0",
	[573] =	"0|0|0|0|0|0|0|0|0",
	[574] =	"0|0|0|0|0|0|0|0|0",
	[575] =	"1|1|1|0|0|0|0|0|0",
	[576] =	"1|1|0|0|0|0|0|0|0",
	[577] =	"0|0|0|0|0|0|0|0|0",
	[578] =	"0|0|0|0|0|0|0|0|0",
	[579] =	"1|1|0|0|0|0|0|0|0",
	[580] =	"1|1|1|0|0|0|0|0|0",
	[581] =	"0|0|0|0|0|0|0|0|0",
	[582] =	"0|0|0|0|0|0|0|0|0",
	[583] =	"0|0|0|0|0|0|0|0|0",
	[584] =	"0|0|0|0|0|0|0|0|0",
	[585] =	"1|0|0|0|0|0|0|0|0",
	[586] =	"0|0|0|0|0|0|0|0|0",
	[587] =	"1|1|0|0|0|0|0|0|0",
	[588] =	"0|0|0|0|0|0|0|0|0",
	[589] =	"1|1|0|0|0|0|0|0|0",
	[590] =	"0|0|0|0|0|0|0|0|0",
	[591] =	"0|0|0|0|0|0|0|0|0",
	[592] =	"0|0|0|0|0|0|0|0|0",
	[593] =	"0|0|0|0|0|0|0|0|0",
	[594] =	"0|0|0|0|0|0|0|0|0",
	[595] =	"0|0|0|0|0|0|0|0|0",
	[596] =	"0|0|0|0|0|0|0|0|0",
	[597] =	"0|0|0|0|0|0|0|0|0",
	[598] =	"0|0|0|0|0|0|0|0|0",
	[599] =	"0|0|0|0|0|0|0|0|0",
	[600] =	"1|1|0|0|0|0|0|0|0",
	[601] =	"0|0|0|0|0|0|0|0|0",
	[602] =	"1|1|1|0|0|0|0|0|0",
	[603] =	"1|1|1|0|0|0|0|0|0",
	[604] =	"0|0|0|0|0|0|0|0|0",
	[605] =	"0|0|0|0|0|0|0|0|0",
	[606] =	"0|0|0|0|0|0|0|0|0",
	[607] =	"0|0|0|0|0|0|0|0|0",
	[608] =	"0|0|0|0|0|0|0|0|0",
	[609] =	"0|0|0|0|0|0|0|0|0",
	[610] =	"0|0|0|0|0|0|0|0|0",
	[611] =	"0|0|0|0|0|0|0|0|0"
}

sb1 = guiCreateScrollBar(392*valx, 528*valy, 574*valx, 19*valy, true, false)
guiSetAlpha(sb1, 0.00)
sb2 = guiCreateScrollBar(970*valx, 240*valy, 18*valx, 288*valy, false, false)
guiSetAlpha(sb2, 0.00)    

csb1 = guiCreateButton(902*valx, 732*valy, 119*valx, 30*valy, "190", false)
csb2 = guiCreateButton(763*valx, 732*valy, 119*valx, 30*valy, "190", false)
csb3 = guiCreateButton(627*valx, 732*valy, 119*valx, 30*valy, "190", false)
csb4 = guiCreateButton(487*valx, 732*valy, 119*valx, 30*valy, "190", false)
csb5 = guiCreateButton(348*valx, 732*valy, 119*valx, 30*valy, "190", false)
csb6 = guiCreateButton(161*valx, 464*valy, 119*valx, 30*valy, "190", false)
csb7 = guiCreateButton(161*valx, 309*valy, 119*valx, 30*valy, "190", false)
csb8 = guiCreateButton(902*valx, 577*valy, 119*valx, 30*valy, "190", false)
csb9 = guiCreateButton(763*valx, 577*valy, 119*valx, 30*valy, "190", false)
csb10 = guiCreateButton(627*valx, 577*valy, 119*valx, 30*valy, "190", false)
csb11 = guiCreateButton(487*valx, 577*valy, 119*valx, 30*valy, "190", false)
csb12 = guiCreateButton(348*valx, 577*valy, 119*valx, 30*valy, "190", false)
csb13 = guiCreateButton(161*valx, 157*valy, 119*valx, 30*valy, "190", false)
csb14 = guiCreateButton((1366-55)*valx, 5*valy, 50*valx, 50*valy, "190", false)
csb15 = guiCreateButton(1038*valx, 221*valy, 60*valx, 60*valy, "", false)
csb16 = guiCreateButton(1260*valx, 221*valy, 60*valx, 60*valy, "", false)
csb17 = guiCreateButton(1186*valx, 221*valy, 60*valx, 60*valy, "", false)
csb18 = guiCreateButton(1112*valx, 221*valy, 60*valx, 60*valy, "", false)
csb19 = guiCreateButton(1200*valx, 554*valy, 119*valx, 30*valy, "190", false)

local x
local y
local z
local asdx
local xp
local yp
local orangebox_X = 1038
local orangebox_Y = 221
local FAR, FAG, FAB, FBR, FBG, FBB, FCR, FCG, FCB, FDR, FDG, FDB
local currentBox = 1
local this1
local this2
local this3
local mehrspeed1
local mehrspeed2
local mehrspeed3
local mehrbesch1
local mehrbesch2
local mehrbesch3
local mehrtarge1
local mehrtarge2
local mehrtarge3
local csinfotext
local csinfor
local csinfog
local csinfob
local sw, sh = guiGetScreenSize()

function rgb2hsv(r, g, b)
  r, g, b = r/255, g/255, b/255
  local max, min = math.max(r, g, b), math.min(r, g, b)
  local h, s 
  local v = max
  local d = max - min
  s = max == 0 and 0 or d/max
  if max == min then 
    h = 0
  elseif max == r then 
    h = (g - b) / d + (g < b and 6 or 0)
  elseif max == g then 
    h = (b - r) / d + 2
  elseif max == b then 
    h = (r - g) / d + 4
  end
  h = h/6
  return h, s, v
end

function hsv2rgb(h, s, v)
  local r, g, b
  local i = math.floor(h * 6)
  local f = h * 6 - i
  local p = v * (1 - s)
  local q = v * (1 - f * s)
  local t = v * (1 - (1 - f) * s)
  local switch = i % 6
  if switch == 0 then
    r = v g = t b = p
  elseif switch == 1 then
    r = q g = v b = p
  elseif switch == 2 then
    r = p g = v b = t
  elseif switch == 3 then
    r = p g = q b = v
  elseif switch == 4 then
    r = t g = p b = v
  elseif switch == 5 then
    r = v g = p b = q
  end
  return math.floor(r*255), math.floor(g*255), math.floor(b*255)
end

function drawcsinfo ()
	dxDrawRectangle(394*valx, 153*valy, 572*valx, 39*valy, tocolor(csinfor, csinfog, csinfob, 255), true)
	dxDrawText(csinfotext, 395*valx, 154*valy, 967*valx, 193*valy, tocolor(0, 0, 0, 255), 1.50*valx, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText(csinfotext, 395*valx, 152*valy, 967*valx, 191*valy, tocolor(0, 0, 0, 255), 1.50*valx, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText(csinfotext, 393*valx, 154*valy, 965*valx, 193*valy, tocolor(0, 0, 0, 255), 1.50*valx, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText(csinfotext, 393*valx, 152*valy, 965*valx, 191*valy, tocolor(0, 0, 0, 255), 1.50*valx, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText(csinfotext, 394*valx, 153*valy, 966*valx, 192*valy, tocolor(255, 255, 255, 255), 1.50*valx, "default-bold", "center", "center", false, false, true, false, false)
end

function showcsinfo (text, r, g, b)
	csinfotext = text
	csinfor = r
	csinfog = g
	csinfob = b
	if isTimer(csinfotimer) then
		killTimer(csinfotimer)
	else
		addEventHandler("onClientRender", root, drawcsinfo)
	end
	csinfotimer = setTimer( function()
		removeEventHandler("onClientRender", root, drawcsinfo)
	end, 2500, 1)
	setVehicleEngineState(getPedOccupiedVehicle( lp ), true)
	drawNos = true
	destroyElement(svmap)
	destroyElement(hbar)
	destroyElement(Blank)
	--removeEventHandler("onClientGUIMouseDown", svmap, mouseDown, false)
	--removeEventHandler("onClientMouseLeave", svmap, mouseSnap, false)
	--removeEventHandler("onClientMouseMove", svmap, mouseMove, false)
	--removeEventHandler("onClientGUIMouseDown", hbar, mouseDown, false)
	--removeEventHandler("onClientMouseMove", hbar, mouseMove, false)
	removeEventHandler("onClientClick", root, mouseUp)
	removeEventHandler("onClientGUIMouseUp", root, mouseUp)
	showChat(true)
	showCursor(false)
	destroyElement(myScreenSource)
	for i = 1, 19 do
		guiSetVisible(_G["csb"..tostring(i)], false)
	end
	guiSetVisible(sb1, false)
	guiSetVisible(sb2, false)
	unbindKey("mouse1", "down", BClick)
	removeEventHandler("onClientGUIScroll",sb1,OnScroll)
	removeEventHandler("onClientRender", root, draw_Customshop)
	--guiSetVisible(michellesVehiclewindow, false)
	--setVehicleColor ( getPedOccupiedVehicle ( getLocalPlayer() ), vColorOld1, vColorOld2, vColorOld3, vColorOld4 )
	triggerServerEvent ( "cancelpaintshop", getLocalPlayer(), getLocalPlayer() )
	setCameraTarget(getLocalPlayer(), getLocalPlayer())
	setGarageOpen ( 24, true )
	toggleAllControls(true)
	if(getElementData(lp,'ElementClicked')==true)then
		setElementData(lp,'ElementClicked',false)
	end
end
addEvent ( "showcsinfo", true)
addEventHandler ( "showcsinfo", getRootElement(), showcsinfo)

function BEnter ()
	guiSetText(source, "255")
end
function BLeave ()
	guiSetText(source, "190")
end
function BClick ()
	for i = 1, 19 do
		if (i >= 1 and i <= 5 ) then
			if (guiGetText(_G["csb"..tostring(i)]) == "255") and (_G["Cs"..tostring(i+7)] == 255) then
				triggerServerEvent ( "finishpaintshop1", getLocalPlayer(), getLocalPlayer(), getPedOccupiedVehicle ( getLocalPlayer() ), 13-i-7 )
			end
		elseif i == 6 then
			if (guiGetText(csb6) == "255") and (Cs6 == 255) then
				triggerServerEvent ( "finishpaintshop2", getLocalPlayer(), getLocalPlayer(), getPedOccupiedVehicle ( getLocalPlayer() ), 3 )
			end
		elseif i == 7 then
			if (guiGetText(csb7) == "255") and (Cs7 == 255) then
				triggerServerEvent ( "finishpaintshop2", getLocalPlayer(), getLocalPlayer(), getPedOccupiedVehicle ( getLocalPlayer() ), 2 )
			end
		elseif (i == 13 ) then
			if (guiGetText(csb13) == "255") and (Cs13 == 255) then
				triggerServerEvent ( "finishpaintshop2", getLocalPlayer(), getLocalPlayer(), getPedOccupiedVehicle ( getLocalPlayer() ), 1 )
			end
		elseif (i == 14 ) then
			if guiGetText(csb14) == "255" then
				setVehicleEngineState(getPedOccupiedVehicle( lp ), true)
				drawNos = true
				destroyElement(svmap)
				destroyElement(hbar)
				destroyElement(Blank)
				--removeEventHandler("onClientGUIMouseDown", svmap, mouseDown, false)
				--removeEventHandler("onClientMouseLeave", svmap, mouseSnap, false)
				--removeEventHandler("onClientMouseMove", svmap, mouseMove, false)
				--removeEventHandler("onClientGUIMouseDown", hbar, mouseDown, false)
				--removeEventHandler("onClientMouseMove", hbar, mouseMove, false)
				removeEventHandler("onClientClick", root, mouseUp)
				removeEventHandler("onClientGUIMouseUp", root, mouseUp)
				showChat(true)
				showCursor(false)
				destroyElement(myScreenSource)
				for i = 1, 19 do
					guiSetVisible(_G["csb"..tostring(i)], false)
				end
				guiSetVisible(sb1, false)
				guiSetVisible(sb2, false)
				unbindKey("mouse1", "down", BClick)
				removeEventHandler("onClientGUIScroll",sb1,OnScroll)
				removeEventHandler("onClientRender", root, draw_Customshop)
				--guiSetVisible(michellesVehiclewindow, false)
				--setVehicleColor ( getPedOccupiedVehicle ( getLocalPlayer() ), vColorOld1, vColorOld2, vColorOld3, vColorOld4 )
				triggerServerEvent ( "cancelpaintshop", getLocalPlayer(), getLocalPlayer() )
				setCameraTarget(getLocalPlayer(), getLocalPlayer())
				setGarageOpen ( 24, true )
				toggleAllControls(true)
				if(getElementData(lp,'ElementClicked')==true)then
					setElementData(lp,'ElementClicked',false)
				end
			end
		elseif (i >= 15 and i <= 18 ) then
			if guiGetText(_G["csb"..tostring(i)]) == "255" then
				orangebox_X, orangebox_Y = guiGetPosition(_G["csb"..tostring(i)], false)
				FAR, FAG, FAB, FBR, FBG, FBB, FCR, FCG, FCB, FDR, FDG, FDB = getVehicleColor(getPedOccupiedVehicle (getLocalPlayer()), true)
				if i == 15 then
					DieFarbeh, DieFarbes, DieFarbev = rgb2hsv(FAR, FAG, FAB)
					DieFarber, DieFarbeg, DieFarbeb, DieFarbehex = 255, 0, 0, "#FF0000"
					currentBox = 1
				elseif i == 16 then
					DieFarbeh, DieFarbes, DieFarbev = rgb2hsv(FDR, FDG, FDB)
					DieFarber, DieFarbeg, DieFarbeb, DieFarbehex = 255, 0, 0, "#FF0000"
					currentBox = 4
				elseif i == 17 then
					DieFarbeh, DieFarbes, DieFarbev = rgb2hsv(FCR, FCG, FCB)
					DieFarber, DieFarbeg, DieFarbeb, DieFarbehex = 255, 0, 0, "#FF0000"
					currentBox = 3
				elseif i == 18 then
					DieFarbeh, DieFarbes, DieFarbev = rgb2hsv(FBR, FBG, FBB)
					DieFarber, DieFarbeg, DieFarbeb, DieFarbehex = 255, 0, 0, "#FF0000"
					currentBox = 2
				end
				DieFarbewhite = tocolor(255,255,255,255)
				DieFarbeblack = tocolor(0,0,0,255)
				DieFarbecurrent = tocolor(255,0,0,255)
				DieFarbehuecurrent = tocolor(255,0,0,255)
				updateColor()
				break
			end
		elseif i == 19 then
			if guiGetText(csb19) == "255" and Cs19 == 255 then
				local a1, b1, c1, a2, b2, c2, a3, b3, c3, a4, b4, c4 = getVehicleColor ( getPedOccupiedVehicle ( getLocalPlayer() ), true )
				local color = "|"..a1..","..b1..","..c1.."|"..a2..","..b2..","..c2.."|"..a3..","..b3..","..c3.."|"..a4..","..b4..","..c4.."|"
				triggerServerEvent ( "finishpaintshop", getLocalPlayer(), getLocalPlayer(), getPedOccupiedVehicle ( getLocalPlayer() ), color )
			end
		end
	end
end


function mouseDown()
  if source == svmap or source == hbar then
    track = source
    local cx, cy = getCursorPosition()
    mouseMove(sw*cx, sh*cy)
  end  
end

function mouseUp(button, state)
  if not state or state ~= "down" then
    if track then 
    end
    track = false 
  end  
end

function mouseMove(x,y)
  if track and source == track then
    if source == svmap then
      local offsetx, offsety = x - 1022*valx, y - 291*valy
      DieFarbes = offsetx/(255*valx)
      DieFarbev = ((255*valy)-offsety)/(255*valy)
    elseif source == hbar then
      local offset = y - 291*valy
      DieFarbeh = ((255*valy)-offset)/(255*valy)
    end 
    updateColor()
  end
end

function updateColor()
	DieFarber, DieFarbeg, DieFarbeb = hsv2rgb(DieFarbeh, DieFarbes, DieFarbev)
	DieFarbecurrent = tocolor(DieFarber, DieFarbeg, DieFarbeb,255)
	DieFarbehuecurrent = tocolor(hsv2rgb(DieFarbeh, 1, 1))
	DieFarbehex = string.format("#%02X%02X%02X", DieFarber, DieFarbeg, DieFarbeb)
	if currentBox == 1 then
		setVehicleColor(getPedOccupiedVehicle (getLocalPlayer()), DieFarber, DieFarbeg, DieFarbeb, FBR, FBG, FBB, FCR, FCG, FCB, FDR, FDG, FDB)
	elseif currentBox == 2 then
		setVehicleColor(getPedOccupiedVehicle (getLocalPlayer()), FAR, FAG, FAB, DieFarber, DieFarbeg, DieFarbeb, FCR, FCG, FCB, FDR, FDG, FDB)
	elseif currentBox == 3 then
		setVehicleColor(getPedOccupiedVehicle (getLocalPlayer()), FAR, FAG, FAB, FBR, FBG, FBB, DieFarber, DieFarbeg, DieFarbeb, FDR, FDG, FDB)
	elseif currentBox == 4 then
		setVehicleColor(getPedOccupiedVehicle (getLocalPlayer()), FAR, FAG, FAB, FBR, FBG, FBB, FCR, FCG, FCB, DieFarber, DieFarbeg, DieFarbeb)
	end
	FAR, FAG, FAB, FBR, FBG, FBB, FCR, FCG, FCB, FDR, FDG, FDB = getVehicleColor(getPedOccupiedVehicle (getLocalPlayer()), true)
end

function mouseSnap()
  if track and source == track then
    if DieFarbes < snaptreshold or DieFarbes > 1-snaptreshold then DieFarbes = math.round(DieFarbes) end
    if DieFarbev < snaptreshold or DieFarbev > 1-snaptreshold then DieFarbev = math.round(DieFarbev) end
    updateColor()
  end
end

for i = 1, 19 do
	_G["As"..tostring(i)] = 255
	_G["Bs"..tostring(i)] = 255
	_G["Cs"..tostring(i)] = 255
	addEventHandler("onClientMouseEnter", _G["csb"..tostring(i)], BEnter)
	addEventHandler("onClientMouseLeave", _G["csb"..tostring(i)], BLeave)
	guiSetAlpha(_G["csb"..tostring(i)], 0)
	guiSetVisible(_G["csb"..tostring(i)], false)
end
guiSetVisible(sb1, false)
guiSetVisible(sb2, false)

function draw_Customshop ()
	setElementData(lp,'ElementClicked',true)

	setCameraMatrix ( x-5+xp, y-5+yp, z+5-guiScrollBarGetScrollPosition(sb2)/20, x, y, z )
	for i = 1, 13 do
		if guiGetText(_G["csb"..tostring(i)]) == "255" and getKeyState("mouse1") == true then
			if (i < 8 or i > 12) and ((i <= 5 and _G["Cs"..tostring(i+7)] ~= 0) or i > 5) then
				_G["colcsb"..tostring(i)] = 100
			end
		else
			if (i < 8 or i > 12) or _G["colcsb"..tostring(i)] ~= 100 then
				_G["colcsb"..tostring(i)] = guiGetText(_G["csb"..tostring(i)])
			end
		end
	end
	if guiGetText(csb19) == "255" and getKeyState("mouse1") == true then
		colcsb19 = 100
	else
		colcsb19 = guiGetText(csb19)
	end
	dxDrawImage(0, 0, 1366*valx, 768*valy, "Carsystem/Spezialtunings/Custom.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawLine((412+(946-412)/100*guiScrollBarGetScrollPosition(sb1))*valx, 527*valy, (412+(946-412)/100*guiScrollBarGetScrollPosition(sb1))*valx, 545*valy, tocolor(0, 17, 247, 255), 5, true)
	dxDrawLine(970*valx, (258+(507-258)/100*guiScrollBarGetScrollPosition(sb2))*valy, 988*valx, (258+(507-258)/100*guiScrollBarGetScrollPosition(sb2))*valy, tocolor(0, 17, 247, 255), 5, true)
	dxDrawImage(902*valx, 732*valy, 119*valx, 30*valy, "Carsystem/Spezialtunings/Kaufen.png", 0, 0, 0, tocolor(As8, Bs8, Cs8, colcsb1), true)
	dxDrawImage(763*valx, 732*valy, 119*valx, 30*valy, "Carsystem/Spezialtunings/Kaufen.png", 0, 0, 0, tocolor(As9, Bs9, Cs9, colcsb2), true)
	dxDrawImage(627*valx, 732*valy, 119*valx, 30*valy, "Carsystem/Spezialtunings/Kaufen.png", 0, 0, 0, tocolor(As10, Bs10, Cs10, colcsb3), true)
	dxDrawImage(487*valx, 732*valy, 119*valx, 30*valy, "Carsystem/Spezialtunings/Kaufen.png", 0, 0, 0, tocolor(As11, Bs11, Cs11, colcsb4), true)
	dxDrawImage(348*valx, 732*valy, 119*valx, 30*valy, "Carsystem/Spezialtunings/Kaufen.png", 0, 0, 0, tocolor(As12, Bs12, Cs12, colcsb5), true)
	dxDrawImage(161*valx, 464*valy, 119*valx, 30*valy, "Carsystem/Spezialtunings/Kaufen.png", 0, 0, 0, tocolor(As6, Bs6, Cs6, colcsb6), true)
	dxDrawImage(161*valx, 309*valy, 119*valx, 30*valy, "Carsystem/Spezialtunings/Kaufen.png", 0, 0, 0, tocolor(As7, Bs7, Cs7, colcsb7), true)
	dxDrawImage(161*valx, 157*valy, 119*valx, 30*valy, "Carsystem/Spezialtunings/Kaufen.png", 0, 0, 0, tocolor(As13, Bs13, Cs13, colcsb13), true)
	dxDrawImage(1200*valx, 554*valy, 119*valx, 30*valy, "Carsystem/Spezialtunings/Kaufen.png", 0, 0, 0, tocolor(As19, Bs19, Cs19, colcsb19), true)
	dxDrawText("3.000$", 1023*valx, 554*valy, 1194*valx, 584*valy, tocolor(255, 255, 255, 255), 2.00, "default-bold", "right", "center", false, false, true, false, false)
	dxDrawText("+"..mehrspeed1.."% max. Speed\n\n+"..mehrbesch1.."% Beschleunigung\n\n-"..mehrtarge1.."% Trägheit", 165*valx, 187*valy, 289*valx, 235*valy, tocolor(17, 247, 0, 255), 1.00*valx, "sans", "left", "top", false, false, true, false, false)
	dxDrawText("+"..mehrspeed2.."% max. Speed\n\n+"..mehrbesch2.."% Beschleunigung\n\n-"..mehrtarge2.."% Trägheit", 165*valx, 339*valy, 289*valx, 387*valy, tocolor(17, 247, 0, 255), 1.00*valx, "sans", "left", "top", false, false, true, false, false)
	dxDrawText("+"..mehrspeed3.."% max. Speed\n\n+"..mehrbesch3.."% Beschleunigung\n\n-"..mehrtarge3.."% Trägheit", 161*valx, 494*valy, 285*valx, 542*valy, tocolor(17, 247, 0, 255), 1.00*valx, "sans", "left", "top", false, false, true, false, false)
	dxUpdateScreenSource( myScreenSource )
	dxDrawImage(395*valx, 242*valy, 571*valx, 285*valy, myScreenSource, 0,0,0, tocolor(255,255,255), false )
	dxDrawImage((1366-55)*valx, 5*valy, 50*valx, 50*valy, "Carsystem/Spezialtunings/Close.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	dxDrawRectangle((1038-3)*valx, (221-3)*valy, 66*valx, 66*valy, tocolor(255, 255, 255, 255), true)
	dxDrawRectangle((1112-3)*valx, (221-3)*valy, 66*valx, 66*valy, tocolor(255, 255, 255, 255), true)
	dxDrawRectangle((1186-3)*valx, (221-3)*valy, 66*valx, 66*valy, tocolor(255, 255, 255, 255), true)
	dxDrawRectangle((1260-3)*valx, (221-3)*valy, 66*valx, 66*valy, tocolor(255, 255, 255, 255), true)
	--dxDrawRectangle((tonumber(orangebox_X)-3*valx), (tonumber(orangebox_Y)-3*valy), 66*valx, 66*valy, tocolor(238, 103, 4, 255), true)
	dxDrawRectangle(1022*valx, 291*valy, 256*valx, 256*valy, DieFarbehuecurrent, true)
	dxDrawImage(1022*valx, 291*valy, 256*valx, 256*valy, "Carsystem/Spezialtunings/Colorpicker/SV.png", 0, 0, 0, DieFarbewhite, true)
	dxDrawImage(1302*valx, 291*valy, 32*valx, 255*valy, "Carsystem/Spezialtunings/Colorpicker/H.png", 0, 0, 0, DieFarbewhite, true)
	dxDrawImageSection((1022-8)*valx+math.floor((256*valx)*DieFarbes), (291-8)*valy+((256*valy)-math.floor((256*valy)*DieFarbev)), 16*valx, 16*valy, 0*valx, 0*valy, 16*valx, 16*valy, "Carsystem/Spezialtunings/Colorpicker/Cursor.png", 0, 0, 0, DieFarbewhite, true)
	dxDrawImageSection((1302-8)*valx, (291-8)*valy+((256*valy)-math.floor((256*valy)*DieFarbeh)), 48*valx, 16*valy, 16*valx, 0*valy, 48*valx, 16*valy, "Carsystem/Spezialtunings/Colorpicker/Cursor.png", 0, 0, 0, DieFarbehuecurrent, true)
	dxDrawRectangle(1038*valx, 221*valy, 60*valx, 60*valy, tocolor(FAR, FAG, FAB, 255), true)
	dxDrawRectangle(1112*valx, 221*valy, 60*valx, 60*valy, tocolor(FBR, FBG, FBB, 255), true)
	dxDrawRectangle(1186*valx, 221*valy, 60*valx, 60*valy, tocolor(FCR, FCG, FCB, 255), true)
	dxDrawRectangle(1260*valx, 221*valy, 60*valx, 60*valy, tocolor(FDR, FDG, FDB, 255), true)
	dxDrawText("Farbe 1:", 1038*valx, 202*valy, 1102*valx, 216*valy, tocolor(255, 255, 255, 255), 1.00*valx, "default", "center", "top", false, false, true, false, false)
	dxDrawText("Farbe 2:", 1112*valx, 202*valy, 1176*valx, 216*valy, tocolor(255, 255, 255, 255), 1.00*valx, "default", "center", "top", false, false, true, false, false)
	dxDrawText("Farbe 3:", 1186*valx, 202*valy, 1250*valx, 216*valy, tocolor(255, 255, 255, 255), 1.00*valx, "default", "center", "top", false, false, true, false, false)
	dxDrawText("Farbe 4:", 1260*valx, 202*valy, 1324*valx, 216*valy, tocolor(255, 255, 255, 255), 1.00*valx, "default", "center", "top", false, false, true, false, false)
end
function blaupdate (Scrolled)
	xp = 0
	yp = 0
	for i = 1, Scrolled do
		if xp >= 0 and xp < 25 and yp == 25 then
			xp = xp+1
		elseif xp == 25 and yp <= 25 and yp > 0 then
			yp = yp-1
		elseif xp <= 25 and xp > 0 and yp == 0 then
			xp = xp-1
		elseif xp == 0 and yp >= 0 then
			yp = yp+1
		end
	end
	xp = 10/25*xp
	yp = 10/25*yp
end

function Customshop ()
orangebox_X = 1038
orangebox_Y = 221
currentBox = 1
guiSetText(csb1, "190")
guiSetText(csb2, "190")
guiSetText(csb3, "190")
guiSetText(csb4, "190")
guiSetText(csb5, "190")
guiSetText(csb6, "190")
guiSetText(csb7, "190")
guiSetText(csb8, "190")
guiSetText(csb9, "190")
guiSetText(csb10, "190")
guiSetText(csb11, "190")
guiSetText(csb12, "190")
guiSetText(csb13, "190")
guiSetText(csb14, "190")
guiSetText(csb15, "")
guiSetText(csb16, "")
guiSetText(csb17, "")
guiSetText(csb18, "")
guiSetText(csb19, "190")
	for i = 1, 19 do
		_G["As"..tostring(i)] = 255
		_G["Bs"..tostring(i)] = 255
		_G["Cs"..tostring(i)] = 255
		guiSetAlpha(_G["csb"..tostring(i)], 0)
		guiSetVisible(_G["csb"..tostring(i)], false)
	end
	if (getPedOccupiedVehicle(lp)) then
		local tow = getPedOccupiedVehicle( lp )
		local id = getElementModel(tow)
		setVehicleEngineState(tow, false)
		drawNos = false
		Bs12 = tonumber ( gettok ( tieferlegungen[id], 1, string.byte ( '|' ) ) )*255
		Cs12 = Bs12
		Bs11 = tonumber ( gettok ( tieferlegungen[id], 2, string.byte ( '|' ) ) )*255
		Cs11 = Bs11
		Bs10 = tonumber ( gettok ( tieferlegungen[id], 3, string.byte ( '|' ) ) )*255
		Cs10 = Bs10
		Bs9 = tonumber ( gettok ( tieferlegungen[id], 4, string.byte ( '|' ) ) )*255
		Cs9 = Bs9
		Bs8 = tonumber ( gettok ( tieferlegungen[id], 5, string.byte ( '|' ) ) )*255
		Cs8 = Bs8
		this1 = getOriginalHandling ( id )
		this2 = getVehicleHandling ( tow )
		this3 = math.floor((this2["suspensionLowerLimit"]-this1["suspensionLowerLimit"])*20 + 0.5)
		if this3 >= 1 then
			As12 = 0
			Bs12 = 255
			Cs12 = 0
		end
		if this3 >= 2 then
			As11 = 0
			Bs11 = 255
			Cs11 = 0
		end
		if this3 >= 3 then
			As10 = 0
			Bs10 = 255
			Cs10 = 0
		end
		if this3 >= 4 then
			As9 = 0
			Bs9 = 255
			Cs9 = 0
		end
		if this3 >= 5 then
			As8 = 0
			Bs8 = 255
			Cs8 = 0
		end	
		this3 = math.floor((this2["maxVelocity"]-this1["maxVelocity"])/10 + 0.5)
		if this3 >= 1 then
			As13 = 0
			Bs13 = 255
			Cs13 = 0
		end
		if this3 >= 2 then
			As7 = 0
			Bs7 = 255
			Cs7 = 0
		end
		if this3 >= 3 then
			As6 = 0
			Bs6 = 255
			Cs6 = 0
		end
		mehrspeed1 = math.floor(100/math.floor(this1["maxVelocity"])*(math.floor(this1["maxVelocity"]+30/3*1)))-100
		mehrspeed2 = math.floor(100/math.floor(this1["maxVelocity"])*(math.floor(this1["maxVelocity"]+30/3*2)))-100
		mehrspeed3 = math.floor(100/math.floor(this1["maxVelocity"])*(math.floor(this1["maxVelocity"]+30/3*3)))-100
		mehrbesch1 = math.floor(100/math.floor(this1["engineAcceleration"])*math.floor(this1["engineAcceleration"]/this1["maxVelocity"]*(this1["maxVelocity"]+100/3*1)))-100
		mehrbesch2 = math.floor(100/math.floor(this1["engineAcceleration"])*math.floor(this1["engineAcceleration"]/this1["maxVelocity"]*(this1["maxVelocity"]+100/3*2)))-100
		mehrbesch3 = math.floor(100/math.floor(this1["engineAcceleration"])*math.floor(this1["engineAcceleration"]/this1["maxVelocity"]*(this1["maxVelocity"]+100/3*3)))-100
		mehrtarge1 = math.floor(100/math.floor(this1["engineInertia"])*math.floor(this1["engineInertia"]/this1["maxVelocity"]*(this1["maxVelocity"]+100/3*1)))-100
		mehrtarge2 = math.floor(100/math.floor(this1["engineInertia"])*math.floor(this1["engineInertia"]/this1["maxVelocity"]*(this1["maxVelocity"]+100/3*2)))-100
		mehrtarge3 = math.floor(100/math.floor(this1["engineInertia"])*math.floor(this1["engineInertia"]/this1["maxVelocity"]*(this1["maxVelocity"]+100/3*3)))-100
		FAR, FAG, FAB, FBR, FBG, FBB, FCR, FCG, FCB, FDR, FDG, FDB = getVehicleColor(getPedOccupiedVehicle (getLocalPlayer()), true)
		DieFarbeh, DieFarbes, DieFarbev = rgb2hsv(FAR, FAG, FAB)
		DieFarber, DieFarbeg, DieFarbeb, DieFarbehex = 255, 0, 0, "#FF0000"
		DieFarbewhite = tocolor(255,255,255,255)
		DieFarbeblack = tocolor(0,0,0,255)
		DieFarbecurrent = tocolor(255,0,0,255)
		DieFarbehuecurrent = tocolor(255,0,0,255)
		svmap = guiCreateStaticImage(1022*valx, 291*valy, 256*valx, 256*valy, "Carsystem/Spezialtunings/Colorpicker/Blank.png", false, nil)	-- cp.gui.svmap
		hbar = guiCreateStaticImage(1302*valx, 291*valy, 32*valx, 256*valy, "Carsystem/Spezialtunings/Colorpicker/Blank.png", false, nil)	-- cp.gui.hbar
		Blank = guiCreateStaticImage(336*valx, 32*valy, 64*valx, 64*valy, "Carsystem/Spezialtunings/Colorpicker/Blank.png", false, nil)		-- cp.gui.Blank
		addEventHandler("onClientGUIMouseDown", svmap, mouseDown, false)
		addEventHandler("onClientMouseLeave", svmap, mouseSnap, false)
		addEventHandler("onClientMouseMove", svmap, mouseMove, false)
		addEventHandler("onClientGUIMouseDown", hbar, mouseDown, false)
		addEventHandler("onClientMouseMove", hbar, mouseMove, false)
		addEventHandler("onClientClick", root, mouseUp)
		addEventHandler("onClientGUIMouseUp", root, mouseUp)
		showChat(false)
		showCursor(true)
		myScreenSource = dxCreateScreenSource ( 640, 480 )
		for i = 1, 19 do
			guiSetVisible(_G["csb"..tostring(i)], true)
		end
		guiSetVisible(sb1, true)
		guiSetVisible(sb2, true)
		bindKey("mouse1", "down", BClick)
		addEventHandler("onClientGUIScroll",sb1,OnScroll)
		x,y,z = getElementPosition(getPedOccupiedVehicle(getLocalPlayer()))
		asdz = z
		xp = 0
		yp = 0
		setCameraMatrix ( x+10, y, z+5, x, y, z )
		updateColor()
		addEventHandler("onClientRender", root, draw_Customshop)
	else
		infobox("Du musst in einem\nWagen sitzen!")
	end
end

function OnScroll(Scrolled)
	Scrolled = math.floor(guiScrollBarGetScrollPosition(Scrolled))
	if Scrolled >= 1 then
		blaupdate(Scrolled)
	end
end	

function hex2rgb(hex)
  hex = hex:gsub("#","")
  return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end
setGarageOpen ( 24, true )

local screenW, screenH = guiGetScreenSize()

michellesVehicleColor1 = guiCreateEdit((1366-300+82)*valx, (768/2-100+39)*valy, 96*valx, 26*valy, "#000000", false, nil)
michellesVehicleColor2 = guiCreateEdit((1366-300+82)*valx, (768/2-100+69)*valy, 96*valx, 26*valy, "#000000", false, nil)
michellesVehicleColor3 = guiCreateEdit((1366-300+82)*valx, (768/2-100+99)*valy, 96*valx, 26*valy, "#000000", false, nil)
michellesVehicleColor4 = guiCreateEdit((1366-300+82)*valx, (768/2-100+129)*valy, 96*valx, 26*valy, "#000000", false, nil)
michellesVehicleLabel1 = guiCreateLabel((1366-300+15)*valx, (768/2-100+38)*valy, 57*valx, 27*valy, "Farbe 1:", false, nil)
guiLabelSetColor(michellesVehicleLabel1, 0, 0, 0)
guiLabelSetHorizontalAlign(michellesVehicleLabel1, "right", true)
guiLabelSetVerticalAlign(michellesVehicleLabel1, "center")
michellesVehicleLabel2 = guiCreateLabel((1366-300+15)*valx, (768/2-100+68)*valy, 57*valx, 27*valy, "Farbe 2:", false, nil)
guiLabelSetColor(michellesVehicleLabel2, 0, 0, 0)
guiLabelSetHorizontalAlign(michellesVehicleLabel2, "right", false)
guiLabelSetVerticalAlign(michellesVehicleLabel2, "center")
michellesVehicleLabel3 = guiCreateLabel((1366-300+15)*valx, (768/2-100+98)*valy, 57*valx, 27*valy, "Farbe 3:", false, nil)
guiLabelSetColor(michellesVehicleLabel3, 0, 0, 0)
guiLabelSetHorizontalAlign(michellesVehicleLabel3, "right", false)
guiLabelSetVerticalAlign(michellesVehicleLabel3, "center")
michellesVehicleLabel4 = guiCreateLabel((1366-300+15)*valx, (768/2-100+128)*valy, 57*valx, 27*valy, "Farbe 4:", false, nil)
guiLabelSetColor(michellesVehicleLabel4, 0, 0, 0)
guiLabelSetHorizontalAlign(michellesVehicleLabel4, "right", false)
guiLabelSetVerticalAlign(michellesVehicleLabel4, "center")

michellesVehicleButton1 = guiCreateButton((1366-300+30)*valx, (768/2-100+158)*valy, 150*valx, 38*valy, "Kaufen\n(1500$ pro Lackierung)", false, nil)
guiSetVisible(michellesVehicleColor1, false)
guiSetVisible(michellesVehicleColor2, false)
guiSetVisible(michellesVehicleColor3, false)
guiSetVisible(michellesVehicleColor4, false)
guiSetVisible(michellesVehicleLabel1, false)
guiSetVisible(michellesVehicleLabel2, false)
guiSetVisible(michellesVehicleLabel3, false)
guiSetVisible(michellesVehicleLabel4, false)
guiSetVisible(michellesVehicleButton1, false)
guiEditSetReadOnly(michellesVehicleColor1, true)
guiEditSetReadOnly(michellesVehicleColor2, true)
guiEditSetReadOnly(michellesVehicleColor3, true)
guiEditSetReadOnly(michellesVehicleColor4, true)
addEventHandler ( "onClientGUIClick", getRootElement(), function()
	if source == michellesVehicleColor1 then
		openPicker("vehicleColor1", guiGetText(michellesVehicleColor1), "Set vehicle color")
	elseif source == michellesVehicleColor2 then
		openPicker("vehicleColor2", guiGetText(michellesVehicleColor2), "Set vehicle color")
	elseif source == michellesVehicleColor3 then
		openPicker("vehicleColor3", guiGetText(michellesVehicleColor3), "Set vehicle color")
	elseif source == michellesVehicleColor4 then
		openPicker("vehicleColor4", guiGetText(michellesVehicleColor4), "Set vehicle color")
	elseif source == michellesVehicleButton2 then
		guiSetVisible(michellesVehiclewindow, false)
		setVehicleColor ( getPedOccupiedVehicle ( getLocalPlayer() ), vColorOld1, vColorOld2, vColorOld3, vColorOld4 )
		triggerServerEvent ( "cancelpaintshop", getLocalPlayer(), getLocalPlayer() )
		ClosePicker("vehicleColor1")
		ClosePicker("vehicleColor2")
		ClosePicker("vehicleColor3")
		ClosePicker("vehicleColor4")
		setCameraTarget(getLocalPlayer(), getLocalPlayer())
		setGarageOpen ( 24, true )
		toggleAllControls(true)
		addEventHandler("onClientRender",getRootElement(),dxDrawHUD)
	elseif source == michellesVehicleButton1 then
		local a1, b1, c1, a2, b2, c2, a3, b3, c3, a4, b4, c4 = getVehicleColor ( getPedOccupiedVehicle ( getLocalPlayer() ), true )
		local color = "|"..a1..","..b1..","..c1.."|"..a2..","..b2..","..c2.."|"..a3..","..b3..","..c3.."|"..a4..","..b4..","..c4.."|"
		triggerServerEvent ( "finishpaintshop", getLocalPlayer(), getLocalPlayer(), getPedOccupiedVehicle ( getLocalPlayer() ), color )
		triggerServerEvent ( "cancelpaintshop", getLocalPlayer(), getLocalPlayer() )
		ClosePicker("vehicleColor1")
		ClosePicker("vehicleColor2")
		ClosePicker("vehicleColor3")
		ClosePicker("vehicleColor4")
		setGarageOpen ( 24, true )
		setCameraTarget(getLocalPlayer(), getLocalPlayer())
		toggleAllControls(true)
		guiSetVisible(michellesVehiclewindow, false)
		setElementData(lp,'ElementClicked',false)
	end
end )		

addEvent("onColorpickerOK", true)
addEventHandler("onColorpickerOK", root, 
function (id, hex)
if id == "vehicleColor1" then
	guiSetText(michellesVehicleColor1, hex) 
elseif id == "vehicleColor2" then
	guiSetText(michellesVehicleColor2, hex)
elseif id == "vehicleColor3" then
	guiSetText(michellesVehicleColor3, hex)
elseif id == "vehicleColor4" then
	guiSetText(michellesVehicleColor4, hex)
end
r, g, b = hex2rgb(guiGetText(michellesVehicleColor1))
r2, g2, b2 = hex2rgb(guiGetText(michellesVehicleColor2))
r3, g3, b3 = hex2rgb(guiGetText(michellesVehicleColor3))
r4, g4, b4 = hex2rgb(guiGetText(michellesVehicleColor4))
if ( not setVehicleColor ( getPedOccupiedVehicle(getLocalPlayer()), r, g, b, r2, g2, b2, r3, g3, b3, r4, g4, b4 ) ) then
infobox("Gebe einen gültigen Farbcode ein!",4000,255,0,0)
end
local tc1, tc2, tc3, tc4, tc5, tc6, tc7, tc8, tc9, tc10, tc11, tc12 = getVehicleColor(getPedOccupiedVehicle (getLocalPlayer()), true)
guiSetProperty(michellesVehicleColor1, "NormalTextColour", "FF"..string.format("%02X%02X%02X", tc1, tc2, tc3))
guiSetProperty(michellesVehicleColor2, "NormalTextColour", "FF"..string.format("%02X%02X%02X", tc4, tc5, tc6))
guiSetProperty(michellesVehicleColor3, "NormalTextColour", "FF"..string.format("%02X%02X%02X", tc7, tc8, tc9))
guiSetProperty(michellesVehicleColor4, "NormalTextColour", "FF"..string.format("%02X%02X%02X", tc10, tc11, tc12))
end)

function showpaintmenue (player)
Customshop()
setGarageOpen ( 24, false )
toggleAllControls(false)	
showCursor(true)
setCameraMatrix(-1790.4,1221.1,27.9,-1786.4,1214.4,25.1)
end
addEvent ( "showpaintmenue", true)
addEventHandler ( "showpaintmenue", getRootElement(), showpaintmenue)