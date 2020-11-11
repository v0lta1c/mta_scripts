-- ----------------------------------------------
-- Name : Vehicle-system
-- File : carshop.lua
-- Developer : Mann
-- Status : Completed

-------------------------------------------------

compacts = {	{"Alpha",602,50000},
				{"Blista Compact",496,40000},
				{"Bravura",401,45000},
				{"Buccaneer",518,50000},
				{"Cadrona",527,45000},
				{"Club",589,90000},
				{"Esperanto",419,80000},
				{"Feltzer",533,110000},
				{"Fortune",526,61000},
				{"Hermes",474,60000},
				{"Hustler",545,73000},
				{"Majestic",517,70000},
				{"Manana",410,30000},
				{"Picador",600,65000},
				{"Previon",436,52432},
				{"Stafford",580,60000},
				{"Stallion",439,70000},
				{"Tampa",549,90000},
				{"Virgo",491,60000},
				
			}

luxury = 	{	{"Admiral",445,90000},
				{"Damaged Glendale",604,200000},
				{"Elegant",507,100000},
				{"Emperor",585,86000},
				{"Euros",587,145000},
				{"Glendale",466,80000},
				{"Greenwood",492,90000},
				{"Intruder",546,80000},
				{"Merit",551,84000},
				{"Nebula",516,90000},
				{"Oceanic",467,80000},
				{"Premier",426,80000},
				{"Primo",547,66000},
				{"Sentinel",405,200000},
				{"Stretch",409,500000},
				{"Sunrise",550,80000},
				{"Tahoma",566,90000},
				{"Vincent",540,90000},
				{"Washington",421,110000},
				{"Willard",529,90000},
			}
			
muscle = 	{	{"Buffalo",402,500000},
				{"Clover",542,250000},
				{"Pheonix",603,350000},
				{"Sabre",475,250000},
			}
			
lowriders = {	{"Blade",536,200000},
				{"Broadway",575,180000},
				{"Remington",534,150000},
				{"Savanna",567,180000},
				{"Slamvan",535,150000},
				{"Tornado",576,150000},
				{"Voodoo",412,225000},

			}	
			
sports = 	{	{"Banshee",429,550000},
				{"Bullet",541,600000},
				{"Cheetah",415,650000},
				{"Comet",480,450000},
				{"Elegy",562,450000},
				{"Flash",565,400000},
				{"Hotknife",434,750000},
				{"Hotring Racer",494,750000},
				{"Hotring Racer 2",502,750000},
				{"Hotring Racer 3",503,750000},
				{"Infernus",411,700000},
				{"Jester",559,550000},
				{"Stratum",561,400000},
				{"Sultan",560,450000},
				{"Super GT",506,450000},
				{"Turismo",451,700000},
				{"Uranus",558,500000},
				{"Windsor",555,400000},
				{"ZR-350",477,500000},

			}
			
suv = 		{	{"Huntley",579,300000},
				{"Landstalker",400,350000},
				{"Perennial",404,250000},
				{"Rancher",489,275000},
				{"Rancher 2",505,275000},
				{"Regina",479,250000},
				{"Romero's Hearse",442,300000},
				{"Solair",458,275000},

			}
			
recreational = {{"Bandito",568,500000},
				{"BF Injection",424,425000},
				{"Bloodring Banger",504,325000},
				{"Caddy",457,75000},
				{"Camper",483,150000},
				{"Journey",508,150000},
				{"Kart",571,50000},
				{"Mesa",500,100000},
				{"Monster",444,800000},
				{"Monster 2",556,800000},
				{"Monster 3",557,800000},
				{"Quadbike",471,50000},
				{"Sandking",495,450000},
				{"Vortex",539,225000},

			   }
			   
vans = 		{	{"Berkley's RC Van",459,75000},
				{"Bobcat",422,75000},
				{"Burrito",482,60000},
				{"Damaged Sadler",605,40000},
				{"Moonbeam",418,75000},
				{"Mower",572,35000},
				{"Pony",413,60000},
				{"Rumpo",440,60000},
				{"Sadler",543,40000},
				{"Tug",583,30000},
				{"Walton",478,75000},
				{"Yosemite",554,70000},

			}
carSlots = {}

button = {}
label = {}
cshop = {}
window = {}
memo = {}
grid = {}

function showCarShop(thePlayer)
		
        cshop.window = guiCreateWindow(0.37, 0.18, 0.28, 0.52, "Vapid Inc.", true)
        guiWindowSetSizable(cshop.window, false)
        cshop.welcomelabel = guiCreateLabel(0.05, 0.06, 0.90, 0.14, "          \n             Welcome to vehicle shop! You can buy\n                 a car or motorcycle of your choice!", true, cshop.window)
        guiSetFont(cshop.welcomelabel, "clear-normal")
        guiLabelSetColor(cshop.welcomelabel, 254, 255, 0)
        button.buybike = guiCreateButton(0.07, 0.30, 0.41, 0.12, "Buy Motorcycle/bike", true, cshop.window)
        guiSetProperty(button.buybike, "NormalTextColour", "FFAAAAAA")
        button.sellbike = guiCreateButton(0.53, 0.30, 0.40, 0.12, "Sell Motorcycle/bike", true, cshop.window)
        guiSetProperty(button.sellbike, "NormalTextColour", "FFAAAAAA")
        button.buycar = guiCreateButton(0.07, 0.46, 0.41, 0.12, "Buy Car", true, cshop.window)
        guiSetProperty(button.buycar, "NormalTextColour", "FFAAAAAA")
        button.sellcar = guiCreateButton(0.54, 0.46, 0.39, 0.12, "Sell Car", true, cshop.window)
        guiSetProperty(button.sellcar, "NormalTextColour", "FFAAAAAA")
        label.warnsell = guiCreateLabel(0.07, 0.62, 0.86, 0.11, "                 Note : You will get only 50% money \n                           back on selling the vehicles", true, cshop.window)
        guiLabelSetColor(label.warnsell, 255, 255, 0)
        button.branches = guiCreateButton(0.08, 0.78, 0.40, 0.13, "Our branches", true, cshop.window)
        guiSetProperty(button.branches, "NormalTextColour", "FFAAAAAA")
        button.close1 = guiCreateButton(0.54, 0.78, 0.39, 0.13, "Close", true, cshop.window)
        guiSetProperty(button.close1, "NormalTextColour", "FFAAAAAA")    
		visible = guiSetVisible(cshop.window,true)
		showCursor(true)
		addEventHandler ( "onClientGUIClick", button.close1, hideCarShop, false )
		addEventHandler ( "onClientGUIClick", button.buybike, 
		function () 
		triggerEvent("buyTheBike",localPlayer) end, false )
		addEventHandler ( "onClientGUIClick", button.sellbike, 
		function () 
		triggerEvent("sellTheBike",localPlayer) end, false )
		addEventHandler ( "onClientGUIClick", button.branches, showBranches, false )
		addEventHandler ( "onClientGUIClick", button.buycar, buycarGui, false )
		addEventHandler ( "onClientGUIClick", button.sellcar, slotter, false )
end 

function hideCarShop()

		guiSetVisible(cshop.window,false)
		showCursor(false)
end 

addEvent("showCarShopGui",true)
addEventHandler("showCarShopGui",localPlayer,showCarShop)

-- Memo code
function showBranches()
        window.branches = guiCreateWindow(0.39, 0.23, 0.25, 0.51, "Branches", true)
        guiWindowSetSizable(window.branches, false)

        memo.branches = guiCreateMemo(0.05, 0.08, 0.90, 0.79, "Our branches are -\n\n1. Wang Cars, San Fierro\n2. Otto's Autos, San Fierro\n3. LS\n4. LS\n...", true, window.branches)
        button.memoclose = guiCreateButton(0.06, 0.90, 0.90, 0.07, "Close", true, window.branches)
        guiSetProperty(button.memoclose, "NormalTextColour", "FFAAAAAA")
		guiSetVisible(window.branches,true)
		showCursor(true)
		addEventHandler ( "onClientGUIClick", button.memoclose, hideBranches, false )
 end

function hideBranches()
		guiSetVisible(window.branches,false)
		showCursor(true)
end

function buycarGui()
		guiSetVisible(cshop.window,false)
        window.buycar = guiCreateWindow(0.63, 0.04, 0.35, 0.86, "Buy Car", true)
        guiWindowSetSizable(window.buycar, false)

        grid.car = guiCreateGridList(0.05, 0.11, 0.91, 0.73, true, window.buycar)
        button.buyCar1 = guiCreateButton(0.06, 0.87, 0.46, 0.05, "Buy Car", true, window.buycar)
        guiSetProperty(button.buyCar1, "NormalTextColour", "FFAAAAAA")
        button.testDrive = guiCreateButton(0.57, 0.87, 0.36, 0.05, "Test Drive", true, window.buycar)
        guiSetProperty(button.testDrive, "NormalTextColour", "FFAAAAAA")
        button.close = guiCreateButton(0.34, 0.94, 0.41, 0.03, "Close", true, window.buycar)
        guiSetProperty(button.close, "NormalTextColour", "FFAAAAAA") 
		local namecolumn = guiGridListAddColumn(grid.car,"Name",0.60)
		local pricecolumn = guiGridListAddColumn(grid.car,"Price",0.25)
		local idcolumn = guiGridListAddColumn(grid.car,"Model Id",0.15)
		local aRow = guiGridListAddRow (grid.car)
		guiGridListSetItemText ( grid.car,aRow, namecolumn, "Compact & Two-Doors", true, false )
		for i, carInfo in ipairs(compacts)do
			local carName,id,price = unpack(carInfo)
			local row = guiGridListAddRow (grid.car)
			guiGridListSetItemText ( grid.car, row, namecolumn, ""..carName.."", false, false )
			guiGridListSetItemText ( grid.car, row, pricecolumn, ""..tostring(price).."", false, true )
			guiGridListSetItemText ( grid.car, row, idcolumn, ""..tostring(id).."", false, true )
		end
		local bRow = guiGridListAddRow (grid.car)
		guiGridListSetItemText ( grid.car,bRow, namecolumn, "Luxury & Four-Doors", true, false )
		for i, carInfo in ipairs(luxury)do
			local carName,id,price = unpack(carInfo)
			local row = guiGridListAddRow (grid.car)
			guiGridListSetItemText ( grid.car, row, namecolumn, ""..carName.."", false, false )
			guiGridListSetItemText ( grid.car, row, pricecolumn, ""..tostring(price).."", false, true )
			guiGridListSetItemText ( grid.car, row, idcolumn, ""..tostring(id).."", false, true )
		end
		local cRow = guiGridListAddRow (grid.car)
		guiGridListSetItemText ( grid.car,cRow, namecolumn, "Muscle", true, false )
		for i, carInfo in ipairs(muscle)do
			local carName,id,price = unpack(carInfo)
			local row = guiGridListAddRow (grid.car)
			guiGridListSetItemText ( grid.car, row, namecolumn, ""..carName.."", false, false )
			guiGridListSetItemText ( grid.car, row, pricecolumn, ""..tostring(price).."", false, true )
			guiGridListSetItemText ( grid.car, row, idcolumn, ""..tostring(id).."", false, true )
		end
		local dRow = guiGridListAddRow (grid.car)
		guiGridListSetItemText ( grid.car,dRow, namecolumn, "Lowriders", true, false )
		for i, carInfo in ipairs(lowriders)do
			local carName,id,price = unpack(carInfo)
			local row = guiGridListAddRow (grid.car)
			guiGridListSetItemText ( grid.car, row, namecolumn, ""..carName.."", false, false )
			guiGridListSetItemText ( grid.car, row, pricecolumn, ""..tostring(price).."", false, true )
			guiGridListSetItemText ( grid.car, row, idcolumn, ""..tostring(id).."", false, true )
		end
		local eRow = guiGridListAddRow (grid.car)
		guiGridListSetItemText ( grid.car,eRow, namecolumn, "Sports", true, false )
		for i, carInfo in ipairs(sports)do
			local carName,id,price = unpack(carInfo)
			local row = guiGridListAddRow (grid.car)
			guiGridListSetItemText ( grid.car, row, namecolumn, ""..carName.."", false, false )
			guiGridListSetItemText ( grid.car, row, pricecolumn, ""..tostring(price).."", false, true )
			guiGridListSetItemText ( grid.car, row, idcolumn, ""..tostring(id).."", false, true )
		end
		local fRow = guiGridListAddRow (grid.car)
		guiGridListSetItemText ( grid.car,fRow, namecolumn, "SUV's", true, false )
		for i, carInfo in ipairs(suv)do
			local carName,id,price = unpack(carInfo)
			local row = guiGridListAddRow (grid.car)
			guiGridListSetItemText ( grid.car, row, namecolumn, ""..carName.."", false, false )
			guiGridListSetItemText ( grid.car, row, pricecolumn, ""..tostring(price).."", false, true )
			guiGridListSetItemText ( grid.car, row, idcolumn, ""..tostring(id).."", false, true )
		end
		local gRow = guiGridListAddRow (grid.car)
		guiGridListSetItemText ( grid.car,gRow, namecolumn, "Recreational", true, false )
		for i, carInfo in ipairs(recreational)do
			local carName,id,price = unpack(carInfo)
			local row = guiGridListAddRow (grid.car)
			guiGridListSetItemText ( grid.car, row, namecolumn, ""..carName.."", false, false )
			guiGridListSetItemText ( grid.car, row, pricecolumn, ""..tostring(price).."", false, true )
			guiGridListSetItemText ( grid.car, row, idcolumn, ""..tostring(id).."", false, true )
		end
		local hRow = guiGridListAddRow (grid.car)
		guiGridListSetItemText ( grid.car,hRow, namecolumn, "Vans", true, false )
		for i, carInfo in ipairs(vans)do
			local carName,id,price = unpack(carInfo)
			local row = guiGridListAddRow (grid.car)
			guiGridListSetItemText ( grid.car, row, namecolumn, ""..carName.."", false, false )
			guiGridListSetItemText ( grid.car, row, pricecolumn, ""..tostring(price).."", false, true )
			guiGridListSetItemText ( grid.car, row, idcolumn, ""..tostring(id).."", false, true )
		end
		function click()
			local getName = guiGridListGetItemText ( grid.car, guiGridListGetSelectedItem ( grid.car ), 3 )
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
		addEventHandler ( "onClientGUIClick", button.close, hideBuyCar, false )
		addEventHandler ( "onClientGUIClick", grid.car, click)
		addEventHandler ( "onClientGUIClick", button.buyCar1,buyCar )
		
		
end 
function hideBuyCar()
		guiSetVisible(window.buycar,false)
		setCameraTarget(localPlayer)
		local destroy = destroyElement(vehView)
		showCursor(false)
end 

function buyCar()
        window.buyVeh = guiCreateWindow(0.34, 0.17, 0.29, 0.62, "Buy Car", true)
        guiWindowSetSizable(window.buyVeh, false)

        button.buyslot1 = guiCreateButton(0.09, 0.13, 0.81, 0.12, "Buy Slot 1", true, window.buyVeh)
        guiSetProperty(button.buyslot1, "NormalTextColour", "FFAAAAAA")
        button.buyslot2 = guiCreateButton(0.09, 0.29, 0.80, 0.12, "Buy Slot 2", true, window.buyVeh)
        guiSetProperty(button.buyslot2, "NormalTextColour", "FFAAAAAA")
        button.buyslot3 = guiCreateButton(0.10, 0.45, 0.80, 0.13, "Buy Slot 3", true, window.buyVeh)
        guiSetProperty(button.buyslot3, "NormalTextColour", "FFAAAAAA")
        button.buyslot4 = guiCreateButton(0.10, 0.62, 0.80, 0.13, "Buy Slot 4", true, window.buyVeh)
        guiSetProperty(button.buyslot4, "NormalTextColour", "FFAAAAAA")
        button.buyslot5 = guiCreateButton(0.10, 0.80, 0.79, 0.13, "Buy Slot 5", true, window.buyVeh)
        guiSetProperty(button.buyslot5, "NormalTextColour", "FFAAAAAA")
        button.closeGui = guiCreateButton(0.87, 0.05, 0.10, 0.05, "X", true, window.buyVeh)
        guiSetProperty(button.closeGui, "NormalTextColour", "FFAAAAAA")    
		function closeGUI()
			guiSetVisible(window.buyVeh,false)
		end
		addEventHandler ( "onClientGUIClick", button.closeGui, closeGUI, false )
		addEventHandler ( "onClientGUIClick", button.buyslot1, purchaseSlot1, false )
		addEventHandler ( "onClientGUIClick", button.buyslot2, purchaseSlot2, false )
		addEventHandler ( "onClientGUIClick", button.buyslot3, purchaseSlot3, false )
		addEventHandler ( "onClientGUIClick", button.buyslot4, purchaseSlot4, false )
		addEventHandler ( "onClientGUIClick", button.buyslot5, purchaseSlot5, false )
end
	
function purchaseSlot1()
		if carSlots.slot1 == nil then
			local cname = guiGridListGetItemText ( grid.car, guiGridListGetSelectedItem ( grid.car ), 1 )
			local price = guiGridListGetItemText ( grid.car, guiGridListGetSelectedItem ( grid.car ), 2 )
			local id = guiGridListGetItemText ( grid.car, guiGridListGetSelectedItem ( grid.car ), 3 )
			local money = getPlayerMoney()
			if money > tonumber(price) then
				carSlots.slot1 = cname
				local slot = 1
				triggerServerEvent("buycarmoney",localPlayer,localPlayer,tonumber(price),cname,slot,tonumber(id))
				guiSetVisible(window.buyVeh,false)
			else 
				outputChatBox("Not Enough Money")
			end
		else
			outputChatBox("Slot is not empty!")
		end
end
function purchaseSlot2()
		if carSlots.slot2 == nil then
			local cname = guiGridListGetItemText ( grid.car, guiGridListGetSelectedItem ( grid.car ), 1 )
			local price = guiGridListGetItemText ( grid.car, guiGridListGetSelectedItem ( grid.car ), 2 )
			local id = guiGridListGetItemText ( grid.car, guiGridListGetSelectedItem ( grid.car ), 3 )
			local money = getPlayerMoney()
			if money > tonumber(price) then
				carSlots.slot2 = cname
				local slot = 2
				triggerServerEvent("buycarmoney",localPlayer,localPlayer,tonumber(price),cname,slot,tonumber(id))
				guiSetVisible(window.buyVeh,false)
			else 
				outputChatBox("Not Enough Money")
			end
		else
			outputChatBox("Slot is not empty!")
		end
end
function purchaseSlot3()
		if carSlots.slot3 == nil then
			local cname = guiGridListGetItemText ( grid.car, guiGridListGetSelectedItem ( grid.car ), 1 )
			local price = guiGridListGetItemText ( grid.car, guiGridListGetSelectedItem ( grid.car ), 2 )
			local id = guiGridListGetItemText ( grid.car, guiGridListGetSelectedItem ( grid.car ), 3 )
			local money = getPlayerMoney()
			if money > tonumber(price) then
				carSlots.slot3 = cname
				local slot = 3
				triggerServerEvent("buycarmoney",localPlayer,localPlayer,tonumber(price),cname,slot,tonumber(id))
				guiSetVisible(window.buyVeh,false)
			else 
				outputChatBox("Not Enough Money")
			end
		else
			outputChatBox("Slot is not empty!")
		end
end
function purchaseSlot4()
		if carSlots.slot4 == nil then
			local cname = guiGridListGetItemText ( grid.car, guiGridListGetSelectedItem ( grid.car ), 1 )
			local price = guiGridListGetItemText ( grid.car, guiGridListGetSelectedItem ( grid.car ), 2 )
			local id = guiGridListGetItemText ( grid.car, guiGridListGetSelectedItem ( grid.car ), 3 )
			local money = getPlayerMoney()
			if money > tonumber(price) then
				carSlots.slot4 = cname
				local slot = 4
				triggerServerEvent("buycarmoney",localPlayer,localPlayer,tonumber(price),cname,slot,tonumber(id))
				guiSetVisible(window.buyVeh,false)
			else 
				outputChatBox("Not Enough Money")
			end
		else
			outputChatBox("Slot is not empty!")
		end
end
function purchaseSlot5()
		if carSlots.slot5 == nil then
			local cname = guiGridListGetItemText ( grid.car, guiGridListGetSelectedItem ( grid.car ), 1 )
			local price = guiGridListGetItemText ( grid.car, guiGridListGetSelectedItem ( grid.car ), 2 )
			local id = guiGridListGetItemText ( grid.car, guiGridListGetSelectedItem ( grid.car ), 3 )
			local money = getPlayerMoney()
			if money > tonumber(price) then
				carSlots.slot5 = cname
				local slot = 5
				triggerServerEvent("buycarmoney",localPlayer,localPlayer,tonumber(price),cname,slot,tonumber(id))
				guiSetVisible(window.buyVeh,false)
			else 
				outputChatBox("Not Enough Money")
			end
		else
			outputChatBox("Slot is not empty!")
		end
end 

function congoGUI(owner,cname,price,slot,id)
        window.Congo = guiCreateWindow(0.39, 0.25, 0.24, 0.27, "Vehicle Shop", true)
        guiWindowSetSizable(window.Congo, false)

        memo.congo = guiCreateMemo(0.05, 0.18, 0.92, 0.59, "Congratulations!\n\nYou've bought the "..cname.." for $"..price.." in slot "..slot.."!\n\nHere are your keys.", true, window.Congo)
        button.hidecongo = guiCreateButton(0.04, 0.82, 0.93, 0.11, "Close", true, window.Congo)
        guiSetProperty(button.hidecongo, "NormalTextColour", "FFAAAAAA")    
		function closecongoGUI()
			guiSetVisible(window.Congo,false)
		end
		addEventHandler ( "onClientGUIClick", button.hidecongo, closecongoGUI, false )
    end

addEvent("showCongoGUI",true)
addEventHandler("showCongoGUI",root,congoGUI)

function slotter()
		guiSetVisible(cshop.window,false)
        window.sellCar = guiCreateWindow(0.36, 0.23, 0.27, 0.56, "Sell Car", true)
        guiWindowSetSizable(window.sellCar, false)

        label.Warn = guiCreateLabel(0.05, 0.07, 0.90, 0.14, "               Cars will be sold for half price of the \n             original  value. Think before proceeding!", true, window.sellCar)
        button.sellSlot1 = guiCreateButton(0.12, 0.23, 0.82, 0.10, "Sell Slot 1", true, window.sellCar)
        guiSetProperty(button.sellSlot1, "NormalTextColour", "FFAAAAAA")
        button.sellSlot2 = guiCreateButton(0.12, 0.36, 0.82, 0.10, "Sell Slot 2", true, window.sellCar)
        guiSetProperty(button.sellSlot2, "NormalTextColour", "FFAAAAAA")
        button.sellSlot3 = guiCreateButton(0.12, 0.50, 0.82, 0.10, "Sell Slot 3", true, window.sellCar)
        guiSetProperty(button.sellSlot3, "NormalTextColour", "FFAAAAAA")
        button.sellSlot4 = guiCreateButton(0.12, 0.64, 0.82, 0.10, "Sell Slot 4", true, window.sellCar)
        guiSetProperty(button.sellSlot4, "NormalTextColour", "FFAAAAAA")
        button.sellSlot5 = guiCreateButton(0.12, 0.77, 0.82, 0.10, "Sell Slot 5", true, window.sellCar)
        guiSetProperty(button.sellSlot5, "NormalTextColour", "FFAAAAAA")
        button.closeSlotter = guiCreateButton(0.12, 0.91, 0.82, 0.06, "Close", true, window.sellCar)
        guiSetProperty(button.closeSlotter, "NormalTextColour", "FFAAAAAA")    
		showCursor(true)
		addEventHandler ( "onClientGUIClick", button.closeSlotter, function ()
		guiSetVisible(window.sellCar,false)
		carSlots.slot1 = nil
		showCursor(false)
		end, false )
		addEventHandler ( "onClientGUIClick", button.sellSlot1, function ()
		triggerServerEvent("sellSlot1",localPlayer,localPlayer)
		carSlots.slot2 = nil
		end, false )
		addEventHandler ( "onClientGUIClick", button.sellSlot2, function ()
		triggerServerEvent("sellSlot2",localPlayer,localPlayer)
		carSlots.slot3 = nil
		end, false )
		addEventHandler ( "onClientGUIClick", button.sellSlot3, function ()
		triggerServerEvent("sellSlot3",localPlayer,localPlayer)
		carSlots.slot4 = nil
		end, false )
		addEventHandler ( "onClientGUIClick", button.sellSlot4, function ()
		triggerServerEvent("sellSlot4",localPlayer,localPlayer)
		carSlots.slot5 = nil
		end, false )
		addEventHandler ( "onClientGUIClick", button.sellSlot5, function ()
		triggerServerEvent("sellSlot5",localPlayer,localPlayer)
		end, false )
end 