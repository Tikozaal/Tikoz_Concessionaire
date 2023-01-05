fx_version('cerulean')
games({ 'gta5' })

shared_script('config.lua');

server_scripts({
    "server.lua",
    '@mysql-async/lib/MySQL.lua'
});

client_scripts({
    "dependencies/pmenu.lua",
    "client.lua"
});