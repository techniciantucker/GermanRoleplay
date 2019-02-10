Speedo = {};

local sx, sy = guiGetScreenSize();
local px, py = 1920, 1080;
local x, y = (sx/px), (sy/py);

function Speedo:constructor(...)
	local self = setmetatable({}, {__index = self});
	self.m_RenderFunc = function()
		self:func_Render();
	end
	if (isPedInVehicle(localPlayer)) then
		addEventHandler("onClientRender", getRootElement(), self.m_RenderFunc);
	end
	addEventHandler("onClientVehicleEnter", getRootElement(), function(player)
		if (player == localPlayer) then
			addEventHandler("onClientRender", getRootElement(), self.m_RenderFunc);
		end
	end);
	addEventHandler("onClientVehicleExit", getRootElement(), function(player)
		if (player == localPlayer) then
			removeEventHandler("onClientRender", getRootElement(), self.m_RenderFunc);
		end
	end);
	return self;
end

function Speedo:func_Render()
	local handyIsOpen = handyIsOpen or false;
	if (isPedInVehicle(localPlayer)) then
		if(getElementData(lp,'inScoreboard')==false)then
			if(not(isPlayerMapVisible(lp)))then
				local vehicle = getPedOccupiedVehicle(localPlayer);
				local vehspeed = getElementSpeed(vehicle);
				local vehfuel = getElementData(vehicle, "fuelstate") or 100;
				local distance=getElementData(vehicle,'distance')
				dxDrawImage(x*1450, y*650, x*500, y*500, "Carsystem/Tacho/SPEEDO.png", 0, 0, 0, tocolor(255, 255, 255, 255), false);
				if (getVehicleEngineState(vehicle) == true) then
					dxDrawImage(x*1600.5, y*1002, x*16, y*16, "Carsystem/Tacho/ENGINE.png", 0, 0, 0, tocolor(255, 255, 255, 255), false);
				end
				if (getVehicleOverrideLights(vehicle) == 2) then
					dxDrawImage(x*1572, y*1001, x*16, y*16, "Carsystem/Tacho/LIGHT.png", 0, 0, 0, tocolor(255, 255, 255, 255), false);
				end
				dxDrawText(math.floor(distance).." KM", x*1707, y*948, x*1790, y*965, tocolor(0, 0, 0, 255), x*1.00, "default-bold", "center", "center", false, false, false, false, false)
				dxDrawImage(x*1567, y*704, x*366, y*331, "Carsystem/Tacho/NADEL.png", (vehspeed*1.23), 0, 0, tocolor(255, 255, 255, 255), false);
				dxDrawImage(x*1496, y*868, x*200, y*200, "Carsystem/Tacho/NADEL.png", (5+vehfuel*1.35), 0, 0, tocolor(255, 255, 255, 255), false);
			end
		end
	end
end


function getElementSpeed(element,unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 1.61 * 100
		end
	else
		return false
	end
end

local instance = Speedo:constructor();