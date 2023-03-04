fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'alx_joblisting'

client_scripts {
  'client/**.lua'
}

server_scripts {
  'server/**.lua'
}

shared_scripts {
  'configs/**.lua',
  '@ox_lib/init.lua'
}
