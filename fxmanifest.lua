fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'wx / woox'
description 'Simple, target based vehicle washing/repairing system'

version '1.0.0'

server_script {
	'server/*.lua'
}

client_scripts {
	'client/*.lua'
}

shared_scripts {'@ox_lib/init.lua','configs/*.lua'}
