addEventHandler("onClientResourceStart", resourceRoot,
    function()    
    end
)
addEventHandler("onClientRender", root,
    function()
	    local cash = getPlayerMoney( getLocalPlayer() )
        dxDrawText("Dollar",   855,   22,  688, 128, tocolor(30, 247, 7, 255), 0.50, "bankgothic", "left", "top", false, false, false, false, false)
        dxDrawText(""..cash,  920,22,796,123, tocolor(255, 255, 255, 255), 0.50, "bankgothic", "left", "top", false, false, false, false, false)
    end
)