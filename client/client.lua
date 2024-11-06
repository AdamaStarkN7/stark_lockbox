local QBCore = exports['qb-core']:GetCoreObject()

function checkValidJob()
    for i, j in ipairs(Config.leoJobs) do
        if (QBCore.Functions.GetPlayerData().job.name == j) then
            return true
        end
    end
    return false
end

if Config.radial == 'qb' then

    local function addRadialLeoLockboxOption()
        local player = PlayerPedId()
        MenuItemId = exports['qb-radialmenu']:AddOption({
            id = 'open_lock_box',
            title = 'Open Lockbox',
            icon = 'lock',
            type = 'client',
            event = 'stark_lockbox:client:openLockBox',
            shouldClose = true
        }, MenuItemId)
    end

    local function updateRadial()
        local player = PlayerPedId()
        if checkValidJob() then
            if IsPedInAnyPoliceVehicle(player) then
                addRadialLeoLockboxOption()
            elseif MenuItemId ~= nil then
                exports['qb-radialmenu']:RemoveOption(MenuItemId)
                MenuItemId = nil
            end
        elseif MenuItemId ~= nil then
            exports['qb-radialmenu']:RemoveOption(MenuItemId)
            MenuItemId = nil
        end
    end

    RegisterNetEvent('qb-radialmenu:client:onRadialmenuOpen', function ()
        updateRadial()
    end)

end

if Config.radial == 'ox' then

    if checkValidJob() then
        lib.addRadialItem({
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
    else
        lib.removeRadialItem('Open Lockbox')
    end

end

RegisterNetEvent('stark_lockbox:client:openLockBox', function ()
    local player = PlayerPedId()
    if IsPedInAnyPoliceVehicle(player) then
        if checkValidJob() then
            if Config.inventory == 'qb' then
                local vehicle = GetVehiclePedIsIn(player, false)
                local id = GetVehicleNumberPlateText(vehicle)
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "LEO Lockbox " .. id, {
                    maxweight = Config.lockboxWeight,
                    slots = Config.lockboxSlots
                })
                TriggerEvent("inventory:client:SetCurrentStash", "LEO Lockbox " .. id)
            elseif Config.inventory == 'ps' then
                local vehicle = GetVehiclePedIsIn(player, false)
                local id = GetVehicleNumberPlateText(vehicle)
                TriggerServerEvent("ps-inventory:server:OpenInventory", "stash", "LEO Lockbox " .. id {
                    maxweight = Config.lockboxWeight,
                    slots = Config.lockboxSlots
                })
                TriggerEvent("ps-inventory:client:SetCurrentStash", "LEO Lockbox " ..  id)
            elseif Config.inventory == 'ox' then
                local ox_inventory = exports.ox_inventory
                ox_inventory:openInventory('stash', 'leo_lockbox')
            else
                QBCore.Functions.Notify("Your inventory script is not supported!", 'error', 5000)
            end
        else
            QBCore.Functions.Notify("You do not have an LEO job!", 'error', 5000)
        end
    else
        QBCore.Functions.Notify("You're not currently in a police vehicle!", 'error', 5000)
    end
end)