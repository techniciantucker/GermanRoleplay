addCommandHandler('cgun',function(player,cmd,waffe)
	if(westsideGetElementData(player,'loggedin')==1)then
		if(waffe)then
			if(waffe=='deagle')then
				if(westsideGetElementData(player,'mats')>=150)then
					giveWeapon(player,24,21,true)
					westsideSetElementData(player,'mats',westsideGetElementData(player,'mats')-150)
				else
					infobox(player,'Du benötigst 150 Mats!')
				end
			elseif(waffe=='mp5')then
				if(westsideGetElementData(player,'mats')>=250)then
					giveWeapon(player,29,120,true)
					westsideSetElementData(player,'mats',westsideGetElementData(player,'mats')-250)
				else
					infobox(player,'Du benötigst 250 Mats!')
				end
			elseif(waffe=='m4')then
				if(westsideGetElementData(player,'mats')>=450)then
					giveWeapon(player,31,100,true)
					westsideSetElementData(player,'mats',westsideGetElementData(player,'mats')-450)
				else
					infobox(player,'Du benötigst 450 Mats!')
				end
			elseif(waffe=='ak47')then
				if(westsideGetElementData(player,'mats')>=350)then
					giveWeapon(player,30,120,true)
					westsideSetElementData(player,'mats',westsideGetElementData(player,'mats')-350)
				else
					infobox(player,'Du benötigst 350 Mats!')
				end
			elseif(waffe=='rifle')then
				if(westsideGetElementData(player,'mats')>=250)then
					giveWeapon(player,33,30,true)
					westsideSetElementData(player,'mats',westsideGetElementData(player,'mats')-250)
				else
					infobox(player,'Du benötigst 250 Mats!')
				end
			else
				infobox(player,'Diese Waffe kannst du nicht\nherstellen!')
				outputChatBox('Mögliche Waffen: deagle/mp5/m4/ak47/rifle',player,0,200,0)
			end
		else
			infobox(player,'Du hast keine Waffe angegeben!')
			outputChatBox('Mögliche Waffen: deagle/mp5/m4/ak47/rifle',player,0,200,0)
		end
	end
end)