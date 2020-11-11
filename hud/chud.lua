x,y = guiGetScreenSize()
setPlayerHudComponentVisible ( "area_name",false)
setPlayerHudComponentVisible ( "vehicle_name" , false)

local fps = false
function getCurrentFPS() -- Setup the useful function
    return fps
end

local function updateFPS(msSinceLastFrame)
    -- FPS are the frames per second, so count the frames rendered per milisecond using frame delta time and then convert that to frames per second.
    fps = (1 / msSinceLastFrame) * 1000
end
addEventHandler("onClientPreRender", root, updateFPS)

-- Ping shit

function ping()
	local ping = getPlayerPing ( localPlayer )
	dxDrawText ( "Ping : "..ping.."",x*(825/1366),y*(25/768),x*(970/1366),y*(55/768),tocolor(255,255,0,255),1,"bankgothic")
	local getFps = math.floor(getCurrentFPS())
	dxDrawText ( "FPS  : "..getFps.."",x*(1050/1366),y*(25/768),x*(1234/1366),y*(55/768),tocolor(255,255,0,255),1,"bankgothic")
	end
	addEventHandler("onClientRender",root,ping)
	-- Zone System
	function zones()
	posx,posy,posz = getElementPosition ( localPlayer )
	zone = getZoneName(posx,posy,posz)

	dxDrawText (""..zone.."",x*(50/1366),y*(715/768),x*(100/1366),y*(745/768),tocolor(255,255,0,255),1,"bankgothic")

end

addEventHandler("onClientRender",root,zones)

function showHud()
	addEventHandler("onClientRender",root,hud)
end

function closeHud()
	removeEventHandler("onClinetRender",root,hud)
end

-- Speedometer and vehicle name and vehicle health
function hud()

	if isPedInVehicle(localPlayer) == false then return end 

	-- now calculating the speed ❤
	if getPedOccupiedVehicle(localPlayer) then
		local health = tostring(math.floor (( getElementHealth ( getPedOccupiedVehicle(localPlayer)))/ 10))
		local veh = getPedOccupiedVehicle(localPlayer)
		name = getVehicleName (veh)
		speedx,speedy,speedz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
		kmh = math.floor(((speedx^2 + speedy^2 + speedz^2) ^ (0.5)) * 180)
		dxDrawText (""..tostring(kmh).." km/h" , x*(1050/1366),y*(715/768),x*(1234/1366),y*(745/768),tocolor(255,255,0,255),1,"bankgothic")
		dxDrawText (""..name.."" , x*(1050/1366),y*(655/768),x*(124/1366),y*(725/768),tocolor(190,190,0,255),1,"bankgothic")
		dxDrawText ("Health : "..health.." %" , x*(1050/1366),y*(685/768),x*(1234/1366),y*(735/768),tocolor(255,255,0,255),1,"bankgothic")
	end
end

addEventHandler ("onClientVehicleEnter",root,showHud)
addEventHandler("onClientVehicleExit",root,closeHud)