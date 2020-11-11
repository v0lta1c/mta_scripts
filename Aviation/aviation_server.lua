pilotJobStartMarker = createMarker(-1554.111328125,-428.8544921875,5.1820593833923,"cylinder",1,255,255,0,200)

function triggerPilotJobFromMarker(thePlayer)
	triggerClientEvent(thePlayer,"triggerJobStartGui",thePlayer)
	playerDoingJob = thePlayer
end

addEventHandler("onMarkerHit",pilotJobStartMarker,triggerPilotJobFromMarker)

function createBlipAndMarkerForPassengerPilot()
	createMarkerForPassengerPilot = createMarker(-1438.5322265625,-564.0849609375,13.2484375,"cylinder",1,255,255,0,200,playerDoingJob)
	createBlipForPassangerPilot = createBlip(-1438.5322265625,-564.0849609375,14.1484375,5,2,0,0,0,255,0,500,playerDoingJob)
	
	addEventHandler("onMarkerHit",createMarkerForPassengerPilot,triggerPassengerJobFrmClient)
end 

addEvent("AirplanePilotTriggers",true)
addEventHandler("AirplanePilotTriggers",resourceRoot,createBlipAndMarkerForPassengerPilot)

function triggerPassengerJobFrmClient()
	triggerClientEvent(playerDoingJob,"triggerAPJobStartGui",playerDoingJob)
end 

passengerPlaneSpawns = {
							{-1186.5986328125,-452.052734375,14.1484375},
							{-1228.3037109375,-512.125,14.1484375},
					   }
function passengerPilotJobStart(selectedAircraft,thePlayer)
	destroyElement(createBlipForPassangerPilot)
	destroyElement(createMarkerForPassengerPilot)
	i = math.random(1,2)
	local vehModel = getVehicleModelFromName(selectedAircraft)
	outputChatBox(vehModel)
	workPlane = createVehicle(vehModel,passengerPlaneSpawns[i][1],passengerPlaneSpawns[i][2],passengerPlaneSpawns[i][3])
	setElementData(thePlayer,"Work Plane",workPlane )
	
end

addEvent("APJobStart",true)
addEventHandler("APJobStart",resourceRoot,passengerPilotJobStart)