DillimoreDevilsPickup = createPickup(-217.8996887207,1401.8452148438,27.7734375,3,1239,500)
setElementInterior(DillimoreDevilsPickup,18)

TriadenPickup = createPickup(-2170.6044921875,645.93798828125,1052.375,3,1239,500)
setElementInterior(TriadenPickup,1)

BrigadaPickup = createPickup(956.67492675781,-53.531768798828,1001.1171875,3,1239,500)
setElementInterior(BrigadaPickup,3)

CaliKartellPickup = createPickup(2196.2165527344,1671.6799316406,12.3671875,3,1239,500)

GrovePickup = createPickup(2505.58350, -1698.21375, 13.55437,3,1239,500)

function ArmHit(player)
	if isPedInVehicle (player) == false then
		if isEvil(player) then
			infobox(player,"Tippe /arm, um dich für 1500$\nmit Waffen auszurüsten und\n/fumkleide, für die Fraktions Umkleide.")
		else
			infobox(player,"Du bist nicht befugt!",4000,255,0,0)
		end
	end
end
addEventHandler("onPickupHit",DillimoreDevilsPickup,ArmHit)
addEventHandler("onPickupHit",TriadenPickup,ArmHit)
addEventHandler("onPickupHit",BrigadaPickup,ArmHit)
addEventHandler("onPickupHit",CaliKartellPickup,ArmHit)
addEventHandler("onPickupHit",GrovePickup,ArmHit)

addCommandHandler("arm",function(player)
	if isEvil(player) then
		if getDistanceBetweenPoints3D(-217.8996887207,1401.8452148438,27.7734375,getElementPosition(player)) < 5 or getDistanceBetweenPoints3D(-2170.6044921875,645.93798828125,1052.375,getElementPosition(player)) < 5 or getDistanceBetweenPoints3D(956.67492675781,-53.531768798828,1001.1171875,getElementPosition(player)) < 5 or getDistanceBetweenPoints3D(2196.2165527344,1671.6799316406,12.3671875,getElementPosition(player)) < 5 or getDistanceBetweenPoints3D(2505.58350, -1698.21375, 13.55437,getElementPosition(player)) < 5 then
			if isPedInVehicle (player) == false then
				if westsideGetElementData(player,"money") >= 1500 then
					giveWeapon(player,24,50,true)
					giveWeapon(player,29,500,true)
					giveWeapon(player,31,500,true)
					giveWeapon(player,33,50,true)
					setElementHealth(player,100)
					setPedArmor(player,100)
					
					takePlayerSaveMoney(player,1500)
					infobox(player,"Du hast dich auszurüstet!",4000,0,255,0)
				else
					infobox(player,"Du hast nicht genug Geld!",4000,255,0,0)
				end
			else
				infobox(player,"Steige aus deinem Fahrzeug aus!")
			end
		else
			infobox(player,"Du bist an keinem /arm Marker!",4000,255,0,0)
		end
	else
		infobox(player,"Du bist nicht befugt!",4000,255,0,0)
	end
end)