panelOpenKey = "o"

connection = dbConnect("sqlite","groups.db")
if connection then
	state = false
	outputDebugString("GROUP SYSTEM : groups.db Connection Successful!")
else	
	outputDebugString("GROUP SYSTEM : Error loading groups.db")
end

function loadTables()
	local groupTable = dbExec(connection,"CREATE TABLE IF NOT EXISTS Groups ( GroupName text, Owner text, Rules text )")
	local memberTable = dbExec(connection,"CREATE TABLE IF NOT EXISTS Members (Name text, GroupName text, Rank int, JoinDate text)")
	if groupTable and memberTable then
		outputDebugString("GROUP SYSTEM : Database Tables loaded!")
	else
		outputDebugString("GROUP SYSTEM : Loading Database Tables failed! Contact an admin!`")
	end 
end

addEventHandler("onResourceStart",resourceRoot,loadTables)

function createGroup(thePlayer,cmd,grpName)
	
	local checkGrpName = dbPoll(dbQuery(connection,"SELECT GroupName FROM Groups WHERE GroupName = ?",getAccountName(getPlayerAccount(thePlayer)) ),-1)
	if #checkGrpName == 0 then
		local checkOwnerShip = dbPoll(dbQuery(connection,"SELECT GroupName FROM Groups WHERE Owner = ?",getAccountName(getPlayerAccount(thePlayer))),-1)
		if #checkOwnerShip == 0 then
			local checkIfInOtherGroup = dbPoll(dbQuery(connection,"SELECT Name FROM Members WHERE Name = ?",getAccountName(getPlayerAccount(thePlayer))),-1)
			if #checkIfInOtherGroup == 0 then
				local time = getRealTime()
				local timeFormat = (time.monthday.."/"..(time.month + 1).."/"..(time.year + 1900 ))
				exports.topbar:showTopBar("*GROUP SYSTEM* You successfully created a group!",thePlayer,255,255,0)
				dbExec(connection,"INSERT INTO Groups VALUES (?,?,?)",grpName,getAccountName(getPlayerAccount(thePlayer)),"Enter the rules here!!")
				dbExec(connection,"INSERT INTO Members VALUES (?,?,?,?)",getAccountName(getPlayerAccount(thePlayer)),grpName,5,timeFormat)
			else 
				exports.topbar:showTopBar("*GROUP SYSTEM* You are already in a group! ",thePlayer,255,0,0)
			end
		else
			exports.topbar:showTopBar("*GROUP SYSTEM* You are already in a group! ",thePlayer,255,0,0)
		end
	else
		exports.topbar:showTopBar("*GROUP SYSTEM* A group with this name already exists!",thePlayer,255,0,0)
	end
end

-- GETTING DATA FROM DB

function getPlayernGrpData(thePlayer)
	local grpStatus = dbPoll(dbQuery(connection,"SELECT Name FROM Members WHERE Name = ?",getAccountName(getPlayerAccount(thePlayer))),-1)
	if #grpStatus > 0 then
		local getGroup = dbPoll(dbQuery(connection,"SELECT GroupName FROM Members WHERE Name = ?",getAccountName(getPlayerAccount(thePlayer))),-1)
		local inGroup = dbPoll(dbQuery(connection,"SELECT Name FROM Members WHERE GroupName = ?",getGroup[1]["GroupName"]),-1)
		local plrRank = dbPoll(dbQuery(connection,"SELECT Rank FROM Members WHERE Name = ?",getAccountName(getPlayerAccount(thePlayer))),-1)
		local joinDate = dbPoll(dbQuery(connection,"SELECT JoinDate FROM Members WHERE Name = ?",getAccountName(getPlayerAccount(thePlayer))),-1)
		local memRank = dbPoll(dbQuery(connection,"SELECT Rank FROM Members WHERE GroupName = ?",getGroup[1]["GroupName"]),-1)
		local allMemJoins = dbPoll(dbQuery(connection,"SELECT JoinDate FROM Members WHERE GroupName = ?",getGroup[1]["GroupName"]),-1)
		triggerClientEvent(thePlayer,"setTheDataForGui",thePlayer,thePlayer,getGroup[1]["GroupName"],#inGroup,plrRank[1]["Rank"],joinDate[1]["JoinDate"],inGroup,memRank,allMemJoins)		
	end
end

addCommandHandler("creategroup",createGroup)

addEvent("getDataFromPlayer",true)
addEventHandler("getDataFromPlayer",root,getPlayernGrpData)

function checkIfMember(thePlayer)
	local inGroup = dbPoll(dbQuery(connection,"SELECT Name FROM Members WHERE Name = ?",getAccountName(getPlayerAccount(thePlayer))),-1)
	if #inGroup > 0 then
		if state == false then
			state = true
			triggerClientEvent(thePlayer,"showTheGui",thePlayer,thePlayer,state)
		else
			state = false
			triggerClientEvent(thePlayer,"showTheGui",thePlayer,thePlayer,state)
		end
	end
end

addEvent("memberCheck",true)
addEventHandler("memberCheck",root,checkIfMember)

function bindPanelKey()
	bindKey(source,panelOpenKey,"up",checkIfMember)
end

addEventHandler("onPlayerLogin",root,bindPanelKey)

--------- RULES UPDATER
function updateRules(player,text)
	dbExec(connection,"UPDATE Groups SET Rules=?",text)
end

addEvent("updateRules",true)
addEventHandler("updateRules",root,updateRules)

-- UPDATING RULES ON RESOURCE START

function updateOnStart(thePlayer)
	local grpStatus = dbPoll(dbQuery(connection,"SELECT Name FROM Members WHERE Name = ?",getAccountName(getPlayerAccount(thePlayer))),-1)
	if #grpStatus > 0 then
		local getGroup = dbPoll(dbQuery(connection,"SELECT GroupName FROM Members WHERE Name = ?",getAccountName(getPlayerAccount(thePlayer))),-1)
		local rulesText = dbPoll(dbQuery(connection,"SELECT Rules FROM Groups WHERE GroupName = ?",getGroup[1]["GroupName"]),-1)
		triggerClientEvent(thePlayer,"onStartUpdate",thePlayer,thePlayer,rulesText[1]["Rules"])
	end
end

addEvent("onStartInfo",true)
addEventHandler("onStartInfo",root,updateOnStart)
