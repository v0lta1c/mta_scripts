-- ----------------------------------------------
-- Name : Vehicle-system
-- File : bikeshop.lua
-- Developer : Mann
-- Status : Completed

-------------------------------------------------

bikes =		{	{"BF-400",581,150000},
				{"Bike",509,5000},
				{"BMX",481,7500},
				{"Faggio",462,5000},
				{"FCR-900",521,175000},
				{"Freeway",463,250000},
				{"Mountain Bike",510,10000},
				{"NRG-500",522,300000},
				{"PCJ-600",461,225000},
				{"Sanchez",468,200000},
				{"Wayfarer",586,125000},

			}

-- GUI

function buybikeGui()
		guiSetVisible(cshop.window,false)
        window.buybike = guiCreateWindow(0.63, 0.04, 0.35, 0.86, "Buy Bike", true)
        guiWindowSetSizable(window.buybike, false)
        grid.bike = guiCreateGridList(0.05, 0.11, 0.91, 0.73, true, window.buybike)
        button.buyBike1 = guiCreateButton(0.06, 0.87, 0.46, 0.05, "Buy Bike", true, window.buybike)
        guiSetProperty(button.buyBike1, "NormalTextColour", "FFAAAAAA")
        button.testDrive = guiCreateButton(0.57, 0.87, 0.36, 0.05, "Test Drive", true, window.buybike)
        guiSetProperty(button.testDrive, "NormalTextColour", "FFAAAAAA")
        button.close = guiCreateButton(0.34, 0.94, 0.41, 0.03, "Close", true, window.buybike)
        guiSetProperty(button.close, "NormalTextColour", "FFAAAAAA") 
		local namecolumn = guiGridListAddColumn(grid.bike,"Name",0.60)
		local pricecolumn = guiGridListAddColumn(grid.bike,"Price",0.25)
		local idcolumn = guiGridListAddColumn(grid.bike,"Model Id",0.15)
		for i, bikeInfo in ipairs(bikes)do
			local bikeName,id,price = unpack(bikeInfo)
			local row = guiGridListAddRow (grid.bike)
			guiGridListSetItemText ( grid.bike, row, namecolumn, ""..bikeName.."", false, false )
			guiGridListSetItemText ( grid.bike, row, pricecolumn, ""..tostring(price).."", false, true )
			guiGridListSetItemText ( grid.bike, row, idcolumn, ""..tostring(id).."", false, true )
		end
		
		function click()
			local getName = guiGridListGetItemText ( grid.bike, guiGridListGetSelectedItem ( grid.bike ), 3 )
			if not vehView then
				 vehView = createVehicle(getName,-1950.212890625,266.423828125,41.047080993652)
			else
				local modelType = getElementModel(vehView)
				if getName == modelType then
				return 
				else 
					local destroy = destroyElement(vehView)
					vehView = createVehicle(getName,-1950.212890625,266.423828125,41.047080993652)
				end
			end
			setCameraMatrix(-1956.177734375,263.4619140625,43.047080993652,-1950.212890625,266.423828125,41.047080993652)
		end
		addEventHandler ( "onClientGUIClick", button.close, hideBuyBike, false )
		addEventHandler ( "onClientGUIClick", grid.bike, click)
		addEventHandler ( "onClientGUIClick", button.buyBike1,buyBike )
		
		
end 

addEvent("buyTheBike",true)
addEventHandler("buyTheBike",root,buybikeGui)

function buyBike()
        window.buyVeh = guiCreateWindow(0.34, 0.17, 0.29, 0.62, "Buy Car", true)
        guiWindowSetSizable(window.buyVeh, false)

        button.buyslot1 = guiCreateButton(0.09, 0.13, 0.81, 0.12, "Buy Slot 1", true, window.buyVeh)
        guiSetProperty(button.buyslot1, "NormalTextColour", "FFAAAAAA")
        button.buyslot2 = guiCreateButton(0.09, 0.29, 0.80, 0.12, "Buy Slot 2", true, window.buyVeh)
        guiSetProperty(button.buyslot2, "NormalTextColour", "FFAAAAAA")
        button.buyslot3 = guiCreateButton(0.10, 0.45, 0.80, 0.13, "Buy Slot 3", true, window.buyVeh)
        guiSetProperty(button.buyslot3, "NormalTextColour", "FFAAAAAA")
        button.closeGui = guiCreateButton(0.87, 0.05, 0.10, 0.05, "X", true, window.buyVeh)
        guiSetProperty(button.closeGui, "NormalTextColour", "FFAAAAAA")    
		function closeGUI()
			guiSetVisible(window.buyVeh,false)
		end
		addEventHandler ( "onClientGUIClick", button.closeGui, closeGUI, false )
		addEventHandler ( "onClientGUIClick", button.buyslot1, purchaseSlot1Bike, false )
		addEventHandler ( "onClientGUIClick", button.buyslot2, purchaseSlot2Bike, false )
		addEventHandler ( "onClientGUIClick", button.buyslot3, purchaseSlot3Bike, false )
end

function hideBuyBike()
		guiSetVisible(window.buybike,false)
		setCameraTarget(localPlayer)
		local destroy = destroyElement(vehView)
		showCursor(false)
end 

bikeSlots = {}

function purchaseSlot1Bike()
		if bikeSlots.slot1 == nil then
			local cname = guiGridListGetItemText ( grid.bike, guiGridListGetSelectedItem ( grid.bike ), 1 )
			local price = guiGridListGetItemText ( grid.bike, guiGridListGetSelectedItem ( grid.bike ), 2 )
			local id = guiGridListGetItemText ( grid.bike, guiGridListGetSelectedItem ( grid.bike ), 3 )
			local money = getPlayerMoney()
			if money > tonumber(price) then
				bikeSlots.slot1 = cname
				local slot = 1
				triggerServerEvent("buybikemoney",localPlayer,localPlayer,tonumber(price),cname,slot,tonumber(id))
				guiSetVisible(window.buyVeh,false)
			else 
				outputChatBox("Not Enough Money",255,0,0)
			end
		else
			outputChatBox("Slot is not empty!",255,255,0)
		end
end 

function purchaseSlot2Bike()
		if bikeSlots.slot2 == nil then
			local cname = guiGridListGetItemText ( grid.bike, guiGridListGetSelectedItem ( grid.bike ), 1 )
			local price = guiGridListGetItemText ( grid.bike, guiGridListGetSelectedItem ( grid.bike ), 2 )
			local id = guiGridListGetItemText ( grid.bike, guiGridListGetSelectedItem ( grid.bike ), 3 )
			local money = getPlayerMoney()
			if money > tonumber(price) then
				bikeSlots.slot2 = cname
				local slot = 2
				triggerServerEvent("buybikemoney",localPlayer,localPlayer,tonumber(price),cname,slot,tonumber(id))
				guiSetVisible(window.buyVeh,false)
			else 
				outputChatBox("Not Enough Money",255,0,0)
			end
		else
			outputChatBox("Slot is not empty!",255,255,0)
		end
end 

function purchaseSlot3Bike()
		if bikeSlots.slot3 == nil then
			local cname = guiGridListGetItemText ( grid.bike, guiGridListGetSelectedItem ( grid.bike ), 1 )
			local price = guiGridListGetItemText ( grid.bike, guiGridListGetSelectedItem ( grid.bike ), 2 )
			local id = guiGridListGetItemText ( grid.bike, guiGridListGetSelectedItem ( grid.bike ), 3 )
			local money = getPlayerMoney()
			if money > tonumber(price) then
				bikeSlots.slot3 = cname
				local slot = 3
				triggerServerEvent("buybikemoney",localPlayer,localPlayer,tonumber(price),cname,slot,tonumber(id))
				guiSetVisible(window.buyVeh,false)
			else 
				outputChatBox("Not Enough Money",255,0,0)
			end
		else
			outputChatBox("Slot is not empty!",255,255,0)
		end
end 

function bikeSlotter()
		guiSetVisible(cshop.window,false)
        window.sellBike = guiCreateWindow(0.36, 0.23, 0.27, 0.56, "Sell Bike", true)
        guiWindowSetSizable(window.sellBike, false)

        label.BikeWarn = guiCreateLabel(0.05, 0.07, 0.90, 0.14, "               Cars will be sold for half price of the \n             original  value. Think before proceeding!", true, window.sellCar)
        button.sellBikeSlot1 = guiCreateButton(0.12, 0.23, 0.82, 0.10, "Sell Slot 1", true, window.sellBike)
        guiSetProperty(button.sellBikeSlot1, "NormalTextColour", "FFAAAAAA")
        button.sellBikeSlot2 = guiCreateButton(0.12, 0.36, 0.82, 0.10, "Sell Slot 2", true, window.sellBike)
        guiSetProperty(button.sellBikeSlot2, "NormalTextColour", "FFAAAAAA")
        button.sellBikeSlot3 = guiCreateButton(0.12, 0.50, 0.82, 0.10, "Sell Slot 3", true, window.sellBike)
        guiSetProperty(button.sellBikeSlot3, "NormalTextColour", "FFAAAAAA")
        button.closeBikeSlotter = guiCreateButton(0.12, 0.91, 0.82, 0.06, "Close", true, window.sellBike)
        guiSetProperty(button.closeBikeSlotter, "NormalTextColour", "FFAAAAAA")    
		showCursor(true)
		addEventHandler ( "onClientGUIClick", button.closeBikeSlotter, function ()
		guiSetVisible(window.sellBike,false)
		showCursor(false)
		end, false )
		addEventHandler ( "onClientGUIClick", button.sellBikeSlot1, function ()
		triggerServerEvent("sellSlotBike1",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.sellBikeSlot2, function ()
		triggerServerEvent("sellSlotBike2",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.sellBikeSlot3, function ()
		triggerServerEvent("sellSlotBike3",localPlayer,localPlayer)
		end, false )
end 

addEvent("sellTheBike",true)
addEventHandler("sellTheBike",root,bikeSlotter)