fx_version 'cerulean'
game 'gta5'

description 'Modern Inventory System'
version '1.0.0'

author 'Your Name'

dependency 'es_extended'

dependency 'ox_lib'

dependency 'ox_inventory'

dependency 'ox_target'

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

shared_scripts {
    'config.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/script.js',
    'html/style.css'
}