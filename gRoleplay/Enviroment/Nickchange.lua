function backchange ( oldnick, newnick )
	outputChatBox ( "[INFO]: Melde dich für eine Namensänderung bei einem Teammitglied!", getPlayerFromName ( oldnick ),0,100,150)
	cancelEvent()
end
addEventHandler ( "onPlayerChangeNick", getRootElement(), backchange )