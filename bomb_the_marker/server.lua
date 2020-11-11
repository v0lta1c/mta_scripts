diffuseKey = "x"


marker1 = createMarker(-104.7578125,2063.3828125,16.499962615967,"cylinder",1.5,255,255,0,50)
marker2 = createMarker(-97.5458984375,2031.7451171875,19.596176757813,"cylinder",1.5,255,255,0,50)
bombTable = { "nil" }

function renders(thePlayer)
	   if thePlayer then
            triggerClientEvent ("holla", root, thePlayer ,thePlayer)
	   end
end

addEventHandler("onPlayerLogin",root,renders)

function isPlayerInMarker(thePlayer)
	if isElementWithinMarker(thePlayer,marker1) then
		if getPlayerTeam(thePlayer) == nil then return
		else
			if bombTable[1] == "placed" then
				outputChatBox("Bomb already planted!",thePlayer,255,0,0)
			else
				placeBomb(thePlayer)
				bombTable = { "placed" }
			end
		end
	else
		outputChatBox("Error")
	end
end
addEventHandler("onMarkerHit",marker1,isPlayerInMarker)

function isPlayerInMarker2(thePlayer)
	if isElementWithinMarker(thePlayer,marker2) then
		if getPlayerTeam(thePlayer) == nil then return
		else
			if bombTable[1] == "placed" then
				outputChatBox("Bomb already planted!",thePlayer,255,0,0)
			else
				placeBomb(thePlayer)
				bombTable = { "placed" }
			end
		end
	else
		outputChatBox("Error")
	end
end
addEventHandler("onMarkerHit",marker2,isPlayerInMarker2)

function placeBomb(thePlayer)
	local bombstate = getElementData(bomb,"planted")
	if bombstate == "yes" then
		outputChatBox("The bomb has already been planted!",thePlayer,255,0,0)
	else
		local x,y,z = getElementPosition(thePlayer)
		bomb = createObject(1654,x,y,z-0.9)
		bombmarker = createMarker(x,y,z+2,"arrow",1,255,0,0,255)
		outputChatBox("Mann has placed the Bomb!!")
		setPedAnimation(thePlayer,"BOMBER","BOM_Plant",3000,false,false,true,false)
		setElementData(bomb,"planted","yes")
		setElementData(thePlayer,"statusbs1","Planted")
		triggerClientEvent("countdown",root,thePlayer,thePlayer,x,y,z)
		bindKey (thePlayer,diffuseKey, "down", diffuseBomb)
	end
end 
function boomboom(thePlayer,_,x,y,z,l)
	local data = getElementData(thePlayer,"timerCount")
	if data == 0 then
		bombTable = { "notPlaced" }
		createExplosion(x,y,z,2)
		setElementData(thePlayer,"statusbs1","boomed")
		setElementData(bomb,"planted","no")
		destroyElement(bomb)
		destroyElement(bombmarker)
		destroyElement(marker1)
		triggerClientEvent("statuses",root,thePlayer)
	end
end
addEvent("boom",true)
addEventHandler("boom",root,boomboom)

function diffuseBomb(thePlayer)
	local mark = isElementWithinMarker(thePlayer,marker1)
		if mark then
				local data = getElementData(thePlayer,"timerCount")	
				if data == 0 then
					outputChatBox("Bomb Exploded!")
				else 
					local bombstate = getElementData(bomb,"planted")
					if bombstate == "yes" then
						setPedAnimation(thePlayer,"BOMBER","BOM_Plant",20000,true,false,true,false)	
						setTimer(function()
							setElementData(bomb,"planted","no")
							destroyElement(bomb)
							destroyElement(bombmarker)
							outputChatBox("Diffused ")
							triggerClientEvent("setDiffusal",root,thePlayer)
						end,20000,1)
					end
				end
		end
end


		
			