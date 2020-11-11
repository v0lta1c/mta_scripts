------------------------------------------------------------------
-- Fuel System by Mann
-- For Mta:sa
-------------------------------------------------------------------

sx_ , sy_ = guiGetScreenSize ()
sx, sy = sx_/1366 , sy_/768 
petrolPrice = 5
dieselPrice = 3
vehfuel = 100
totfuel = 100000
car = getPedOccupiedVehicle(localPlayer)
cars = { 
			
			{541,200,"petrol"}, -- Bullet
			{429,100,"petrol"}, -- Banshee
			{403,500,"diesel"}, -- Linerunner
		}


-- now lets draw the dxGui when a marker is hit for PETROL
function drawMarkerGUI ( thePlayer )
local veh1 = getPedOccupiedVehicle (localPlayer)
local id = getElementModel(veh1)
for i,fuellim in ipairs(cars) do
	local id1, totvehfuel,fueltype = unpack(fuellim)
	if id == id1 then
	 maxvehfuel = totvehfuel
	 typeOfFuel = fueltype
	end
end
if typeOfFuel == "petrol" then
dxDrawRectangle(sx*420,sy*230,sx*470,sy*280,tocolor(0,0,0,150))
dxDrawText ( "Fuel Station" , sx*560, sy*235, sx*490, sy*235, tocolor ( 255, 255, 0, 255 ), 1, "bankgothic" )
dxDrawText("Fuel Type : Petrol", sx*440,sy*290,sx*500,sy*240,tocolor(255,255,255,255),1 ,"bankgothic")
dxDrawText("Price : $" ..petrolPrice.. "", sx*440,sy*330,sx*500,sy*240,tocolor(255,255,255,255),1 ,"bankgothic")
dxDrawText("Total Fuel : " ..totfuel.." litres", sx*440,sy*370,sx*500,sy*240,tocolor(255,255,255,255),1 ,"bankgothic")
dxDrawText("Your Fuel : " ..vehfuel.."/"..maxvehfuel.. " litres", sx*440,sy*410,sx*500,sy*240,tocolor(255,255,255,255),1 ,"bankgothic")

local veh = isPedInVehicle( localPlayer )
if veh then
     local veh1 = getPedOccupiedVehicle (localPlayer)
     local getEngineState = getVehicleEngineState(veh1)

if getEngineState == true then
         dxDrawText("Please switch off the engine", sx*435,sy*450,sx*500,sy*240,tocolor(255,255,0,255),0.95 ,"bankgothic")
elseif getEngineState ~= true then
         dxDrawText("Hold SPACE to refuel!", sx*475,sy*450,sx*500,sy*240,tocolor(255,255,0,255),0.95 ,"bankgothic")
		 if (getKeyState('space')) then
		  if vehfuel < maxvehfuel then
			if (not startTick) then startTick = getTickCount() end
			if (getTickCount() - startTick > 1000) then
				vehfuel = vehfuel + 1
				totfuel = totfuel - 1
				local startTick = getTickCount()
			end
			end 
		  end
end	
end 
else 
	dxDrawText("Your vehicle does not run on petrol!", sx*410,sy*330,sx*500,sy*240,tocolor(255,0,0,255),1 ,"bankgothic")
end
end 




-- for diesel

function drawMarkerGUI1 ( thePlayer )
local veh1 = getPedOccupiedVehicle (localPlayer)
local id = getElementModel(veh1)
for i,fuellim in ipairs(cars) do
	local id1, totvehfuel,fueltype = unpack(fuellim)
	if id == id1 then
	 maxvehfuel = totvehfuel
	 typeOfFuel = fueltype
	end
end
if typeOfFuel == "diesel"then
dxDrawRectangle(sx*420,sy*230,sx*470,sy*280,tocolor(0,0,0,150))
dxDrawText ( "Fuel Station" , sx*560, sy*235, sx*490, sy*235, tocolor ( 255, 255, 0, 255 ), 1, "bankgothic" )
dxDrawText("Fuel Type : Diesel", sx*440,sy*290,sx*500,sy*240,tocolor(255,255,255,255),1 ,"bankgothic")
dxDrawText("Price : $" ..dieselPrice.. "", sx*440,sy*330,sx*500,sy*240,tocolor(255,255,255,255),1 ,"bankgothic")
dxDrawText("Total Fuel : " ..totfuel.." litres", sx*440,sy*370,sx*500,sy*240,tocolor(255,255,255,255),1 ,"bankgothic")
dxDrawText("Your Fuel : " ..vehfuel.."/"..maxvehfuel.. " litres", sx*440,sy*410,sx*500,sy*240,tocolor(255,255,255,255),1 ,"bankgothic")

local veh = isPedInVehicle( localPlayer )
if veh then
     local veh1 = getPedOccupiedVehicle (localPlayer)
     local getEngineState = getVehicleEngineState(veh1)

if getEngineState == true then
         dxDrawText("Please switch off the engine", sx*435,sy*450,sx*500,sy*240,tocolor(255,255,0,255),0.95 ,"bankgothic")
elseif getEngineState ~= true then
         dxDrawText("Hold SPACE to refuel!", sx*475,sy*450,sx*500,sy*240,tocolor(255,255,0,255),0.95 ,"bankgothic")
		 if (getKeyState('space')) then
		  if vehfuel < maxvehfuel then
			if (not startTick) then startTick = getTickCount() end
			if (getTickCount() - startTick > 1000) then
				vehfuel = vehfuel + 1
				totfuel = totfuel - 1
				local startTick = getTickCount()
			end
			end 
		  end
end	
end 
else 
	dxDrawText("Your vehicle does not run on diesel!", sx*410,sy*330,sx*500,sy*240,tocolor(255,0,0,255),1 ,"bankgothic")
end
end 

-- to show the gui (petrol)
addEvent("showthedxGui",true)
addEventHandler("showthedxGui",resourceRoot,function ()
addEventHandler("onClientRender",root,drawMarkerGUI )
end)
-- diesel
addEvent("showthedxGui1",true)
addEventHandler("showthedxGui1",resourceRoot,function ()
addEventHandler("onClientRender",root,drawMarkerGUI1 )
end )
--to hide the gui (petrol)
addEvent("hidethedxGui",true)
addEventHandler("hidethedxGui",resourceRoot,function ()
removeEventHandler("onClientRender",root,drawMarkerGUI )
end )
-- diesel
addEvent("hidethedxGui1",true)
addEventHandler("hidethedxGui1",resourceRoot,function ()
removeEventHandler("onClientRender",root,drawMarkerGUI1 )
end )