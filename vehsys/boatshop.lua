-- ----------------------------------------------
-- Name : Vehicle-system
-- File : boatshop.lua
-- Developer : Mann
-- Status : Work in progress, not yet completed

-------------------------------------------------

boats = 	{	{"Coastguard",472,200000},
				{"Dinghy",473,100000},
				{"Jetmax",493,250000},
				{"Launch",595,200000},
				{"Marquis",484,225000},
				{"Reefer",453,150000},
				{"Speeder",452,125000},
				{"Squalo",446,250000},
				{"Tropic",454,175000},
			}
			
function showBoatGUI()
        window.boats = guiCreateWindow(0.42, 0.24, 0.21, 0.49, "Vapid Inc.", true)
        guiWindowSetSizable(window.boats, false)

        label.welcome = guiCreateLabel(0.03, 0.08, 0.93, 0.12, "                 Welcome! Here you can\n                     buy or sell boats!", true, window.boats)
        button.buyBoat = guiCreateButton(0.07, 0.32, 0.87, 0.15, "Buy Boat", true, window.boats)
        guiSetProperty(button.buyBoat, "NormalTextColour", "FFAAAAAA")
        button.sellBoat = guiCreateButton(0.07, 0.51, 0.87, 0.15, "Sell Boat", true, window.boats)
        guiSetProperty(button.sellBoat, "NormalTextColour", "FFAAAAAA")
        button.closeBoatText = guiCreateButton(0.07, 0.82, 0.87, 0.15, "Close", true, window.boats)
        guiSetProperty(button.closeBoatText, "NormalTextColour", "FFAAAAAA")    
		showCursor(true)
		addEventHandler ( "onClientGUIClick", button.closeBoatText, function ()
		guiSetVisible(window.boats,false)
		showCursor(false) end, false )
		addEventHandler ( "onClientGUIClick", button.buyBoat, buyBoatGui, false )
		addEventHandler ( "onClientGUIClick", button.sellBoat, waterSlotter, false )
end 

addEvent("showboatGui",true)
addEventHandler("showboatGui",localPlayer,showBoatGUI)

function buyBoatGui()
        window.buyWater = guiCreateWindow(0.63, 0.04, 0.35, 0.86, "Buy Boat", true)
        guiWindowSetSizable(window.buyWater, false)

        grid.water = guiCreateGridList(0.05, 0.11, 0.91, 0.73, true, window.buyWater)
        button.buyWater1 = guiCreateButton(0.06, 0.87, 0.46, 0.05, "Buy Boat", true, window.buyWater)
        guiSetProperty(button.buyWater1, "NormalTextColour", "FFAAAAAA")
        button.testBoat = guiCreateButton(0.57, 0.87, 0.36, 0.05, "Test Drive", true, window.buyWater)
        guiSetProperty(button.testBoat, "NormalTextColour", "FFAAAAAA")
        button.closeBoat = guiCreateButton(0.34, 0.94, 0.41, 0.03, "Close", true, window.buyWater)
        guiSetProperty(button.closeBoat, "NormalTextColour", "FFAAAAAA") 
		local namecolumn = guiGridListAddColumn(grid.water,"Name",0.60)
		local pricecolumn = guiGridListAddColumn(grid.water,"Price",0.25)
		local idcolumn = guiGridListAddColumn(grid.water,"Model Id",0.15)
		for i, waterInfo in ipairs(boats)do
			local waterName,id,price = unpack(waterInfo)
			local row = guiGridListAddRow (grid.water)
			guiGridListSetItemText ( grid.water, row, namecolumn, ""..waterName.."", false, false )
			guiGridListSetItemText ( grid.water, row, pricecolumn, ""..tostring(price).."", false, true )
			guiGridListSetItemText ( grid.water, row, idcolumn, ""..tostring(id).."", false, true )
		end
		function click()
			local getName = guiGridListGetItemText ( grid.water, guiGridListGetSelectedItem ( grid.water ), 3 )
			if not vehView then
				 vehView = createVehicle(getName,-1642.0966796875,178.677734375,0)
			else
				local modelType = getElementModel(vehView)
				if getName == modelType then
				return 
				else 
					local destroy = destroyElement(vehView)
					vehView = createVehicle(getName,-1642.0966796875,178.677734375,0)
				end
			end
			setCameraMatrix(-1626.0478515625,181.49609375,0.55000001192093,-1642.0966796875,178.677734375,0)
		end
		showCursor(true)
		guiSetVisible(window.boats,false)
		addEventHandler ( "onClientGUIClick", grid.water, click)
		addEventHandler ( "onClientGUIClick", button.buyWater1, buyTheBoat)
		addEventHandler ( "onClientGUIClick", button.closeBoat, function ()
		guiSetVisible(window.buyWater,false)
		setCameraTarget(localPlayer)
		local destroy = destroyElement(vehView)
		showCursor(false) end, false )
end 

function buyTheBoat()
        window.buyVeh2 = guiCreateWindow(0.34, 0.17, 0.29, 0.62, "Buy Plane", true)
        guiWindowSetSizable(window.buyVeh2, false)

        button.buyslot1water = guiCreateButton(0.09, 0.13, 0.81, 0.12, "Buy Slot 1", true, window.buyVeh2)
        guiSetProperty(button.buyslot1water, "NormalTextColour", "FFAAAAAA")
        button.buyslot2water = guiCreateButton(0.09, 0.29, 0.80, 0.12, "Buy Slot 2", true, window.buyVeh2)
        guiSetProperty(button.buyslot2water, "NormalTextColour", "FFAAAAAA")
        button.closeBoatGui1 = guiCreateButton(0.87, 0.05, 0.10, 0.05, "X", true, window.buyVeh2)
        guiSetProperty(button.closeBoatGui1, "NormalTextColour", "FFAAAAAA")    
		function closeBoatGUI()
			guiSetVisible(window.buyVeh2,false)
		end
		addEventHandler ( "onClientGUIClick", button.closeBoatGui1, closeBoatGUI, false )
		addEventHandler ( "onClientGUIClick", button.buyslot1water, purchaseBSlot1, false )
		addEventHandler ( "onClientGUIClick", button.buyslot2water, purchaseBSlot2, false )
end 

waterSlots ={}
function purchaseBSlot1()
		if waterSlots.slot1 == nil then
			local cname = guiGridListGetItemText ( grid.water, guiGridListGetSelectedItem ( grid.water ), 1 )
			local price = guiGridListGetItemText ( grid.water, guiGridListGetSelectedItem ( grid.water ), 2 )
			local id = guiGridListGetItemText ( grid.water, guiGridListGetSelectedItem ( grid.water ), 3 )
			local money = getPlayerMoney()
			if money > tonumber(price) then
				waterSlots.slot1 = cname
				local slot = 1
				triggerServerEvent("buyboatmoney",localPlayer,localPlayer,tonumber(price),cname,slot,tonumber(id))
				guiSetVisible(window.buyVeh2,false)
			else 
				outputChatBox("Not Enough Money")
			end
		else
			outputChatBox("Slot is not empty!")
		end
end 

function purchaseBSlot2()
		if waterSlots.slot2 == nil then
			local cname = guiGridListGetItemText ( grid.water, guiGridListGetSelectedItem ( grid.water ), 1 )
			local price = guiGridListGetItemText ( grid.water, guiGridListGetSelectedItem ( grid.water ), 2 )
			local id = guiGridListGetItemText ( grid.water, guiGridListGetSelectedItem ( grid.water ), 3 )
			local money = getPlayerMoney()
			if money > tonumber(price) then
				waterSlots.slot2 = cname
				local slot = 2
				triggerServerEvent("buyboatmoney",localPlayer,localPlayer,tonumber(price),cname,slot,tonumber(id))
				guiSetVisible(window.buyVeh2,false)
			else 
				outputChatBox("Not Enough Money")
			end
		else
			outputChatBox("Slot is not empty!")
		end
end 

function waterSlotter()
        window.sellWater = guiCreateWindow(0.36, 0.23, 0.27, 0.56, "Sell Boat", true)
        guiWindowSetSizable(window.sellWater, false)
		guiSetVisible(window.boats,false)
        label.WaterWarn = guiCreateLabel(0.05, 0.07, 0.90, 0.14, "               Boats will be sold for half price of the \n             original  value. Think before proceeding!", true, window.sellAir)
        button.sellWaterSlot1 = guiCreateButton(0.12, 0.23, 0.82, 0.10, "Sell Slot 1", true, window.sellWater)
        guiSetProperty(button.sellWaterSlot1, "NormalTextColour", "FFAAAAAA")
        button.sellWaterSlot2 = guiCreateButton(0.12, 0.36, 0.82, 0.10, "Sell Slot 2", true, window.sellWater)
        guiSetProperty(button.sellWaterSlot2, "NormalTextColour", "FFAAAAAA")
        button.closeWaterSlotter = guiCreateButton(0.12, 0.91, 0.82, 0.06, "Close", true, window.sellWater)
        guiSetProperty(button.closeWaterSlotter, "NormalTextColour", "FFAAAAAA")    
		showCursor(true)
		addEventHandler ( "onClientGUIClick", button.closeWaterSlotter, function ()
		guiSetVisible(window.sellWater,false)
		showCursor(false)
		end, false )
		addEventHandler ( "onClientGUIClick", button.sellWaterSlot1, function ()
		triggerServerEvent("sellWaterSlot1",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.sellWaterSlot2, function ()
		triggerServerEvent("sellWaterSlot2",localPlayer,localPlayer)
		end, false )
end 