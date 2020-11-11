function WarnAndKill(thePlayer)
	rotZ1 = getPedRotation ( localPlayer )
	timer1 = setTimer ( createProjectile, 8000, 0, localPlayer, 20, 15.7054, 1719.3632, 50.123, 1.0, thePlayer, 0, 0, rotZ1, 0.1, 0.1, 0.1 )
	timer2 = setTimer ( createProjectile, 8000, 0, localPlayer, 20, 237.7176, 1696.5727, 50.1087, 1.0, thePlayer, 0, 0, rotZ1, 0.1, 0.1, 0.1 )
	timer3 = setTimer ( createProjectile, 8000, 0, localPlayer, 20, 354.6243, 2028.3897, 50.1217, 1.0, thePlayer, 0, 0, rotZ1, 0.1, 0.1, 0.1 )
	timer4 = setTimer ( createProjectile, 8000, 0, localPlayer, 20, 188.241, 2081.3469, 50.1422, 1.0, thePlayer, 0, 0, rotZ1, 0.1, 0.1, 0.1 )
end
addEvent("WarnAndKill",true)
addEventHandler("WarnAndKill",root,WarnAndKill)

addEvent ( "leaveShape", true )
addEventHandler ( "leaveShape", root,
function ()
		
		killTimer ( timer1 )
		killTimer ( timer2 )
		killTimer ( timer3 )
		killTimer ( timer4 )
		
end
)



