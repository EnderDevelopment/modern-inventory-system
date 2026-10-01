local ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('moderninventory:getInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        cb(xPlayer.getInventory())
    else
        cb(nil)
    end
end)

RegisterServerEvent('moderninventory:useItem')
AddEventHandler('moderninventory:useItem', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.useItem(item)
    end
end)

RegisterServerEvent('moderninventory:dropItem')
AddEventHandler('moderninventory:dropItem', function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.removeInventoryItem(item, count)
        TriggerClientEvent('ox_inventory:notify', source, {
            type = 'success',
            text = 'You dropped ' .. count .. ' ' .. item.label
        })
    end
end)

RegisterServerEvent('moderninventory:moveItem')
AddEventHandler('moderninventory:moveItem', function(fromSlot, toSlot)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.moveInventoryItem(fromSlot, toSlot)
    end
end)