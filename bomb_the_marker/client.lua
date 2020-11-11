-- Settings
scoreBoardBindKey = "F6"

sx , sy = guiGetScreenSize()
myX, myY = 1366,768
sx,sy = sx/myX, sy/myY
function drawTimer(thePlayer)
		local data = getElementData(localPlayer,"timerCount")
		if data == 1 then
			removeEventHandler("onClientRender",root,drawTimer)
		end
		dxDrawText("Bomb triggers in : ",sx*30,sy*230,sx*275,sy*250,tocolor(255,255,0,255),sx*0.85,"bankgothic")
		dxDrawText(data,sx*280,sy*230,sx,sy,tocolor(255,0,0,255),sx*0.85,"bankgothic")
end
function countdownTimer(thePlayer,_,x,y,z) 
		local downTimer = 60		
		addEventHandler("onClientRender",root,drawTimer)
		function boomNigga(thePlayer)		
			setElementData(localPlayer,"timerCount",downTimer)
			downTimer = downTimer - 1
			local countZero = getElementData(localPlayer,"timerCount")
			local triggered = triggerServerEvent("boom",root,localPlayer,x,y,z)
			outputChatBox(z)
		end
		timer = setTimer(boomNigga,1000,61)
		local getData = getElementData(localPlayer,"timerCount")
end

addEvent("countdown",true)
addEventHandler("countdown",localPlayer,countdownTimer)

statusbs1 = "Clear"
statusbs2 = "Clear"
statusbs3 = "Clear"
statusbs4 = "Clear"
statusbs5 = "Clear"
statusbs6 = "Clear"
addEvent("statuses",true)
addEventHandler("statuses",root,function(thePlayer)
	statusbs1 = getElementData(thePlayer,"statusbs1")
	booms = getElementData(thePlayer,"Blasts")
	booms = booms + 1
	setElementData(thePlayer,"Blasts",booms)
	killTimer(timer)
end)

function processBombSites()
			dxDrawText("Bombsite 1 : ",sx*30,sy*270,sx*240,sy*290,tocolor(255,255,0,255),sx*1,"bankgothic")
			dxDrawText(""..statusbs1.."",sx*250,sy*270,sx,sy,tocolor(255,0,0,255),sx*1,"bankgothic")
			dxDrawText("Bombsite 2 : ",sx*30,sy*295,sx*240,sy*315,tocolor(255,255,0,255),sx*1,"bankgothic")
			dxDrawText(""..statusbs2.."",sx*250,sy*295,sx,sy,tocolor(255,0,0,255),sx*1,"bankgothic")
			dxDrawText("Bombsite 3 : ",sx*30,sy*320,sx*240,sy*340,tocolor(255,255,0,255),sx*1,"bankgothic")
			dxDrawText(""..statusbs3.."",sx*250,sy*320,sx,sy,tocolor(255,0,0,255),sx*1,"bankgothic")
end
addEventHandler("onClientRender",root,processBombSites)

function removeTimerAndSetDiffused(thePlayer)
	removeEventHandler("onClientRender",root,drawTimer)
	removeEventHandler("countdown",root,countdownTimer)
	setElementData(thePlayer,"statusbs1","Diffused")
	statusbs1 = getElementData(thePlayer,"statusbs1")
	diffuses = getElementData(thePlayer,"Diffuses")
	diffuses = diffuses + 1
	setElementData(thePlayer,"Diffuses",diffuses)
	killTimer(timer)
end
addEvent("setDiffusal",true)
addEventHandler("setDiffusal",root,removeTimerAndSetDiffused)

function drawScoreboard(thePlayer)
	dxDrawRectangle(sx*420,sy*140,sx*640,sy*480,tocolor(0,0,0,160),false)
	dxDrawLine(sx*420,sy*185,sx*420+sx*640,sy*185,tocolor(255,255,0,255),sx*3)
	dxDrawText("Players",sx*430,sy*150,sx,sy,tocolor(255,255,0,255),sx*2)
	local players = getElementsByType("player")
	local n = sy*170
	for i,v in ipairs(players) do
		if sx < 0.60 and sy < 0.80 then
			n = n + sy*75
		else
			n = n + sy*25
		end
		dxDrawText(getPlayerName(v),sx*430,sy*n,sx,sy,tocolor(255,255,255,255),sx*1.5)
		dxDrawLine(sx*420,sy*(n+sy*25) ,sx*420+sx*640,sy*(n+sy*25) ,tocolor(255,255,255,255),sx*1.5)
	end
	dxDrawText("Team",sx*590,sy*150,sx,sy,tocolor(255,255,0,255),sx*2)
	local n = sy*170
	for i,v in ipairs(players) do
		if sx < 0.60 and sy < 0.80 then
			n = n + sy*75
		else
			n = n + sy*25
		end
		local team = getPlayerTeam(v)
		if team then
			local teamname = getTeamName(team)
			dxDrawText(teamname,sx*590,sy*n,sx,sy,tocolor(255,255,255,255),sx*1.5)
		else 
			local teamname = "None"
			dxDrawText(teamname,sx*590,sy*n,sx,sy,tocolor(255,255,255,255),sx*1.5)
		end
	end
	dxDrawLine(sx*580,sy*140,sx*580,sy*140+sy*480,tocolor(255,255,0,255),sx*1.5)
	dxDrawLine(sx*700,sy*140,sx*700,sy*140+sy*480,tocolor(255,255,0,255),sx*1.5)
	dxDrawText("Blasts",sx*710,sy*150,sx,sy,tocolor(255,255,0,255),sx*2)
	local booms = getElementData(thePlayer,"Blasts")
	local n = sy*170
	for i,v in ipairs(players) do
		if sx < 0.60 and sy < 0.80 then
			n = n + sy*75
		else
			n = n + sy*25
		end
		local boom = getElementData(thePlayer,"Blasts")
		dxDrawText(tostring(boom),sx*710,sy*n,sx,sy,tocolor(255,255,255,255),sx*1.5)
	end
	dxDrawLine(sx*800,sy*140,sx*800,sy*140+sy*480,tocolor(255,255,0,255),sx*1.5)
	dxDrawText("Diffuses",sx*810,sy*150,sx,sy,tocolor(255,255,0,255),sx*2)
	local n = sy*170
	for i,v in ipairs(players) do
		if sx < 0.60 and sy < 0.80 then
			n = n + sy*75
		else
			n = n + sy*25
		end
		diffuses = getElementData(thePlayer,"Diffuses")
		dxDrawText(tostring(diffuses),sx*810,sy*n,sx,sy,tocolor(255,255,255,255),sx*1.5)
	end
	dxDrawLine(sx*910,sy*140,sx*910,sy*140+sy*480,tocolor(255,255,0,255),sx*1.5)
	dxDrawText("Ping",sx*920,sy*150,sx,sy,tocolor(255,255,0,255),sx*2)
	local n = sy*170
	for i,v in ipairs(players) do
		if sx < 0.60 and sy < 0.80 then
			n = n + sy*75
		else
			n = n + sy*25
		end
		local ping = getPlayerPing(v)
		dxDrawText(tostring(ping),sx*920,sy*n,sx,sy,tocolor(255,255,255,255),sx*1.5)
	end
	dxDrawLine(sx*980,sy*140,sx*980,sy*140+sy*480,tocolor(255,255,0,255),sx*1.5)
	dxDrawText("Kills",sx*990,sy*150,sx,sy,tocolor(255,255,0,255),sx*2)
end
function renderScoreboard(thePlayer)
	addEventHandler("onClientRender",root,drawScoreboard)
	unbindKey(scoreBoardBindKey)
	bindKey(scoreBoardBindKey,"down",stopScoreBoardRender,thePlayer)
end

function stopScoreBoardRender(thePlayer)
	removeEventHandler("onClientRender",root,drawScoreboard)
	unbindKey(scoreBoardBindKey)
	bindKey(scoreBoardBindKey,"down",renderScoreboard,thePlayer)

end
addEvent("holla",true)
addEventHandler("holla",resourceRoot,stopScoreBoardRender)