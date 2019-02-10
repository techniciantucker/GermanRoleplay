debug.sethook()

firstgrow = 600
firstchange = 3600
secondchange = 7200
thirdchange = 3600
playerToGroundLevel = 4.3829 - 3.0744

weedPlants =  {}

local time = getMinTime () - 60 * 24 * 4
mysql_vio_query ( "DELETE FROM weed WHERE time <= '"..time.."'" )

function drugsSellHobby_func ( amount )

	player = client
	
	local amount = math.abs ( math.floor ( tonumber ( amount ) ) )
	local drugs = westsideGetElementData ( player, "drugs" )
	
	if drugs >= amount then
		westsideSetElementData ( player, "drugs", drugs - amount )
		givePlayerMoney ( player, "money", amount * 7 )
		westsideSetElementData ( player, "money", westsideGetElementData ( player, "money" ) + amount * 7 )
		outputChatBox ( "[INFO]: Du hast für "..amount.." Gramm Drogen "..(amount*7).."$ bekommen!", player, 0,100,150 )
	else
		infobox(player,"So viele Drogen hast du nicht!",4000,255,0,0)
	end
end
addEvent ( "drugsSellHobby", true )
addEventHandler ( "drugsSellHobby", getRootElement(), drugsSellHobby_func )

function createWeedPlants ()

	result = mysql_query ( handler, "SELECT * FROM weed" )
	weedCount = 0
	if result then
		weedData = mysql_fetch_assoc ( result )
		while weedData do
			weedCount = weedCount + 1

			local id = weedData["id"]
			local x = weedData["x"]
			local y = weedData["y"]
			local z = weedData["z"]
			local time = weedData["time"]
			local name = weedData["name"]

			addWeed ( id, x, y, z, time, name )
			weedData = mysql_fetch_assoc ( result )
		end
		mysql_free_result(result)
	end
end
setTimer ( createWeedPlants, 1000, 1 )

function addWeed ( id, x, y, z, time, name )

	weedPlants[id] = createObject ( 3409, x, y, z )

	local boxA = createObject ( 2991, -2589.3125, 330.35571289063, 4.1824889183044, 0, 0, 270 )
	local boxB = createObject ( 2991, -2587.8278808594, 330.31005859375, 4.1824889183044, 0, 0, 270 )

	westsideSetElementData ( weedPlants[id], "id", id )

	westsideSetElementData ( weedPlants[id], "id", id )

	westsideSetElementData ( boxA, "id", id )
	westsideSetElementData ( boxB, "id", id )

	westsideSetElementData ( weedPlants[id], "time", time )
	westsideSetElementData ( boxA, "time", time )
	westsideSetElementData ( boxB, "time", time )

	westsideSetElementData ( weedPlants[id], "weed", true )
	westsideSetElementData ( boxA, "weed", true )
	westsideSetElementData ( boxB, "weed", true )

	local ox1, oy1, oz1 = -2588.5119628906-(-2589.3125), 330.2961730957-(330.35571289063), -3.1796875+(4.1824889183044)
	local ox2, oy2, oz2 = -2588.5119628906-(-2587.8278808594), 330.2961730957-(330.31005859375), -3.1796875+(4.1824889183044)

	attachElements ( boxA, weedPlants[id], ox1, oy1, oz1, 0, 0, 270 )
	attachElements ( boxB, weedPlants[id], ox2, oy2, oz2, 0, 0, 270 )

	setElementParent ( boxA, weedPlants[id] )
	setElementParent ( boxB, weedPlants[id] )

	setElementAlpha ( boxA, 0 )
	setElementAlpha ( boxB, 0 )

	if not serverRestartedAMinuteAgo then
		setElementPosition ( weedPlants[id], x, y, z )
		moveObject ( weedPlants[id], 30000, x, y, z + playerToGroundLevel )
	end
end

function grow_func ( player, cmd, planttype )
	if westsideGetElementData(player,"jailtime") == 0 then
		if planttype == "weed" then
			if isPedOnGround ( player ) and not getPedOccupiedVehicle ( player ) and getElementInterior ( player ) == 0 and getElementDimension ( player ) == 0 then
				if not westsideGetElementData ( player, "growing" ) then
					if westsideGetElementData ( player, "flowerseeds" ) >= 1 then
						local x, y, z = getElementPosition ( player )
						if z > -5 then
							westsideSetElementData ( player, "growing", true )

							setTimer ( growFinished, 28500, 1, player )
							toggleAllControls ( player, false, true, true )

							setPedAnimation ( player, "BOMBER", "BOM_Plant_Crouch_In", 1500, false, false, false, true )
							setTimer ( setPedAnimation, 1500, 1, player, "BOMBER", "BOM_Plant_Loop", -1, true, false, false, true )

							westsideSetElementData ( player, "flowerseeds", westsideGetElementData ( player, "flowerseeds" ) - 1 )

							local time = getMinTime ()
							local name = getPlayerName ( player )

							local z = z - playerToGroundLevel * 2

							x = math.floor ( x * 10000 ) / 10000
							y = math.floor ( y * 10000 ) / 10000
							z = math.floor ( z * 10000 ) / 10000

							mysql_vio_query ( "INSERT INTO weed ( x, y, z, time, name ) VALUES ( '"..x.."', '"..y.."', '"..( z + playerToGroundLevel - 0.5 ).."', '"..time.."', '"..name.."' )" )

							local id = MySQL_GetString ( "weed", "id", "recieved = '0'" )
							mysql_vio_query ( "UPDATE weed SET recieved = '1' WHERE id = '"..id.."'" )

							id = tonumber ( id )

							addWeed ( id, x, y, z, time, name )

							outputLog ( getPlayerName ( player ).." hat an "..x.."|"..y.."|"..z.." Drogen angebaut.", "Weed" )

							infobox(player,"Hanf wird angepflanzt!",4000,0,255,0)
							outputChatBox("[INFO]: Du kannst es per Klick ernten, wann du willst, jedoch steigt",player,0,100,150)
							outputChatBox("der Ertrag der Ernte pro Stunde (Max. 50 Gramm!).",player,0,100,150)
						else
							infobox ( player, "Hier kannst du nicht anbauen!", 4000, 255, 0, 0 )
						end
					else
						infobox(player,"Du hast keine Hanfsamen dabei!",4000,255,0,0)
					end
				else
					infobox(player,"Pflanz erst zu ende an!",4000,255,0,0)
				end
			else
				infobox(player,"Du biast an einer\nungültigen Stelle!",4000,255,0,0)
			end
		else
			infobox(player,"Nutze /grow weed!",4000,0,100,150)
		end
	else
		infobox(player,"Im Knast nicht möglich!")
	end
end
addCommandHandler ( "grow", grow_func )

function growFinished ( player )

	setPedAnimation ( player, "BOMBER", "BOM_Plant_Crouch_Out", 1500, false, false, false, true )
	setTimer ( defreezeAfterWeedPlant, 1500, 1, player )
end

function defreezeAfterWeedPlant ( player )

	toggleAllControls ( player, true, true, true )
	setPedAnimation ( player )
	westsideSetElementData ( player, "growing", false )
end

-- // Samen
function BuyFlowersServer_func ()

	local player = client
	local money = tonumber ( westsideGetElementData ( player, "money" ) )
	local seeds = tonumber ( westsideGetElementData ( player, "flowerseeds" ) )
	
	if money >= 100 then
		westsideSetElementData ( player, "money", money - 100 )
		takePlayerMoney ( player, 100 )

		westsideSetElementData ( player, "flowerseeds", seeds + 2 )

		triggerClientEvent ( player, "infobox_start", getRootElement(), "2 Samen gekauft! Tippe /grow weed,\num sie anzupflanzen!", 4000, 0, 255, 0 )
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht genug Geld!", 4000, 255, 0, 0 )
	end
end
addEvent ( "BuyFlowersServer", true )
addEventHandler ( "BuyFlowersServer", getRootElement(), BuyFlowersServer_func )