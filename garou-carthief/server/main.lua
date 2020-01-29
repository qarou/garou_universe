--[[
********************************************************************
CONTACT: Garou
********************************************************************
Github: https://github.com/qarou
Discord: Garou#0190
Discord Server: https://discord.gg/VkJ6tT5
********************************************************************
]]

local ESX
local showed = false

cachedData = {}

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

RegisterServerEvent("garou-carthief:globalEvent")
AddEventHandler("garou-carthief:globalEvent", function(options)
    ESX.Trace((options["event"] or "none") .. " triggered to all clients.")

    TriggerClientEvent("garou-carthief:eventHandler", -1, options["event"] or "none", options["data"] or nil)
end)


RegisterServerEvent('garou-carthief:updateblip')
AddEventHandler('garou-carthief:updateblip', function(coords)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('garou-carthief:update', xPlayers[i], coords)
			if not showed then
				TriggerClientEvent('esx:showNotification', xPlayers[i], '911 Cağrı\n Araba Hırsızlığı, Haritada İşaretli.')
				showed = true
			end
		else
			TriggerClientEvent('garou-carthief:hideblip', xPlayers[i])
		end
	end
end)

RegisterServerEvent('garou-carthief:givereward')
AddEventHandler('garou-carthief:givereward', function(amount)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
	xPlayer.addMoney(amount)
	cachedData["Cooldown"] = os.time()
    TriggerClientEvent('esx:showNotification', source, 'Kazandın $' ..amount)
end)

RegisterServerEvent('garou-carthief:done')
AddEventHandler('garou-carthief:done', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
            TriggerClientEvent('garou-carthief:hideblip', xPlayers[i])
		end
	end
end)

ESX.RegisterServerCallback('garou-carthief:copson',function(source, cb)
	local copamount = 0
	local Players = GetPlayers()
	for i=1, #Players, 1 do
		local _source = Players[i]
		local xPlayer = ESX.GetPlayerFromId(_source)
		local playerjob = xPlayer.job.name
		if playerjob == 'police' then
			copamount = copamount + 1
		end
	end
	if copamount >= Config.CopsRequired then
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback("garou-carthief:getCooldown", function(source, cb)
	if cachedData["Cooldown"] then
		if os.time() - cachedData["Cooldown"] > Config.CooldownTime then
			cb(true)
		else
			cb(false)
		end
	else
		cb(true)
	end
end)