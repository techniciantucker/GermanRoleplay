spawnPointListCMD1 = {
 ["Noobspawn (LS)"]="streetLS",
 
 ['Fahrschule']='fahrschuleLS',
 ['Anwaltskanzlei']='anwaltLS',
 ['Detektei']='detektivLS',

 ["Haus"]="house",
 ["Basis"]="faction",
 
 ---Sapd---
 ["Police Department (LS)"]="faction",
 
 ---Brigada---
 ["Brigada Base"]="faction",
 
 ---Triaden---
 ["Triaden Basis"]="faction",
 
 ---Cali Kartell---
 ["Cali Kartell Base"]="faction",
 
 ---Army---
 ["Flugzeugtraeger"]="faction",
 
 ["Area 51"]="faction",
---Reporter---
 ["Reporter Basis (LS)"]="faction",
 
 ---Fbi---
 ["FBI Basis (LS)"]="faction",
 
 ---Grove---
 ["Grove Street Base"]="faction",
 
  ---D. Devils---
 ["D. Devils Base"]="faction",
 
 ---Mechaniker---
 ["Mechaniker Basis"]="faction",
 
 ---Hier, Yacht & Wohnwagen---
 ["Hier"]="hier",
 ["Yacht"]="boat",
 ["Wohnwagen"]="wohnmobil"
 }

spawnPointListCMD2 = {
 ["Noobspawn (LS)"]="",
 
 ['Fahrschule']='',
 ['Anwaltskanzlei']='',
 ['Detektei']='',
 
 ["Haus"]="",
 ["Basis"]="",
 
 ---Sapd---
 ["Police Department (LS)"]="lspd",
 
 ---Brigada---
 ["Brigada Base"]="brigada",
 
 ---Triaden---
 ["Triaden Basis"]="triaden",
 
 ---Cali Kartell---
 ["Cali Kartell Base"]="kartell",
 
 ---Army---
 ["Flugzeugtraeger"]="sf",
 
 ["Area 51"]="lv",
 ---Reporter---
 ["Reporter Basis (LS)"]="reporterLS",
 
  ---Fbi-------
 ["FBI Basis (LS)"]="fbiLS",
 
  ---Grove---
 ["Grove Street Base"]="grovestreet",
 
 ---D. Devils---
 ["D. Devils Base"]="bikerLS",
 
 ---Mechaniker---
  ["Mechaniker Basis"]="mechaniker",
  
 ---Hier, Yacht & Wohnwagen---
 ["Hier"]="",
 ["Yacht"]="",
 ["Wohnwagen"]=""
 }

factionsInBothCitys = {
 [1]=true, ---Sapd----------
 [2]=true, ---Brigada-------
 [3]=true, ---Triaden-------
 [6]=true, ---Fbi-----------
 [7]=true, ---Grove---------
 [8]=true, ---Army----------
 [9]=true, ---D. Devils-----
 [10]=true ---Mechaniker----
 }

function showSpawnSelection ()

	if isElement ( gWindow["spawnPointSelection"] ) then
		hideall();
		guiSetVisible ( gWindow["spawnPointSelection"], true )
	else
		hideall();
		gWindow["spawnPointSelection"] = guiCreateStaticImage(0.22, 0.19, 0.19, 0.47, "Images/Background.png", true)

		gGrid["availableSpawnPoints"] = guiCreateGridList(0.04, 0.05, 0.93, 0.60, true, gWindow["spawnPointSelection"])
		guiGridListSetSelectionMode(gGrid["availableSpawnPoints"],2)
		guiSetAlpha(gGrid["availableSpawnPoints"], 0.85)
		gColumn["spawnPoint"] = guiGridListAddColumn(gGrid["availableSpawnPoints"],"Startpunkte", 0.9)
		guiSetAlpha(gGrid["availableSpawnPoints"],1)
		gButton["changeSpawnPoint"] = guiCreateButton(0.04, 0.66, 0.92, 0.06, "Spawnpunkt setzen", true, gWindow["spawnPointSelection"])
		guiSetFont(gButton["changeSpawnPoint"],"default-bold-small")
		
		addEventHandler ( "onClientGUIClick", gButton["changeSpawnPoint"],
			function ()
				local row, column = guiGridListGetSelectedItem ( gGrid["availableSpawnPoints"] )
				local text = guiGridListGetItemText ( gGrid["availableSpawnPoints"], row, column )
				
				local cmd1 = spawnPointListCMD1[text]
				local cmd2 = spawnPointListCMD2[text]
				
				if cmd1 then
					triggerServerEvent ( "changeSpawnPosition", lp, cmd1, cmd2 )
				end
			end,
		false )
	end
	fillSpawnPointList ()
end

function fillSpawnPointList ()
	guiGridListClear ( gGrid["availableSpawnPoints"] )
	local row
	---NOOBSPAWN LS---
	row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
	guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "Noobspawn (LS)", false, false )
	----- Unternehmen -----
	if(getElementData(lp,'unternehmen')==1)then
		row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
		guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "Fahrschule", false, false )
	elseif(getElementData(lp,'unternehmen')==2)then
		row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
		guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "Anwaltskanzlei", false, false )
	elseif(getElementData(lp,'unternehmen')==3)then
		row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
		guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "Detektei", false, false )
	end
	---HAUS---
	if getElementData ( lp, "housekey" ) ~= 0 then
		row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
		guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "Haus", false, false )
	end
	---FRAKTIONEN---
	local fraktion = getElementData ( lp, "fraktion" )
	if fraktion == 1 then
		row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
		guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "Police Department (LS)", false, false )
	elseif fraktion == 2 then
		row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
		guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "Brigada Base", false, false )
	elseif fraktion == 3 then
		row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
		guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "Triaden Basis", false, false )
	elseif fraktion == 4 then
		row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
		guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "Cali Kartell Base", false, false )
	elseif fraktion == 5 then
		row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
		guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "Reporter Basis (LS)", false, false )	
	elseif fraktion == 6 then
		row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
		guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "FBI Basis (LS)", false, false )
	elseif fraktion == 7 then
		row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
		guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "Grove Street Base", false, false )
	elseif fraktion == 8 then
		row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
		guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "Flugzeugtraeger", false, false )
		row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
		guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "Area 51", false, false )
	elseif fraktion == 9 then
		row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
		guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "D. Devils Base", false, false )
	elseif fraktion == 10 then
		row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
		guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "Mechaniker Basis", false, false )		
	elseif fraktion > 0 then
		row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
		guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "Basis", false, false )
	end
	
	-- Vip --
	if getElementData(lp,"vip") > 0 then
		row = guiGridListAddRow ( gGrid["availableSpawnPoints"] )
		guiGridListSetItemText ( gGrid["availableSpawnPoints"], row, gColumn["spawnPoint"], "Hier", false, false )
	end
end