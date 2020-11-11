sx,sy = guiGetScreenSize()

function showGamenet()
	local window = guiCreateWindow(0,0,sx,sy, "Gamenet Browser", false)
	local browser = guiCreateBrowser(sx/25, sx/25, (sx * 9/10), (sy * 8/10), false, false, false, window)
	local theBrowser = guiGetBrowser(browser) -- Get the browser element from gui-browser
	local close = guiCreateButton((sx*9.2/10),(sy*9.2/10),75,50,"Close",false,window)
	addEventHandler("onClientBrowserCreated", theBrowser, 
		function()
			loadBrowserURL(source, "http://gamenet.ga")
			showCursor(true)
		end
	)
	addEventHandler("onClientGUIClick",close,
	function()
		guiSetVisible(window,false)
		showCursor(false)
	end,false)
end

addCommandHandler("browse",showGamenet)

