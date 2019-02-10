local bergwerkFahrzeuge={}

local bergWerkMarker={ 
{780.6376953125,834.013671875,6.0685515403748}, 
{761.990234375,887.02734375,-1.0214252471924}, 
{757.0986328125,933.28125,6.0846247673035}, 
{715.546875,984.8310546875,6.0937972068787}, 
{655.400390625,1000.134765625,6.0895495414734}, 
{550.0283203125,991.7216796875,-5.5585160255432}, 
{587.4228515625,979.2021484375,-6.791543006897}, 
{637.08203125,982.5859375,-7.1999607086182}, 
{678.697265625,971.5791015625,-12.483222961426}, 
{728.5830078125,946.3642578125,-7.1815962791443}, 
{757.822265625,838.33203125,-7.1906428337097}, 
{712.396484375,757.2431640625,-6.446355342865}, 
{659.1689453125,728.845703125,-3.5345470905304}, 
{641.2763671875,745.552734375,-11.624731063843}, 
{550.583984375,781.3525390625,-18.2103099823}, 
{707.2705078125,943.0888671875,-18.474489212036}, 
{710.82421875,917.689453125,-18.43604850769}, 
{727.5078125,889.470703125,-26.286144256592}, 
{734.703125,841.6630859375,-18.450113296509}, 
{727.9228515625,804.3701171875,-18.45757484436}, 
{689.4140625,769.818359375,-18.466459274292}, 
{637.5966796875,966.466796875,-18.469551086426}, 
{591.203125,964.982421875,-18.484901428223}, 
{534.6044921875,954.7607421875,-21.401294708252}, 
{572.0771484375,944.3115234375,-30.193265914917}, 
{639.4072265625,950.2939453125,-34.697402954102}, 
{690.578125,925.58203125,-29.968132019043}, 
{713.4052734375,860.3388671875,-29.471879959106}, 
{688.2177734375,847.26171875,-27.970180511475}, 
{676.3857421875,826.9267578125,-28.1953125}, 
{688.8427734375,792.955078125,-30.012126922607}, 
{614.1953125,793.09765625,-31.834470748901}, 
{471.185546875,871.93359375,-28.775455474854}, 
{534.9111328125,882.6181640625,-36.291439056396}, 
{549.3935546875,862.0732421875,-42.703006744385}, 
{592.361328125,854.462890625,-42.809783935547}, 
{636.1767578125,872.62109375,-42.738338470459}, 
{679.9541015625,884.7333984375,-39.568901062012}, 
{648.3388671875,902.876953125,-41.723373413086}, 
{599.7080078125,902.904296875,-44.830863952637}
}

local bergwerkArbeiterPickup=createPickup(816.55212402344,857.05157470703,12.7890625,3,1274,50)

addEventHandler('onPickupHit',bergwerkArbeiterPickup,function(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		triggerClientEvent(player,'BerkwerkWindow',player)
	end
end)

addEvent('bergwerkArbeiterAnnehmen',true)
addEventHandler('bergwerkArbeiterAnnehmen',root,function(player)
	if(westsideGetElementData(player,'job')=='Bergwerksarbeiter')then
		infobox(player,'Du bist bereits Bergwerksarbeiter!')
	else
		westsideSetElementData(player,'job','Bergwerksarbeiter')
		infobox(player,'Du bist nun Bergwerksarbeiter!')
	end
end)
 
function createDozers()
	vehicle= createVehicle(486,838.125,836.66796875,12.584193229675,359.12658691406,354.01245117188,354.77600097656)
	table.insert(bergwerkFahrzeuge,vehicle)
	addEventHandler("onVehicleStartEnter",vehicle,startEnterbergwerkFahrzeuge)
	addEventHandler("onVehicleEnter",vehicle,enterbergwerkFahrzeuge)
	addEventHandler("onVehicleExit",vehicle,exitbergwerkFahrzeuge)
	vehicle= createVehicle(486,832.166015625,836.607421875,12.024010658264,357.91809082031,355.166015625,2.054443359375)
	table.insert(bergwerkFahrzeuge,vehicle)
	addEventHandler("onVehicleStartEnter",vehicle,startEnterbergwerkFahrzeuge)
	addEventHandler("onVehicleEnter",vehicle,enterbergwerkFahrzeuge)
	addEventHandler("onVehicleExit",vehicle,exitbergwerkFahrzeuge)
	vehicle= createVehicle(486,827.23828125,836.4169921875,11.597550392151,357.06115722656,354.5947265625,5.262451171875)
	table.insert(bergwerkFahrzeuge,vehicle)
	addEventHandler("onVehicleStartEnter",vehicle,startEnterbergwerkFahrzeuge)
	addEventHandler("onVehicleEnter",vehicle,enterbergwerkFahrzeuge)
	addEventHandler("onVehicleExit",vehicle,exitbergwerkFahrzeuge)
	vehicle= createVehicle(486,822.5830078125,836.0126953125,11.112034797668,356.50634765625,353.64990234375,5.6964111328125)
	table.insert(bergwerkFahrzeuge,vehicle)
	addEventHandler("onVehicleStartEnter",vehicle,startEnterbergwerkFahrzeuge)
	addEventHandler("onVehicleEnter",vehicle,enterbergwerkFahrzeuge)
	addEventHandler("onVehicleExit",vehicle,exitbergwerkFahrzeuge)
	vehicle= createVehicle(486,817.6357421875,835.1611328125,10.589272499084,355.80322265625,354.01794433594,11.920166015625)
	table.insert(bergwerkFahrzeuge,vehicle)
	addEventHandler("onVehicleStartEnter",vehicle,startEnterbergwerkFahrzeuge)
	addEventHandler("onVehicleEnter",vehicle,enterbergwerkFahrzeuge)
	addEventHandler("onVehicleExit",vehicle,exitbergwerkFahrzeuge)
	respawnbergwerkFahrzeuge()
	checkDistanceBergWerk()
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createDozers)

local grundpos={594,873,-44}
local maxDis=360

function checkDistanceBergWerk()
	for key, theVehicle in pairs(bergwerkFahrzeuge) do
		if(isElement(theVehicle))then
			local x,y,z=getElementPosition(theVehicle)
			if(getDistanceBetweenPoints3D(x,y,z,grundpos[1],grundpos[2],grundpos[3])>maxDis)then
				blowVehicle(theVehicle,true)
				createExplosion(x,y,z,4)
			end	
		end
	end
	setTimer(checkDistanceBergWerk,10000,1)	
end

function startEnterbergwerkFahrzeuge(thePlayer)
	if(not(westsideGetElementData(thePlayer,'job')=='Bergwerksarbeiter'))then
		infobox(thePlayer,'Du bist nicht befugt!')
		cancelEvent()	
	end
end

function respawnbergwerkFahrzeuge()
	for key, theVehicle in pairs(bergwerkFahrzeuge) do
		if(getVehicleOccupant(theVehicle)==false)then
			setVehicleOverrideLights (theVehicle,1)
			setVehicleEngineState (theVehicle,false)				
			respawnVehicle (theVehicle)
		end
	end
	setTimer(respawnbergwerkFahrzeuge,300000,1)		
end
 
function enterbergwerkFahrzeuge(thePlayer)
	setElementData(thePlayer,'aktiverBergwertarbeiter',true)
	local markerrandom=math.random(1,table.getn(bergWerkMarker))
	if(getElementData(thePlayer,"lastBergWerkMarker"))then
		markerrandom=getElementData(thePlayer,"lastBergWerkMarker")
	end
	
	local markerelement=createMarker(bergWerkMarker[markerrandom][1],bergWerkMarker[markerrandom][2],bergWerkMarker[markerrandom][3],"checkpoint", 4,200,0,0,0,thePlayer)
	addEventHandler("onMarkerHit",markerelement,enterbergWerkMarker)
	setElementData(thePlayer,"bergMarker",markerelement)
	setElementData(thePlayer,"lastBergWerkMarker",markerrandom)
	outputChatBox('~~~~~ Bergwerksarbeiter ~~~~~',thePlayer,255,255,255)
	outputChatBox('Fahre mit dem Dozer die Marker in der Grube ab.',thePlayer,0,200,0)
	
	outputLog('[BERGWERK]: '..getPlayerName(thePlayer)..' hat den Job gestartet/ist eingestiegen','Jobsystem')
end

function enterbergWerkMarker(thePlayer)
	if(getElementType(thePlayer)~="player")then
		return false
	end
	if(isPedInVehicle(thePlayer))then
		if(getElementModel(getPedOccupiedVehicle(thePlayer))==486)then
		
		else
			exitbergwerkFahrzeuge(thePlayer)
			return false
		end
	else
		exitbergwerkFahrzeuge(thePlayer)
		return false	
	end
	if(source==getElementData(thePlayer,"bergMarker"))then		
		destroyElement(getElementData(thePlayer,"bergMarker"))

		if(westsideGetElementData(thePlayer,'level')<11)then
			bergbetrag=90
		elseif(westsideGetElementData(thePlayer,'level')>10)and(westsideGetElementData(thePlayer,'level')<21)then
			bergbetrag=140
		elseif(westsideGetElementData(thePlayer,'level')>20)and(westsideGetElementData(thePlayer,'level')<26)then
			bergbetrag=200
		end
		
		outputChatBox('Du hast für deine Arbeit '..bergbetrag..'$ erhalten!',thePlayer,0,200,0)
		if(westsideGetElementData(thePlayer,'playingtime')<=600)then
			outputChatBox('Das erarbeitete Geld erhältst du erst beim Payday!',thePlayer)
		end
		westsideSetElementData(thePlayer,'jobgehalt',tonumber(westsideGetElementData(thePlayer,'jobgehalt'))+bergbetrag)
		
		westsideSetElementData(thePlayer,'Punkte_Bergwerkarbeiter',tonumber(westsideGetElementData(thePlayer,'Punkte_Bergwerkarbeiter'))+1)
		if(westsideGetElementData(thePlayer,'Punkte_Bergwerkarbeiter')>1999)then
			if(westsideGetElementData(thePlayer,'Erfolg_Bergwerkarbeiter')==0)then
				triggerClientEvent(thePlayer,'erfolgWindow',thePlayer,'Überschüttet von Steinen')
				westsideSetElementData(thePlayer,'Erfolg_Bergwerkarbeiter',1)
				westsideSetElementData(thePlayer,'pokale',tonumber(westsideGetElementData(thePlayer,'pokale'))+1)
				outputLog(getPlayerName(thePlayer)..' hat den Erfolg Überschüttet von Steinen freigeschalten','Erfolge')
			end
		end
		westsideSetElementData(thePlayer,'erfahrungspunkte',tonumber(westsideGetElementData(thePlayer,'erfahrungspunkte'))+10)
		
		outputLog('[BERGWERK]: '..getPlayerName(thePlayer)..' hat einen Marker durchfahren','Jobsystem')

		local markerrandom=math.random(1,table.getn(bergWerkMarker))
		local markerelement=createMarker(bergWerkMarker[markerrandom][1],bergWerkMarker[markerrandom][2],bergWerkMarker[markerrandom][3], "checkpoint",4,200,0,0,0,thePlayer)
		addEventHandler("onMarkerHit",markerelement,enterbergWerkMarker)
		setElementData(thePlayer,"bergMarker",markerelement)	
		infobox(thePlayer,'Ab zum nächsten Marker!')	
		setElementData(thePlayer,"lastBergWerkMarker",markerrandom)
	end
end

function exitbergwerkFahrzeuge(thePlayer)
	if(isElement(getElementData(thePlayer,"bergMarker")))then
		if(isElement(getElementData(thePlayer,"bergMarker")))then
			destroyElement(getElementData(thePlayer,"bergMarker"))
		end
		setElementData(thePlayer,"bergMarker",false)
		setElementData(thePlayer,'aktiverBergwertarbeiter',false)
		outputLog('[BERGWERK]: '..getPlayerName(thePlayer)..' hat den Job beendet/ist ausgestiegen','Jobsystem')
	end
end

function bergWerksPlayerDead()
	if(getElementData(source,'aktiverBergwertarbeiter')==true)then
		exitbergwerkFahrzeuge(source)
		setElementData(source,'aktiverBergwertarbeiter',false)
	end
end
addEventHandler("onPlayerWasted",getRootElement(),bergWerksPlayerDead)