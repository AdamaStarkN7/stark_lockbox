Config = {}

Config.debug = 'false' -- true or false

Config.radial = 'ox' -- supported: 'qb' or 'ox' -- default 'ox'

Config.inventory = 'ox' -- supported: 'qb', 'ps', or 'ox'

Config.lockboxSlots = 10 -- Recommended Value, Could Be Higher or Lower Depending On Server Needs

Config.lockboxWeight = 120000 -- Recommended Value, Could Be Higher or Lower Depending On Server Needs

Config.leoJobs = {
    'police',
    'lssd',
    -- add your server's police job here as found in qb-core/shared/jobs.lua
}

Config.leoJobTypes = {
    'leo',
    -- add your server's police job type here as found in qb-core/shared/jobs.lua
}