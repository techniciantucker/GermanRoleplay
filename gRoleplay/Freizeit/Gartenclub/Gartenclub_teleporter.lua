VonAussenNachInnen = createMarker (2348.5, -1372.9000244141, 23.5, "cylinder", 1, 255,255,255)

VonInnenNachAussen = createMarker (422.39999389648, 2536.5, 9.1000003814697, "cylinder", 1, 255, 255, 255)
setElementInterior (VonInnenNachAussen, 10)

addEventHandler ("onMarkerHit", VonAussenNachInnen, 
function (source, dim )
  if not isPedInVehicle(source) then
  fadeElementInterior (source,10,420.39999389648,2536.5,10)
  setElementRotation (source,0,0,0.00274658)
  end
end)

addEventHandler ("onMarkerHit", VonInnenNachAussen, 
function (source, dim )
  fadeElementInterior (source,0,2348.6999511719,-1374.4000244141,24)
  setElementRotation (source,0,0,180)
end)