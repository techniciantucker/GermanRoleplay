root = getRootElement ()
rangedWeapons = {}
	for i = 0, 50 do
		rangedWeapons[i] = false
	end
	rangedWeapons[22] = true
	rangedWeapons[23] = true
	rangedWeapons[24] = true
	rangedWeapons[25] = true
	rangedWeapons[26] = true
	rangedWeapons[27] = true
	rangedWeapons[28] = true
	rangedWeapons[29] = true
	rangedWeapons[32] = true
	rangedWeapons[30] = true
	rangedWeapons[31] = true
	rangedWeapons[33] = true
	rangedWeapons[34] = true
	rangedWeapons[35] = true
	rangedWeapons[36] = true
	rangedWeapons[37] = true
	rangedWeapons[38] = true
	
root = getRootElement()

_takePlayerMoney = takePlayerMoney
_givePlayerMoney = givePlayerMoney

function takePlayerMoney ()
end
function givePlayerMoney ()
end

curVersion = "1.2"

-- Handy
prePaidPrices = {
 ["low"]=50,
 ["middle"] = 100,
 ["large"] = 250
 }

-- Fahrzeuge
singleTrunkWeapons = { [16]=true, [17]=true, [18]=true, [39]=true }

-- 24/7
flowers_price = 5
cam_price = 40
camammo_price = 36
nvgoogles_price = 150
tgoogles_price = 150
wuerfel_price = 10
rubbellos_price = 10
zigarett_price = 25
beer_price = 10

-- DayNames
daynames = { [0]="Mo", [1]="Di", [2]="Mi", [3]="Do", [4]="Fr", [5]="Sa", [6]="So" }

-- Pennerskins
malehomeless = { [1]=78, [2]=79, [3]=134, [4]=135, [4]=136, [5]=137 }
femalehomeless = { [1]=77 }

-- Animationen --
animationCMDs = {
"handsup",
"phoneout",
"phonein",
"drunk",
"robman",
"bomb",
"getarrested",
"laugh",
"lookout",
"crossarms",
"lay",
"hide",
"vomit",
"wave",
"slapass",
"deal",
"crack",
"smoke",
"smokef",
"ground",
"fucku",
"chat",
"taichi",
"chairsit",
"dance",
"piss",
"wank"
}

-- Fahrzeugliste
evelse = { [594]=true }
trailers = { [606]=true,  [607]=true, [610]=true, [590]=true, [569]=true, [611]=true, [584]=true, [608]=true, [435]=true, [450]=true, [591]=true}
rc_vehs = { [464]=true, [501]=true, [465]=true, [564]=true }
trains = { [537]=true, [538]=true, [569]=true, [590]=true, [537]=true, [449]=true, }
cars = { [579]=true, [400]=true, [404]=true, [489]=true, [505]=true, [479]=true, [442]=true, [458]=true, [402]=true, [429]=true, [411]=true, [559]=true, [541]=true, [415]=true, [561]=true, [480]=true, [560]=true, [562]=true, [506]=true, [565]=true, 
[451]=true, [434]=true, [558]=true, [555]=true, [477]=true, [503]=true, [502]=true, [494]=true, [434]=true, [565]=true, [568]=true, [557]=true, [424]=true, [504]=true, [495]=true, [539]=true, [483]=true, [508]=true, [500]=true,  [444]=true,
[556]=true, [536]=true, [575]=true, [534]=true, [542]=true, [567]=true, [535]=true, [576]=true, [412]=true, [459]=true, [422]=true, [482]=true, [605]=true, [530]=true, [418]=true, [582]=true, [413]=true, [440]=true, [543]=true, [583]=true, [478]=true,
[554]=true, [602]=true, [496]=true, [401]=true, [518]=true, [527]=true, [589]=true, [419]=true, [533]=true, [526]=true, [474]=true, [545]=true, [517]=true, [410]=true, [600]=true, [436]=true, [580]=true, [439]=true, [549]=true, [491]=true,
[445]=true, [604]=true, [507]=true, [585]=true, [466]=true, [492]=true, [546]=true, [551]=true, [516]=true, [467]=true, [426]=true, [547]=true, [405]=true, [409]=true, [550]=true, [566]=true, [540]=true, [529]=true, [485]=true,
[574]=true, [420]=true, [525]=true, [552]=true, [416]=true, [596]=true, [597]=true, [499]=true, [428]=true, [598]=true, [470]=true, [528]=true, [590]=true }
lkws = { [499]=true, [609]=true, [498]=true, [524]=true, [532]=true, [578]=true, [486]=true, [406]=true, [573]=true, [455]=true, [588]=true, [403]=true, [514]=true, [423]=true, [414]=true, [443]=true, [515]=true, [531]=true, [456]=true,
[433]=true, [427]=true, [407]=true, [544]=true, [432]=true, [431]=true, [437]=true, [408]=true, }

motorboats = { [472]=true, [473]=true, [493]=true, [595]=true, [430]=true, [453]=true, [452]=true, [446]=true }
bikes = { [471]=true, [523]=true, [581]=true, [521]=true, [463]=true, [522]=true, [461]=true, [468]=true, [586]=true }
raftboats = { [484]=true, [454]=true }
helicopters = { [548]=true, [425]=true, [417]=true, [487]=true, [488]=true, [497]=true, [563]=true, [447]=true, [469]=true }
planea = { [512]=true, [593]=true, [476]=true, [460]=true, [513]=true }	-- Propeller
planeb = { [592]=true, [577]=true, [511]=true, [520]=true, [553]=true, [519]=true }	-- Düsenjets
nolicense = { [457]=true, [539]=true, [571]=true, [572]=true, [509]=true, [481]=true, [462]=true, [510]=true, [448]=true, [438]=true }

-- Trucker --
tour1Price = 75
tour2Price = 125
tour3Price = 175
tour4Price = 250
maxdamage = 100
trucks = { [515]=true, [514]=true, [403]=true }
truckTrailer = { [435]=true, [450]=true, [591]=true }

-- Farben --
markerred = 125, 0, 0, 255

-- Tankstelle & Burgershot --
literPrice = 1.25
kannisterPrice = 35

-- Fraktionen --
fraktionsNamen = { [0]="Zivilist", [1]="SAPD", [2]="Brigada", [3]="Triaden", [4]="Cali Kartell", [5]="Reporter", [6]="F.B.I", [7]="Grove Street", [8]="Army", [9]= "Dillymore Devils", [10]="Mechaniker" }