-- STOPANIM COMMAND

function stopTheAnim(thePlayer)
	setPedAnimation(thePlayer,false)
	setElementFrozen(thePlayer,false)
end
addCommandHandler("stopanim",stopTheAnim)

-- AIRCRAFT ANIMS

-- pullacross (thrw_barl_thrw)

function animthrw_barl_thrw(thePlayer)
	setPedAnimation(thePlayer,"AIRPORT","thrw_barl_thrw")
	setElementFrozen(thePlayer,true)
end
addCommandHandler("pullacross",animthrw_barl_thrw)

-- BD_FIRE

-- smoke (M_smklean_loop)

function animM_smklean_loop(thePlayer)
	setPedAnimation(thePlayer,"BD_FIRE","M_smklean_loop")
	setElementFrozen(thePlayer,true)
end
addCommandHandler("smoke",animM_smklean_loop)

-- wash (wash_up)

function animwash_up(thePlayer)
	setPedAnimation(thePlayer,"BD_FIRE","wash_up")
	setElementFrozen(thePlayer,true)
end
addCommandHandler("wash",animwash_up)

-- BEACH

-- sunbathe1 (bather)

function animbather(thePlayer)
	setPedAnimation(thePlayer,"BEACH","bather")
	setElementFrozen(thePlayer,true)
end
addCommandHandler("sunbathe1",animbather)

-- sunbathe2 (Lay_Bac_Loop)

function animLay_Bac_Loop(thePlayer)
	setPedAnimation(thePlayer,"BEACH","Lay_Bac_Loop")
	setElementFrozen(thePlayer,true)
end
addCommandHandler("sunbathe2",animLay_Bac_Loop)

-- BOMBER

-- plant (BOM_Plant)

function animBOM_Plant(thePlayer)
	setPedAnimation(thePlayer,"BOMBER","BOM_Plant")
	setElementFrozen(thePlayer,true)
end
addCommandHandler("plant",animBOM_Plant)


-- BUDDY

-- crouchfire (buddy_crouchfire)

function animbuddy_crouchfire(thePlayer)
	setPedAnimation(thePlayer,"BUDDY","buddy_crouchfire")
	setElementFrozen(thePlayer,true)
end
addCommandHandler("crouchfire",animbuddy_crouchfire)

-- CAR

-- fixcar (Fixn_Car_Loop)

function animFixn_Car_Loop(thePlayer)
	setPedAnimation(thePlayer,"CAR","Fixn_Car_Loop")
	setElementFrozen(thePlayer,true)
end
addCommandHandler("fixcar",animFixn_Car_Loop)