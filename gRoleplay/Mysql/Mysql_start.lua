gMysqlHost	    = "127.0.0.1"
gMysqlUser 		= "root"
gMysqlPass 		= ""
gMysqlDatabase1 = "groleplay"
gMysqlDatabase2 = "groleplay"

function MySQL_Startup()
	handler=mysql_connect(gMysqlHost,gMysqlUser,gMysqlPass,gMysqlDatabase1)
	if(not(handler))then
		outputDebugString("DB VERBINDUNG FEHLERHAFT!!")
	else
		outputDebugString("DB VERBINDUNG HERGESTELLT!!")
	end
	handler_old=mysql_connect(gMysqlHost,gMysqlUser,gMysqlPass,gMysqlDatabase2)
end
MySQL_Startup()

function MySQL_End()
	mysql_close(handler)
end

function MySQL_GetVar(tablename, feldname, bedingung)
	local result = mysql_query(handler, "SELECT "..feldname.." from "..tablename.." WHERE "..bedingung)
	if( not result) then
		--outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
	else
		if(mysql_num_rows(result) > 0) then
			local dsatz = mysql_fetch_assoc(result)
			local savename = feldname
			mysql_free_result(result)
			return tonumber(dsatz[feldname])
		else
			mysql_free_result(result)
			return false
		end
	end
end

function MySQL_GetString(tablename, feldname, bedingung)
	local result = mysql_query(handler, "SELECT "..feldname.." from "..tablename.." WHERE "..bedingung)
	if( not result) then
		 --outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
	else
		if(mysql_num_rows(result) > 0) then
			local dsatz = mysql_fetch_assoc(result)
			local savename = feldname
			mysql_free_result(result)
			return dsatz[feldname]
		else
			mysql_free_result(result)
			return false
		end
	end
end

function MySQL_GetStringDataset(tablename, fieldnames, bedingung)
	local result = mysql_query(handler, "SELECT "..fieldnames.." FROM "..tablename.." WHERE "..bedingung)
	if( not result) then
		 --outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
	else
		if mysql_num_rows ( result ) > 0 then
			local dsatz = mysql_fetch_assoc(result)
			mysql_free_result(result)
			return dsatz
		else
			mysql_free_result(result)
			return false
		end
	end
end

function MySQL_ExistAmount ( tablename, bedingung )
	local result = mysql_query ( handler, "SELECT * from "..tablename.." WHERE "..bedingung )
	if ( not result ) then
		--outputDebugString ( "Error executing the query: ("..mysql_errno ( handler )..") "..mysql_error ( handler ) )
	else
		local rows = mysql_num_rows ( result )
		mysql_free_result ( result )
		return rows
	end
end

function MySQL_GetOldString(tablename, feldname, bedingung)
	local result = mysql_query(handler_old, "SELECT "..feldname.." from "..tablename.." WHERE "..bedingung)
	if( not result) then
		 --outputDebugString("Error executing the query: (" .. mysql_errno(handler_old) .. ") " .. mysql_error(handler_old))
	else
		if(mysql_num_rows(result) > 0) then
			local dsatz = mysql_fetch_assoc(result)
			local savename = feldname
			mysql_free_result(result)
			return dsatz[feldname]
		else
			mysql_free_result(result)
			return false
		end
	end
end

function MySQL_SetVar(tablename, feldname, var, bedingung)
	if var then
		local result = mysql_query(handler, "UPDATE "..tablename.." SET "..feldname.." = "..var.." WHERE "..bedingung)
		if( not result) then
			 --outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
		else
			mysql_free_result(result)
			return false
		end
	end
end

function MySQL_DelRow(tablename, bedingung)
	local result = mysql_query(handler, "DELETE FROM "..tablename.." WHERE "..bedingung)
	if( not result) then
		 --outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
	else
		mysql_free_result(result)
		return false
	end
	--outputDebugString ("geloescht?!")
end

function MySQL_SetString(tablename, feldname, var, bedingung)
	if var and bedingung then
		local result = mysql_query(handler, "UPDATE "..tablename.." SET "..feldname.." = '"..var.."' WHERE "..bedingung)
		if( not result) then
			--outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
		else
			mysql_free_result(result)
			return false
		end
	end
end

function MySQL_SetOldString(tablename, feldname, var, bedingung)
	if var and bedingung then
		local result = mysql_query(handler_old, "UPDATE "..tablename.." SET "..feldname.." = '"..var.."' WHERE "..bedingung)
		if( not result) then
			--outputDebugString("Error executing the query: (" .. mysql_errno(handler_func) .. ") " .. mysql_error(handler_func))
		else
			mysql_free_result(result)
			return false
		end
	end
end

function MySQL_DatasetExist(tablename, bedingung)
	local result = mysql_query(handler, "SELECT * from "..tablename.." WHERE "..bedingung)
	if( not result) then
		 --outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
	else
		if(mysql_num_rows(result) > 0) then
			mysql_free_result(result)
			return true
		else
			mysql_free_result(result)
			return false
		end
	end
end

function MySQL_DatasetOldExist(tablename, bedingung)
	local result = mysql_query(handler_old, "SELECT * from "..tablename.." WHERE "..bedingung)
	if( not result) then
		 --outputDebugString("Error executing the query: (" .. mysql_errno(handler_old) .. ") " .. mysql_error(handler_old))
	else
		if(mysql_num_rows(result) > 0) then
			mysql_free_result(result)
			return true
		else
			mysql_free_result(result)
			return false
		end
	end
end

function MySQL_Safe ( string )
	return MySQL_Save ( string )
end
function MySQL_Save ( string )
	
	if string then
		return mysql_escape_string ( handler, string )
	end
end

function mysql_vio_query ( query )

	if stringSaveFind(query, "Adminlevel") then
		--outputDebugString ( "Query: "..query)
	end
	local result = mysql_query ( handler, query )
	local oldres = result
	if not result then
		--outputDebugString ( "Error: Invalid Query: "..tostring ( query ) )
		--outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
	else
		mysql_free_result ( result )
	end
	return oldres
end
function mysql_vio_old_query ( query )

	local result = mysql_query ( handler_old, query )
	local oldres = result
	if not result then
		--outputDebugString ( "Error: Invalid Query: "..tostring ( query ) )
		--outputDebugString("Error executing the query: (" .. mysql_errno(handler_old) .. ") " .. mysql_error(handler_old))
	else
		mysql_free_result ( result )
	end
	return oldres
end

function stringSaveFind ( arg1, arg2 )

	if arg1 and arg2 then
		return string.find ( arg1, arg2 )
	else
		return false
	end
end
addEventHandler ( "onResourceStop", getResourceRootElement(getThisResource()),MySQL_End)