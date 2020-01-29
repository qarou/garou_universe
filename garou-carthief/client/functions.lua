--[[
********************************************************************
CONTACT: Garou
********************************************************************
Github: https://github.com/qarou
Discord: Garou#0190
Discord Server: https://discord.gg/VkJ6tT5
********************************************************************
]]

GlobalFunction = function(event, data)
    local options = {
        event = event,
        data = data
    }

    TriggerServerEvent("garou-carthief:globalEvent", options)
end

DoAction = function(id, _, data)
    if data["Action"] == "Enter" then
        EnterGarage(id)
    elseif data["Action"] == "Steal" then
        ExitGarage(id)
    end
end

StartThread = function(garage)
    DoScreenFadeOut(1200)
    while not IsScreenFadedOut() do
        Wait(0)
    end
    cachedData["warehouseblip"] = AddBlipForCoord(Config.Coords[garage]["GarageEnter"]["Pos"])
    SetBlipSprite(cachedData["warehouseblip"], 524)
    SetBlipScale(cachedData["warehouseblip"], 0.7)
    SetBlipColour(cachedData["warehouseblip"], 29)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Garage')
    EndTextCommandSetBlipName(cachedData["warehouseblip"])
    SetNewWaypoint(Config.Coords[garage]["GarageEnter"]["Pos"])
    Wait(1500)
    DoScreenFadeIn(1200)
    ESX.ShowNotification('You have a marked location of a garage where u can break in.')
	
    while cachedData["StartedMission"] do
        
        local sleep = 500
        local pedCoords = GetEntityCoords(PlayerPedId())
        local garageData = Config.Coords[garage]
        
        for _, data in pairs(garageData) do
        
            local dstcheck = GetDistanceBetweenCoords(pedCoords, data["Pos"], true)
            local text = data["Text"]

            if dstcheck <= 5.5 then
                sleep = 5
                if dstcheck <= 1.3 then
                    text = "[~b~E~s~] " ..data["Text"]
                    if IsControlJustReleased(0, 38) then
                        DoAction(garage, _, data)
                    end
                end
                ESX.Game.Utils.DrawText3D(data["Pos"], text, 0.6)
                DrawMarker(6, data["Pos"]-vector3(0.0,0.0,0.975), 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 55, 100, 200, 155, 0, false, false, 0, false, false, false, false)
            end
        end
        Citizen.Wait(sleep)
    end
end

EnterGarage = function(garage)
    local carModel = Config.CarModels[math.random(#Config.CarModels)]
    local data = Config.Coords[garage]
    ESX.ShowNotification(Config.LockPicking)
    while not HasAnimDictLoaded('missheistfbisetup1') do
        RequestAnimDict('missheistfbisetup1')
        Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), 'missheistfbisetup1', 'hassle_intro_loop_f', 8.0, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(Config.LockPickTime)
    ClearPedTasksImmediately(PlayerPedId())
    DoScreenFadeOut(1200)
    Wait(1200)
    while not IsScreenFadedOut() do
        Wait(0)
    end
    SetEntityCoords(PlayerPedId(), data["GarageExit"]["Pos"])
    SetEntityHeading(PlayerPedId(), data["GarageExit"]["Heading"])
    FreezeEntityPosition(PlayerPedId(), true)
    FreezeEntityPosition(PlayerPedId(), false)
    if DoesBlipExist(cachedData["warehouseblip"]) then
        RemoveBlip(cachedData["warehouseblip"])
    end
    while not HasModelLoaded(GetHashKey(carModel)) do
        Wait(0)
        RequestModel(GetHashKey(carModel))
    end
    cachedData["StolenVehicle"] = CreateVehicle(GetHashKey(carModel), data["Car"]["Pos"], data["Car"]["Heading"], true)
    DoScreenFadeIn(1200)
    Wait(1200)
    SetVehicleDoorsLocked(cachedData["StolenVehicle"], 2)
    cachedData["InGarage"] = true
    InGarage(data)
end

InGarage = function(data)
    local random = math.random(1,4)
    while cachedData["InGarage"] do
           
        local sleep = 500
        local pedCoords = GetEntityCoords(PlayerPedId())
        
        for id,coords in pairs(data["Keys"]) do
            
            local dstcheck = GetDistanceBetweenCoords(pedCoords, coords["Pos"], true)
            local text = coords["Text"]

            if dstcheck <= 3.5 then
                sleep = 5
                if dstcheck <= 1.3 then
                    text = "[~b~E~s~] " ..coords["Text"]
                    if IsControlJustReleased(0, 38) then
                        SearchKeys(coords, random, data)
                    end
                end
                ESX.Game.Utils.DrawText3D(coords["Pos"], text, 0.6)
                DrawMarker(6, coords["Pos"]-vector3(0.0,0.0,0.975), 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 55, 100, 200, 155, 0, false, false, 0, false, false, false, false)
            end
        end
        Citizen.Wait(sleep)
    end
end

SearchKeys = function(data, random, coords)
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
    Wait(2500)
    if data["Random"] == random then
        ESX.ShowNotification('You found the keys, enter the vehicle')
        ClearPedTasksImmediately(PlayerPedId())
        cachedData["HasKeys"] = true
        SetVehicleDoorsLocked(cachedData["StolenVehicle"], false)
        VehicleThread(coords)
    else
        ESX.ShowNotification('You found nothing.')
        ClearPedTasksImmediately(PlayerPedId())
    end
end

VehicleThread = function(data)
    while cachedData["HasKeys"] do
        local sleep = 500
        local vehCoords = GetEntityCoords(cachedData["StolenVehicle"])
        if IsPedInVehicle(PlayerPedId(), cachedData["StolenVehicle"]) then
            sleep = 0
            if GetEntitySpeed(cachedData["StolenVehicle"]) > 2.0 then
                StartChase(data)
                break
            end
        end
        Citizen.Wait(sleep)
    end
end

ExitGarage = function(data)
    DoScreenFadeOut(1200)
    Wait(1200)
    while not IsScreenFadedOut() do
        Wait(0)
    end
    SetEntityCoords(PlayerPedId(), data["Pos"])
    cachedData["InGarage"] = false
    cachedData["StartedMission"] = false
    DoScreenFadeIn(1200)
end

StartChase = function(data)
    DoScreenFadeOut(1200)
    while not IsScreenFadedOut() do
        Wait(0)
    end
    SetPedCoordsKeepVehicle(PlayerPedId(), data["GarageEnter"]["VehPos"])
    SetEntityHeading(cachedData["StolenVehicle"], data["GarageEnter"]["VehHeading"])
    SetVehicleFixed(cachedData["StolenVehicle"])
    DoScreenFadeIn(1200)
    cachedData["InGarage"] = false
    cachedData["StartedMission"] = true
    cachedData["InChase"] = true
    cachedData["Tracker"] = true
    local timer = 0
    while cachedData["InChase"] do
        if DoesEntityExist(cachedData["StolenVehicle"]) then
            local text = "Tracker"
            local vehicle = cachedData["StolenVehicle"]
            local vehCoords = GetEntityCoords(vehicle)
            if (GetEntitySpeed(cachedData["StolenVehicle"]) == 0.0 and IsPedInVehicle(PlayerPedId(), cachedData["StolenVehicle"], false)) or DoesEntityExist(GetPedInVehicleSeat(cachedData["StolenVehicle"], 0)) then
                timer = timer+10
                text = "Removing Tracker"
                if math.floor((timer / 1000) / Config.TrackerTime * 100) >= 100 then
                    cachedData["InChase"] = false
                    cachedData["Tracker"] = false
                    TriggerServerEvent('garou-carthief:done')
                    ReturnVehicle()
                end
            end
            drawTxt(0.97, 0.6, 1.0, 1.0, 0.5, text .. '~b~ ' .. math.floor((timer / 1000) / Config.TrackerTime * 100) .. "~s~%", 255, 255, 255, 255)
        else
            break
        end
        Citizen.Wait(0)
    end
end

ReturnVehicle = function()
    cachedData["ReturnVehBlip"] = AddBlipForCoord(Config.ReturnVehicle["Pos"])
    SetBlipSprite(cachedData["ReturnVehBlip"], 478)
    SetBlipScale(cachedData["ReturnVehBlip"], 0.7)
    SetBlipColour(cachedData["ReturnVehBlip"], 29)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Vehicle DropOff')
    EndTextCommandSetBlipName(cachedData["ReturnVehBlip"])
    SetNewWaypoint(Config.ReturnVehicle["Pos"])
    while not cachedData["Tracker"] and cachedData["StartedMission"] do   
        local sleep = 500
        local pedCoords = GetEntityCoords(PlayerPedId())
        local dstcheck = GetDistanceBetweenCoords(pedCoords, Config.ReturnVehicle["Pos"], true)
        local text = Config.ReturnVehicle["Text"]

        if dstcheck <= 10.5 then
            sleep = 5
            if dstcheck <= 5.3 then
                text = "[~b~E~s~] " ..Config.ReturnVehicle["Text"]
                if IsControlJustReleased(0, 38) then
                    FinishTheft()
                    break
                end
            end
            ESX.Game.Utils.DrawText3D(Config.ReturnVehicle["Pos"], text, 0.6)
            DrawMarker(6, Config.ReturnVehicle["Pos"]-vector3(0.0,0.0,0.975), 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 55, 100, 200, 155, 0, false, false, 0, false, false, false, false)
        end
        Citizen.Wait(sleep)
    end
end

FinishTheft = function()
    TaskLeaveVehicle(PlayerPedId(), cachedData["StolenVehicle"], 0)
    DoScreenFadeOut(1200)
    Wait(2000)
    while not IsScreenFadedOut() do
        Wait(0)
    end
    DeleteVehicle(cachedData["StolenVehicle"])
    DoScreenFadeIn(1200)
    TriggerServerEvent('garou-carthief:givereward', Config.ReturnVehicle["Reward"])
    cachedData["Ongoing"] = false
    if DoesBlipExist(cachedData["ReturnVehBlip"]) then
        RemoveBlip(cachedData["ReturnVehBlip"])
    end
end

drawTxt = function(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end