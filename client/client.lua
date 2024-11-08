local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Debug(QBCore.Functions.GetPlayerData().job)

function checkValidJob()
    for i, job in ipairs(Config.leoJobs) do
        if (QBCore.Functions.GetPlayerData().job.name == job) then
            return true
        end
    end
    return false
end

function checkValidJobType()
    for j, type in ipairs(Config.leoJobTypes) do
        if (QBCore.Functions.GetPlayerData().job.type == type ) then
            return true
        end
    end
    return false
end

local id = 'Open Lockbox'

-- default
lib.addRadialItem({
    {
        id = id,
        label = 'Lock Box',
        icon = 'lock',
        onSelect = function ()
            TriggerEvent('stark_lockbox:client:openLockBox')
        end
    }
})

-- Removes From Ox Lib Global Radial Menu If No LEO Job
-- if tostring(checkValidJob()) == 'false' or tostring(checkValidJobType()) == 'false' then
--     exports.ox_lib:removeRadialItem(id)
-- end

if Config.radial ~= 'ox' then
    exports.ox_lib:removeRadialItem(id)
end

if Config.radial == 'qb' then

    -- Removes From Ox Lib Global Radial Menu If User Wants QB Radial Functionality
    -- exports.ox_lib:removeRadialItem(id)

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
        if checkValidJob() or checkValidJobType() then
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

RegisterNetEvent('stark_lockbox:client:openLockBox', function ()
    local player = PlayerPedId()
    if IsPedInAnyPoliceVehicle(player) then
        if checkValidJob() or checkValidJobType() then
            local vehicle = GetVehiclePedIsIn(player, false)
            local id = GetVehicleNumberPlateText(vehicle)

            if Config.inventory == 'qb' then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "LEO Lockbox " .. id, {
                    maxweight = Config.lockboxWeight,
                    slots = Config.lockboxSlots
                })
                TriggerEvent("inventory:client:SetCurrentStash", "LEO Lockbox " .. id)
            elseif Config.inventory == 'ps' then
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