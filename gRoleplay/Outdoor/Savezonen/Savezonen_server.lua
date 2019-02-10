SaveZones = {
	{ Name = 'Fahrschule', X = 1047.0274658203, Y = -1702.1452636719, W = 100, H = 75 },
    { Name = 'Lspd', X = 1398.6916503906, Y = -1862.7938232422, W = 165, H = 130 }	-- Name, X, Y, Width, Height
}

for i, k in pairs( SaveZones ) do 
	k.Name = createColRectangle( k.X, k.Y, k.W, k.H )
	createRadarArea( k.X, k.Y, k.W, k.H, 0, 255, 0, 175, getRootElement() ) -- Grüne Markierung --
	
	
	
	addEventHandler("onColShapeHit", k.Name, function( hitElement )
		if ( isElement( hitElement ) ) then
			if ( getElementType( hitElement ) == "player" ) then
 				setElementData( hitElement, "player.inSaveZone", true )

				toggleControl( hitElement, "fire", false )
				
				triggerClientEvent(hitElement, "showSafezone", hitElement, true)
			end
		end
	end)
	addEventHandler("onColShapeLeave", k.Name, function( hitElement )
		if ( isElement( hitElement ) and getElementType( hitElement ) == "player" ) then
			if getElementData(hitElement, "player.inSaveZone") then
				setElementData( hitElement, "player.inSaveZone", false )

				toggleControl( hitElement, "fire", true )
				triggerClientEvent(hitElement, "showSafezone", hitElement, false)
				
			end
		end
	end)
end


