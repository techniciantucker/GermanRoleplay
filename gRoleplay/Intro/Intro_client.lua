local sm = {}
sm.moov = 0
sm.object1,sm.object2 = nil,nil
 
local function removeCamHandler()
	if(sm.moov == 1)then
		sm.moov = 0
	end
end
 
local function camRender()
	if (sm.moov == 1) then
		local x1,y1,z1 = getElementPosition(sm.object1)
		local x2,y2,z2 = getElementPosition(sm.object2)
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	end
end
addEventHandler("onClientPreRender",root,camRender)
 
function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
	if(sm.moov == 1)then return false end
	sm.object1 = createObject(1337,x1,y1,z1)
	sm.object2 = createObject(1337,x1t,y1t,z1t)
	setElementAlpha(sm.object1,0)
	setElementAlpha(sm.object2,0)
	setObjectScale(sm.object1,0.01)
	setObjectScale(sm.object2,0.01)
	moveObject(sm.object1,time,x2,y2,z2,0,0,0,"InOutQuad")
	moveObject(sm.object2,time,x2t,y2t,z2t,0,0,0,"InOutQuad")
	sm.moov = 1
	setTimer(removeCamHandler,time,1)
	setTimer(destroyElement,time,1,sm.object1)
	setTimer(destroyElement,time,1,sm.object2)
	return true
end

addEvent("startIntro",true)
addEventHandler("startIntro",root,function()
	triggerEvent("newloadscreen",getLocalPlayer(),getLocalPlayer())
	
	setElementData(lp,"tut",true)
	
	setTimer(function()
		setCameraMatrix(1562.8197021484,-1663.5921630859,113.43319702148,1562.2465820313,-1664.1723632813,112.85442352295,0,70)
		
		setTimer(function()
			slowDrawText ( "Du hast dich erfolgreich registriert!\n\nF3 - Tutorial abspielen / F4 - Direkt spawnen [Drücke]" )
			outputChatBox('Du hast dich erfolgreich registriert! F3 - Tutorial abspielen / F4 - Direkt spawnen [Drücke].',0,100,150)
			playSound("Intro/1.wav")
		end,4000,1)
	end,2000,1)
end)

bindKey("f3","down",function()
	if getElementData(lp,"tut") == true then
		introSound = playSound("Intro/Intro.mp3")
		setSoundVolume(introSound,0.2)
	
		setElementData(lp,"tut",false)
	
		local x1,y1,z1 = 1562.8197021484,-1663.5921630859,113.43319702148
		local x2,y2,z2 = 1506.9171142578,-1720.8618164063,22.570699691772
		local x1t,y1t,z1t = 1562.2465820313,-1664.1723632813,112.85442352295
		local x2t,y2t,z2t = 1506.3095703125,-1721.5780029297,22.227083206177
		
		smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,5000)
				
		setTimer(function()
			slowDrawText("In unserer Stadthalle erhälst du einen Überblick aller Jobs,\nsowie die Möglichkeit, dir eine Identität zu verschaffen.")
			playSound("Intro/2.wav")
		end,5500,1)
				
		setTimer(function() -- Shops
			local x1,y1,z1 = 1506.9171142578,-1720.8618164063,22.570699691772
			local x2,y2,z2 = 1363.4315185547,-1725.3699951172,29.219699859619
			local x1t,y1t,z1t = 1506.3095703125,-1721.5780029297,22.227083206177
			local x2t,y2t,z2t = 1363.2081298828,-1726.0981445313,28.571750640869
					
			smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,5000)
					
			setTimer(function()
				slowDrawText("In unseren Shops gibt es viele Artikel, welche dir einen\nkleinen, allerdings auch einen großen Vorteil verschaffen können.")
				playSound("Intro/3.wav")
			end,5500,1)
			
			setTimer(function() -- Fahrschule
				local x1,y1,z1 = 1363.4315185547,-1725.3699951172,29.219699859619
				local x2,y2,z2 = 1149.8353271484,-1708.7635498047,41.037700653076
				local x1t,y1t,z1t = 1363.2081298828,-1726.0981445313,28.571750640869
				local x2t,y2t,z2t = 1149.2593994141,-1708.3165283203,40.35326385498
						
				smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,5000)
						
				setTimer(function()
					slowDrawText("An der Fahrschule kannst du alle Scheine beantragen, welche benötigt\nwerden, um Geld zu verdienen, Autos zu kaufen, oder einer\nFraktion beitreten zu können.")
					playSound("Intro/4.wav")
				end,5500,1)
				
				setTimer(function() -- Autohäuser
					local x1,y1,z1 = 1149.8353271484,-1708.7635498047,41.037700653076
					local x2,y2,z2 = 1151.7790527344,-1645.5255126953,28.241800308228
					local x1t,y1t,z1t = 1149.2593994141,-1708.3165283203,40.35326385498
					local x2t,y2t,z2t = 1152.498046875,-1645.3614501953,27.566473007202
						
					smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,5000)
						
					setTimer(function()
						slowDrawText("Wir bieten Boden, sowie Flugfahrzeuge an, welche die Fortbewegung\nerheblich erleichtern.")
						playSound("Intro/5.wav")
					end,5500,1)
					
					setTimer(function() -- Restaurants
						local x1,y1,z1 = 1151.7790527344,-1645.5255126953,28.241800308228
						local x2,y2,z2 = 844.78277587891,-1598.4626464844,35.06420135498
						local x1t,y1t,z1t = 1152.498046875,-1645.3614501953,27.566473007202
						local x2t,y2t,z2t = 844.04223632813,-1598.8026123047,34.484531402588
							
						smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,5000)
							
						setTimer(function()
							slowDrawText("An unseren Zahlreichen Restaurants kannst du zwischen vielen,\nunterschiedlichen Menüs wählen, welche dich mit Energie versorgen.")
							playSound("Intro/6.wav")
						end,5500,1)
						
						setTimer(function() -- Ammunation
							local x1,y1,z1 = 844.78277587891,-1598.4626464844,35.06420135498
							local x2,y2,z2 = 1331.1213378906,-1280.8526611328,37.196201324463
							local x1t,y1t,z1t = 844.04223632813,-1598.8026123047,34.484531402588
							local x2t,y2t,z2t = 1331.8532714844,-1280.8465576172,36.514911651611
								
							smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,5000)
								
							setTimer(function()
								slowDrawText("An der Ammunation erhälst du einen Waffenschein, sowie eine\ngroße Auswahl von verschiedenen Waffen, welche\nhauptsächlich zur Selbstverteidigung dienen.")
								playSound("Intro/7.wav")
							end,5500,1)
						
							setTimer(function() -- Bank
								local x1,y1,z1 = 1331.1213378906,-1280.8526611328,37.196201324463
								local x2,y2,z2 = 1424.2780761719,-1040.7034912109,41.499801635742
								local x1t,y1t,z1t = 1331.8532714844,-1280.8465576172,36.514911651611
								local x2t,y2t,z2t = 1425.0399169922,-1040.3280029297,40.971920013428
									
								smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,5000)
									
							setTimer(function()
								slowDrawText("An der Bank kannst du dein Geld verwalten, und erhälst von den\nBankangestellten Support, falls du Fragen zu deinem Geld hast.\nSie hat jeden Tag von 06:00 - 23:00 Uhr geöffnet.")
								playSound("Intro/8.wav")
							end,5500,1)
							
								setTimer(function() -- Ende
									local x1,y1,z1 = 1424.2780761719,-1040.7034912109,41.499801635742
									local x2,y2,z2 = 1504.5367431641,-1016.383972168,262.85818481445
									local x1t,y1t,z1t = 1425.0399169922,-1040.3280029297,40.971920013428
									local x2t,y2t,z2t = 1505.2468261719,-1016.9046020508,262.38412475586
									
									smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,5000)
									
									setTimer(function()
										slowDrawText("Nun wünschen wir dir viel Spaß beim Spielen!")
										playSound("Intro/9.wav")
									end,5500,1)
									
									setTimer(function()
										triggerEvent("newloadscreen",getLocalPlayer(),getLocalPlayer())
										setTimer(function()
											triggerServerEvent("gameBeginGuiShow",getLocalPlayer(),getLocalPlayer())
											destroyElement(introSound)
										end,3000,1)
									end,10000,1)
								end,15000,1)
							end,15000,1)
						end,15000,1)
					end,15000,1)
				end,15000,1)
			end,15000,1)
		end,15000,1)
	end
end)

bindKey("f4","down",function()
	if getElementData(lp,"tut") == true then
		triggerServerEvent("gameBeginGuiShow",getLocalPlayer(),getLocalPlayer())
		setElementData(lp,"tut",false)
	end
end)
