--[[
********************************************************************
CONTACT: Garou
********************************************************************
Github: https://github.com/qarou
Discord: Garou#0190
Discord Server: https://discord.gg/VkJ6tT5
********************************************************************
]]

fx_version 'adamant'

game 'gta5' 

version '1.0.0' 

description 'Car thief job by Garou'

client_scripts {
	"config.lua",
	"client/functions.lua",
	"client/main.lua",
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"config.lua",
	"server/main.lua"
}