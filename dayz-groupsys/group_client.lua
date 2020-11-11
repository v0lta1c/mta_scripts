
-- This function center's all windows

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

-- Making the gui

function groupGui()
	
	mainWindow = guiCreateWindow(300,100,640,480,"Group Panel",false)
	mainTab = guiCreateTabPanel(25,25,580,430,false,mainWindow)
	infoTab = guiCreateTab("Info",mainTab)
	membersTab = guiCreateTab("Members",mainTab)
	moneyTab = guiCreateTab("Money",mainTab)
	ranksTab = guiCreateTab("Rank",mainTab)
	settingsTab = guiCreateTab("Settings",mainTab)
	
	-- the info panel
		grpNameLabel = guiCreateLabel(100,30,380,50,"",false,infoTab)
		guiSetFont(grpNameLabel,"sa-header")
		guiLabelSetColor(grpNameLabel,0,255,0)
		guiLabelSetHorizontalAlign(grpNameLabel,"center",false)
		grpMembers = guiCreateLabel(40,70,100,25,"Members : ",false,infoTab)
		guiLabelSetColor(grpMembers,255,255,0)
		grpMemberCount = guiCreateLabel(100,70,100,25,"",false,infoTab)		
		ruleTextLabel = guiCreateLabel(50,120,40,25,"Rules :",false,infoTab)
		guiLabelSetColor(ruleTextLabel,255,255,0)
		rulesBox = guiCreateMemo(110,115,410,250,"Enter the Rules here",false,infoTab)
		ruleSaveBtn = guiCreateButton(485,380,50,30,"Save!",false,infoTab)
		guiSetInputMode("no_binds_when_editing")
		addEventHandler("onClientGUIClick",ruleSaveBtn,saveRank,false)
		
		
	-- Players Tab
		memberGrid = guiCreateGridList(40,70,400,300,false,membersTab)
		nameColumn = guiGridListAddColumn(memberGrid,"Name",0.30)
		accColumn = guiGridListAddColumn(memberGrid,"Account Name",0.30)
		joinDate = guiGridListAddColumn(memberGrid,"Joining Date",0.25)
		rankOfMember = guiGridListAddColumn(memberGrid,"Rank",0.10)
		
	centerAllWindows(resourceRoot)
	guiSetVisible(mainWindow,false)
end

addEventHandler("onClientResourceStart",root,groupGui)

-- Make a timer that refreshes data input

setTimer(function ()
					triggerServerEvent("getDataFromPlayer",localPlayer,localPlayer)
		end,
		1000,0)

-- THE GUI SHOWING ELEMENTS
function setData(thePlayer,getGroup,memCount,plrRank,joiningDate,allGroupGuys,memRank,allMemJoins)
	-- FOR INFO TAB
	guiSetText(grpNameLabel,getGroup)
	guiSetText(grpMemberCount,memCount)
	rankOfBuddy = plrRank
	-- FOR MEMBER TAB
	if memTabMade then return 
	else
		for i,names in ipairs(allGroupGuys) do
			local row = guiGridListAddRow(memberGrid)
			memTabMade = guiGridListSetItemText(memberGrid,row,accColumn,allGroupGuys[i]["Name"],false,false)
			guiGridListSetItemText(memberGrid,row,nameColumn,getPlayerName(thePlayer),false,false)
			guiGridListSetItemText(memberGrid,row,joinDate,allMemJoins[i]["JoinDate"],false,false)
			guiGridListSetItemText(memberGrid,row,rankOfMember,memRank[i]["Rank"],false,false)
		end
	end
end 

addEvent("setTheDataForGui",true)
addEventHandler("setTheDataForGui",root,setData)
-- TRIGGERING RULES ON RESOURCE START

function onStartCInfo()
	triggerServerEvent("onStartInfo",localPlayer,localPlayer)
end

addEventHandler("onClientResourceStart",root,onStartCInfo)

--UPDATING THE ABOVE

function startUpdate(thePlayer,rulesText)
	guiSetText(rulesBox,rulesText)
end	
	
addEvent("onStartUpdate",true)
addEventHandler("onStartUpdate",root,startUpdate)
function triggerGui(player,state)
        guiSetVisible(mainWindow,state)
        showCursor(state)
        state = false
end 


addEvent("showTheGui",true)
addEventHandler("showTheGui",root,triggerGui)

function saveRank()
	if rankOfBuddy == 5 then
		local text = guiGetText(rulesBox)
		guiSetText(rulesBox,text)
		exports.topbar:showTopBar("*GROUP SYSTEM* The Rules have been updated!! ",255,255,0)
		triggerServerEvent("updateRules",localPlayer,localPlayer,text)
	else 
		exports.topbar:showTopBar("*GROUP SYSTEM* You must have rank of 5 or above to edit! ",255,0,0)
	end
end 