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

cachedData = {}

Citizen.CreateThread(function()
	while not ESX do

		TriggerEvent("esx:getSharedObject", function(library) 
			ESX = library 
		end)

		Citizen.Wait(0)
	end

end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(playerData)
	ESX.PlayerData = playerData
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(newJob)
	ESX.PlayerData["job"] = newJob
end)

RegisterNetEvent("garou-carthief:eventHandler")
AddEventHandler("garou-carthief:eventHandler", function(response, eventData)
	if response == "started_mission" then
		cachedData["Ongoing"] = true
	else	
 		print("Wrong event handler: " .. response)
	end
end)

Citizen.CreateThread(function()
	Wait(500)
	
	while true do
		
		local sleep = 500
		local pedCoords = GetEntityCoords(PlayerPedId())
		
		for id,coords in pairs(Config.Start) do
			
			local dstcheck = GetDistanceBetweenCoords(pedCoords, coords["Pos"], true)
			local text = coords["Text"]

			if not cachedData["StartedMission"] then
				if dstcheck <= 5.5 then
					sleep = 5
					if dstcheck <= 1.3 then
						text = "[~b~E~s~] " ..coords["Text"]
						if IsControlJustReleased(0, 38) then
							ESX.TriggerServerCallback("garou-carthief:copson", function(starable)
								if starable then
									if not cachedData["Ongoing"] then
										ESX.TriggerServerCallback("garou-carthief:getCooldown", function(available)
											if available then
												cachedData["StartedMission"] = true
												GlobalFunction('started_mission')
												StartThread(math.random(#Config.Coords))
											else
												ESX.ShowNotification("Şu anda hiç araba yok.")
											end
										end)
									else
										ESX.ShowNotification("Devam eden bir hırsızlık var")
									end
								else
									ESX.ShowNotification('Yeterli polis yok.')
								end
							end)
							Wait(1000)
						end
					end
					ESX.Game.Utils.DrawText3D(coords["Pos"], text, 0.6)
					DrawMarker(6, coords["Pos"]-vector3(0.0,0.0,0.975), 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 55, 100, 200, 155, 0, false, false, 0, false, false, false, false)
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

RegisterCommand('start1', function()
	cachedData["StartedMission"] = true
	GlobalFunction('started_mission')
	StartThread(1)
end)

Citizen.CreateThread(function()
	local PedConfig = Config.Start["Start"]["Ped"]
	if not HasModelLoaded(PedConfig["Model"]) then
		while not HasModelLoaded(PedConfig["Model"]) do
			RequestModel(PedConfig["Model"])
			Citizen.Wait(10)
		end
	end

	cachedData["Ped"] = CreatePed(5, PedConfig["Model"], PedConfig["Pos"], PedConfig["Heading"], false)

	SetEntityAsMissionEntity(cachedData["Ped"], true, true)

	SetPedCombatAttributes(cachedData["Ped"], 46, true)                     
	SetPedFleeAttributes(cachedData["Ped"], 0, 0)                      
	SetBlockingOfNonTemporaryEvents(cachedData["Ped"], true)
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(3500)
        if cachedData["InChase"] then
            local coords = GetEntityCoords(cachedData["StolenVehicle"])
            TriggerServerEvent('garou-carthief:updateblip', coords)
        end
    end
end)

RegisterNetEvent('garou-carthief:update')
AddEventHandler('garou-carthief:update', function(coords)
    RemoveBlip(cachedData["VehBlip"])
    cachedData["VehBlip"] = AddBlipForCoord(coords)
    SetBlipSprite(cachedData["VehBlip"], 523)
    SetBlipScale(cachedData["VehBlip"], 1.0)
	SetBlipColour(cachedData["VehBlip"], 1)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Çalıntı Araç')
    EndTextCommandSetBlipName(cachedData["VehBlip"])
    PulseBlip(cachedData["VehBlip"])
end)

RegisterNetEvent('garou-carthief:hideblip')
AddEventHandler('garou-carthief:hideblip', function()
	if DoesBlipExist(cachedData["VehBlip"]) then
		RemoveBlip(cachedData["VehBlip"])
	end
end)