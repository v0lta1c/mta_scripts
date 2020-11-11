-- the co-ordinates of the markers at petrol station 
markercords = {
                {1938.384765625, -1769.27588, 12.3828125},
                {1938.728515625,-1776.16919,12.3828125},
				{1000.0810546875,-933.890625,41.1796875},
				{1008.10546875,-940.4150390625,41.1796875},
				{-93.0087890625,-1175.1728515625,1.2510697841644},
				{-88.11328125,-1163.9443359375,1.2560164928436},
				
				}
dieselcords = {
				{1945.2275390625,-1772.568359375,12.390598297119},
				{1000.4375,-940.9677734375,41.1796875},
				{-100.248046875,-1172.15625,1.4720582962036},
				{-94.89453125,-1160.2958984375,1.1527733802795},
			  }

 -- this handles the spawning of markers and also the events when car hits the marker 
addEventHandler("onResourceStart",resourceRoot, function()
     for i, pos in ipairs(markercords) do
          local x,y,z,typefuel = unpack(pos)
          local marker = createMarker(x,y,z,"cylinder",3,255,255,0,50)
          addEventHandler("onMarkerHit", marker, markerHit)
		  addEventHandler("onMarkerLeave",marker,markerLeave)
     end
end)

addEventHandler("onResourceStart",resourceRoot, function()
     for i, pos in ipairs(dieselcords) do
          local x,y,z = unpack(pos)
          local marker = createMarker(x,y,z,"cylinder",3,0,255,0,50)
          addEventHandler("onMarkerHit", marker, markerHit1)
		  addEventHandler("onMarkerLeave",marker,markerLeave1)
     end
end)
 
 -- this is what happens when a car hits the marker (petrol marker)
function markerHit(thePlayer)
      if getElementType(thePlayer) ~= "player" then return end
      if isElementWithinMarker(thePlayer,source) then
          if isPedInVehicle(thePlayer) then
               triggerClientEvent(thePlayer,"showthedxGui",root)
		  else
			   outputChatBox("Come in a car!")
          end
     end
end
-- diesel marker
function markerHit1(thePlayer)
      if getElementType(thePlayer) ~= "player" then return end
      if isElementWithinMarker(thePlayer,source) then
          if isPedInVehicle(thePlayer) then
               triggerClientEvent(thePlayer,"showthedxGui1",root)
		  else
			   outputChatBox("Come in a car!")
          end
     end
end
-- when car leaves the marker (petrol)
function markerLeave(thePlayer)
        triggerClientEvent(thePlayer,"hidethedxGui",root)
end
-- diesel
function markerLeave1(thePlayer)
        triggerClientEvent(thePlayer,"hidethedxGui1",root)
end

-- to turn on/off engine 

function changeEngineState(thePlayer)
    local veh = isPedInVehicle (thePlayer)
    if veh then
      local veh1 = getPedOccupiedVehicle(thePlayer)
       local state = getVehicleEngineState ( veh1 )
        setVehicleEngineState ( veh1, not state )
    else 
	outputChatBox("Error",source,255,0,0)
    end
end 

addCommandHandler("engine",changeEngineState)
