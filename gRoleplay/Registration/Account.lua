﻿tablesToMoveOver = {
 ["inventar"] = true,
 ["packages"] = true,
 ["players"] = true,
 ["userdata"] = true
 }

pnameColumn = {
 }

fieldDatas = {}
fieldNames = {}

for key, index in pairs ( tablesToMoveOver ) do
	fieldDatas[key] = {}
	local i = 0
	local fieldString = ""
	local result = mysql_query ( handler_old, "SHOW FIELDS FROM `"..key.."`" )
	while mysql_num_rows ( result ) > 0 do
		i = i + 1
		local data = mysql_fetch_assoc ( result )
		if data then
			if # fieldString > 0 then
				fieldString = fieldString..", "
			end
			fieldDatas[key][i] = data["Field"]
			fieldString = fieldString.." "..data["Field"]
		else
			break
		end
	end
	fieldNames[key] = fieldString
	mysql_free_result ( result )
end

function isRegistered ( pname )

	if MySQL_DatasetExist ( "players", "Name LIKE '"..MySQL_Save ( pname ).."'") then
		return true
	else
		local result = mysql_query ( handler_old, "SELECT * from players WHERE Name LIKE '"..pname.."'" )
		if result then
			if mysql_num_rows ( result ) > 0 then
				removeAccountIntoNewDatabase ( pname )
				mysql_free_result ( result )
				return true
			end
			mysql_free_result ( result )
		end
	end
	return false
end

function moveAccountToOldDatabase ( name )
	if (gMysqlDatabase1 ~= gMysqlDatabase2) then
		local query, dsatz, i, fieldValues, result
		local errorC = 1
		for key1, index1 in pairs ( tablesToMoveOver ) do
			local fix
			if pnameColumn[key1] then
				fix = pnameColumn[key1]
			else
				fix = "Name"
			end
			mysql_vio_old_query ( "DELETE FROM "..key1.." WHERE "..fix.." LIKE '"..name.."'" )
			result = mysql_query ( handler, "SELECT * from "..key1.." WHERE "..fix.." LIKE '"..name.."'")
			if result then
				if mysql_num_rows ( result ) > 0 then
					dsatz = mysql_fetch_assoc ( result )
					mysql_free_result ( result )
					while not MySQL_DatasetOldExist ( key1, fix.." LIKE '"..name.."'" ) and errorC < 10 do
						errorC = errorC + 1
						fieldValues = ""
					
						i = 0
						for key2, index2 in pairs ( fieldDatas[key1] ) do
							i = i + 1
							if i > 1 then
								fieldValues = fieldValues..","
							end
							fieldValues = fieldValues.."'"..dsatz[fieldDatas[key1][i]].."'"
						end
						query = "INSERT INTO "..key1.." ( "..fieldNames[key1].." ) VALUES ( "..fieldValues.." )"
					
						mysql_vio_old_query ( query )
					end
					if errorC >= 10 then
						print ( "ERROR C!" )
						errorC = 1
					end
				
					mysql_vio_query ( "DELETE FROM "..key1.." WHERE "..fix.." LIKE '"..name.."'" )
				
				
					moveVehiclesToOldDatabase ( name )
				end
			end
		end
	else
		outputLog ( "Spielerdaten werden nicht ausgelagert, da nur eine Datenbank existiert!", "outsource" )
	end
end

function removeAccountIntoNewDatabase ( name )
	if (gMysqlDatabase1 ~= gMysqlDatabase2) then
	local query, dsatz
	for key1, index1 in pairs ( tablesToMoveOver ) do
		local fix
		if pnameColumn[key1] then
			fix = pnameColumn[key1]
		else
			fix = "Name"
		end
		result = mysql_query ( handler_old, "SELECT * from "..key1.." WHERE "..fix.." LIKE '"..name.."'")
		if mysql_num_rows ( result ) > 0 then
			dsatz = mysql_fetch_assoc ( result )
			mysql_free_result ( result )
			
			local fieldValues = ""
			
			local i = 0
			for key2, index2 in pairs ( fieldDatas[key1] ) do
				i = i + 1
				if i > 1 then
					fieldValues = fieldValues..","
				end
				fieldValues = fieldValues.."'"..dsatz[fieldDatas[key1][i]].."'"
			end
			query = "INSERT INTO "..key1.." ( "..fieldNames[key1].." ) VALUES ( "..fieldValues.." )"
			
			local result = mysql_query ( handler, query )
			if result then
				mysql_free_result ( result )
			end
			
			local result = mysql_query ( handler_old, "DELETE FROM "..key1.." WHERE "..fix.." LIKE '"..name.."'" )
			if result then
				mysql_free_result ( result )
			end
			
			moveVehiclesToNewDatabase ( name )
		end
	end
	end
end

function outSourceAccounts ()
	if (gMysqlDatabase1 ~= gMysqlDatabase2) then
	local outsourcedAccounts = 0
	local cur = getSecTime ( - ( 3 * 24 ) )
	local result = mysql_query ( handler, "SELECT * FROM players")
	local accountsToMove = {}
	local i = 0
	while true do
		dsatz = mysql_fetch_assoc ( result )
		if dsatz then
			i = i + 1
			if tonumber ( dsatz["LastLogin"] ) < cur then
				accountsToMove[dsatz["Name"]] = true
				outsourcedAccounts = outsourcedAccounts + 1
			end
		else
			break
		end
	end
	for key, index in pairs ( accountsToMove ) do
		moveAccountToOldDatabase ( key )
	end
	outputServerLog ( "Es wurden "..outsourcedAccounts.." Accounts ausgelagert." )
	if result then
		mysql_free_result ( result )
	end
	end
end
outSourceAccounts ()