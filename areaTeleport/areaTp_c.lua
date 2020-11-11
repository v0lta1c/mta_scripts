function detectProperPos(thePlayer)
	local x,y,z = getElementPosition(thePlayer)
	local newZ = getGroundPosition(x,y,z)
	setElementPosition(thePlayer,x,y,newZ)
	setElementFrozen(thePlayer,false)
	local x,y,z = getElementPosition(thePlayer)
	zone = getZoneName(x,y,z)
	if zone == "The Big Ear" then 
		manageTheTeleport()
	end
	
end

function manageTheTeleport(thePlayer)
	local x,y,z = getElementPosition(thePlayer)
	local tpDedXNeg = math.random(-500,-400)
	local tpDedXPos = math.random(400,500)
	local tpDedYPos = math.random(400,500)
	local tpDedYNeg = math.random(-500,-400)
	local tpDedXChance = math.random(1,2)
	local tpDedYChance = math.random(1,2)
	if tpDedXChance == 1 then
		tpDedX = tpDedXPos
	else
		tpDedX = tpDedXNeg
	end
	if tpDedYChance == 1 then
		tpDedY = tpDedYPos
	else
		tpDedY = tpDedYNeg
	end
	local tpX = x + tpDedX
	local tpY = y + tpDedY
	setElementPosition(thePlayer,tpX,tpY,z)
	setCameraTarget(localPlayer)
	setElementFrozen(thePlayer,true)
	
	detectProperPos(thePlayer)
	
end

addEvent("manageTeleport",true)
addEventHandler("manageTeleport",root,manageTheTeleport)