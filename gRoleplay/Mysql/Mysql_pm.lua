-- Offline Message --
function offlinemsg ( msg, sender, empfaenger )

	datum = timestamp()
	mysql_query(handler, "INSERT INTO pm (Sender, Empfaenger, Text, Datum) VALUES ('"..sender.."','"..empfaenger.."','"..msg.."','"..datum.."')")
end

-- Checken --
function checkmsgs ( player )

	local i = 1
	while true and i <= 10 do
		local msg = MySQL_GetString( "pm", "Text", "Empfaenger LIKE '"..getPlayerName(player).."'" )
		if msg then
			local datum = MySQL_GetString( "pm", "Datum", "Empfaenger LIKE '"..getPlayerName(player).."'" )
			local sender = MySQL_GetString( "pm", "Sender", "Empfaenger LIKE '"..getPlayerName(player).."'" )
			local text = msg
			local msg = "Offlinenachricht von: "..sender.." ("..datum.."): "..msg
			outputChatBox ( msg, player, 255,255,0 ) -- Chatfarbe: Gelb
			MySQL_DelRow("pm", "Empfaenger LIKE '"..getPlayerName(player).."' AND Text LIKE '"..text.."' AND Sender LIKE '"..sender.."' AND Datum LIKE '"..datum.."'")
			i = i + 1
		else
			break
		end
	end
end

-- Money entnehmen --
function takeMSGMoney ( player )

	setElementData ( player, "money", getElementData(player,"money")-pm_price )

end