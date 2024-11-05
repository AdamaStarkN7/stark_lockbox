fx_version 'cerulean'

lua54 'yes'

game 'gta5'

name 'stark_lockbox'

author 'Adam Biegert'

version '1.0'

description 'LEO Lockbox Script for Ox Inventory'

dependencies {
    'ox_lib',
    'ox_inventory',
}

shared_scripts {
    '@qb-core/shared/locale.lua',
    'config.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}