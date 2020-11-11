-- ----------------------------------------------
-- Name : Vehicle-system
-- File : planeshop.lua
-- Developer : Mann
-- Status : Completed

-------------------------------------------------

aircraft = 	{	{"Andromada",592,550000},
				{"Beagle",511,500000},
				{"Cargobob",548,6500000},
				{"Cropduster",512,600000},
				{"Dodo",593,500000},
				{"Leviathan",417,600000},
				{"Maverick",487,550000},
				{"Nevada",553,550000},
				{"Raindance",563,500000},
				{"Rustler",476,500000},
				{"Seasparrow",447,550000},
				{"Shamal",519,750000},
				{"Skimmer",460,500000},
				{"Sparrow",469,530000},
				{"Stuntplane",513,570000},
				
			}
			
function showPlaneGUI()
        window.aircrafts = guiCreateWindow(0.42, 0.24, 0.21, 0.49, "Vapid Inc.", true)
        guiWindowSetSizable(window.aircrafts, false)

        label.welcome = guiCreateLabel(0.03, 0.08, 0.93, 0.12, "                 Welcome! Here you can\n                     buy or sell aircrafts!", true, window.aircrafts)
        button.buyAir = guiCreateButton(0.07, 0.32, 0.87, 0.15, "Buy Aircraft", true, window.aircrafts)
        guiSetProperty(button.buyAir, "NormalTextColour", "FFAAAAAA")
        button.sellAir = guiCreateButton(0.07, 0.51, 0.87, 0.15, "Sell Aircraft", true, window.aircrafts)
        guiSetProperty(button.sellAir, "NormalTextColour", "FFAAAAAA")
        button.closeAirText = guiCreateButton(0.07, 0.82, 0.87, 0.15, "Close", true, window.aircrafts)
        guiSetProperty(button.closeAirText, "NormalTextColour", "FFAAAAAA")    
		showCursor(true)
		addEventHandler ( "onClientGUIClick", button.closeAirText, function ()
		guiSetVisible(window.aircrafts,false)
		showCursor(false) end, false )
		addEventHandler ( "onClientGUIClick", button.buyAir, buyAirGui, false )
		addEventHandler ( "onClientGUIClick", button.sellAir, airSlotter, false )
end 

addEvent("showplaneGui",true)
addEventHandler("showplaneGui",localPlayer,showPlaneGUI)

function buyAirGui()
        window.buyAir = guiCreateWindow(0.63, 0.04, 0.35, 0.86, "Buy Aircraft", true)
        guiWindowSetSizable(window.buyAir, false)

        grid.air = guiCreateGridList(0.05, 0.11, 0.91, 0.73, true, window.buyAir)
        button.buyAir1 = guiCreateButton(0.06, 0.87, 0.46, 0.05, "Buy Aircraft", true, window.buyAir)
        guiSetProperty(button.buyAir1, "NormalTextColour", "FFAAAAAA")
        button.testFlight = guiCreateButton(0.57, 0.87, 0.36, 0.05, "Test Flight", true, window.buyAir)
        guiSetProperty(button.testFlight, "NormalTextColour", "FFAAAAAA")
        button.closePlane = guiCreateButton(0.34, 0.94, 0.41, 0.03, "Close", true, window.buyAir)
        guiSetProperty(button.closePlane, "NormalTextColour", "FFAAAAAA") 
		local namecolumn = guiGridListAddColumn(grid.air,"Name",0.60)
		local pricecolumn = guiGridListAddColumn(grid.air,"Price",0.25)
		local idcolumn = guiGridListAddColumn(grid.air,"Model Id",0.15)
		for i, airInfo in ipairs(aircraft)do
			local airName,id,price = unpack(airInfo)
			local row = guiGridListAddRow (grid.air)
			guiGridListSetItemText ( grid.air, row, namecolumn, ""..airName.."", false, false )
			guiGridListSetItemText ( grid.air, row, pricecolumn, ""..tostring(price).."", false, true )
			guiGridListSetItemText ( grid.air, row, idcolumn, ""..tostring(id).."", false, true )
		end
		function click()
			local getName = guiGridListGetItemText ( grid.air, guiGridListGetSelectedItem ( grid.air ), 3 )
			if not vehView then
				 vehView = createVehicle(getName,-1198.5791015625,-272.8369140625,15.1484375)
			else
				local modelType = getElementModel(vehView)
				if getName == modelType then
				return 
				else 
					local destroy = destroyElement(vehView)
					vehView = createVehicle(getName,-1198.5791015625,-272.8369140625,15.1484375)
				end
			end
			setCameraMatrix(-1241.708984375,-268.111328125,14.14396572113,-1198.5791015625,-272.8369140625,15.1484375)
		end
		showCursor(true)
		guiSetVisible(window.aircrafts,false)
		addEventHandler ( "onClientGUIClick", grid.air, click)
		addEventHandler ( "onClientGUIClick", button.buyAir1, buyPlane)
		addEventHandler ( "onClientGUIClick", button.closePlane, function ()
		guiSetVisible(window.buyAir,false)
		setCameraTarget(localPlayer)
		local destroy = destroyElement(vehView)
		showCursor(false) end, false )
end 

function buyPlane()
        window.buyVeh1 = guiCreateWindow(0.34, 0.17, 0.29, 0.62, "Buy Plane", true)
        guiWindowSetSizable(window.buyVeh1, false)

        button.buyslot1air = guiCreateButton(0.09, 0.13, 0.81, 0.12, "Buy Slot 1", true, window.buyVeh1)
        guiSetProperty(button.buyslot1air, "NormalTextColour", "FFAAAAAA")
        button.buyslot2air = guiCreateButton(0.09, 0.29, 0.80, 0.12, "Buy Slot 2", true, window.buyVeh1)
        guiSetProperty(button.buyslot2air, "NormalTextColour", "FFAAAAAA")
        button.closePlaneGui1 = guiCreateButton(0.87, 0.05, 0.10, 0.05, "X", true, window.buyVeh1)
        guiSetProperty(button.closePlaneGui1, "NormalTextColour", "FFAAAAAA")    
		function closeAirGUI()
			guiSetVisible(window.buyVeh1,false)
		end
		addEventHandler ( "onClientGUIClick", button.closePlaneGui1, closeAirGUI, false )
		addEventHandler ( "onClientGUIClick", button.buyslot1air, purchasePSlot1, false )
		addEventHandler ( "onClientGUIClick", button.buyslot2air, purchasePSlot2, false )
end 

airSlots ={}
function purchasePSlot1()
		if airSlots.slot1 == nil then
			local cname = guiGridListGetItemText ( grid.air, guiGridListGetSelectedItem ( grid.air ), 1 )
			local price = guiGridListGetItemText ( grid.air, guiGridListGetSelectedItem ( grid.air ), 2 )
			local id = guiGridListGetItemText ( grid.air, guiGridListGetSelectedItem ( grid.air ), 3 )
			local money = getPlayerMoney()
			if money > tonumber(price) then
				airSlots.slot1 = cname
				local slot = 1
				triggerServerEvent("buyaircraftmoney",localPlayer,localPlayer,tonumber(price),cname,slot,tonumber(id))
				guiSetVisible(window.buyVeh1,false)
			else 
				outputChatBox("Not Enough Money")
			end
		else
			outputChatBox("Slot is not empty!")
		end
end

function purchasePSlot2()
		if airSlots.slot2 == nil then
			local cname = guiGridListGetItemText ( grid.air, guiGridListGetSelectedItem ( grid.air ), 1 )
			local price = guiGridListGetItemText ( grid.air, guiGridListGetSelectedItem ( grid.air ), 2 )
			local id = guiGridListGetItemText ( grid.air, guiGridListGetSelectedItem ( grid.air ), 3 )
			local money = getPlayerMoney()
			if money > tonumber(price) then
				airSlots.slot2 = cname
				local slot = 2
				triggerServerEvent("buyaircraftmoney",localPlayer,localPlayer,tonumber(price),cname,slot,tonumber(id))
				guiSetVisible(window.buyVeh1,false)
			else 
				outputChatBox("Not Enough Money")
			end
		else
			outputChatBox("Slot is not empty!")
		end
end 

function airSlotter()
        window.sellAir = guiCreateWindow(0.36, 0.23, 0.27, 0.56, "Sell Car", true)
        guiWindowSetSizable(window.sellAir, false)
		guiSetVisible(window.aircrafts,false)
        label.Warn = guiCreateLabel(0.05, 0.07, 0.90, 0.14, "               Aircrafts will be sold for half price of the \n             original  value. Think before proceeding!", true, window.sellAir)
        button.sellAirSlot1 = guiCreateButton(0.12, 0.23, 0.82, 0.10, "Sell Slot 1", true, window.sellAir)
        guiSetProperty(button.sellAirSlot1, "NormalTextColour", "FFAAAAAA")
        button.sellAirSlot2 = guiCreateButton(0.12, 0.36, 0.82, 0.10, "Sell Slot 2", true, window.sellAir)
        guiSetProperty(button.sellAirSlot2, "NormalTextColour", "FFAAAAAA")
        button.closeAirSlotter = guiCreateButton(0.12, 0.91, 0.82, 0.06, "Close", true, window.sellAir)
        guiSetProperty(button.closeAirSlotter, "NormalTextColour", "FFAAAAAA")    
		showCursor(true)
		addEventHandler ( "onClientGUIClick", button.closeAirSlotter, function ()
		guiSetVisible(window.sellAir,false)
		showCursor(false)
		end, false )
		addEventHandler ( "onClientGUIClick", button.sellAirSlot1, function ()
		triggerServerEvent("sellAirSlot1",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.sellAirSlot2, function ()
		triggerServerEvent("sellAirSlot2",localPlayer,localPlayer)
		end, false )
end 