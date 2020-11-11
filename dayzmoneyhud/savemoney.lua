addEventHandler("onPlayerLogin", getRootElement(),
function()
	local account = getPlayerAccount(source)
	if account then
		local money = getAccountData(account, "stats.money")
		setPlayerMoney(source, money)
	else
		outputChatBox("You are not login ! (/login)", source, 250, 0, 0, true)
	end
end)
addEventHandler("onPlayerQuit", getRootElement(),
function()
	local account = getPlayerAccount(source)
	if account then
		local cash = getPlayerMoney(source)
		setAccountData(account, "stats.money", cash)
	else
		outputChatBox("You are not login ! (/login)", source, 250, 0, 0, true)
	end
end)
