col = createColCuboid(-78.83984375,1645.3515625,13.620933532715,520,500,100)
gateCol = createColCuboid(-83.26171875,2056.6376953125,15.555465698242,10,20,8)

gate1 = createObject(975,-78.5,2061.8,18.1,0,0,90)
gate2 = createObject(975,-78.5,2061.8,21.2,0,0,90)
gate3 = createObject(975,-78.40039,2070.6006,18.1,0,0,90)
gate4 = createObject(975,-78.40039,2070.6006,21.2,0,0,90)
function moveGate(thePlayer)
	if getElementType(thePlayer) == "player" then
			local team = getPlayerTeam(thePlayer)
			if getTeamName(team) == "Police" then
				moveObject(gate1,8000,-78.5,2051.8,18.1)
				moveObject(gate2,8000,-78.5,2051.8,21.2)
				moveObject(gate3,8000,-78.40039,2078.6006,18.1)
				moveObject(gate4,8000,-78.40039,2078.6006,21.2)
			else
				outputChatBox("Entry prohibited!",thePlayer,255,0,0)
			end
	end
end
addEventHandler("onColShapeHit",gateCol,moveGate)
function closeGate(thePlayer)
	if getElementType(thePlayer) == "player" then
			local team = getPlayerTeam(thePlayer)
			if getTeamName(team) == "Police" then
				moveObject(gate1,4000,-78.5,2061.8,18.1)
				moveObject(gate2,4000,-78.5,2061.8,21.2)
				moveObject(gate3,4000,-78.40039,2070.6006,18.1)
				moveObject(gate4,4000,-78.40039,2070.6006,21.2)
			end
	end
end
addEventHandler("onColShapeLeave",gateCol,closeGate)
function sendWarningAndKill(thePlayer,matchingDimension)
		if getElementType(thePlayer) == "player" then
			local team = getPlayerTeam(thePlayer)
			if getTeamName(team) == "Police" or getTeamName(team) == "Pilot" then
			else
				outputChatBox("Warning! This is a restricted area! Trespassers would be blown away!",thePlayer,255,0,0)
				triggerClientEvent("WarnAndKill",root,thePlayer,thePlayer)
			end
		end
end

addEventHandler("onColShapeHit",col,sendWarningAndKill)

function leftShape(thePlayer)
		if getElementType(thePlayer) == "player" then
			local team = getPlayerTeam(thePlayer)
			if getTeamName(team) == "Police" then
			else
				triggerClientEvent("leaveShape",root)
			end
		end
end

addEventHandler("onColShapeLeave",col,leftShape)



pickup = createPickup(-95.7587890625,2072.103515625,17.666297912598,3,1254,0)
function deathPickup(thePlayer)
	outputChatBox("You should be a member of Law Enforcement to gain access to area 51",thePlayer,255,255,0)
end
addEventHandler("onPickupHit",pickup,deathPickup)
