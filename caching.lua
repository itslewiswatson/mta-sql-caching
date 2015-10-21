-- The equivalent of setAccountData
function setPlayerData(plr, column, value)
	if (not plr or not column or not value) then return nil end
	if (plr:getType() ~= "player" or plr ~= localPlayer) then return false end
	
	-- Update the table
	accountData[column] = value
	
	return true
end

-- The equivalent of getAccountData
function getPlayerData(plr, column)
	if (not plr or not column or not accountData or accountData[column] == nil) then return nil end
	if (plr ~= localPlayer) then return false end
	
	-- Special character to get the whole table
	if (column == "*") then
		return accountData
	end
	
	return accountData[column]
end

function passTable(sync)
	accountData = sync
end
addEvent("sendTableToClient", true)
addEventHandler("sendTableToClient", root, passTable)

function onQuit()
	triggerServerEvent("sendTableToServer", resourceRoot, accountData)
end
addEventHandler("onClientResourceStop", resourceRoot, onQuit)
