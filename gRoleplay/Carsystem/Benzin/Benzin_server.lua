function setVehicleFuelState ()
	if westsideGetElementData ( source, "ownerfraktion" ) or not westsideGetElementData ( source, "owner" ) then
		westsideSetElementData ( source, "fuelstate", 100 )
		westsideSetElementData ( source, "engine", false )
		setVehicleEngineState ( source, false )
	end
end
addEventHandler ( "onVehicleRespawn", getRootElement(), setVehicleFuelState )

function refreshVehDistance_func ( veh, nd )
	if tonumber ( nd ) then
		if getPedOccupiedVehicle ( client ) == veh then
			westsideSetElementData ( veh, "distance", nd )
		end
	end
end
addEvent ( "refreshVehDistance", true )
addEventHandler ( "refreshVehDistance", getRootElement(), refreshVehDistance_func )

function nonFuelVehicleEnter ()
	if not westsideGetElementData ( source, "fuelstate" ) then
		westsideSetElementData ( source, "fuelstate", 100 )
	end
	if not westsideGetElementData ( source, "distance" ) then
		westsideSetElementData ( source, "distance", 0 )
	end
end
addEventHandler ( "onVehicleEnter", getRootElement(), nonFuelVehicleEnter )

----- Tankstatus setzen -----
function setVehicleNewFuelState ( veh )
	if isElement ( veh ) then
		if getVehicleEngineState ( veh ) then
			local vx, vy, vz = getElementVelocity ( veh )
			if helicopters[getElementModel ( veh )] or planea[getElementModel ( veh )] or planeb[getElementModel ( veh )] then
				vehfactor = 400
			else
				vehfactor = 300
			end
			if westsideGetElementData ( veh, "fuelSaving" ) then
				vehfactor = vehfactor * 2
			end
			if vehfactor then
				local speed = math.floor ( math.sqrt(vx^2 + vy^2 + vz^2)*214 ) / vehfactor + 0.2
				local newFuel = tonumber ( westsideGetElementData ( veh, "fuelstate" ) ) - speed
				westsideSetElementData ( veh, "fuelstate", newFuel )
				if westsideGetElementData ( veh, "fuelstate" ) <= 0 then
					if getVehicleOccupant ( veh, 0 ) then
						outputChatBox ( "[INFO]: Deinem Fahrzeug ist das Benzin ausgegangen!", getVehicleOccupant ( veh, 0 ), 0,100,150 )
					end
					saveBenzinForPrivVeh ( veh )
					westsideSetElementData ( veh, "engine", false )
					setVehicleEngineState ( veh, false )
					westsideSetElementData ( veh, "timerrunning", false )
				elseif math.floor(westsideGetElementData(veh,"fuelstate"))/10 == math.floor(westsideGetElementData(veh,"fuelstate")/10) then
					saveBenzinForPrivVeh ( veh )
					setTimer ( setVehicleNewFuelState, 10000, 1, veh )
				else
					setTimer ( setVehicleNewFuelState, 10000, 1, veh )
				end
			end
		else
			westsideSetElementData ( veh, "timerrunning", false )
		end
	end
end

----- Benzin speichern -----
function saveBenzinForPrivVeh ( veh )
	local pname = westsideGetElementData ( veh, "owner" )
	local slot = westsideGetElementData ( veh, "carslotnr_owner" )
	if pname and slot then
		MySQL_SetString("vehicles", "Benzin", westsideGetElementData(_G["privVeh"..pname..slot],"fuelstate"), "Besitzer LIKE '" ..pname.."' AND Slot LIKE '"..slot.."'")
	end
end

----- Komplett tanken -----
function fillComplete_func ( player, varb )
	if player == client then
		local veh = getPedOccupiedVehicle ( player )
		if veh and getPedOccupiedVehicleSeat ( player ) == 0 then
			local fuel = westsideGetElementData(veh,"fuelstate")
			if fuel <= 99 then
				if varb then multy = 3 else multy = 1 end
				local costs = math.floor(3,10)*3
				if costs <= westsideGetElementData ( player, "money" ) then
					takePlayerMoney ( player, costs )					
					westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - costs )
					setElementFrozen ( veh, true )
					setTimer ( fillCar, 3000, 1, veh, 100-fuel )
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 25)
					
					outputLog("[TANKSTELLE]: "..getPlayerName(player).." hat sein Fahrzeug betankt!","Tankstellen")
				else
					infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
				end
			else
				infobox(player,"Dein Fahrzeug hat noch\ngenug Benzin!",4000,255,0,0)
			end
		end
	end
end
addEvent ( "fillComplete", true )
addEventHandler ( "fillComplete", getRootElement(), fillComplete_func )

----- Liter tanken -----
function fillPart_func ( player, liters )
	local liters = math.abs ( tonumber ( liters ) )
	local veh = getPedOccupiedVehicle ( player )
	if player == client then
		if veh and getPedOccupiedVehicleSeat ( player ) == 0 then
			local fuel = westsideGetElementData(veh,"fuelstate")
			local fuel = math.abs ( fuel )
			if fuel <= 99 then
				if liters and fuel+liters <= 100 then
					if varb then multy = 3 else multy = 1 end
					local costs = math.floor(3,10)*3
					if costs <= westsideGetElementData ( player, "money" ) then
						takePlayerMoney ( player, costs )
						westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - costs )
						setElementFrozen ( veh, true )
						setTimer ( fillCar, 3000, 1, veh, liters )
						westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 25)
						
						outputLog("[TANKSTELLE]: "..getPlayerName(player).." hat sein Fahrzeug betankt!","Tankstellen")
					else
						infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
					end
				else
					infobox(player,"Trage einen gültigen\nWert ein!",4000,255,0,0)
				end
			else
				infobox(player,"Dein Fahrzeug hat noch\ngenug Benzin!",4000,255,0,0)
			end
		end
	end
end
addEvent ( "fillPart", true )
addEventHandler ( "fillPart", getRootElement(), fillPart_func )

----- Kanister kaufen -----
function buyKannister_func ( player )

	if player == client then
		if westsideGetElementData ( player, "money" ) >= 200 then
			if tonumber ( westsideGetElementData ( player, "benzinkannister" ) ) >= 5 then
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast bereits zu viele Kanister!", 4000,255,0,0)
			else
				westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) - 200 )
				
				westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 25)
				
				infobox(player,"Benzinkanister gekauft!",4000,0,255,0)
				westsideSetElementData ( player, "benzinkannister", tonumber ( westsideGetElementData ( player, "benzinkannister" ) )+1 )
				
				outputLog("[TANKSTELLE]: "..getPlayerName(player).." hat sich einen Kanister gekauft!","Tankstellen")
			end
		else
			infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
		end
	end
end
addEvent ( "buyKannister", true )
addEventHandler ( "buyKannister", getRootElement(), buyKannister_func )

----- Kanister nutzen -----
function fillThisCar ( player )
	local veh = getPedOccupiedVehicle ( player )
	if veh then
		local fuel = tonumber ( westsideGetElementData ( veh, "fuelstate" ) )
		if fuel then
			if fuel <= 85 then
				if tonumber ( westsideGetElementData ( player, "benzinkannister" ) ) >= 1 then
					westsideSetElementData ( veh, "fuelstate", fuel+15 )
					infobox(player,"Das Fahrzeug wurde betankt!",4000,0,255,0)
					westsideSetElementData ( player, "benzinkannister", tonumber ( westsideGetElementData ( player, "benzinkannister" ) ) - 1 )
					
					westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 25)
					
					outputLog("[TANKSTELLE]: "..getPlayerName(player).." hat sein Fahrzeug betankt!","Tankstellen")
				else
					infobox(player,"Du hast keinen Benzinkanister!",4000,255,0,0)
				end
			else
				infobox(player,"Dein Fahrzeug hat noch\ngenug Benzin!",4000,255,0,0)
			end
		end
	end
end
addCommandHandler ( "fill", fillThisCar )

----- Fahrzeug füllen -----
function fillCar ( veh, liters )
	local liters = math.abs ( liters )
	if isElement ( veh ) then
		westsideSetElementData ( veh, "fuelstate", tonumber ( westsideGetElementData ( veh, "fuelstate" ) ) + liters )
		local player = getVehicleOccupant ( veh, 0 )
		if player then
			infobox(player,"Das Fahrzeug wurde betankt!",4000,0,255,0)
			
			westsideSetElementData(player,"erfahrungspunkte",tonumber(westsideGetElementData(player,"erfahrungspunkte")) + 25)
			
			outputLog("[TANKSTELLE]: "..getPlayerName(player).." hat sein Fahrzeug betankt!","Tankstellen")
		end
		setElementFrozen ( veh, false )
	end
end

----- Snack kaufen -----
addEvent("powersnack",true)
addEventHandler("powersnack",root,function(player)
	if westsideGetElementData(player,"money") >= 3 then
		snackprozent = math.random(5,35)
		takePlayerSaveMoney(player,3)
		infobox(player,"Powersnack gekauft! Dein Leben\nwurde um "..snackprozent.."% erhöht!",4000,0,255,0)
		addPlayerHealth(player,snackprozent)
		
		westsideSetElementData(player,'hunger',tonumber(westsideGetElementData(player,'hunger'))+10)
		if(westsideGetElementData(player,'hunger')>100)then
			westsideSetElementData(player,'hunger',100)
		end
	else
		infobox(player,"Du hast nicht genügend\nGeld dabei!",4000,255,0,0)
	end
end)

----- Distance -----
function abzugTankAnzeige()
	for veh,theKey in ipairs(getElementsByType("vehicle")) do
		if(westsideGetElementData(theKey,"owner"))then
            setNewTankVehicle(theKey)
		end
	end
end

function setNewTankVehicle(veh)
    if(isElement(veh))then
        if(getElementType(veh)=="vehicle")then
            if(getVehicleEngineState ( veh ))then
                local pname = westsideGetElementData ( veh, "owner" )
                local Distance = westsideGetElementData ( veh, "distance" )
                local slot = westsideGetElementData ( veh, "carslotnr_owner" )
               
                if(slot)then
                    MySQL_SetString("vehicles", "Distance", Distance, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
               
                    local ox,oy,oz=getElementPosition(veh)
                    if(westsideGetElementData(veh,"oldTankX"))then
                        ox=westsideGetElementData(veh,"oldTankX")
                        oy=westsideGetElementData(veh,"oldTankY")
                        oz=westsideGetElementData(veh,"oldTankZ")
                    end
                    local nx,ny,nz=getElementPosition(veh)
                    local entf=getDistanceBetweenPoints3D(ox,oy,oz,nx,ny,nz)
                    westsideSetElementData(veh,"distance",tonumber(westsideGetElementData(veh,"distance"))+entf/100)
 
                    westsideSetElementData(veh,"oldTankX",nx)
                    westsideSetElementData(veh,"oldTankY",ny)
                    westsideSetElementData(veh,"oldTankZ",nz)
                end
            end
        end
    end
end

function tankcounterabzugTankAnzeige()
	setTimer(tankcounterabzugTankAnzeige,1000,1)
	abzugTankAnzeige()
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),tankcounterabzugTankAnzeige)