-- ----------------------------------------------
-- Name : Vehicle-system
-- File : server.lua
-- Developer : Mann
-- Status : Completed(Few bugs known)

-------------------------------------------------

-- First we'll connect to a database
connection = dbConnect("sqlite","veh.db")
count= 0
function startTable()
    dbExec(connection, "CREATE TABLE IF NOT EXISTS Count (count integer)")
	dbExec(connection, "CREATE TABLE IF NOT EXISTS purchasedCars (Owner text,Vehicle text,Price integer,Slot integer,Id integer)")
	dbExec(connection, "CREATE TABLE IF NOT EXISTS purchasedBikes (Owner text,Vehicle text,Price integer,Slot integer,Id integer)")
	dbExec(connection, "CREATE TABLE IF NOT EXISTS purchasedAircrafts (Owner text,Vehicle text,Price integer,Slot integer,Id integer)")
	dbExec(connection, "CREATE TABLE IF NOT EXISTS purchasedBoats (Owner text,Vehicle text,Price integer,Slot integer,Id integer)")
	local check = dbPoll(dbQuery(connection,"SELECT count FROM Count"),-1)
		if #check == 0 then
			count = 0
			dbExec(connection,"INSERT INTO Count VALUES (?)",0)
		
		else
			if count > 1000 then
				dbExec(connection,"UPDATE Count SET count=?",0)
			else
				count = (check[1]["count"])
			end
		end
end


addEventHandler("onResourceStart", resourceRoot, startTable)

function markerHit(thePlayer)
		if getElementType(thePlayer) ~= "player" then return end
		if isElementWithinMarker(thePlayer,source) then
				triggerClientEvent(thePlayer,"showCarShopGui",root)
		end
end

function markerHit1(thePlayer)
		if getElementType(thePlayer) ~= "player" then return end
		if isElementWithinMarker(thePlayer,source) then
				triggerClientEvent(thePlayer,"showplaneGui",root)
		end
end

function markerHit2(thePlayer)
		if getElementType(thePlayer) ~= "player" then return end
		if isElementWithinMarker(thePlayer,source) then
				triggerClientEvent(thePlayer,"showboatGui",root)
		end
end

carShopCords = {	{-1956.107421875,263.2412109375,34.50333333},
				}
planeShopCords =	{	{-1544.830078125,-439.8544921875,5.07000},
					}
boatShopCords = 	{	{-1622.29296875,158.236328125,2.6546875},
					}					
addEventHandler("onResourceStart",resourceRoot, function()
			for i,cords in ipairs(carShopCords)do
				local x,y,z = unpack(cords)
				local marker = createMarker(x,y,z,"cylinder",1,255,255,0,255)
				addEventHandler("onMarkerHit", marker, markerHit)
			end
end)
addEventHandler("onResourceStart",resourceRoot, function()
			for i,cords in ipairs(planeShopCords)do
				local x,y,z = unpack(cords)
				local marker = createMarker(x,y,z,"cylinder",1,255,255,0,255)
				addEventHandler("onMarkerHit", marker, markerHit1)
			end
end)
addEventHandler("onResourceStart",resourceRoot, function()
			for i,cords in ipairs(boatShopCords)do
				local x,y,z = unpack(cords)
				local marker = createMarker(x,y,z,"cylinder",1,255,255,0,255)
				addEventHandler("onMarkerHit", marker, markerHit2)
			end
end)
addEvent("buycarmoney",true)
addEventHandler("buycarmoney",root,
function(thePlayer,price,cname,slot,id)
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Slot FROM purchasedCars WHERE Owner = ? AND Slot = ?",owner,slot),-1)
		if #check == 0 then
			takePlayerMoney(thePlayer,price)
			dbExec(connection,"INSERT INTO purchasedCars VALUES (?,?,?,?,?)",owner,cname,price,slot,id)
			triggerClientEvent(thePlayer,"showCongoGUI",root,owner,cname,price,slot)
			count = count + 1
			dbExec(connection,"UPDATE Count SET count=?",count)
		else
			outputChatBox("You already have a car in slot "..slot.."!")			
		end
end)

-- Spawn Car 1

addEvent("spawnCar1",true)
addEventHandler("spawnCar1",root,
function(thePlayer)
	
	if isPedInVehicle(thePlayer) then
		outputChatBox("Spawning cars while inside a car is disallowed!!",thePlayer,255,0,0)
	else
	if car1created then 
		outputChatBox("Car has already been Spawned",thePlayer,255,255,0)
	else
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Id FROM purchasedCars WHERE Owner = ? AND Slot = ?",tostring(owner),1),-1)
		if type(check) == "table" and #check > 0  then
			local id = tostring(check[1]["Id"])
			local x,y,z = getElementPosition(thePlayer)
			 car1created = createVehicle(id,x+1,y+1,z)
		else
			outputChatBox("No car in Slot 1!",thePlayer,255,0,0)
		end
	end
	end
	
end )



-- Destroy car 1

addEvent("destroyCar1",true)
addEventHandler("destroyCar1",root,
function(thePlayer)
	if car1created then
		destroyElement(car1created)
		outputChatBox("Car is being destroyed!",thePlayer,255,255,0)
		car1created = nil
	else
		outputChatBox("Your car has not spawned or no car in Slot 1!",thePlayer,255,0,0)
	end
end)

-- Spawn Car 2

addEvent("spawnCar2",true)
addEventHandler("spawnCar2",root,
function(thePlayer)
	
	if isPedInVehicle(thePlayer) then
		outputChatBox("Spawning cars while inside a car is disallowed!!",thePlayer,255,0,0)
	else
	if car2created then 
		outputChatBox("Car has already been Spawned",thePlayer,255,255,0)
	else
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Id FROM purchasedCars WHERE Owner = ? AND Slot = ?",tostring(owner),2),-1)
		if type(check) == "table" and #check > 0  then
			local id = tostring(check[1]["Id"])
			local x,y,z = getElementPosition(thePlayer)
			 car2created = createVehicle(id,x+1,y+1,z)
		else
			outputChatBox("No car in Slot 2!",thePlayer,255,0,0)
		end
	end
	end
	
end )


-- Destroy car 2

addEvent("destroyCar2",true)
addEventHandler("destroyCar2",root,
function(thePlayer)
	if car2created then
		destroyElement(car2created)
		outputChatBox("Car is being destroyed!",thePlayer,255,255,0)
		car2created = nil
	else
		outputChatBox("Your car has not spawned or no car in Slot 2!",thePlayer,255,0,0)
	end
end)

-- Spawn Car 3

addEvent("spawnCar3",true)
addEventHandler("spawnCar3",root,
function(thePlayer)
	
	if isPedInVehicle(thePlayer) then
		outputChatBox("Spawning cars while inside a car is disallowed!!",thePlayer,255,0,0)
	else
	if car3created then 
		outputChatBox("Car has already been Spawned",thePlayer,255,255,0)
	else
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Id FROM purchasedCars WHERE Owner = ? AND Slot = ?",tostring(owner),3),-1)
		if type(check) == "table" and #check > 0  then
			local id = tostring(check[1]["Id"])
			local x,y,z = getElementPosition(thePlayer)
			 car3created = createVehicle(id,x+1,y+1,z)
		else
			outputChatBox("No car in Slot 3!",thePlayer,255,0,0)
		end
	end
	end
	
end )

-- Destroy car 3

addEvent("destroyCar3",true)
addEventHandler("destroyCar3",root,
function(thePlayer)
	if car3created then
		destroyElement(car3created)
		outputChatBox("Car is being destroyed!",thePlayer,255,255,0)
		car3created = nil
	else
		outputChatBox("Your car has not spawned or no car in Slot 3!",thePlayer,255,0,0)
	end
end)

-- Spawn Car 4

addEvent("spawnCar4",true)
addEventHandler("spawnCar4",root,
function(thePlayer)
	
	if isPedInVehicle(thePlayer) then
		outputChatBox("Spawning cars while inside a car is disallowed!!",thePlayer,255,0,0)
	else
	if car4created then 
		outputChatBox("Car has already been Spawned",thePlayer,255,255,0)
	else
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Id FROM purchasedCars WHERE Owner = ? AND Slot = ?",tostring(owner),4),-1)
		if type(check) == "table" and #check > 0  then
			local id = tostring(check[1]["Id"])
			local x,y,z = getElementPosition(thePlayer)
			 car4created = createVehicle(id,x+1,y+1,z)
		else
			outputChatBox("No car in Slot 4!",thePlayer,255,0,0)
		end
	end
	end
	
end )

-- Destroy car 4

addEvent("destroyCar4",true)
addEventHandler("destroyCar4",root,
function(thePlayer)
	if car4created then
		destroyElement(car4created)
		outputChatBox("Car is being destroyed!",thePlayer,255,255,0)
		car4created = nil
	else
		outputChatBox("Your car has not spawned or no car in Slot 4!",thePlayer,255,0,0)
	end
end)

-- Spawn Car 5

addEvent("spawnCar5",true)
addEventHandler("spawnCar5",root,
function(thePlayer)
	
	if isPedInVehicle(thePlayer) then
		outputChatBox("Spawning cars while inside a car is disallowed!!",thePlayer,255,0,0)
	else
	if car5created then 
		outputChatBox("Car has already been Spawned",thePlayer,255,255,0)
	else
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Id FROM purchasedCars WHERE Owner = ? AND Slot = ?",tostring(owner),5),-1)
		if type(check) == "table" and #check > 0  then
			local id = tostring(check[1]["Id"])
			local x,y,z = getElementPosition(thePlayer)
			 car5created = createVehicle(id,x+1,y+1,z)
		else
			outputChatBox("No car in Slot 5!",thePlayer,255,0,0)
		end
	end
	end
	
end )

-- Destroy car 5

addEvent("destroyCar5",true)
addEventHandler("destroyCar5",root,
function(thePlayer)
	if car5created then
		destroyElement(car5created)
		outputChatBox("Car is being destroyed!",thePlayer,255,255,0)
		car5created = nil
	else
		outputChatBox("Your car has not spawned or no car in Slot 5!",thePlayer,255,0,0)
	end
end)

-- Selling slot 1

addEvent("sellSlot1",true)
addEventHandler("sellSlot1",root,
function (thePlayer)
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Price FROM purchasedCars WHERE Owner = ? AND Slot = ?",tostring(owner),1),-1)
		if type(check) == "table" and #check > 0  then
			local price = tostring(check[1]["Price"])
			dbExec(connection,"DELETE FROM purchasedCars WHERE Owner = ? AND Slot = ?",tostring(owner),1)
			outputChatBox("Car sold successfully! Here is your refund!",thePlayer,255,255,0)
			givePlayerMoney(thePlayer,tonumber(price)/2)
			count = count + 1
			dbExec(connection,"UPDATE Count SET count=?",count)
		else 
			outputChatBox("No car found!",thePlayer,255,0,0)
		end
end)

-- Selling slot 2

addEvent("sellSlot2",true)
addEventHandler("sellSlot2",root,
function (thePlayer)
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Price FROM purchasedCars WHERE Owner = ? AND Slot = ?",tostring(owner),2),-1)
		if type(check) == "table" and #check > 0  then
			local price = tostring(check[1]["Price"])
			dbExec(connection,"DELETE FROM purchasedCars WHERE Owner = ? AND Slot = ?",tostring(owner),2)
			outputChatBox("Car sold successfully! Here is your refund!",thePlayer,255,255,0)
			givePlayerMoney(thePlayer,tonumber(price)/2)
			count = count + 1
			dbExec(connection,"UPDATE Count SET count=?",count)
		else 
			outputChatBox("No car found!",thePlayer,255,0,0)
		end
end)

-- Selling slot 3

addEvent("sellSlot3",true)
addEventHandler("sellSlot3",root,
function (thePlayer)
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Price FROM purchasedCars WHERE Owner = ? AND Slot = ?",tostring(owner),3),-1)
		if type(check) == "table" and #check > 0  then
			local price = tostring(check[1]["Price"])
			dbExec(connection,"DELETE FROM purchasedCars WHERE Owner = ? AND Slot = ?",tostring(owner),3)
			outputChatBox("Car sold successfully! Here is your refund!",thePlayer,255,255,0)
			givePlayerMoney(thePlayer,tonumber(price)/2)
			count = count + 1
			dbExec(connection,"UPDATE Count SET count=?",count)
		else 
			outputChatBox("No car found!",thePlayer,255,0,0)
		end
end)

-- Selling slot 4

addEvent("sellSlot4",true)
addEventHandler("sellSlot4",root,
function (thePlayer)
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Price FROM purchasedCars WHERE Owner = ? AND Slot = ?",tostring(owner),4),-1)
		if type(check) == "table" and #check > 0  then
			local price = tostring(check[1]["Price"])
			dbExec(connection,"DELETE FROM purchasedCars WHERE Owner = ? AND Slot = ?",tostring(owner),4)
			outputChatBox("Car sold successfully! Here is your refund!",thePlayer,255,255,0)
			givePlayerMoney(thePlayer,tonumber(price)/2)
			count = count + 1
			dbExec(connection,"UPDATE Count SET count=?",count)
		else 
			outputChatBox("No car found!",thePlayer,255,0,0)
		end
end)

-- Selling slot 5

addEvent("sellSlot5",true)
addEventHandler("sellSlot5",root,
function (thePlayer)
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Price FROM purchasedCars WHERE Owner = ? AND Slot = ?",tostring(owner),5),-1)
		if type(check) == "table" and #check > 0  then
			local price = tostring(check[1]["Price"])
			dbExec(connection,"DELETE FROM purchasedCars WHERE Owner = ? AND Slot = ?",tostring(owner),5)
			outputChatBox("Car sold successfully! Here is your refund!",thePlayer,255,255,0)
			givePlayerMoney(thePlayer,tonumber(price)/2)
			count = count + 1
			dbExec(connection,"UPDATE Count SET count=?",count)
		else 
			outputChatBox("No car found!",thePlayer,255,0,0)
		end
end)

-- Buy bike

addEvent("buybikemoney",true)
addEventHandler("buybikemoney",root,
function(thePlayer,price,cname,slot,id)
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Slot FROM purchasedBikes WHERE Owner = ? AND Slot = ?",owner,slot),-1)
		if #check == 0 then
			takePlayerMoney(thePlayer,price)
			dbExec(connection,"INSERT INTO purchasedBikes VALUES (?,?,?,?,?)",owner,cname,price,slot,id)
			triggerClientEvent(thePlayer,"showCongoGUI",root,owner,cname,price,slot)
			count = count + 1
			dbExec(connection,"UPDATE Count SET count=?",count)
		else
			outputChatBox("You already have a car in slot "..slot.."!",thePlayer,255,0,0)			
		end
end)

-- spawn bike 1

addEvent("spawnBike1",true)
addEventHandler("spawnBike1",root,
function(thePlayer)
	
	if isPedInVehicle(thePlayer) then
		outputChatBox("Spawning cars while inside a car is disallowed!!",thePlayer,255,0,0)
	else
	if bike1created then 
		outputChatBox("Car has already been Spawned",thePlayer,255,255,0)
	else
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Id FROM purchasedBikes WHERE Owner = ? AND Slot = ?",tostring(owner),1),-1)
		if type(check) == "table" and #check > 0  then
			local id = tostring(check[1]["Id"])
			local x,y,z = getElementPosition(thePlayer)
			 bike1created = createVehicle(id,x+1,y+1,z)
		else
			outputChatBox("No car in Slot 1!",thePlayer,255,0,0)
		end
	end
	end
	
end )

-- Destroy Bike 1

addEvent("destroyBike1",true)
addEventHandler("destroyBike1",root,
function(thePlayer)
	if bike1created then
		destroyElement(bike1created)
		outputChatBox("Car is being destroyed!",thePlayer,255,255,0)
		bike1created = nil
	else
		outputChatBox("Your car has not spawned or no car in Slot 1!",thePlayer,255,0,0)
	end
end)

-- spawn bike 2

addEvent("spawnBike2",true)
addEventHandler("spawnBike2",root,
function(thePlayer)
	
	if isPedInVehicle(thePlayer) then
		outputChatBox("Spawning cars while inside a car is disallowed!!",thePlayer,255,0,0)
	else
	if bike2created then 
		outputChatBox("Car has already been Spawned",thePlayer,255,255,0)
	else
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Id FROM purchasedBikes WHERE Owner = ? AND Slot = ?",tostring(owner),2),-1)
		if type(check) == "table" and #check > 0  then
			local id = tostring(check[1]["Id"])
			local x,y,z = getElementPosition(thePlayer)
			 bike2created = createVehicle(id,x+1,y+1,z)
		else
			outputChatBox("No car in Slot 2!",thePlayer,255,0,0)
		end
	end
	end
	
end )

-- Destroy Bike 2

addEvent("destroyBike2",true)
addEventHandler("destroyBike2",root,
function(thePlayer)
	if bike2created then
		destroyElement(bike2created)
		outputChatBox("Car is being destroyed!",thePlayer,255,255,0)
		bike2created = nil
	else
		outputChatBox("Your car has not spawned or no car in Slot 2!",thePlayer,255,0,0)
	end
end)

-- spawn bike 3

addEvent("spawnBike3",true)
addEventHandler("spawnBike3",root,
function(thePlayer)
	
	if isPedInVehicle(thePlayer) then
		outputChatBox("Spawning cars while inside a car is disallowed!!",thePlayer,255,0,0)
	else
	if bike3created then 
		outputChatBox("Car has already been Spawned",thePlayer,255,255,0)
	else
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Id FROM purchasedBikes WHERE Owner = ? AND Slot = ?",tostring(owner),3),-1)
		if type(check) == "table" and #check > 0  then
			local id = tostring(check[1]["Id"])
			local x,y,z = getElementPosition(thePlayer)
			 bike3created = createVehicle(id,x+1,y+1,z)
		else
			outputChatBox("No car in Slot 3!",thePlayer,255,0,0)
		end
	end
	end
	
end )

-- Destroy Bike 3

addEvent("destroyBike3",true)
addEventHandler("destroyBike3",root,
function(thePlayer)
	if bike3created then
		destroyElement(bike3created)
		outputChatBox("Car is being destroyed!",thePlayer,255,255,0)
		bike3created = nil
	else
		outputChatBox("Your car has not spawned or no car in Slot 3!",thePlayer,255,0,0)
	end
end)

-- Selling bike slot 1

addEvent("sellSlotBike1",true)
addEventHandler("sellSlotBike1",root,
function (thePlayer)
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Price FROM purchasedBikes WHERE Owner = ? AND Slot = ?",tostring(owner),1),-1)
		if type(check) == "table" and #check > 0  then
			local price = tostring(check[1]["Price"])
			dbExec(connection,"DELETE FROM purchasedBikes WHERE Owner = ? AND Slot = ?",tostring(owner),1)
			outputChatBox("Bike sold successfully! Here is your refund!",thePlayer,255,255,0)
			givePlayerMoney(thePlayer,tonumber(price)/2)
			count = count + 1
			dbExec(connection,"UPDATE Count SET count=?",count)
		else 
			outputChatBox("No Bike found!",thePlayer,255,0,0)
		end
end)

-- Selling bike slot 2

addEvent("sellSlotBike2",true)
addEventHandler("sellSlotBike2",root,
function (thePlayer)
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Price FROM purchasedBikes WHERE Owner = ? AND Slot = ?",tostring(owner),2),-1)
		if type(check) == "table" and #check > 0  then
			local price = tostring(check[1]["Price"])
			dbExec(connection,"DELETE FROM purchasedBikes WHERE Owner = ? AND Slot = ?",tostring(owner),2)
			outputChatBox("Bike sold successfully! Here is your refund!",thePlayer,255,255,0)
			givePlayerMoney(thePlayer,tonumber(price)/2)
			count = count + 1
			dbExec(connection,"UPDATE Count SET count=?",count)
		else 
			outputChatBox("No Bike found!",thePlayer,255,0,0)
		end
end)

-- Selling bike slot 3

addEvent("sellSlotBike3",true)
addEventHandler("sellSlotBike3",root,
function (thePlayer)
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Price FROM purchasedBikes WHERE Owner = ? AND Slot = ?",tostring(owner),3),-1)
		if type(check) == "table" and #check > 0  then
			local price = tostring(check[1]["Price"])
			dbExec(connection,"DELETE FROM purchasedBikes WHERE Owner = ? AND Slot = ?",tostring(owner),3)
			outputChatBox("Bike sold successfully! Here is your refund!",thePlayer,255,255,0)
			givePlayerMoney(thePlayer,tonumber(price)/2)
			count = count + 1
			dbExec(connection,"UPDATE Count SET count=?",count)
		else 
			outputChatBox("No Bike found!",thePlayer,255,0,0)
		end
end)

--  Buy Plane

addEvent("buyaircraftmoney",true)
addEventHandler("buyaircraftmoney",root,
function(thePlayer,price,cname,slot,id)
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Slot FROM purchasedAircrafts WHERE Owner = ? AND Slot = ?",owner,slot),-1)
		if #check == 0 then
			takePlayerMoney(thePlayer,price)
			dbExec(connection,"INSERT INTO purchasedAircrafts VALUES (?,?,?,?,?)",owner,cname,price,slot,id)
			triggerClientEvent(thePlayer,"showCongoGUI",root,owner,cname,price,slot)
			count = count + 1
			dbExec(connection,"UPDATE Count SET count=?",count)
		else
			outputChatBox("You already have an Aircraft in slot "..slot.."!")			
		end
end)

-- Selling Air slot 1

addEvent("sellAirSlot1",true)
addEventHandler("sellAirSlot1",root,
function (thePlayer)
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Price FROM purchasedAircrafts WHERE Owner = ? AND Slot = ?",tostring(owner),1),-1)
		if type(check) == "table" and #check > 0  then
			local price = tostring(check[1]["Price"])
			dbExec(connection,"DELETE FROM purchasedAircrafts WHERE Owner = ? AND Slot = ?",tostring(owner),1)
			outputChatBox("Aircraft sold successfully! Here is your refund!",thePlayer,255,255,0)
			count = count + 1
			dbExec(connection,"UPDATE Count SET count=?",count)
			givePlayerMoney(thePlayer,tonumber(price)/2)
		else 
			outputChatBox("No plane found!",thePlayer,255,0,0)
		end
end)

-- Selling Air slot 2

addEvent("sellAirSlot2",true)
addEventHandler("sellAirSlot2",root,
function (thePlayer)
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Price FROM purchasedAircrafts WHERE Owner = ? AND Slot = ?",tostring(owner),2),-1)
		if type(check) == "table" and #check > 0  then
			local price = tostring(check[1]["Price"])
			dbExec(connection,"DELETE FROM purchasedAircrafts WHERE Owner = ? AND Slot = ?",tostring(owner),2)
			outputChatBox("Aircraft sold successfully! Here is your refund!",thePlayer,255,255,0)
			givePlayerMoney(thePlayer,tonumber(price)/2)
			count = count + 1
			dbExec(connection,"UPDATE Count SET count=?",count)
		else 
			outputChatBox("No plane found!",thePlayer,255,0,0)
		end
end)

-- spawn Plane 1

addEvent("spawnPlane1",true)
addEventHandler("spawnPlane1",root,
function(thePlayer)
	
	if isPedInVehicle(thePlayer) then
		outputChatBox("Spawning aircrafts while inside an aircraft is disallowed!!",thePlayer,255,0,0)
	else
	if plane1created then 
		outputChatBox("Aircraft has already been Spawned",thePlayer,255,255,0)
	else
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Id FROM purchasedAircrafts WHERE Owner = ? AND Slot = ?",tostring(owner),1),-1)
		if type(check) == "table" and #check > 0  then
			local id = tostring(check[1]["Id"])
			local x,y,z = getElementPosition(thePlayer)
			 plane1created = createVehicle(id,x+1,y+1,z)
		else
			outputChatBox("No aircraft in Slot 1!",thePlayer,255,0,0)
		end
	end
	end
	
end )

-- spawn Plane 2

addEvent("spawnPlane2",true)
addEventHandler("spawnPlane2",root,
function(thePlayer)
	
	if isPedInVehicle(thePlayer) then
		outputChatBox("Spawning aircrafts while inside an aircraft is disallowed!!",thePlayer,255,0,0)
	else
	if plane2created then 
		outputChatBox("Aircraft has already been Spawned",thePlayer,255,255,0)
	else
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Id FROM purchasedAircrafts WHERE Owner = ? AND Slot = ?",tostring(owner),2),-1)
		if type(check) == "table" and #check > 0  then
			local id = tostring(check[1]["Id"])
			local x,y,z = getElementPosition(thePlayer)
			 plane2created = createVehicle(id,x+1,y+1,z)
		else
			outputChatBox("No aircraft in Slot 2!",thePlayer,255,0,0)
		end
	end
	end
	
end )

-- Destroy Plane 1

addEvent("destroyCraft1",true)
addEventHandler("destroyCraft1",root,
function(thePlayer)
	if plane1created then
		destroyElement(plane1created)
		outputChatBox("Aircraft is being destroyed!",thePlayer,255,255,0)
		plane1created = nil
	else
		outputChatBox("Your aircraft has not spawned or no aircraft in Slot 1!",thePlayer,255,0,0)
	end
end)

-- Destroy Plane 2

addEvent("destroyCraft2",true)
addEventHandler("destroyCraft2",root,
function(thePlayer)
	if plane2created then
		destroyElement(plane2created)
		outputChatBox("Aircraft is being destroyed!",thePlayer,255,255,0)
		plane2created = nil
	else
		outputChatBox("Your aircraft has not spawned or no aircraft in Slot 2!",thePlayer,255,0,0)
	end
end)

--  Buy Boat

addEvent("buyboatmoney",true)
addEventHandler("buyboatmoney",root,
function(thePlayer,price,cname,slot,id)
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Slot FROM purchasedBoats WHERE Owner = ? AND Slot = ?",owner,slot),-1)
		if #check == 0 then
			takePlayerMoney(thePlayer,price)
			dbExec(connection,"INSERT INTO purchasedBoats VALUES (?,?,?,?,?)",owner,cname,price,slot,id)
			triggerClientEvent(thePlayer,"showCongoGUI",root,owner,cname,price,slot)
			count = count + 1
			dbExec(connection,"UPDATE Count SET count=?",count)
		else
			outputChatBox("You already have a Boat in slot "..slot.."!")			
		end
end)

-- Selling Boat slot 1

addEvent("sellWaterSlot1",true)
addEventHandler("sellWaterSlot1",root,
function (thePlayer)
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Price FROM purchasedBoats WHERE Owner = ? AND Slot = ?",tostring(owner),1),-1)
		if type(check) == "table" and #check > 0  then
			local price = tostring(check[1]["Price"])
			dbExec(connection,"DELETE FROM purchasedBoats WHERE Owner = ? AND Slot = ?",tostring(owner),1)
			outputChatBox("Boat sold successfully! Here is your refund!",thePlayer,255,255,0)
			givePlayerMoney(thePlayer,tonumber(price)/2)
			count = count + 1
			dbExec(connection,"UPDATE Count SET count=?",count)
		else 
			outputChatBox("No boat found!",thePlayer,255,0,0)
		end
end)

-- Selling Boat slot 2

addEvent("sellWaterSlot2",true)
addEventHandler("sellWaterSlot2",root,
function (thePlayer)
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Price FROM purchasedBoats WHERE Owner = ? AND Slot = ?",tostring(owner),2),-1)
		if type(check) == "table" and #check > 0  then
			local price = tostring(check[1]["Price"])
			dbExec(connection,"DELETE FROM purchasedBoats WHERE Owner = ? AND Slot = ?",tostring(owner),2)
			outputChatBox("Boat sold successfully! Here is your refund!",thePlayer,255,255,0)
			givePlayerMoney(thePlayer,tonumber(price)/2)
			count = count + 1
			dbExec(connection,"UPDATE Count SET count=?",count)
		else 
			outputChatBox("No boat found!",thePlayer,255,0,0)
		end
end)

-- spawn Boat 1

addEvent("spawnBoat1",true)
addEventHandler("spawnBoat1",root,
function(thePlayer)
	
	if isPedInVehicle(thePlayer) then
		outputChatBox("Spawning boats while inside a boat is disallowed!!",thePlayer,255,0,0)
	else
	if boat1created then 
		outputChatBox("Boat has already been Spawned",thePlayer,255,255,0)
	else
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Id FROM purchasedBoats WHERE Owner = ? AND Slot = ?",tostring(owner),1),-1)
		if type(check) == "table" and #check > 0  then
			local id = tostring(check[1]["Id"])
			local x,y,z = getElementPosition(thePlayer)
			 boat1created = createVehicle(id,x+5,y+5,z)
		else
			outputChatBox("No boat in Slot 1!",thePlayer,255,0,0)
		end
	end
	end
	
end )

-- spawn Boat 2

addEvent("spawnBoat2",true)
addEventHandler("spawnBoat2",root,
function(thePlayer)
	
	if isPedInVehicle(thePlayer) then
		outputChatBox("Spawning boats while inside a boat is disallowed!!",thePlayer,255,0,0)
	else
	if boat2created then 
		outputChatBox("Boat has already been Spawned",thePlayer,255,255,0)
	else
		local owner = getAccountName(getPlayerAccount(thePlayer))
		local check = dbPoll(dbQuery(connection,"SELECT Id FROM purchasedBoats WHERE Owner = ? AND Slot = ?",tostring(owner),2),-1)
		if type(check) == "table" and #check > 0  then
			local id = tostring(check[1]["Id"])
			local x,y,z = getElementPosition(thePlayer)
			 boat2created = createVehicle(id,x+5,y+5,z)
		else
			outputChatBox("No boat in Slot 2!",thePlayer,255,0,0)
		end
	end
	end
	
end )

-- Destroy Boat 1

addEvent("destroyBoat1",true)
addEventHandler("destroyBoat1",root,
function(thePlayer)
	if boat1created then
		destroyElement(boat1created)
		outputChatBox("Boat is being destroyed!",thePlayer,255,255,0)
		boat1created = nil
	else
		outputChatBox("Your boat has not spawned or no boat in Slot 1!",thePlayer,255,0,0)
	end
end)

-- Destroy Boat 2

addEvent("destroyBoat2",true)
addEventHandler("destroyBoat2",root,
function(thePlayer)
	if boat2created then
		destroyElement(boat2created)
		outputChatBox("Boat is being destroyed!",thePlayer,255,255,0)
		boat2created = nil
	else
		outputChatBox("Your boat has not spawned or no boat in Slot 2!",thePlayer,255,0,0)
	end
end)

addEventHandler("onPlayerQuit",root,
function (thePlayer)
local veh = getPedOccupiedVehicle(thePlayer)
blowVehicle(veh)
end)