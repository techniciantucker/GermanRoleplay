addEvent('onFraktionInvite', true);
addEvent('onFraktionUninvite', true);
addEvent('onLoadPlayerList', true);
addEvent('onLoadFraktionPlayerList', true);
addEvent('onFraktionSetPlayerRang', true);

local ziviskin = 15;

function fraktionPanelOpen(player, btn, state)
	if(state == 'down')then
		if(westsideGetElementData(player, 'fraktion') ~= 0)then
			if(getElementData(player, 'frakOpen') == false)then
				setElementData(player, 'frakOpen', true);
				local fraktionPlayers = loadFraktionPlayers(player);
				local zivilistPlayers = loadZivilistPlayers();
				local fraktionCash    = getFraktionCash(player);
				triggerClientEvent(player, 'clientLoadFraktionPanel', player, fraktionPlayers, zivilistPlayers,fraktionCash);
			else
				setElementData(player, 'frakOpen', false);
				triggerClientEvent(player, 'clientUnloadFraktionPanel', player);
			end
		end
	end
end

function refreshPanel(player)	
	local fraktionPlayers = loadFraktionPlayers(player);
	local zivilistPlayers = loadZivilistPlayers();
	local fraktionCash    = getFraktionCash(player);
	
	local frak 
	local state
	local fraktionTable = {};
	local fraktion 		= tonumber(westsideGetElementData(player, 'fraktion'));
	local query	  	    = mysql_query(handler, 'SELECT * FROM userdata');
	if(query)then
	local queryRows = mysql_fetch_assoc(query);
		while(queryRows)do 
			if(tonumber(queryRows['Fraktion']) == fraktion)then
				if(isElement(getPlayerFromName(queryRows['Name'])))then
					state = 'online';
					target = getPlayerFromName(queryRows['Name']);
					frak  = tonumber(westsideGetElementData(target, 'rang'));
				else
					state = 'offline';
					frak  = queryRows['FraktionsRang'];
				end
				table.insert(fraktionTable, {queryRows['Name'], frak, state});
			end
			queryRows = mysql_fetch_assoc(query);
		end
		mysql_free_result(query);
	end
	triggerClientEvent(player, 'clientRefreshFraktionPanel', player, fraktionPlayers, zivilistPlayers,fraktionCash)
end

function loadZivilistPlayers()
	local zivilistTable = {};	
	if(#getElementsByType("player") > 0)then
		for _, player in pairs(getElementsByType("player")) do 
			if(getElementData(player, "loggedin"))then
				if(westsideGetElementData(player, 'fraktion') == 0)then
					table.insert(zivilistTable, {getPlayerName(player)});
				end
			end
		end
	end
	return zivilistTable;
end

function loadFraktionPlayers(player)
	local frak
	local state
	local fraktionTable = {};
	local fraktion 		= tonumber(westsideGetElementData(player, 'fraktion'));
	local query	  	    = mysql_query(handler, 'SELECT * FROM userdata');
	if(query ~= false)then
		local queryCorners = mysql_num_rows(query);
		if(queryCorners > 0)then
			local queryRows = mysql_fetch_assoc(query);
			while(queryRows)do 
				if(tonumber(queryRows['Fraktion']) == fraktion)then
					if(isElement(getPlayerFromName(queryRows['Name'])))then
						state = 'online';
						target = getPlayerFromName(queryRows['Name']);
						frak  = tonumber(westsideGetElementData(target, 'rang'));
					else
						state = 'offline';
						frak  = queryRows['FraktionsRang'];
					end
					table.insert(fraktionTable, {queryRows['Name'], frak, state});
				end
				queryRows = mysql_fetch_assoc(query);
			end
			mysql_free_result(query);
		end
	end
	return fraktionTable;
end

function invitePlayer(player, target)
	if(isElement(getPlayerFromName(target)))then
		local invPlayer 	= getPlayerFromName(target);
		local fraktion		= tonumber(westsideGetElementData(player, 'fraktion'));
		local fraktionsRang = tonumber(westsideGetElementData(player, 'rang'));
		if(fraktionsRang >= 5)then
			if(tonumber(westsideGetElementData(invPlayer,"perso"))==1)then
				if(tonumber(westsideGetElementData(invPlayer,"hartzseven"))==0)then
					westsideSetElementData(invPlayer, 'rang', 0);
					westsideSetElementData(invPlayer, 'fraktion', fraktion);
					mysql_query(handler, "UPDATE `userdata` SET `Fraktion` = "..fraktion.." WHERE Name = '"..getPlayerName(invPlayer).."'");
					infobox(player,"Der Spieler wurde in\neure Fraktion aufgenommen!",4000,0,255,0)
					infobox(invPlayer,"Du wurdest in eine\nFraktion aufgenommen!",4000,0,255,0)
					refreshPanel(player);
				else
					infobox(player,"Der Spieler hat Hartz 7\nbeantragt!")
				end
			else
				infobox(player,"Der Spieler hat keinen\nPersonalausweis!")
			end
		else
			outputChatBox('Du bist nicht befugt!', player);
		end
	end
end
addEventHandler('onFraktionInvite', root, invitePlayer);

function uninvitePlayer(player, target)
	local fraktion 	   = tonumber(westsideGetElementData(player, 'fraktion'));
	local fraktionRang = tonumber(westsideGetElementData(player, 'rang'));
	if(fraktionRang >= 5)then
		if(isElement(getPlayerFromName(target)))then
			local uninvPlayer = getPlayerFromName(target);
			local uninvRang   = tonumber(westsideGetElementData(uninvPlayer, 'rang'));
			if(fraktionRang > uninvRang) then
				westsideSetElementData(uninvPlayer, 'rang', 0);
				westsideSetElementData(uninvPlayer, 'fraktion', 0);
				setElementModel(uninvPlayer, ziviskin);
				westsideSetElementData(uninvPlayer, 'skin', ziviskin);
				mysql_query(handler, "UPDATE `userdata` SET `Fraktion` = 0 WHERE Name = '"..getPlayerName(uninvPlayer).."'");
				mysql_query(handler, "UPDATE `userdata` SET `FraktionsRang` = 0 WHERE Name = '"..getPlayerName(uninvPlayer).."'");
				infobox(player,"Der Spieler wurde aus\nder Fraktion geworfen!",4000,255,0,0)
				infobox(uninvPlayer,"Du wurdest aus der\nFraktion geworfen!",4000,255,0,0)
				refreshPanel(player);
			end
		else
			local target = tostring(target);
			local uninvQuery = mysql_query(handler, 'SELECT * FROM `userdata` WHERE `Name` = "'..target..'"');
			if(uninvQuery ~= false)then
				local row	 	    = mysql_fetch_assoc(uninvQuery);
				local uninvRang	  	= tonumber(row['FraktionsRang']);
				local uninvFraktion = tonumber(row['Fraktion']);
				if(fraktionRang > uninvRang)then
					local uninviteFinishQuery  = mysql_query(handler, "UPDATE `userdata` SET `Fraktion` = 0 WHERE Name = '"..target.."'");
					local uninviteFinishQuery2 = mysql_query(handler, "UPDATE `userdata` SET `FraktionsRang` = 0 WHERE Name = '"..target.."'");
					if(uninviteFinishQuery and uninviteFinishQuery2)then
						infobox(player,"Der Spieler wurde offline\naus der Fraktion geworfen!",4000,255,0,0)
						refreshPanel(player);
					else
						outputDebugString('Error database has a failed Query, pleas Contact a Admin ('..mysql_errno(handler)..')');
					end
				else
					if westsideGetElementData(player,"adminlvl") > 4 then
						local uninviteFinishQuery  = mysql_query(handler, "UPDATE `userdata` SET `Fraktion` = 0 WHERE Name = '"..target.."'");
						local uninviteFinishQuery2 = mysql_query(handler, "UPDATE `userdata` SET `FraktionsRang` = 0 WHERE Name = '"..target.."'");
						if(uninviteFinishQuery and uninviteFinishQuery2)then
							infobox(player,"Der Spieler wurde offline\naus der Fraktion geworfen!",4000,255,0,0)
							refreshPanel(player);
						end
					end
				end
			end
		end
	end
end
addEventHandler('onFraktionUninvite', root, uninvitePlayer);

function respawnVehiclesFraktion(player)
	local fraktion = westsideGetElementData(player, 'fraktion');
	local fraktionRang = tonumber(westsideGetElementData(player, 'rang'));
	if(fraktionRang > 2)then
		if(factionVehicles[fraktion])then
			for veh, _ in pairs ( factionVehicles[fraktion] ) do
				if not getVehicleOccupant ( veh ) then
					respawnVehicle ( veh )
				end
			end
			infobox(player,"Die Base wurde respawnt!",4000,0,255,0)
		end
	end
end
addEvent('onRespawnVehicles', true)
addEventHandler('onRespawnVehicles', root, respawnVehiclesFraktion)

function giveFraktionPlayerRang(player, target, typ)
	local fraktion 	   = tonumber(westsideGetElementData(player, 'fraktion'));
	local fraktionRang = tonumber(westsideGetElementData(player, 'rang'));
	if(fraktionRang >= 4)then
		if(isElement(getPlayerFromName(target)))then
			local rPlayer 	  = getPlayerFromName(target);
			local rPlayerRang = tonumber(westsideGetElementData(rPlayer, 'rang'));
			if(fraktionRang > rPlayerRang)then
				if(typ == '+')then
					if(rPlayerRang <= 4)then
						westsideSetElementData(rPlayer, 'rang', westsideGetElementData(rPlayer, 'rang') + 1);
						mysql_query(handler, "UPDATE `userdata` SET `FraktionsRang` = "..rPlayerRang.." WHERE Name = '"..getPlayerName(rPlayer).."'");
						infobox(player,"Der Spieler wurde befördert!",4000,0,255,0)
						infobox(rPlayer,"Du wurdest befördert!",4000,0,255,0)
						refreshPanel(player);
					end
				elseif(typ == '-')then
					if(rPlayerRang >= 1)then
						westsideSetElementData(rPlayer, 'rang', westsideGetElementData(rPlayer, 'rang') - 1);
						mysql_query(handler, "UPDATE `userdata` SET `FraktionsRang` = "..rPlayerRang.." WHERE Name = '"..getPlayerName(rPlayer).."'");
						infobox(player,"Der Spieler wurde degradiert!",4000,255,0,0)
						infobox(rPlayer,"Du wurdest degradiert!",4000,255,0,0)
						refreshPanel(player);
					end
				end
			end
		else
			local updateRang;
			local target = tostring(target);
			local rQuery = mysql_query(handler, "SELECT * FROM `userdata` WHERE `Name` = '"..target.."'");
			if(rQuery)then
				local row 		= mysql_fetch_assoc(rQuery);
				local rRang	    = tonumber(row['FraktionsRang']);
				if(fraktionRang > rRang)then
					if(typ == '+')then
						if(rRang <= 4)then
							updateRang = rRang + 1;
							local rangQueryUp = mysql_query(handler, "UPDATE `userdata` SET `FraktionsRang` = "..updateRang.."  WHERE Name = '"..target.."'");
							infobox(player,"Der Spieler wurde befördert!",4000,0,255,0)
							refreshPanel(player);
						end
					elseif(typ == '-')then
						if(rRang >= 1)then
							updateRang = rRang - 1;
							local rangQueryDOWN = mysql_query(handler, "UPDATE `userdata` SET `FraktionsRang` = "..updateRang.."  WHERE Name = '"..target.."'");
							infobox(player,"Der Spieler wurde degradiert!",4000,255,0,0)
							refreshPanel(player);
						end
					end
				end
			end
		end
	end
end
addEventHandler('onFraktionSetPlayerRang', root, giveFraktionPlayerRang);

-- Fraktions-Kasse --
function setFraktionCash(player, money, typ)
	local fraktion	   = tonumber(westsideGetElementData(player, 'fraktion'));
	local fraktionRang = tonumber(westsideGetElementData(player, 'rang'));
	local moneyPlayer  = tonumber(westsideGetElementData(player, 'money'));
	if(typ == '-')then
		if(fraktionRang >= 5)then
			local cash = getFraktionCash(player);
			if(cash >= money)then
				newCash = cash - money;
				local cashQuery = mysql_query(handler, 'UPDATE `fraktionen` SET `FKasse` = '..newCash..' WHERE ID = "'..fraktion..'"');
				if(cashQuery)then
					westsideSetElementData(player, 'money', moneyPlayer + money);
					infobox(player,"Du hast "..money.."$ aus der\nFraktions-Kasse gezahlt!",4000,255,0,0)
					refreshPanel(player);
					
					outputLog(getPlayerName(player).." hat "..money.."$ aus der F-Kasse gezahlt.","Frakikasse")
				else
					outputDebugString('Query Failed `Fraktion Kasse` '..mysql_errno(handler));
				end
			else
				infobox(player,"So viel Geld habt ihr\nnicht in der Kasse!",4000,255,0,0)
			end
		end
	elseif(typ == '+')then
		if(moneyPlayer >= money)then
			local cash = getFraktionCash(player);
			newCash = cash + money;
			local cashQuery = mysql_query(handler, 'UPDATE `fraktionen` SET `FKasse` = '..newCash..' WHERE ID = "'..fraktion..'"');
			if(cashQuery)then
				westsideSetElementData(player, 'money', moneyPlayer - money);
				infobox(player,"Du hast "..money.."$ in die\nFraktions-Kasse gezahlt!",4000,0,255,0)
				refreshPanel(player);
				
				outputLog(getPlayerName(player).." hat "..money.."$ in die F-Kasse gezahlt.","Frakikasse")
			else
				outputDebugString('Query Failed `Fraktion Kasse` '..mysql_errno(handler));
			end
		else
			infobox(player,"So viel Geld hast du nicht!",4000,255,0,0)
		end
	end
end
addEvent('FraktionDepot', true)
addEventHandler('FraktionDepot', root, setFraktionCash)

function getFraktionCash(player)
	local fraktion 	   = tonumber(westsideGetElementData(player, 'fraktion'));
	local fraktionRang = tonumber(westsideGetElementData(player, 'rang'));
	local cashQuery = mysql_query(handler, 'SELECT * FROM `fraktionen` WHERE `ID` = "'..fraktion..'"');
	if(cashQuery)then
		local row 	= mysql_fetch_assoc(cashQuery);
		local money = tonumber(row['FKasse']);
		return money;
	end
	return false;
end