createObject ( 2642, -2358.2592773438, -160.6789855957, 36.138740539551 )
createObject ( 8843, -2352.7250976563, -159.10821533203, 34.3203125 )
createObject ( 8843, -2333.2939453125, -172.28869628906, 34.3203125, 0, 0, 90 )

--SF1
local x1, y1, z1 = -2336.861, -166.727, 35.5557
SF1_Burger = createBlip ( x1, y1, z1, 10, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--SF2
local x2, y2, z2 = -2356.456, 1008.131, 50.898
SF2_Burger = createBlip ( x2, y2, z2, 10, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--SF3
local x3, y3, z3 = -1912.433, 827.927, 35.23
SF3_Burger = createBlip ( x3, y3, z3, 10, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LS1
local x4, y4, z4 = 810.486, -1616.065, 13.547
LS1_Burger = createBlip ( x4, y4, z4, 10, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LS2
local x5, y5, z5 = 1199.532, -918.503, 43.119
LS2_Burger = createBlip ( x5, y5, z5, 10, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LV1
local x6, y6, z6 = 2169.804, 2795.715, 10.82
LV1_Burger = createBlip ( x6, y6, z6, 10, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LV2
local x7, y7, z7 = 1872.643, 2071.749, 11.062
LV2_Burger = createBlip ( x7, y7, z7, 10, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LV3
local x8, y8, z8 = 2472.864, 2034.171, 11.062
LV3_Burger = createBlip ( x8, y8, z8, 10, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LV4
local x9, y9, z9 = 1157.919, 2072.185, 11.062
LV4_Burger = createBlip ( x9, y9, z9, 10, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
--LV5
local x10, y10, z10 = 2366.804, 2071.029, 10.82
LV5_Burger = createBlip ( x10, y10, z10, 10, 2, 255, 0, 0, 255, 0, 200, getRootElement() )

local Leave_Burger = {}
local BurgershotPissMarker1={}
local BurgershotPissMarker2={}

local function Exit_Burger_MarkerHit ( hitElement, dim )
if getElementType(hitElement) == "player" and (dim) then
	if isPedInVehicle ( hitElement ) == false then
		if source == Leave_Burger[1] then
			fadeElementInterior ( hitElement, 0, -2332.601, -166.775, 35.555 )
		elseif source == Leave_Burger[2] then
			fadeElementInterior ( hitElement, 0, -2358.291, 1008.128, 50.865 )
		elseif source == Leave_Burger[3] then
			fadeElementInterior ( hitElement, 0, -1910.713, 829.443, 35.172 )
		elseif source == Leave_Burger[4] then
			fadeElementInterior ( hitElement, 0, 812.933, -1615.971, 13.547 )
		elseif source == Leave_Burger[5] then
			fadeElementInterior ( hitElement, 0, 1197.942, -920.777, 43.042 )
		elseif source == Leave_Burger[6] then
			fadeElementInterior ( hitElement, 0, 2172.253, 2795.917, 10.82 )
		elseif source == Leave_Burger[7] then
			fadeElementInterior ( hitElement, 0, 1874.243, 2071.953, 11.062 )
		elseif source == Leave_Burger[8] then
			fadeElementInteriorr ( hitElement, 0, 2471.358, 2034.094, 11.062 )
		elseif source == Leave_Burger[9] then
			fadeElementInterior ( hitElement, 0, 1159.508, 2072.281, 11.062 )
		elseif source == Leave_Burger[10] then
			fadeElementInterior ( hitElement, 0, 2363.591, 2070.875, 10.82 )
		end
		setElementDimension ( hitElement, 0 )
		toggleControl ( hitElement, "fire", true )
		toggleControl ( hitElement, "enter_exit", true )
	end
end
end

function Burgershotpissen(player,dim)
	if(getElementType(player)=='player' and dim)then
		if(westsideGetElementData(player,'harndrang')>0)then
			infobox(player,'Das pinkeln dauert 10 Sekunden..')
			setPedAnimation ( player, "PAULNMAC", "Piss_loop")
			setTimer(function()
				setPedAnimation(player,false)
				setElementFrozen(player,false)
				westsideSetElementData(player,'harndrang',0)
				infobox(player,'Du hast deine Blase entleert.')
			end,10000,1)
		else
			infobox(player,'Du musst nicht pinkeln!')
		end
	end
end

-- Leave
local x0, y0, z0 = 362.923, -75.221, 1001.508

for i=1, 10, 1 do
Leave_Burger[i] = createMarker ( x0, y0, z0, "corona", 1.5, 0, 0, 255, 150 )
BurgershotPissMarker1[i]=createMarker(366.93902587891,-57.446388244629,1001.5102539063,'corona',1,0,0,200)
BurgershotPissMarker2[i]=createMarker(371.06506347656,-57.32405090332,1001.5191040039,'corona',1,0,0,200)
setElementInterior(BurgershotPissMarker1[i],10)
setElementInterior(BurgershotPissMarker2[i],10)
setElementDimension(BurgershotPissMarker1[i],i)
setElementDimension(BurgershotPissMarker2[i],i)
setElementAlpha(BurgershotPissMarker1[i],50)
setElementAlpha(BurgershotPissMarker2[i],50)
setElementInterior ( Leave_Burger[i], 10 )
setElementDimension ( Leave_Burger[i], i )
addEventHandler ( "onMarkerHit", Leave_Burger[i], Exit_Burger_MarkerHit )
addEventHandler('onMarkerHit',BurgershotPissMarker1[i],Burgershotpissen)
addEventHandler('onMarkerHit',BurgershotPissMarker2[i],Burgershotpissen)
end

local SF1_Burger_Enter = createMarker ( x1, y1, z1, "corona", 1.5, 0, 0, 255, 150 )
local SF2_Burger_Enter = createMarker ( x2, y2, z2, "corona", 1.5, 0, 0, 255, 150 )
local SF3_Burger_Enter = createMarker ( x3, y3, z3, "corona", 1.5, 0, 0, 255, 150 )
local LS1_Burger_Enter = createMarker ( x4, y4, z4, "corona", 1.5, 0, 0, 255, 150 )
local LS2_Burger_Enter = createMarker ( x5, y5, z5, "corona", 1.5, 0, 0, 255, 150 )
local LV1_Burger_Enter = createMarker ( x6, y6, z6, "corona", 1.5, 0, 0, 255, 150 )
local LV2_Burger_Enter = createMarker ( x7, y7, z7, "corona", 1.5, 0, 0, 255, 150 )
local LV3_Burger_Enter = createMarker ( x8, y8, z8, "corona", 1.5, 0, 0, 255, 150 )
local LV4_Burger_Enter = createMarker ( x9, y9, z9, "corona", 1.5, 0, 0, 255, 150 )
local LV5_Burger_Enter = createMarker ( x10, y10, z10, "corona", 1.5, 0, 0, 255, 150 )

local mx, my, mz = 376.42150878906,-67.635887145996,1000.650

local Buy_Burger = {}

local function burgerBuyHit ( player, dim )

	if dim == true then
		triggerClientEvent ( player, "show_Burgershot_GUI", player, player )
	end
end

for i=1, 10, 1 do
Buy_Burger[i] = createMarker ( mx, my, mz, "cylinder",1,0,100,150 )
setElementInterior ( Buy_Burger[i], 10 )
setElementDimension ( Buy_Burger[i], i )
addEventHandler ( "onMarkerHit", Buy_Burger[i], burgerBuyHit )
end

local skin = 205
local pex, pey, pez = 376.449, -65.647, 1001.508

local Ped_Burger = {}
for i=1, 10, 1 do
Ped_Burger[i] = createPed ( skin, pex, pey, pez )
setElementInterior ( Ped_Burger[i], 10 )
setElementDimension ( Ped_Burger[i], i )
setPedRotation ( Ped_Burger[i], 180 )
setElementData ( Ped_Burger[i], "undeadbarped", true )
end

local function burgerEnterMarkerHit ( hitElement, dim )
if getElementType(hitElement) == "player" and (dim) then
	if isPedInVehicle ( hitElement ) == false then
		if source == SF1_Burger_Enter then
			setElementDimension ( hitElement, 1 )
		elseif source == SF2_Burger_Enter then
			setElementDimension ( hitElement, 2 )
		elseif source == SF3_Burger_Enter then
			setElementDimension ( hitElement, 3 )
		elseif source == LS1_Burger_Enter then
			setElementDimension ( hitElement, 4 )
		elseif source == LS2_Burger_Enter then
			setElementDimension ( hitElement, 5 )
		elseif source == LV1_Burger_Enter then
			setElementDimension ( hitElement, 6 )
		elseif source == LV2_Burger_Enter then
			setElementDimension ( hitElement, 7 )
		elseif source == LV3_Burger_Enter then
			setElementDimension ( hitElement, 8 )
		elseif source == LV4_Burger_Enter then
			setElementDimension ( hitElement, 9 )
		elseif source == LV5_Burger_Enter then
			setElementDimension ( hitElement, 10 )
		end
		fadeElementInterior ( hitElement, 10, 363.886, -73.787, 1001.508 )
		toggleControl ( hitElement, "fire", false )
		toggleControl ( hitElement, "enter_exit", false )
	end
end
end
addEventHandler ( "onMarkerHit", SF1_Burger_Enter, burgerEnterMarkerHit )
addEventHandler ( "onMarkerHit", SF2_Burger_Enter, burgerEnterMarkerHit )
addEventHandler ( "onMarkerHit", SF3_Burger_Enter, burgerEnterMarkerHit )
addEventHandler ( "onMarkerHit", LS1_Burger_Enter, burgerEnterMarkerHit )
addEventHandler ( "onMarkerHit", LS2_Burger_Enter, burgerEnterMarkerHit )
addEventHandler ( "onMarkerHit", LV1_Burger_Enter, burgerEnterMarkerHit )
addEventHandler ( "onMarkerHit", LV2_Burger_Enter, burgerEnterMarkerHit )
addEventHandler ( "onMarkerHit", LV3_Burger_Enter, burgerEnterMarkerHit )
addEventHandler ( "onMarkerHit", LV4_Burger_Enter, burgerEnterMarkerHit )
addEventHandler ( "onMarkerHit", LV5_Burger_Enter, burgerEnterMarkerHit )

-- Menüs --
function KleinesBurgershotMenue_func(player)
	if westsideGetElementData ( player, "money" ) >= 25 then
		infobox(player,"Menü gekauft!",4000,0,255,0)
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
addEvent("KleinesBurgershotMenue",true)
addEventHandler("KleinesBurgershotMenue",getRootElement(),KleinesBurgershotMenue_func)

function MittleresBurgershotMenue_func(player)
	if westsideGetElementData ( player, "money" ) >= 50 then
		infobox(player,"Menü gekauft!",4000,0,255,0)
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
addEvent("MittleresBurgershotMenue",true)
addEventHandler("MittleresBurgershotMenue",getRootElement(),MittleresBurgershotMenue_func)

function GrosesBurgershotMenue_func(player)
	if westsideGetElementData ( player, "money" ) >= 75 then
		infobox(player,"Menü gekauft!",4000,0,255,0)
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
addEvent("GrosesBurgershotMenue",true)
addEventHandler("GrosesBurgershotMenue",getRootElement(),GrosesBurgershotMenue_func)

function BigBurgershotMenue_func(player)
	if westsideGetElementData ( player, "money" ) >= 100 then
		infobox(player,"Menü gekauft!",4000,0,255,0)
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
addEvent("BigBurgershotMenue",true)
addEventHandler("BigBurgershotMenue",getRootElement(),BigBurgershotMenue_func)