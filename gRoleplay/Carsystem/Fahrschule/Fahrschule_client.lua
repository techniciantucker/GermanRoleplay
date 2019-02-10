local drivingSchoolCorrectQuestions, drivingSchoolCurQuestion

local drivingLicenses = {}
 drivingLicenses["question"] = {
  [1]="Wie schnell darfst du in der Stadt fahren?",
  [2]="Wo darfst du nicht parken?",
  [3]="Wofür steht die Abkürzung Stvo?",
  [4]="Was darfst du während des fahrens nicht?",
  [5]="Was ist an einer Kreuzung ohne Ampeln zu beachten?",
  [6]="Was tust du, wenn ein Staatsfahrzeug sich dir nähert?",
  [7]="Was gilt in einer Einbahnstrasse?"
 }
 drivingLicenses["answereA"] = {
  [1]="80 km/h",
  [2]="In der Tiefgarage",
  [3]="Strassen Verkehrs Ordnung",
  [4]="Telefonieren bzw. das Handy nutzen",
  [5]="Die Landschaft",
  [6]="Abremsen, aussteigen und wegrennen",
  [7]="Nichts besonderes"
 }
 drivingLicenses["answereB"] = {
  [1]="100 km/h",
  [2]="Auf Parkplätzen",
  [3]="Stammtisch Versammlung",
  [4]="Den Radiosender wechseln",
  [5]="Rechts vor Links",
  [6]="An den Strassenrand fahren und halten",
  [7]="Wenden verboten"
 }
 drivingLicenses["answereC"] = {
  [1]="120 km/h",
  [2]="Am Strassenrand",
  [3]="Seriöses Vorstellungsgespräch",
  [4]="Das Licht an und ausschalten",
  [5]="Links vor Rechts",
  [6]="Winken, Hupen und weiterfahren",
  [7]="Parken verboten"
 }
 drivingLicenses["answereD"] = {
  [1]="Es gibt keine km/h Begrenzung",
  [2]="Auf Strassen und Privatgrundstücken",
  [3]="Sahniges Volksfest",
  [4]="Verkehrsschilder lesen",
  [5]="Schönheit vor Alter",
  [6]="Sein eigenes Fahrzeug quer auf die Strasse stellen",
  [7]="Anhalten"
 }
 drivingLicenses["correct"] = {
  [1]=1,
  [2]=4,
  [3]=1,
  [4]=1,
  [5]=2,
  [6]=2,
  [7]=2
 }

function startDrivingLicenseTheory_func ()
	showCursor ( true )
	drivingSchoolCorrectQuestions = 0
	drivingSchoolCurQuestion = 1
	showDrivingLicenseQuestion ( 1 )
end
addEvent ( "startDrivingLicenseTheory", true )
addEventHandler ( "startDrivingLicenseTheory", getRootElement(), startDrivingLicenseTheory_func )

function showDrivingLicenseQuestion ( questionNR )
	drivingSchoolCurQuestion = questionNR
	gWindow["drivingLicenseTheory"] = guiCreateStaticImage(0.38, 0.01, 0.24, 0.40, "Images/Background.png", true)

	gLabel["drivingLicenseTheoryQuestion"] = guiCreateLabel(0.03, 0.08, 0.94, 0.19,drivingLicenses["question"][questionNR],true,gWindow["drivingLicenseTheory"])
	guiSetAlpha(gLabel["drivingLicenseTheoryQuestion"],1)
	guiLabelSetColor(gLabel["drivingLicenseTheoryQuestion"],255,255,255)
	guiLabelSetVerticalAlign(gLabel["drivingLicenseTheoryQuestion"],"top")
	guiLabelSetHorizontalAlign(gLabel["drivingLicenseTheoryQuestion"],"left",true)
	guiSetFont(gLabel["drivingLicenseTheoryQuestion"],"clear-normal")
	gButton["drivingLicenseTheorySend"] = guiCreateButton(0.23, 0.89, 0.54, 0.08, "Bestätigen", true,gWindow["drivingLicenseTheory"])
	guiSetAlpha(gButton["drivingLicenseTheorySend"],1)
	guiSetFont(gButton["drivingLicenseTheorySend"],"default-bold-small")
	gRadio["drivingShoolAnswereA"] = guiCreateRadioButton(0.03, 0.29, 0.94, 0.07,drivingLicenses["answereA"][questionNR],true,gWindow["drivingLicenseTheory"])
	guiSetAlpha(gRadio["drivingShoolAnswereA"],1)
	guiSetFont(gRadio["drivingShoolAnswereA"],"default-bold-small")
	gRadio["drivingShoolAnswereB"] = guiCreateRadioButton(0.03, 0.39, 0.94, 0.07,drivingLicenses["answereB"][questionNR],true,gWindow["drivingLicenseTheory"])
	guiSetAlpha(gRadio["drivingShoolAnswereB"],1)
	guiSetFont(gRadio["drivingShoolAnswereB"],"default-bold-small")
	gRadio["drivingShoolAnswereC"] = guiCreateRadioButton(0.03, 0.50, 0.94, 0.07,drivingLicenses["answereC"][questionNR],true,gWindow["drivingLicenseTheory"])
	guiSetAlpha(gRadio["drivingShoolAnswereC"],1)
	guiSetFont(gRadio["drivingShoolAnswereC"],"default-bold-small")
	gRadio["drivingShoolAnswereD"] = guiCreateRadioButton(0.03, 0.60, 0.94, 0.07,drivingLicenses["answereD"][questionNR],true,gWindow["drivingLicenseTheory"])
	guiSetAlpha(gRadio["drivingShoolAnswereD"],1)
	guiSetFont(gRadio["drivingShoolAnswereD"],"default-bold-small")
	addEventHandler ( "onClientGUIClick", gButton["drivingLicenseTheorySend"],function ()
		local selected
		if guiRadioButtonGetSelected ( gRadio["drivingShoolAnswereA"] ) then
			selected = 1
		elseif guiRadioButtonGetSelected ( gRadio["drivingShoolAnswereB"] ) then
			selected = 2
		elseif guiRadioButtonGetSelected ( gRadio["drivingShoolAnswereC"] ) then
			selected = 3
		elseif guiRadioButtonGetSelected ( gRadio["drivingShoolAnswereD"] ) then
			selected = 4
		else
			selected = 5
		end
		destroyElement ( gWindow["drivingLicenseTheory"] )
		if drivingLicenses["correct"][drivingSchoolCurQuestion] == selected then
			drivingSchoolCorrectQuestions = drivingSchoolCorrectQuestions + 1
		end
		if drivingSchoolCurQuestion < 7 then
			showDrivingLicenseQuestion ( drivingSchoolCurQuestion + 1 )
		else
			triggerServerEvent ( "drivingSchoolTheoryComplete", lp, drivingSchoolCorrectQuestions )
		end
	end,false )
end

function drivingSchoolFinished_func ()
end
addEvent ( "drivingSchoolFinished", true )
addEventHandler ( "drivingSchoolFinished", getRootElement(), drivingSchoolFinished_func )

function checkDrivingSchoolSpeed_func ()
	if getElementData ( lp, "drivingSchoolPractise" ) then
		local vx, vy, vz = getElementVelocity ( getPedOccupiedVehicle ( lp ) )
		local speed = math.sqrt ( vx ^ 2 + vy ^ 2 + vz ^ 2 )		
		if speed > 90 * 0.00464 then
			triggerServerEvent ( "drivingSchoolToFast", lp )
		else
			setTimer ( checkDrivingSchoolSpeed_func, 500, 1 )
		end
	end
end
addEvent ( "checkDrivingSchoolSpeed", true )
addEventHandler ( "checkDrivingSchoolSpeed", getRootElement(), checkDrivingSchoolSpeed_func )