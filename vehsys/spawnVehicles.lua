-- ----------------------------------------------
-- Name : Vehicle-system
-- File : spawnVehicles.lua
-- Developer : Mann
-- Status : Work in progress, not yet completed

-------------------------------------------------

tab = {}
tabpanel = {}
button = {}
window = {}
memo = {}

addEventHandler("onClientResourceStart", resourceRoot,
    function ()
        window.vehs = guiCreateWindow(0.30, 0.13, 0.42, 0.63, "Spawn Vehicles", true)
        guiWindowSetSizable(window.vehs, false)
        tabpanel.tabb = guiCreateTabPanel(0.02, 0.05, 0.98, 0.94, true, window.vehs)

        tab.SpawnCar = guiCreateTab("Cars", tabpanel.tabb)

        button.car1 = guiCreateButton(0.04, 0.03, 0.41, 0.11, "Spawn Slot 1", true, tab.SpawnCar)
        guiSetProperty(button.car1, "NormalTextColour", "FFAAAAAA")
        button.descar1 = guiCreateButton(0.54, 0.03, 0.42, 0.11, "Destroy Slot 1", true, tab.SpawnCar)
        guiSetProperty(button.descar1, "NormalTextColour", "FFAAAAAA")
        button.car2 = guiCreateButton(0.04, 0.19, 0.41, 0.11, "Spawn Slot 2", true, tab.SpawnCar)
        guiSetProperty(button.car2, "NormalTextColour", "FFAAAAAA")
        button.descar2 = guiCreateButton(0.54, 0.20, 0.43, 0.11, "Destroy Slot 2", true, tab.SpawnCar)
        guiSetProperty(button.descar2, "NormalTextColour", "FFAAAAAA")
        button.car3 = guiCreateButton(0.04, 0.36, 0.41, 0.11, "Spawn Slot 3", true, tab.SpawnCar)
        guiSetProperty(button.car3, "NormalTextColour", "FFAAAAAA")
        button.descar3 = guiCreateButton(0.54, 0.36, 0.43, 0.11, "Destroy Slot 3", true, tab.SpawnCar)
        guiSetProperty(button.descar3, "NormalTextColour", "FFAAAAAA")
        button.car4 = guiCreateButton(0.04, 0.53, 0.41, 0.11, "Spawn Slot 4", true, tab.SpawnCar)
        guiSetProperty(button.car4, "NormalTextColour", "FFAAAAAA")
        button.descar4 = guiCreateButton(0.54, 0.53, 0.43, 0.11, "Destroy Slot 4", true, tab.SpawnCar)
        guiSetProperty(button.descar4, "NormalTextColour", "FFAAAAAA")
        button.car5 = guiCreateButton(0.04, 0.70, 0.41, 0.11, "Spawn Slot 5", true, tab.SpawnCar)
        guiSetProperty(button.car5, "NormalTextColour", "FFAAAAAA")
        button.descar5 = guiCreateButton(0.54, 0.70, 0.43, 0.11, "Destroy Slot 5", true, tab.SpawnCar)
        guiSetProperty(button.descar5, "NormalTextColour", "FFAAAAAA")

        tab.bikes = guiCreateTab("Bikes", tabpanel.tabb)

        button.bike1 = guiCreateButton(0.03, 0.02, 0.40, 0.13, "Spawn Slot 1", true, tab.bikes)
        guiSetProperty(button.bike1, "NormalTextColour", "FFAAAAAA")
        button.desbike1 = guiCreateButton(0.54, 0.02, 0.39, 0.13, "Destroy Slot 1", true, tab.bikes)
        guiSetProperty(button.desbike1, "NormalTextColour", "FFAAAAAA")
        button.bike2 = guiCreateButton(0.03, 0.20, 0.40, 0.13, "Spawn Slot 2", true, tab.bikes)
        guiSetProperty(button.bike2, "NormalTextColour", "FFAAAAAA")
        button.bike3 = guiCreateButton(0.03, 0.37, 0.40, 0.13, "Spawn Slot 3", true, tab.bikes)
        guiSetProperty(button.bike3, "NormalTextColour", "FFAAAAAA")
        button.desbike2 = guiCreateButton(0.54, 0.20, 0.39, 0.13, "Destroy Slot 2", true, tab.bikes)
        guiSetProperty(button.desbike2, "NormalTextColour", "FFAAAAAA")
        button.desbike3 = guiCreateButton(0.54, 0.37, 0.39, 0.13, "Destroy Slot 3", true, tab.bikes)
        guiSetProperty(button.desbike3, "NormalTextColour", "FFAAAAAA")

        tab.aircrafts = guiCreateTab("Aircrafts", tabpanel.tabb)

        button.aircraft1 = guiCreateButton(0.02, 0.03, 0.45, 0.12, "Spawn Slot 1", true, tab.aircrafts)
        guiSetProperty(button.aircraft1, "NormalTextColour", "FFAAAAAA")
        button.descraft1 = guiCreateButton(0.52, 0.03, 0.45, 0.12, "Destroy Slot 1", true, tab.aircrafts)
        guiSetProperty(button.descraft1, "NormalTextColour", "FFAAAAAA")
        button.aircraft2 = guiCreateButton(0.02, 0.19, 0.45, 0.12, "Spawn Slot 2", true, tab.aircrafts)
        guiSetProperty(button.aircraft2, "NormalTextColour", "FFAAAAAA")
        button.descraft2 = guiCreateButton(0.52, 0.19, 0.45, 0.12, "Destroy Slot 2", true, tab.aircrafts)
        guiSetProperty(button.descraft2, "NormalTextColour", "FFAAAAAA")

        tab.boats = guiCreateTab("Boats", tabpanel.tabb)

        button.boat1 = guiCreateButton(0.02, 0.03, 0.44, 0.13, "Spawn Slot 1", true, tab.boats)
        guiSetProperty(button.boat1, "NormalTextColour", "FFAAAAAA")
        button.desboat1 = guiCreateButton(0.53, 0.03, 0.44, 0.13, "Destroy Slot 1", true, tab.boats)
        guiSetProperty(button.desboat1, "NormalTextColour", "FFAAAAAA")
        button.boat2 = guiCreateButton(0.02, 0.21, 0.44, 0.13, "Spawn Slot 2", true, tab.boats)
        guiSetProperty(button.boat2, "NormalTextColour", "FFAAAAAA")
        button.desboat2 = guiCreateButton(0.53, 0.21, 0.44, 0.13, "Destroy Slot 2", true, tab.boats)
        guiSetProperty(button.desboat2, "NormalTextColour", "FFAAAAAA")   
		guiSetVisible(window.vehs,false)
		showCursor(false)
		addEventHandler ( "onClientGUIClick", button.car1, function () 
		triggerServerEvent("spawnCar1",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.descar1, function () 
		triggerServerEvent("destroyCar1",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.car2, function () 
		triggerServerEvent("spawnCar2",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.descar2, function () 
		triggerServerEvent("destroyCar2",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.car3, function () 
		triggerServerEvent("spawnCar3",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.descar3, function () 
		triggerServerEvent("destroyCar3",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.car4, function () 
		triggerServerEvent("spawnCar4",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.descar4, function () 
		triggerServerEvent("destroyCar4",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.car5, function () 
		triggerServerEvent("spawnCar5",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.descar5, function () 
		triggerServerEvent("destroyCar5",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.bike1, function () 
		triggerServerEvent("spawnBike1",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.desbike1, function () 
		triggerServerEvent("destroyBike1",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.bike2, function () 
		triggerServerEvent("spawnBike2",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.desbike2, function () 
		triggerServerEvent("destroyBike2",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.bike3, function () 
		triggerServerEvent("spawnBike3",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.desbike3, function () 
		triggerServerEvent("destroyBike3",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.aircraft1, function () 
		triggerServerEvent("spawnPlane1",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.descraft1, function () 
		triggerServerEvent("destroyCraft1",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.aircraft2, function () 
		triggerServerEvent("spawnPlane2",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.descraft2, function () 
		triggerServerEvent("destroyCraft2",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.boat1, function () 
		triggerServerEvent("spawnBoat1",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.desboat1, function () 
		triggerServerEvent("destroyBoat1",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.boat2, function () 
		triggerServerEvent("spawnBoat2",localPlayer,localPlayer)
		end, false )
		addEventHandler ( "onClientGUIClick", button.desboat2, function () 
		triggerServerEvent("destroyBoat2",localPlayer,localPlayer)
		end, false )
end)

local state = false

bindKey ( "n", "down", function ( )

if state == false then
guiSetVisible(window.vehs,true)
showCursor(true)
state = true

else

guiSetVisible(window.vehs,false)
showCursor(false)
state = false

end
end
)
