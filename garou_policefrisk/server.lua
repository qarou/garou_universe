--[[
********************************************************************
CONTACT: Garou
********************************************************************
Github: https://github.com/qarou
Discord: Garou#0190
Discord Server: https://discord.gg/VkJ6tT5
********************************************************************
]]

ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterServerEvent("garou_policefrisk:closestPlayer")
AddEventHandler("garou_policefrisk:closestPlayer", function(closestPlayer)
    _source = source
    target = closestPlayer

    TriggerClientEvent("garou_policefrisk:friskPlayer", target)
end)

RegisterServerEvent("garou_policefrisk:notifyMessage")
AddEventHandler("garou_policefrisk:notifyMessage", function(frisk)
    if frisk == true then
        TriggerClientEvent("chatMessage", _source, "Bir şey hissettim")
    elseif frisk == false then
        TriggerClientEvent("chatMessage", _source, "Hiçbir şey hissedemedim")
    end
end)