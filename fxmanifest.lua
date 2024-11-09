fx_version 'cerulean'

lua54 'yes'

game 'gta5'

name 'stark_lockbox'

author 'Adam Biegert'

version '1.0.2'

description 'LEO Lockbox Script'

dependencies {
    'qb-radialmenu',
    -- 'qb-inventory',
    -- 'ps-inventory',
    'ox_lib', -- Can be commented out or removed if you don't want to use Ox
    'ox_inventory', -- Can be commented out or removed if you don't want to use Ox
}

shared_scripts {
    '@qb-core/shared/locale.lua',
    'config.lua',
    '@ox_lib/init.lua' -- Can be commented out or removed if you don't want to use Ox
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}