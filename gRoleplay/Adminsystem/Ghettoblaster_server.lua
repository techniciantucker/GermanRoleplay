local Blaster = {}

function newPlaySound(player, link)
	Blaster[player] = createObject(2226, 0, 0, 0 )
	exports.bone_attach:attachElementToBone(Blaster[player],player,12,0,0,0.4,0,180,0)
	for k, v in pairs(getElementsByType("player")) do 
		triggerClientEvent(v, 'createNewMusik', v, player, link)
	end
end
addEvent("newPlaySound", true)
addEventHandler("newPlaySound", root, newPlaySound)

addEvent('deleteBlaster', true)
addEventHandler('deleteBlaster', root, function(player)
	destroyElement(Blaster[player])
	for k, v in pairs(getElementsByType("player")) do 
		triggerClientEvent(v, 'deleteMusic', v, player)
	end
end)

addEventHandler('onPlayerQuit', root, function()
	if Blaster[source] then
		destroyElement(Blaster[source])
		for k, v in pairs(getElementsByType("player")) do 
			triggerClientEvent(v, 'deleteMusic', v, source)
		end
	end
end)