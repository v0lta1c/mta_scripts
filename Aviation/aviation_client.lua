----------------------------------------------------------------
--           Aviation Job
--      Author & Owner : Mann
----------------------------------------------------------------

companies = {
				{"Jet Airways"},
				{"Etihad Airways"},
				{"Global Airlines"},
			}
			
passengerAirplanes = {
						-- SYNTAX : Name Of aircraft,fuel capacity,fuel,consumption per minute,total seats,max weight it can carry,sa model name
						{"Airbus 380",140000,"Kerosene",120,400,150000,"Andromada"},
						{"Boeing 787",90000,"Kerosene",95,320,90000,"Nevada"},
					 }

function makeGui()
	JobStartWindow = guiCreateWindow(500, 300, 600, 450,"Aviation Job",false)
	guiWindowSetSizable(JobStartWindow, false)
	guiSetVisible(JobStartWindow, false)
	JobStartInfoLabel = guiCreateLabel(40,35,600,15,"Welcome to the Aviation Industry! You can select an option from below to continue your job!",false,JobStartWindow)
	guiSetFont(JobStartInfoLabel, "clear-normal")
	JobStartAirplanePilotButton = guiCreateButton(100,100,400,50,"Work as an Airplane Pilot",false,JobStartWindow)
	JobStartHeliPilotButton = guiCreateButton(100,170,400,50,"Work as a Helicopter Pilot",false,JobStartWindow)
	JobStartAirportCrewButton = guiCreateButton(100,240,400,50,"Work as a crew at the Airport",false,JobStartWindow)
	JobStartCloseGui = guiCreateButton(400,370,150,50,"Close",false,JobStartWindow)
	
	centerAllWindows(resourceRoot)
	
	-- All the functions handled by the buttons
	addEventHandler("onClientGUIClick", JobStartCloseGui, closeJobStartGUI, false)
	addEventHandler("onClientGUIClick", JobStartAirplanePilotButton, startAirplanePilotJob, false)

end

addEventHandler("onClientResourceStart", resourceRoot, makeGui)

function showJobStartGui()
	guiSetVisible(JobStartWindow, true)
	showCursor(true)
end

addEvent("triggerJobStartGui",true)
addEventHandler("triggerJobStartGui",root,showJobStartGui)

function centerAllWindows(res)
	for ind, element in ipairs(getElementsByType("gui-window", res)) do
		centerWindow(element)
	end
end

function centerWindow(window)
    local sx, sy = guiGetScreenSize()
    local width, heigh = guiGetSize(window, false)
    local x, y = (sx-width) / 2, (sy-heigh) / 2
    guiSetPosition(window, x, y, false)
end

-- This closes the primitive "Job Start" gui

function closeJobStartGUI()
	guiSetVisible(JobStartWindow,false)
	showCursor(false)
end 

------------------------------------------------------------------
-- This initializes the Airplane Pilot GUI 
------------------------------------------------------------------
--Everything pertaining to Airplane Server GUI
------------------------------------------------------------------


function AirplanePilotJobGui()
	AirplanePilotJobWindow = guiCreateWindow(500, 300, 400, 250,"Airplane Pilot Job",false)
	guiSetVisible(AirplanePilotJobWindow,false)
	guiWindowSetSizable(AirplanePilotJobWindow, false)
	guiSetVisible(AirplanePilotJobWindow, false)
	AirplanePilotSelectLabel = guiCreateLabel(50,50,350,25,"Select the type of airplane you want to work with",false,AirplanePilotJobWindow)
	guiSetFont(AirplanePilotSelectLabel, "clear-normal")
	AirplanePilotJobPassengerButton = guiCreateButton(100,100,200,50,"Passenger Airplane",false,AirplanePilotJobWindow)
	AirplanePilotJobCargoButton = guiCreateButton(100,170,200,50,"Cargo Airplane",false,AirplanePilotJobWindow)
	AirplanePilotJobCloseButton = guiCreateButton(320,210,75,25,"Close",false,AirplanePilotJobWindow)
	
	centerAllWindows(resourceRoot)
	
	addEventHandler("onClientGUIClick", AirplanePilotJobCloseButton, closeAirplanePilotGui, false)
	addEventHandler("onClientGUIClick", AirplanePilotJobPassengerButton, startAsPassengerPilot, false)
end 

function showAirplanePilotGui()
	guiSetVisible(AirplanePilotJobWindow,true)
	showCursor(true)
end 

function closeAirplanePilotGui()
	guiSetVisible(AirplanePilotJobWindow,false)
	showCursor(false)
end 

addEventHandler("onClientResourceStart", resourceRoot, AirplanePilotJobGui)

--This triggers an airplane pilot job

function startAirplanePilotJob()
	closeJobStartGUI()
	outputChatBox("[AVIATION INDUSTRY] #00FFFFYou have successfully joined as an Airplane Pilot! The user interface will guide you further!",0,255,0,true)
	showAirplanePilotGui()
	setElementData(localPlayer,"Airplane Pilot",true)
end 

function startAsPassengerPilot ()
	if getElementData(localPlayer,"Airplane Pilot") == true then
		outputChatBox("[PILOT JOB] #00FFFFYou have selected to work as a pilot in a Passenger Airplane! Get to the place alloted to you to trigger your job!",0,255,0,true)
		closeAirplanePilotGui()
		triggerServerEvent("AirplanePilotTriggers",resourceRoot)
		setElementData(localPlayer,"AP Passenger",true)
	else
		outputChatBox("[PILOT JOB] #00FFFFYou are not an Airplane Pilot!",localPlayer,0,255,0,true)
	end
end 

function createAPSelectGUI()
	APSelectWindow = guiCreateWindow(500,300,600,400,"Select an Airplane",false)
	guiWindowSetSizable(APSelectWindow, false)
	guiSetVisible(APSelectWindow,false)
	local APSelectInfoLabel = guiCreateLabel(175,35,550,25,"Please select your choice below",false,APSelectWindow)
	local APSelectCompanyLabel = guiCreateLabel(50,75,120,25,"Company :",false,APSelectWindow)
	local APSelectCompanyComboBox = guiCreateComboBox(125,75,300,50,"Select Company",false,APSelectWindow)
    APSelectPlaneComboBox = guiCreateComboBox(125,130,300,50,"Select Airplane",false,APSelectWindow)
	guiSetFont(APSelectInfoLabel, "clear-normal")
	local APSelectPlaneLabel = guiCreateLabel(50,125,120,25,"Airplane :",false,APSelectWindow)
	for i,company in ipairs(companies) do
		local companyAdd = unpack(company)
		guiComboBoxAddItem(APSelectCompanyComboBox,companyAdd)
	end
	for i,plane in ipairs(passengerAirplanes) do
		local planeAdd = unpack(plane)
		guiComboBoxAddItem(APSelectPlaneComboBox,planeAdd)
	end
	local APSelectSpecifications = guiCreateLabel(50,190,300,30,"Aircraft Specifications",false,APSelectWindow)	
	guiLabelSetColor(APSelectSpecifications,255,255,0)
	function triggerSpecifications()
		local item = guiComboBoxGetSelected(APSelectPlaneComboBox)
		local selectedAircraft = guiComboBoxGetItemText(APSelectPlaneComboBox,item)
		for i,v in pairs(passengerAirplanes) do
			if v[1] == selectedAircraft then	
				local capacity = v[2]
				guiSetText(APSelectSpecFuelCapacity,"Fuel Capacity : "..capacity.." litres")
				local fuel = v[3]
				guiSetText(APSelectSpecFuel,"Fuel : "..fuel)
				local fuelCons = v[4]
				guiSetText(APSelectSpecFuelCons,"Fuel Consumption : "..fuelCons.." litres per minute")
				local totSeats = v[5]
				guiSetText(APSelectSpecTotalSeats,"Total Seats : "..totSeats)
				local maxWeight = v[6]
				guiSetText(APSelectSpecMaxWeight,"Max Weight : "..maxWeight.." kg")
				local planeModel = v[7]
				guiSetText(APSelectSpecModel,"Model : "..planeModel)
			end
		end
	end
	APSelectSpecFuelCapacity = guiCreateLabel(50,210,300,30,"Fuel Capacity : Select an Airplane",false,APSelectWindow)
	APSelectSpecFuel = guiCreateLabel(50,230,300,30,"Fuel : Select an Airplane",false,APSelectWindow)
	APSelectSpecFuelCons = guiCreateLabel(50,250,300,30,"Fuel Consumption : Select an Airplane",false,APSelectWindow)
	APSelectSpecTotalSeats = guiCreateLabel(50,270,300,30,"Total Seats : Select an Airplane",false,APSelectWindow)
	APSelectSpecMaxWeight = guiCreateLabel(50,290,300,30,"Maximum Weight : Select an Airplane",false,APSelectWindow)
	APSelectSpecModel = guiCreateLabel(50,310,300,30,"Model : Select an Airplane",false,APSelectWindow)
	
	APSelectSelectThisPlaneBtn = guiCreateButton(250,340,100,50,"Select This Airplane",false,APSelectWindow)
	addEventHandler("onClientGUIComboBoxAccepted",APSelectPlaneComboBox,triggerSpecifications)
	addEventHandler("onClientGUIClick",APSelectSelectThisPlaneBtn,givePlaneAndFirstTrigger,false)
	
	centerAllWindows(resourceRoot)
end 

addEventHandler("onClientResourceStart", resourceRoot, createAPSelectGUI)

function showAPJobStartGui()
	guiSetVisible(APSelectWindow,true)
	showCursor(true)
	
end

addEvent("triggerAPJobStartGui",true)                                                                                    
addEventHandler("triggerAPJobStartGui",root ,showAPJobStartGui)

function givePlaneAndFirstTrigger()
	local item = guiComboBoxGetSelected(APSelectPlaneComboBox)
	local selectedAircraft = guiComboBoxGetItemText(APSelectPlaneComboBox,item)
	local thePlane
	for i,v in pairs(passengerAirplanes) do
		if selectedAircraft == v[1] then
			thePlane = v[7]
		end
	end
	setElementAlpha(localPlayer,"AP Start",true)
	outputChatBox("[PILOT JOB] #00FFFFYou selected a "..selectedAircraft.."! You'll be guided further after getting to your aircraft.",0,255,0,true)
	guiSetVisible(APSelectWindow,false)
	showCursor(false)
	triggerServerEvent("APJobStart",resourceRoot,thePlane,localPlayer)
end
	