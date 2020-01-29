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

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
	ESX.PlayerData.job = job
end)


-- // FRISK FUNCTION // --
RegisterCommand("arama", function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == "police" then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	
		if closestPlayer == -1 or closestDistance > 2.0 then 
			ESX.ShowNotification("Yakınlarda oyuncu yok!")
		else
			TriggerServerEvent("garou_policefrisk:closestPlayer", GetPlayerServerId(closestPlayer))
		end
	end
end, false)

RegisterNetEvent("garou_policefrisk:menuEvent") -- Call this event if you want to add it to your police menu -- -- Polis menünüze eklemek istiyorsanız bu etkinliği girin
AddEventHandler("garou_policefrisk:menuEvent", function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer == -1 or closestDistance > 2.0 then 
		ESX.ShowNotification("Yakınlarda oyuncu yok!")
	else
		TriggerServerEvent("garou_policefrisk:closestPlayer", GetPlayerServerId(closestPlayer))
	end
end)

local weapons = {
	-- PISTOLS - TABANCALAR --
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_COMBATPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_REVOLVER",
	"WEAPON_APPISTOL",
	"WEAPON_STUNGUN",
	"WEAPON_FLAREGUN",
	-- SMGS - SMGLER --
	"WEAPON_MICROSMG",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_SMG",
	"WEAPON_SMG_MK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_COMBATPDW",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_GUSENBERG",
	"WEAPON_MINISMG",
	-- RIFLES - TÜFEKLER --
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_COMPACTRIFLE",
	-- SNIPER RIFLES - SNIPER TUFEKLERI --
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE",
	-- SHOTGUNS - POMPALILAR --
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_MUSKET",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DOUBLEBARRELSHOTGUN",
	"WEAPON_AUTOSHOTGUN",
}

RegisterNetEvent('garou_policefrisk:friskPlayer') 
AddEventHandler('garou_policefrisk:friskPlayer', function()
	local ped = PlayerPedId()
	
	for a = 1, #weapons do
        if HasPedGotWeapon(ped, GetHashKey(weapons[a]), false) then
            TriggerServerEvent("garou_policefrisk:notifyMessage", true)
            break;
        else
            TriggerServerEvent("garou_policefrisk:notifyMessage", false)
            break;
        end
    end
end)