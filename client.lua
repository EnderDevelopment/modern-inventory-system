local ESX = exports['es_extended']:getSharedObject()

local function openInventory()
    local playerData = ESX.GetPlayerData()
    local inventory = playerData.inventory
    
    SendNUIMessage({
        action = 'openInventory',
        inventory = inventory,
        weightLimit = Config.Inventory.WeightLimit,
        slots = Config.Inventory.Slots
    })
    SetNuiFocus(true, true)
end

RegisterCommand('inventory', function()
    openInventory()
end, false)

RegisterNUICallback('closeInventory', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('useItem', function(data, cb)
    local item = data.item
    TriggerServerEvent('moderninventory:useItem', item)
    cb('ok')
end)

RegisterNUICallback('dropItem', function(data, cb)
    local item = data.item
    local count = data.count
    TriggerServerEvent('moderninventory:dropItem', item, count)
    cb('ok')
end)

RegisterNUICallback('moveItem', function(data, cb)
    local fromSlot = data.fromSlot
    local toSlot = data.toSlot
    TriggerServerEvent('moderninventory:moveItem', fromSlot, toSlot)
    cb('ok')
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, 322) then -- E key
            openInventory()
        end
    end
end)