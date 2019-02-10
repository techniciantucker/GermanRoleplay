-- Textdraws --
timeForEveryLetter = 50

-- Playerlist --
factioncount = 99

factionMembers = {}
for i = -1, 10 do
	factionMembers[i] = {}
end

factionColors = {}
factionColors[-1] = {}
	factionColors[-1][1] = 100
	factionColors[-1][2] = 100
	factionColors[-1][3] = 100
factionColors[0] = {} -- Zivilist
	factionColors[0][1] = 200
	factionColors[0][2] = 200
	factionColors[0][3] = 200
factionColors[1] = {} -- SAPD
	factionColors[1][1] = 0
	factionColors[1][2] = 255
	factionColors[1][3] = 0
factionColors[2] = {} -- Brigada
	factionColors[2][1] = 115
	factionColors[2][2] = 115
	factionColors[2][3] = 115
factionColors[3] = {} -- Triaden
	factionColors[3][1] = 21
	factionColors[3][2] = 67
	factionColors[3][3] = 207
factionColors[4] = {} -- Calli Kartell
	factionColors[4][1] = 219
	factionColors[4][2] = 175
	factionColors[4][3] = 92
factionColors[5] = {} -- Reporter
	factionColors[5][1] = 255
	factionColors[5][2] = 150
	factionColors[5][3] = 0
factionColors[6] = {} -- FBI
	factionColors[6][1] = 125
	factionColors[6][2] = 125
	factionColors[6][3] = 200
factionColors[7] = {} -- Grove
	factionColors[7][1] = 0
	factionColors[7][2] = 150
	factionColors[7][3] = 0
factionColors[8] = {} -- Army
	factionColors[8][1] = 0
	factionColors[8][2] = 255
	factionColors[8][3] = 0
factionColors[9] = {} -- Biker
	factionColors[9][1] = 99
	factionColors[9][2] = 52
	factionColors[9][3] = 37
factionColors[10] = {} -- Mechaniker
	factionColors[10][1] = 255
	factionColors[10][2] = 100
	factionColors[10][3] = 100

nitroprice = 50
tuningpartprice = 75

uncosts = 1.5

-- Skins
copcars = { [598]=true, [596]=true, [597]=true }
copbikes = { [523]=true }
copjeeps = { [599]=true }
cophelis = { [497]=true }
copvehs = { [598]=true, [596]=true, [597]=true, [523]=true, [599]=true, [497]=true }

copskins = { [280]=true, [281]=true, [282]=true, [283]=true, [284]=true, [285]=true, [288]=true }

-- Mechaniker
mechcars = { [525]=true }