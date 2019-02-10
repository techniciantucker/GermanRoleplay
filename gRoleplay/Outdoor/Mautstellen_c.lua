----- Mautstellen Peds -----
local Mautstellen_LSBrueckePed1 = createPed(71,62.599998474121,-1531.8000488281,5.3000001907349,0.00274658)
local Mautstellen_LSBrueckePed2 = createPed(71,58.099998474121,-1534.6999511719,5.1999998092651,172.001831)

function MautstellenPedsNoDamage()
	cancelEvent()
end
addEventHandler('onClientPedDamage',Mautstellen_LSBrueckePed1,MautstellenPedsNoDamage)
addEventHandler('onClientPedDamage',Mautstellen_LSBrueckePed2,MautstellenPedsNoDamage)