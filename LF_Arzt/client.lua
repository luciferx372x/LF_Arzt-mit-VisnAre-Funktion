local isDoctorBusy = false
ESX = exports["es_extended"]:getSharedObject()

-- Dein Heal Event & visn_are Integration
RegisterNetEvent('doctor:healPlayer')
AddEventHandler('doctor:healPlayer', function()
    local ped = PlayerPedId()

    -- GTA-Health auffüllen
    SetEntityHealth(ped, GetEntityMaxHealth(ped))

    -- Visuelle Effekte entfernen
    ClearPedBloodDamage(ped)
    ResetPedVisibleDamage(ped)
    ClearPedTasksImmediately(ped)

    -- visn_are Health Buffer resetten
    TriggerEvent('visn_are:resetHealthBuffer')
    TriggerEvent('visn_are:resetHealth')

  
    ESX.ShowNotification("~g~Du wurdest vollständig geheilt!")
    print("^2[LF_Arzt] doctor:healPlayer wurde erfolgreich ausgeführt.^7")
end)

-- KI-Ambulanz rufen (Befehl /callmedic)
RegisterCommand('callmedic', function()
    print("^2[LF_Arzt] Befehl /callmedic wurde eingegeben.^7")
    ESX.TriggerServerCallback('visn_npc_med:checkEMS', function(canUse)
        if canUse then
            SpawnAmbulanceNearby()
        else
            ESX.ShowNotification("Sanitäter im Dienst!")
        end
    end)
end)

function SpawnAmbulanceNearby()
    local playerPed = PlayerPedId()
    local pPos = GetEntityCoords(playerPed)
    local vehicleModel = `bftecrtw2`
    
    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do Wait(10) end

    local spawnPos = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 45.0, 0.0)
    local streetFound, outPos, heading = GetClosestVehicleNodeWithHeading(spawnPos.x, spawnPos.y, spawnPos.z, 1, 3.0, 0)
    if streetFound then spawnPos = outPos end

    ESX.Game.SpawnVehicle(vehicleModel, spawnPos, heading or 0.0, function(veh)
        local driverModel = `s_m_m_doctor_01`
        RequestModel(driverModel)
        while not HasModelLoaded(driverModel) do Wait(10) end
        
        local driver = CreatePedInsideVehicle(veh, 4, driverModel, -1, true, false)
        SetVehicleSiren(veh, true)
        TaskVehicleDriveToCoord(driver, veh, pPos.x, pPos.y, pPos.z, 20.0, 0, vehicleModel, 786603, 2.0, true)

        Citizen.CreateThread(function()
            local timeout = 0
            while #(GetEntityCoords(veh) - pPos) > 12.0 and timeout < 30 do Wait(1000) timeout = timeout + 1 end
            
            print("^2[LF_Arzt] Arzt ist angekommen.^7")
            TaskVehicleTempAction(driver, veh, 1, 3000) 
            Wait(2000)
            TaskLeaveVehicle(driver, veh, 0)
            TaskGoToEntity(driver, playerPed, -1, 1.0, 2.0, 0, 0)
            
            Wait(8000) -- Behandlungszeit
            TriggerServerEvent('visn_npc_med:payTreatment', true)
            
            -- Heilung triggern
            TriggerEvent('doctor:healPlayer')
            
            Wait(2000)
            TaskEnterVehicle(driver, veh, -1, -1, 1.0, 1, 0)
            TaskVehicleDriveWander(driver, veh, 20.0, 786603)
            Wait(15000)
            DeleteEntity(driver)
            DeleteEntity(veh)
        end)
    end)
end

-- Krankenhaus-Tresen Heilung
function StartHospitalHeal()
    if isDoctorBusy then return end
    isDoctorBusy = true
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD", 0, true)
    Wait(5000)
    TriggerServerEvent('visn_npc_med:payTreatment', false)
    
    TriggerEvent('doctor:healPlayer')
    
    ClearPedTasksImmediately(PlayerPedId())
    isDoctorBusy = false
end

-- NPC Spawner für Tresen
Citizen.CreateThread(function()
    for _, hosp in pairs(Config.Hospitals) do
        RequestModel(hosp.npcModel)
        while not HasModelLoaded(hosp.npcModel) do Wait(10) end
        local ped = CreatePed(4, hosp.npcModel, hosp.npcCoords.x, hosp.npcCoords.y, hosp.npcCoords.z - 1.0, hosp.npcCoords.w, false, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        
        Citizen.CreateThread(function()
            while true do
                local sleep = 1500
                if #(GetEntityCoords(PlayerPedId()) - vector3(hosp.npcCoords.x, hosp.npcCoords.y, hosp.npcCoords.z)) < 3.0 then
                    sleep = 0
                    ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um dich behandeln zu lassen für 1000€.")
                    if IsControlJustReleased(0, 38) then StartHospitalHeal() end
                end
                Wait(sleep)
            end
        end)
    end
end)
