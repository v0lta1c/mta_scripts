
function checkPlayerInCol()
	thePlayer = source
	setTimer(function ()
		local x,y,z = getElementPosition(thePlayer)
		zone = getZoneName(x,y,z)
		if zone == "Restricted Area" then
		outputChatBox(thePlayer .. " was inside/near Area 51 before disconnecting, as a result "..thePlayer.." will be teleported away!",source)
		setCameraMatrix(thePlayer,0,0,0)
		triggerClientEvent(thePlayer,"manageTeleport",thePlayer,thePlayer)
	end
		end,3000,1)
	
end

addEventHandler("onPlayerLogin",root,checkPlayerInCol)
