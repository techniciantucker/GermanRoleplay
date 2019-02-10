--SF1
local x1, y1, z1 = -1808.3822021484, 945.3701171875, 23.848808288574
SF1_Pizza = createBlip ( x1, y1, z1, 29, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--SF2
local x2, y2, z2 = -1721.3131103516, 1359.7663574219, 6.6736726760864
SF2_Pizza = createBlip ( x2, y2, z2, 29, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LS1
local x3, y3, z3 = 2105.474, -1806.535, 13.555
LS1_Pizza = createBlip ( x3, y3, z3, 29, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LV1
local x4, y4, z4 = 2756.748, 2477.368, 11.062
LV1_Pizza = createBlip ( x4, y4, z4, 29, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LV2
local x5, y5, z5 = 2330.648, 2533.395, 10.82
LV2_Pizza = createBlip ( x5, y5, z5, 29, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LV4
local x7, y7, z7 = 2083.309, 2224.7, 11.023
LV4_Pizza = createBlip ( x7, y7, z7, 29, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--Palomino
local x8, y8, z8 = 2331.825, 75.036, 26.621
Palomino_Pizza = createBlip ( x8, y8, z8, 29, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--Montgomery
local x9, y9, z9 = 1367.407, 248.438, 19.567
Montgomery_Pizza = createBlip ( x9, y9, z9, 29, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--Blueberry
local x10, y10, z10 = 212.427, -202.231, 1.578
Blueberry_Pizza = createBlip ( x10, y10, z10, 29, 2, 255, 0, 0, 255, 0, 200, getRootElement() )

local Leave_Pizza = {}

local function Exit_Pizza_MarkerHit ( hitElement, dim )
if getElementType(hitElement) == "player" and (dim) then
	if isPedInVehicle ( hitElement ) == false then
		if source == Leave_Pizza[1] then
			fadeElementInterior ( hitElement, 0, -1806, 945.3701171875, 24.5 )
		elseif source == Leave_Pizza[2] then
			fadeElementInterior ( hitElement, 0, -1724.324, 1360.114, 7.188 )
		elseif source == Leave_Pizza[3] then
			fadeElementInterior ( hitElement, 0, 2103.621, -1806.449, 13.555 )
		elseif source == Leave_Pizza[4] then
			fadeElementInterior ( hitElement, 0, 2755.366, 2475.8, 11.0625 )
		elseif source == Leave_Pizza[5] then
			fadeElementInterior ( hitElement, 0, 2330.499, 2530.822, 10.82 )
		elseif source == Leave_Pizza[7] then
			fadeElementInterior ( hitElement, 0, 2083.45, 2222.954, 10.82 )
		elseif source == Leave_Pizza[8] then
			fadeElementInterior ( hitElement, 0, 2334.801, 75.065, 26.484 )
		elseif source == Leave_Pizza[9] then
			fadeElementInterior ( hitElement, 0, 1365.703, 249.18, 19.567 )
		elseif source == Leave_Pizza[10] then
			fadeElementInterior ( hitElement, 0, 212.601, -205.18, 1.578 )
		end
		setElementDimension ( hitElement, 0 )
		toggleControl ( hitElement, "fire", true )
		toggleControl ( hitElement, "enter_exit", true )
	end
end
end

-- Leave
local x0, y0, z0 = 372.29702758789, -133.29911804199, 1001.49219

for i=1, 10, 1 do
Leave_Pizza[i] = createMarker ( x0, y0, z0, "corona", 1.4, 0, 0, 255, 150 )
setElementInterior ( Leave_Pizza[i], 5 )
setElementDimension ( Leave_Pizza[i], i )
addEventHandler ( "onMarkerHit", Leave_Pizza[i], Exit_Pizza_MarkerHit )
end

local SF1_Pizza_Enter = createMarker ( x1, y1, z1, "corona", 1.5, 0, 0, 255, 150 )
local SF2_Pizza_Enter = createMarker ( x2, y2, z2, "corona", 1.5, 0, 0, 255, 150 )
local LS1_Pizza_Enter = createMarker ( x3, y3, z3, "corona", 1.5, 0, 0, 255, 150 )
local LV1_Pizza_Enter = createMarker ( x4, y4, z4, "corona", 1.5, 0, 0, 255, 150 )
local LV2_Pizza_Enter = createMarker ( x5, y5, z5, "corona", 1.5, 0, 0, 255, 150 )
local LV4_Pizza_Enter = createMarker ( x7, y7, z7, "corona", 1.5, 0, 0, 255, 150 )
local Palomino_Pizza_Enter = createMarker ( x8, y8, z8, "corona", 1.5, 0, 0, 255, 150 )
local Montgomery_Pizza_Enter = createMarker ( x9, y9, z9, "corona", 1.5, 0, 0, 255, 150 )
local Blueberry_Pizza_Enter = createMarker ( x10, y10, z10, "corona", 1.5, 0, 0, 255, 150 )

local mx, my, mz = 376.68966674805,-119.23748016357,1000.650

local Buy_Pizza = {}

local function pizzaBuyHit ( player, dim )
	if dim == true then
		triggerClientEvent(player,"show_Pizzaria_GUI",player)
	end
end

for i=1, 10, 1 do
Buy_Pizza[i] = createMarker ( mx, my, mz, "cylinder",1,0,100,150 )
setElementInterior ( Buy_Pizza[i], 5 )
setElementDimension ( Buy_Pizza[i], i )
addEventHandler ( "onMarkerHit", Buy_Pizza[i], pizzaBuyHit )
end

local skin = 155
local pex, pey, pez = 376.69479370117, -117.20676422119, 1001.141418457

local Ped_Pizza = {}
for i=1, 10, 1 do
Ped_Pizza[i] = createPed ( skin, pex, pey, pez )
setElementInterior ( Ped_Pizza[i], 5 )
setElementDimension ( Ped_Pizza[i], i )
setPedRotation ( Ped_Pizza[i], 180 )
setElementData ( Ped_Pizza[i], "undeadbarped", true )
end

local function pizzaEnterMarkerHit ( hitElement, dim )
if getElementType(hitElement) == "player" and (dim) then
	if isPedInVehicle ( hitElement ) == false then
		if source == SF1_Pizza_Enter then
			setElementDimension ( hitElement, 1 )
		elseif source == SF2_Pizza_Enter then
			setElementDimension ( hitElement, 2 )
		elseif source == LS1_Pizza_Enter then
			setElementDimension ( hitElement, 3 )
		elseif source == LV1_Pizza_Enter then
			setElementDimension ( hitElement, 4 )
		elseif source == LV2_Pizza_Enter then
			setElementDimension ( hitElement, 5 )
		elseif source == LV4_Pizza_Enter then
			setElementDimension ( hitElement, 7 )
		elseif source == Palomino_Pizza_Enter then
			setElementDimension ( hitElement, 8 )
		elseif source == Montgomery_Pizza_Enter then
			setElementDimension ( hitElement, 9 )
		elseif source == Blueberry_Pizza_Enter then
			setElementDimension ( hitElement, 10 )
		end
		fadeElementInterior ( hitElement, 5, 372.29702758789, -131, 1001 )
		toggleControl ( hitElement, "fire", false )
		toggleControl ( hitElement, "enter_exit", false )
	end
end
end
addEventHandler ( "onMarkerHit", SF1_Pizza_Enter, pizzaEnterMarkerHit )
addEventHandler ( "onMarkerHit", SF2_Pizza_Enter, pizzaEnterMarkerHit )
addEventHandler ( "onMarkerHit", LS1_Pizza_Enter, pizzaEnterMarkerHit )
addEventHandler ( "onMarkerHit", LV1_Pizza_Enter, pizzaEnterMarkerHit )
addEventHandler ( "onMarkerHit", LV2_Pizza_Enter, pizzaEnterMarkerHit )
addEventHandler ( "onMarkerHit", LV4_Pizza_Enter, pizzaEnterMarkerHit )
addEventHandler ( "onMarkerHit", Palomino_Pizza_Enter, pizzaEnterMarkerHit )
addEventHandler ( "onMarkerHit", Montgomery_Pizza_Enter, pizzaEnterMarkerHit )
addEventHandler ( "onMarkerHit", Blueberry_Pizza_Enter, pizzaEnterMarkerHit )

function pizzaLeave ( player )
	setElementPosition ( player, 372.29702758789, -122, 1001 )
	setElementDimension ( player, westsideGetElementData ( player, "intdim" ) )
end

-- Menüs --
function KleinesPizzariaMenue_func(player)
	if westsideGetElementData ( player, "money" ) >= 25 then
		infobox(player,"Menü gekauft.",2500,0,255,0)
		addPlayerHealth(player,25)
		westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))+25)
		if(westsideGetElementData(player,'hunger')>100)then
			westsideSetElementData(player,'hunger',100)
		end
		takePlayerSaveMoney ( player, 25 )
		setElementFrozen(player,true)
		setPedAnimation ( player, "FOOD", "EAT_Burger")
		setTimer(function()
			setPedAnimation(player,false)
			setElementFrozen(player,false)
		end,10000,1)
	else
		infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
	end
end
addEvent("KleinesPizzariaMenue",true)
addEventHandler("KleinesPizzariaMenue",getRootElement(),KleinesPizzariaMenue_func)

function MittleresPizzariaMenue_func(player)
	if westsideGetElementData ( player, "money" ) >= 50 then
		infobox(player,"Menü gekauft.",2500,0,255,0)
		addPlayerHealth(player,50)
		westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))+50)
		if(westsideGetElementData(player,'hunger')>100)then
			westsideSetElementData(player,'hunger',100)
		end
		takePlayerSaveMoney ( player, 50 )
		setElementFrozen(player,true)
		setPedAnimation ( player, "FOOD", "EAT_Burger")
		setTimer(function()
			setPedAnimation(player,false)
			setElementFrozen(player,false)
		end,10000,1)
	else
		infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
	end
end
addEvent("MittleresPizzariaMenue",true)
addEventHandler("MittleresPizzariaMenue",getRootElement(),MittleresPizzariaMenue_func)

function GrosesPizzariaMenue_func(player)
	if westsideGetElementData ( player, "money" ) >= 75 then
		infobox(player,"Menü gekauft.",2500,0,255,0)
		addPlayerHealth(player,75)
		westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))+75)
		if(westsideGetElementData(player,'hunger')>100)then
			westsideSetElementData(player,'hunger',100)
		end
		takePlayerSaveMoney ( player, 75 )
		setElementFrozen(player,true)
		setPedAnimation ( player, "FOOD", "EAT_Burger")
		setTimer(function()
			setPedAnimation(player,false)
			setElementFrozen(player,false)
		end,10000,1)
	else
		infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
	end
end
addEvent("GrosesPizzariaMenue",true)
addEventHandler("GrosesPizzariaMenue",getRootElement(),GrosesPizzariaMenue_func)

function BigPizzariaMenue_func(player)
	if westsideGetElementData ( player, "money" ) >= 100 then
		infobox(player,"Menü gekauft.",2500,0,255,0)
		addPlayerHealth(player,100)
		westsideSetElementData(player,'hunger',100)
		takePlayerSaveMoney ( player, 100 )
		setElementFrozen(player,true)
		setPedAnimation ( player, "FOOD", "EAT_Burger")
		setTimer(function()
			setPedAnimation(player,false)
			setElementFrozen(player,false)
		end,10000,1)
	else
		infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
	end
end
addEvent("BigPizzariaMenue",true)
addEventHandler("BigPizzariaMenue",getRootElement(),BigPizzariaMenue_func)