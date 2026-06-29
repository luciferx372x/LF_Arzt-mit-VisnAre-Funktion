ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('visn_npc_med:checkEMS', function(source, cb)
    local xPlayers = ESX.GetExtendedPlayers('berufsfeuerwehr', 'krankenhaus')
    cb(#xPlayers < Config.MinMedics)
end)

RegisterNetEvent('visn_npc_med:payTreatment')
AddEventHandler('visn_npc_med:payTreatment', function(isMobile)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local amount = isMobile and Config.MobileMedicCost or Config.HealingCost
    
    if xPlayer.getAccount('money').money >= amount then
        xPlayer.removeAccountMoney('money', amount)
        
        -- VISN-ARE SERVER REVIVE
        TriggerEvent('visn_are:server:revivePlayer', src)
        TriggerClientEvent('visn_are:client:revivePlayer', src)
        
        -- Benachrichtigung hier entfernt, um Doppelung zu vermeiden
    else
        TriggerClientEvent('esx:showNotification', src, "~r~Nicht genug Geld!")
    end
end)