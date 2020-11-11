local holo
local screen_h = 0
local screen_w = 0
local elementBuffer = {}
--
-- First holoscreen at the Gant bridge -------------
--

-- The background holo
function createGarverHolo()
	holo,screen_w,screen_h = exports.holo:createHoloScreen(-1664.8251953125,547.0658203125,41.020697021484,0,0,136,5,3)
	setElementData(holo,"interactive","aim") 
	addEventHandler ( "onHoloScrenRender", holo,drawGarverHolo)
	elementBuffer["headText"] = "Welcome to Garver Bridge!"
	elementBuffer["button1Text"] = "Click Here!"
end

addEventHandler("onClientResourceStart",resourceRoot,createGarverHolo)

-- Draw the garver holoscreen

function drawGarverHolo(rendertarget)
	dxSetRenderTarget(rendertarget,true)
	--
		-- dxDrawRectangle (0,0,10,RTE_h,tocolor(0,255,0,200),false)
		
		dxDrawRectangle (0,0,screen_w,screen_h,tocolor(0,0,0,220),false)
		dxDrawRectangle(0,400,300,100,tocolor(255,255,255,255),false)
		dxDrawText(elementBuffer["headText"],0,0,300,300,tocolor(255,255,255,255),1,"pricedown")
		dxDrawText(elementBuffer["button1Text"],0,410,0,410,tocolor(0,0,0,255),1,"pricedown")
		local ix = (getElementData(holo,"ix") or -1)*screen_w
		local iy = (getElementData(holo,"iy") or -1)*screen_h
		local holoX, holoY, holoZ = getElementPosition(holo)
		local plX,plY,plZ = getElementPosition(localPlayer)
		local dist = getDistanceBetweenPoints3D(holoX,holoY,holoZ,plX,plY,plZ)
		local cstate = isPedDoingTask(localPlayer,"TASK_SIMPLE_USE_GUN")
		if dist < 10 then
			if cstate then
				if ix > 0 and iy > 0 then
						if iy > 400 then
							elementBuffer["button1Text"] = "You can pass through!"
						else
							elementBuffer["button1Text"] = "Click Here!"
						end
					elementBuffer["headText"] = "You are aiming this screen"
				end
			else
					elementBuffer["headText"] = "Welcome to Garver Bridge!"
					elementBuffer["button1Text"] = "Click Here!"
				
			end
		end
	--
	dxSetRenderTarget()
end

