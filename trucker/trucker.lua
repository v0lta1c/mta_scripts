                                                                          -- Completely made for gamenet.ga.
-- Rewritten by Mann.
-- This script still uses some parts of old code which was inevitable part of the API, most other stuff has been rewritten and made better.
 
truckerData = {}
-- trucker marker
truckerJobMarker = createMarker(-576.111328125,-504.34765625,24.6234375,"cylinder",1,255,255,0,50)
-- Cords where Linerunner or Roadtrain will spawn
truckCords = {
					{-589.2080078125,-487.6708984375,26.5234375}, --  { int x, int y, int z }
					{-579.8203125,-488.2666015625,26.5234375},
					{-570.095703125,-487.48828125,26.5234375},
					{-560.037109375,-486.5380859375,26.5234375},
					{-550.0224609375,-486.9775390625,26.5234375},
					{-539.7041015625,-487.2060546875,26.5234375},
			 }
-- Truck Models
truckModels = {
					{"Linerunner",403}, -- { "Model Name", model id }
					{"Roadtrain",515},
			  }
-- Trucker trailer positions
trailerPositions = {
						{-55.9912109375,-1140.5751953125,2.078125,0,0,65},
						{-80.2744140625,-1157.6904296875,1.8298377990723,0,0,65},
				   }

-- Blip of the Job
truckerJobBlip = createBlip(-576.111328125,-504.34765625,25.5234375,11,2,0,0,0,0,0,200)

-- ONLY FOR DEVELOPMENT AND TESTING PURPOSES. COMMENT IMMEDIATELY WHEN RESOURCE IS READY
function getPlayerJob(thePlayer)
	return 2,"trucker"
end

-- Function which is triggered everytime a player hits the trucker marker
function truckerMarkerTrigger(hitElement,matchingDimension)
	if source == truckerJobMarker then
		if isElement(hitElement) and getElementType(hitElement) == "player" and not isPedInVehicle(hitElement) then
			if not truckerData[hitElement] then
				local jobid,job = getPlayerJob (hitElement)
				if jobid == 2 then
					outputChatBox ("[TRUCKER] #ff0000Press E to start your job!",hitElement,255,255,0,true)
					if not isKeyBound (hitElement,"e","down",startTruckerJob) then
						bindKey (hitElement,"e","down",startTruckerJob)
						setTimer (unbindKey,10000,1,hitElement,"e","down",startTruckerJob)
					end
				else
					outputChatBox ("[TRUCKER] #ff0000You aren't a trucker!",hitElement,255,255,0,true)
				end
			else
				outputChatBox ("[TRUCKER] #ff0000Your job is already started!",hitElement,255,255,0,true)
			end
		end
	end
end

addEventHandler("onMarkerHit",truckerJobMarker,truckerMarkerTrigger)

-- This function is triggered when the player starts the job
function startTruckerJob (player,key,state)
  unbindKey (player,key,state,startTruckerJob)
  local cords = truckCords[math.random (1,#truckCords)]
  local model = truckModels[math.random(1,#truckModels)]
  local jobveh = createVehicle (model[2],cords[1],cords[2],cords[3]) 
  local blip = createBlipAttachedTo (jobveh,56,2,255,0,0,255,0,9999.0,player)
  truckerData[player] = {{jobveh,blip},0,0}
  setElementData (jobveh,"jobveh","trucker")
  outputChatBox ("[TRUCKER] #ff0000You have now joined as a Trucker! Get to your truck to start your job! Good luck!",player,255,255,0,true)
end 

-- When some other player enters your truck DIRECTLY FROM THE OLD CODE, DIDN'T CHANGE IT!

addEventHandler ("onVehicleStartEnter",getRootElement(),
function(player,seat,jacked,door)
  if getElementData (source,"jobveh") == "trucker" then
    if getPlayerJob (player) == 2 then
      if truckerData[player][1] ~= 0 then
        if source ~= truckerData[player][1][1] then
          cancelEvent (true)
          outputChatBox ("[TRUCKER] #ff00This isn't your truck!",player,255,255,0,true)
        end
      else
        cancelEvent (true)
        outputChatBox ("[TRUCKER] #ff0000This isn't your truck!",player,255,255,0,true)
      end
    else
      cancelEvent(true)
      outputChatBox ("[TRUCKER] #ff0000You are no trucker and this isn't your truck!",player,255,255,0,true)
    end
  end
end)

-- On player entering the truck for the first time
addEventHandler ("onVehicleEnter",getRootElement(),
function(player,seat,jacked)
  if truckerData[player] and truckerData[player][1][1] == source then
    outputChatBox ("[TRUCKER] #ff0000Go and pick up the trailer marked for you!",player,255,255,0,true)
	createTrailerForPlayer(player)
  end 
end)

-- Creates the trailer for the player
function createTrailerForPlayer(player)
	local cords = trailerPositions[math.random(1,#trailerPositions)]
	local truckTrailer = createVehicle(450,cords[1],cords[2],cords[3],cords[4],cords[5],cords[6])
	local trailerBlip = createBlip(cords[1],cords[2],cords[3],0,2,255,255,0,200,0,99999,player)
	attachElements(trailerBlip,truckTrailer)
end 

-- 
function attachTrailerAndDestination(truck)
	
end 