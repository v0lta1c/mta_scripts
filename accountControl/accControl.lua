-- First we'll check how many accounts a player has when he joins

function checkPlayerAccounts()
		playerSerial = getPlayerSerial(source)
		accsOfPlayer = getAccountsBySerial(playerSerial)
		numOfAccs = #accsOfPlayer - 2
		if #accsOfPlayer > 2 then
			outputChatBox("ACCOUNT CONTROL : #FFFFFFMore than two accounts detected! Deleting some accounts!",source,255,255,0,true)
			deleteAccounts()
		else
			outputChatBox("ACCOUNT CONTROL : #FFFFFFYou seem legit with two or less accounts!",source,255,255,0,true)
		end
		player = source 
end

addEventHandler("onPlayerJoin",root,checkPlayerAccounts)

function deleteAccounts()
		for numOfAccs , accounts in pairs(accsOfPlayer) do
			removeAccount(accounts)
			outputChatBox("ACCOUNT CONTROL : #FFFFFFAccount "..getAccountName(accounts).." removed!",player,255,255,0,true)
		end 
end 