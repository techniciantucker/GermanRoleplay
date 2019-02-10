function zigarettenRauchen(player)
	zigarettenHeahl = math.random(15,35)
	
	if westsideGetElementData(player,"zigaretten") >= 1 then
		if westsideGetElementData(player,"jailtime") == 0 then
			if(not(isPedInVehicle(player)))then
				infobox(player,"Du hast eine Zigarette geraucht!",4000,0,255,0)
				westsideSetElementData(player,"zigaretten",westsideGetElementData(player,"zigaretten") - 1)
				addPlayerHealth(player,zigarettenHeahl)
				
				setElementFrozen(player,true)
				setPedAnimation(player,"smoking","M_smkstnd_loop")
				setTimer(function()
					setPedAnimation(player,false)
					setElementFrozen(player,false)
				end,10000,1)
				
				outputLog("[ZIGARETTE]: "..getPlayerName(player).." hat eine Zigarette geraucht!","Zigarette")
			else
				infobox(player,'Im Auto nicht möglich!')
			end
		else
			infobox(player,"Im Knast nicht möglich!")
		end
	else
		infobox(player,"Du hast keine Zigaretten!",4000,255,0,0)
	end
end
addCommandHandler('smoke',zigarettenRauchen)

function pissen(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(westsideGetElementData(player,'harndrang')>0)then
			if(not(isPedInVehicle(player)))and(not(isElementInWater(player)))then
				setElementData(player,'inPinkeln',true)
				infobox(player,'Das pinkeln dauert 10 Sekunden..')
				setPedAnimation ( player, "PAULNMAC", "Piss_loop")
				setTimer(function()
					setPedAnimation(player,false)
					setElementFrozen(player,false)
					setElementData(player,'inPinkeln',false)
					westsideSetElementData(player,'harndrang',0)
					infobox(player,'Du hast deine Blase entleert.')
				end,10000,1)
				outputLog(getPlayerName(player).." hat seine Blase entleert","Harndrang")
			else
				infobox(player,'Im Auto/Wasser nicht möglich!')
			end
		end
	end
end
addCommandHandler('piss',pissen)

function animlist(player)
	if(westsideGetElementData(player,'loggedin')==1)then
		outputChatBox("~~~~~ Animationen ~~~~~",player, 255,255,255 )
		outputChatBox("/handsup,/phoneout,/phonein,/drunk,/robman",player, 200, 200, 0 )
		outputChatBox("/bomb,/getarrested,/laugh,/lookout,/crossarms",player, 200, 200, 0 )
		outputChatBox("/lay,/hide,/vomit,/eat,/wave,/slapass",player, 200, 200, 0 )
		outputChatBox("/deal,/crack,/smoke,/ground,/fucku",player, 200, 200, 0 )
		outputChatBox("/chat,/taichi,/chairsit,/dance [1-7],/wank",player, 200, 200, 0 )
		outputChatBox("Zum Abbrechen einer Animation: /stopanim oder Leertaste",player, 0,200,200 )
	end
end
addCommandHandler('animationen',animlist)
addCommandHandler('animlist',animlist)
addCommandHandler('anims',animlist)

local animationenYo={
["phoneout"]={"ped", "phone_out",false,true,false},
["phonein"]={"ped", "phone_in",false,true,true},
["drunk"]={"ped", "WALK_drunk",true,true,false},
["robman"]={"shop", "ROB_Loop_Threat",true,false,false},
["getarrested"]={"ped", "ARRESTgun",false,false,true},
["laugh"]={"rapping", "Laugh_01",false,false,false},
["lookout"]={"shop", "ROB_Shifty",false,false,false},
["crossarms"]={"cop_ambient", "Coplook_loop",true,false,false},
["lay"]={"beach", "bather",true,false,false},
["hide"]={"ped", "cower",true,false,false},
["wave"]={"ON_LOOKERS", "wave_loop",true,false,false},
["slapass"]={"sweet", "sweet_ass_slap",false,false,false},
["deal"]={"dealer", "dealer_deal",false,false,false},
["crack"]={"crack", "crckdeth2",true,true,false},
["ground"]={"beach", "ParkSit_M_loop",true,false,false},
["fucku"]={"ped", "fucku",false,true,false},
["chat"]={ "ped", "IDLE_chat",true,true,false},
["taichi"]={  "park", "Tai_Chi_Loop",true,true,false},
["chairsit"]={ "BEACH", "SitnWait_loop_W",true,false,false},
["wank"]={ "PAULNMAC", "wank_loop",true,false,false},
["eat"]={"VENDING", "vend_eat1_P",false,false,false},
["handsup"]={"shop", "SHP_HandsUp_Scr",false,true,false},
["bomb"]={ "bomber", "BOM_Plant_In",false,true,false},
}

function setAnimation(player,cmd)
    if(animationenYo[cmd])then
		if(not(getElementData(player,'inPinkeln')==true))then
			if(not(isPedInVehicle(player)))then
				westsideSetElementData(player,"anim", 1)
				westsideSetElementData(player,"lastAnim",cmd)
				setPedAnimation(player, animationenYo[cmd][1], animationenYo[cmd][2],-1,animationenYo[cmd][3],animationenYo[cmd][4],true,animationenYo[cmd][5])
				bindKey ( player, "space", "down", stopanima )
				showanimtext(player)

				if(cmd=="handsup")then
					setTimer(handb,500,1,player)
				elseif(cmd=="bomb")then
					setTimer(bombb,500,1,player)
				end
			else
				infobox(player,'Im Auto nicht möglich!')
			end
		end
    end
end

function showanimtext(player)
	infobox(player,'Tippe /stopanim oder drücke\nLeertaste, zum beenden der Animation.')
end

function handb(player)
    setPedAnimation(player,"shop","SHP_Rob_HandsUp",-1,true,false)
end
function bombb(player)
    setPedAnimation(player, "bomber", "BOM_Plant",-1,false,false,false)
end

addCommandHandler("handsup",setAnimation,false,false)
addCommandHandler("wank",setAnimation,false,false)
addCommandHandler("handsup",setAnimation,false,false)
addCommandHandler("ground",setAnimation,false,false)
addCommandHandler("fucku",setAnimation,false,false)
addCommandHandler("chat",setAnimation,false,false)
addCommandHandler("taichi",setAnimation,false,false)
addCommandHandler("phoneout",setAnimation,false,false)
addCommandHandler("phonein",setAnimation,false,false)
addCommandHandler("drunk",setAnimation,false,false)
addCommandHandler("robman",setAnimation,false,false)
addCommandHandler("bomb",setAnimation,false,false)
addCommandHandler("getarrested",setAnimation,false,false)
addCommandHandler("laugh",setAnimation,false,false)
addCommandHandler("lookout",setAnimation,false,false)
addCommandHandler("crossarms",setAnimation,false,false)
addCommandHandler("lay",setAnimation,false,false)
addCommandHandler("hide",setAnimation,false,false)
addCommandHandler("vomit",setAnimation,false,false)
addCommandHandler("eat",setAnimation,false,false)
addCommandHandler("wave",setAnimation,false,false)
addCommandHandler("slapass",setAnimation,false,false)
addCommandHandler("deal",setAnimation,false,false)
addCommandHandler("chairsit",setAnimation,false,false)
addCommandHandler("crack",setAnimation,false,false)

function stopanima(player)
    if westsideGetElementData(player,"anim")==1 then
        if isElement(westsideGetElementData(player,"animObj"))then
            destroyElement(westsideGetElementData(player,"animObj"))
            westsideSetElementData(player,"animObj",nil)
        end
        setPedAnimation(player)
        westsideSetElementData(player,"anim", 0)

        local lastAnim=westsideGetElementData(player,"lastAnim")
    end
end
addCommandHandler("stopanim",stopanima,false,false)

----- Tanzen -----
function dance_func ( player, cmd, style )
    if style then
        local style = tonumber ( style )
        if style == 1 then
            setPedAnimation ( player, "DANCING", "dnce_M_a",-1,true,false,false )
        elseif style == 2 then
            setPedAnimation ( player, "DANCING", "dnce_M_b",-1,true,false,false )
        elseif style == 3 then
            setPedAnimation ( player, "DANCING", "dnce_M_c",-1,true,false,false )
        elseif style == 4 then
            setPedAnimation ( player, "DANCING", "dnce_M_d",-1,true,false,false )
        elseif style == 5 then
            setPedAnimation ( player, "DANCING", "dnce_M_e",-1,true,false,false )
        elseif style == 6 then
            setPedAnimation ( player, "DANCING", "dance_loop",-1,true,false,false )
        else
            local rnd = math.random ( 1, 4 )
            if rnd == 1 then
                setPedAnimation ( player, "STRIP", "STR_Loop_A",-1,true,false,false )
            elseif rnd == 2 then
                setPedAnimation ( player, "STRIP", "STR_Loop_B",-1,true,false,false )
            elseif rnd == 3 then
                setPedAnimation ( player, "STRIP", "STR_Loop_C",-1,true,false,false )
            else
                setPedAnimation ( player, "STRIP", "STR_Loop_A",-1,true,false,false )
            end
        end
        westsideSetElementData( player, "anim", 1)
        bindKey ( player, "space", "down", stopanima )
        showanimtext(player)
    else
        infobox(player,'Tippe /dance [1-7]!')
    end
end
addCommandHandler("dance",dance_func,false,false)