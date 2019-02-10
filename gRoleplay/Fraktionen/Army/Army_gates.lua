removeWorldModel(966,1000,-1526.390625,481.3828125,6.1796875)
removeWorldModel(968,1000,-1526.4375,481.3828125,6.90625)

local armyGateA_1 = createObject(986,285.900390625,1817.7001953125,17.299999237061,0,0,270)
local armyGateA_2 = createObject(985,285.900390625,1825.599609375,17.299999237061,0,0,270)

local armyGateA_moving = false
local armyGateA_state = false

local armyGateB = createObject(988,92.900390625,1920.900390625,17.799999237061,0,0,270)
setObjectScale(armyGateB,0.84)

local armyGateB_moving = false
local armyGateB_state = false

local armyGateC_1 = createObject(985,139.099609375,1941.599609375,17.299999237061,0,0,0)
local armyGateC_2 = createObject(986,131.099609375,1941.599609375,17.299999237061,0,0,0)

local armyGateC_moving = false
local armyGateC_state = false

local armyGateD = createObject(976,209.900390625,1874.7001953125,12.300000190735,0,0,0)

local armyGateD_moving = false
local armyGateD_state = false

local function Army_Gate_LV_func ( player )

	local x1, y1, z1 = getElementPosition ( player )
	local x2, y2, z2 = getElementPosition ( armyGateA_1 )
	local x3, y3, z3 = getElementPosition ( armyGateA_2 )
	local x4, y4, z4 = getElementPosition ( armyGateB )
	local x5, y5, z5 = getElementPosition ( armyGateC_1 )
	local x6, y6, z6 = getElementPosition ( armyGateC_2 )
	local x7, y7, z7 = getElementPosition ( armyGateD )
	if isArmy ( player ) then
		if getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2) <= 10 or getDistanceBetweenPoints3D(x1,y1,z1,x3,y3,z3) <= 10 then
			if armyGateA_moving == false then
				if armyGateA_state == false then
					armyGateA_moving = true
					moveObject(armyGateA_1,2000,285.900390625,1811.7998046875,17.299999237061)
					moveObject(armyGateA_2,2000,285.900390625,1831,17.299999237061)
					setTimer(function()
						armyGateA_moving = false
						armyGateA_state = true
					end,2000,1)
				else
					armyGateA_moving = true
					moveObject(armyGateA_1,2000,285.900390625,1817.7001953125,17.299999237061)
					moveObject(armyGateA_2,2000,285.900390625,1825.599609375,17.299999237061)				
					setTimer(function()
						armyGateA_moving = false
						armyGateA_state = false
					end,2000,1)
				end
			end
		elseif getDistanceBetweenPoints3D(x1,y1,z1,x4,y4,z4) <= 10 then
			if armyGateB_moving == false then
				if armyGateB_state == false then
					armyGateB_moving = true 
					moveObject(armyGateB,2000,92.900390625,1920.900390625,12.600000)
					setTimer(function()
						armyGateB_state = true
						armyGateB_moving = false
					end,2000,1)
				else
					armyGateB_moving = true
					moveObject(armyGateB,2000,92.900390625,1920.900390625,17.799999237061)
					setTimer(function()
						armyGateB_state = false
						armyGateB_moving = false
					end,2000,1)
				end
			end
		elseif getDistanceBetweenPoints3D(x1,y1,z1,x5,y5,z5) <= 10 or getDistanceBetweenPoints3D(x1,y1,z1,x6,y6,z6) <= 10 then
			if armyGateC_moving == false then
				if armyGateC_state == false then
					armyGateC_moving = true
					moveObject(armyGateC_1,2000,145.2998046875,1941.599609375,17.299999237061)
					moveObject(armyGateC_2,2000,124.59999847412,1941.5999755859,17.299999237061)
					setTimer(function()
						armyGateC_moving = false
						armyGateC_state = true
					end,2000,1)
				else
					armyGateC_moving = true
					moveObject(armyGateC_1,2000,139.099609375,1941.599609375,17.299999237061)
					moveObject(armyGateC_2,2000,131.099609375,1941.599609375,17.299999237061)
					setTimer(function()
						armyGateC_moving = false
						armyGateC_state = false
					end,2000,1)
				end
			end
		elseif getDistanceBetweenPoints3D(x1,y1,z1,x7,y7,z7) <= 10 then
			if armyGateD_moving == false then
				if armyGateD_state == false then
					armyGateD_moving = true
					moveObject(armyGateD,2000,217.099609375,1874.7001953125,12.300000190735)
					setTimer(function()
						armyGateD_state = true
						armyGateD_moving = false
					end,2000,1)
				else
					armyGateD_moving = true
					moveObject(armyGateD,2000,209.900390625,1874.7001953125,12.300000190735)
					setTimer(function()
						armyGateD_state = false
						armyGateD_moving = false 
					end,2000,1)
				end
			end
		end
	end
end
addCommandHandler ( "move", Army_Gate_LV_func )

local armyLiftA = createObject(3095,268.60000610352,1884.0999755859,16.60000038147,179.99450683594,0,0)
local armyLiftA_Light1 = createObject(3385,265.5,1880.900390625,16.60000038147,0,0,0)
local armyLiftA_Light2 = createObject(3385,265.5,1887.2001953125,16.60000038147,0,0,0)
local armyLiftA_Light3 = createObject(3385,271.7998046875,1880.900390625,16.60000038147,0,0,0)
local armyLiftA_Light4 = createObject(3385,271.7998046875,1887.2001953125,16.60000038147,0,0,0)
local armyLiftA_Camouflag = createObject(3095,268.7998046875,1875.7998046875,16,0,0,0)

local armyLiftA_moving = false
local armyLiftA_state = false

local function Army_Gate_Lift_func ( player ) 
	local x1, y1, z1 = getElementPosition(player)
	local x2, y2, z2 = getElementPosition(armyLiftA)
	if isArmy ( player ) then
		if getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2) <= 5 or getDistanceBetweenPoints3D(x1,y1,z1,268.60000610352,1884.0999755859,16.60000038147) <= 7 or getDistanceBetweenPoints3D(x1,y1,z1,268.599609375,1884.099609375,-29.299999237061) <= 7 then
			if armyLiftA_moving == false then
				if armyLiftA_state == false then
					armyLiftA_moving = true
					moveObject(armyLiftA,14000,268.599609375,1884.099609375,-29.299999237061)
					moveObject(armyLiftA_Light1,14000,265.5,1880.900390625,-29.299999237061)
					moveObject(armyLiftA_Light2,14000,265.5,1887.2001953125,-29.299999237061)
					moveObject(armyLiftA_Light3,14000,271.7998046875,1880.900390625,-29.299999237061)
					moveObject(armyLiftA_Light4,14000,271.7998046875,1887.2001953125,-29.299999237061)
					setTimer(function()
						moveObject(armyLiftA_Camouflag,4000,268.7998046875,1884,16)
					end,7000,1)
					setTimer(function()
						armyLiftA_moving = false
						armyLiftA_state = true
					end,7000,1)
				else
					armyLiftA_moving = true
					moveObject(armyLiftA,14000,268.60000610352,1884.0999755859,16.60000038147)
					moveObject(armyLiftA_Light1,14000,265.5,1880.900390625,16.60000038147)
					moveObject(armyLiftA_Light2,14000,265.5,1887.2001953125,16.60000038147)
					moveObject(armyLiftA_Light3,14000,271.7998046875,1880.900390625,16.60000038147)
					moveObject(armyLiftA_Light4,14000,271.7998046875,1887.2001953125,16.60000038147)	
					setTimer(function()
						moveObject(armyLiftA_Camouflag,4000,268.7998046875,1875.7998046875,16)
					end,7000,1)
					setTimer(function()
						armyLiftA_moving = false
						armyLiftA_state = false
					end,14000,1)
				end
			else
				infobox(player,"Warter bis der Lift sich\nnicht mehr bewegt!")
			end
		end
	end
end
addCommandHandler("move",Army_Gate_Lift_func)


local armyParkA = createObject(11102,275.7001953125,1884.099609375,-27.299999237061,0,0,0)
setObjectScale(armyParkA,1.2)
local armyParkA_sphere = createColSphere(275.7001953125,1884.099609375,-27.299999237061,10)

local armyParkA_state = false

addEventHandler("onColShapeHit",armyParkA_sphere,function( hitelement )
	if isElement(hitelement) then
		if getElementType(hitelement) == "player" then
			if isArmy(hitelement) then
				if armyParkA_state == false then
					moveObject(armyParkA,4000,275.7001953125,1884.099609375,-33.7,0,0,0)
					armyParkA_state = true
				end
			end
		end
	end
end)

addEventHandler("onColShapeLeave",armyParkA_sphere, function(hitelement)
	if isElement(hitelement) then
		if getElementType(hitelement) == "player" then
			--if isArmy(hitelement) then
				bool = true
				for i, pi in ipairs(getElementsByType("player")) do
					if isElementWithinColShape(hitelement,armyParkA_sphere) then
						bool = false
						break
					end
				end
				if bool == true then
					moveObject(armyParkA,4000,275.7001953125,1884.099609375,-27.299999237061,0,0,0)
					armyParkA_state = false
				end
			--end
		end
	end	
end)

function armyGateMoveSwitch ( i )
	_G["armyGate"..i.."Moving"] = false
end

sfarmyzaun = createObject(986, -1522.8876953125,482.0810546875,6.8689527511597,0,0,352.05688476)
sfarmygate = createObject(986, -1530.7382,482.61816,6.87969017,359.7473144,0,0)
sfarmygatestate = true

local function Army_Gate_SF_func(player)
	tx,ty,tz = getElementPosition(sfarmygate)
	px, py, pz = getElementPosition(player)
	local dis = getDistanceBetweenPoints3D ( tx, ty, tz, px, py, pz )
	if isArmy (player) then
		if (dis <= 30) then
			if (sfarmygatestate == true) then
				moveObject( sfarmygate, 1500, -1530.7382,482.61816,0)
				sfarmygatestate = false
			else
				moveObject( sfarmygate, 1500, -1530.7382,482.618164,6.879690)
				sfarmygatestate = true
			end
		end
	end
end
addCommandHandler("move", Army_Gate_SF_func)

ArmySFToHeli = createMarker ( -1563.841796875, 316.7578125, 7.1875, "corona", 1, 255, 0, 0 )
ArmySFFromHeli = createMarker ( -1568.5400390625, 320.6103515625, 22.641159057617, "corona", 1, 255, 0, 0)

local function ArmySFToHeli_func ( player )
	if isArmy(player) or isOnStateDuty(player) then
		if getVehicleOccupant(player) == false then
			setElementPosition(player, -1572.3564453125, 320.419921875, 22.641159057617)
		else
			infobox(player,"Du hast keinen Schlüssel\nfür diese Tür!")
		end
	end
end 
addEventHandler("onMarkerHit", ArmySFToHeli, ArmySFToHeli_func)

local function ArmySFFromHeli_func (player)
	if isArmy(player) or isOnStateDuty(player) then
		if getVehicleOccupant(player) == false then
			setElementPosition(player, -1566.3642578125, 312.6513671875, 7.1875)
		else
			infobox(player,"Du hast keinen Schlüssel\nfür diese Tür!")
		end
	end
end
addEventHandler("onMarkerHit", ArmySFFromHeli, ArmySFFromHeli_func)

sfarmygate1 = createObject(3114, -1414.5,516.40002441406,16.683000564575,0,0,0)
sfarmygate1state = true

local function sfarmygate1_func(player)
	tx,ty,tz = getElementPosition(sfarmygate1)
	px, py, pz = getElementPosition(player)
	local dis = getDistanceBetweenPoints3D ( tx, ty, tz, px, py, pz )
	if isArmy (player) then
		if (dis <= 20) then
			if (sfarmygate1state == true) then
				moveObject( sfarmygate1, 6000, -1414.5,516.40002441406,9.63)
				sfarmygate1state = false
			else
				moveObject( sfarmygate1, 6000, -1414.5,516.40002441406,16.683000564575)
				sfarmygate1state = true
			end
		end
	end
end
addCommandHandler("move", sfarmygate1_func)

sfarmygate2= createObject(3115, -1456.6999511719,501.29998779297,17,0,0,180)
sfarmygate2state = true

local function sfarmygate2_func(player)
	tx,ty,tz = getElementPosition(sfarmygate2)
	px, py, pz = getElementPosition(player)
	local dis = getDistanceBetweenPoints3D ( tx, ty, tz, px, py, pz )
	if isArmy (player) then
		if (dis <= 20) then
			if (sfarmygate2state == true) then
				moveObject( sfarmygate2, 6000, -1456.6999511719,501.29998779297,9.8999996185303)
				sfarmygate2state = false
			else
				moveObject( sfarmygate2, 6000, -1456.6999511719,501.29998779297,17)
				sfarmygate2state = true
			end
		end
	end
end
addCommandHandler("move", sfarmygate2_func)