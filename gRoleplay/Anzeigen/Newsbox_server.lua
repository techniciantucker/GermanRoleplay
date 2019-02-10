local tsIp  = "k.A."

function newsbox()
	outputChatBox( "────────────────| #FFFFFFGerman Roleplay Info #00B9FF|────────────────", getRootElement(), 0, 185, 255, true )
	outputChatBox("Du hast Fragen oder Probleme? Dann Tippe /report.",root,255,255,255)
	outputChatBox("Du bist neu? Dann empfehlen wir dir unser Hilfemenü unter F1.",root,255,255,255)
	outputChatBox("Unser Teamspeak³ Server: "..tsIp,root,255,255,255)
	outputChatBox( "────────────────| #FFFFFFGerman Roleplay Info #00B9FF|────────────────", getRootElement(), 0, 185, 255, true )
end
setTimer(newsbox,300000,0)

function infobox ( player, text, time, r, g, b )

	if isElement ( player ) then
		triggerClientEvent ( player, "infobox_start", getRootElement(), text, time, r, g, b )
	end
end