local libState = GetResourceState('ox_lib') -- Resource Dependency
local invState = GetResourceState('ox_inventory') -- Resource Dependency

local ox_inventory = exports.ox_inventory

-- Code Block is for Debugging Purposes Only
if libState == 'started' then
    print("ox_lib Has Started Successfully!")
else
    print("Specified Resource Missing/Not Started")
end

if invState == 'started' then
    print("ox_inventory Has Started Successfully!")
else
    print ("Specified Resource Missing/Not Started")
end

-- Define Stash
local lockbox = {
    id = 'leo_lockbox', -- Unique Name to ID stash in Database
    label = 'LEO Lockbox', -- Display Name
    slots = Config.lockboxSlots, -- User Defined Slots
    weight = Config.lockboxWeight, -- User Defined Weight
    owner = true, -- Gives each player their own unique stash
}

-- Setting Up A Custom Stash Outside of Ox Inventory
AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        ox_inventory:RegisterStash(lockbox.id, lockbox.label, lockbox.slots, lockbox.weight, lockbox.owner)
    end
end)