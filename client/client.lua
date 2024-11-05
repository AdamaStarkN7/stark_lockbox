local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = exports.ox_inventory

lib.addRadialItem(
    {
        {
            id = 'Open Lockbox',
            label = 'Lock Box',
            icon = 'lock',
            onSelect = function()
                TriggerEvent('stark_lockbox:client:openLockBox')
            end
        },
    }
)

RegisterNetEvent('stark_lockbox:client:openLockBox', function()
    local player = PlayerPedId()
    if IsPedInAnyVehicle(player) then
        if QBCore.Functions.GetPlayerData().job.name == 'police' or QBCore.Functions.GetPlayerData().job.name == 'lssd' then
            ox_inventory:openInventory('stash', 'leo_lockbox')
        else
            QBCore.Functions.Notify("You do not have an LEO job!", 'error', 5000)
        end
    else
        QBCore.Functions.Notify("You're not currently in a vehicle!", 'error', 5000)
    end
end)

if QBCore.Functions.GetPlayerData().job.name ~= 'police' or QBCore.Functions.GetPlayerData().job.name ~= 'lssd' then
    lib.removeRadialItem('Open Lockbox')
end