fx_version 'bodacious'
game 'gta5'
author 'dullpear'
version '1.0.0'
description 'Scenes for your roleplay!'

--[[
	    __
     __| |	__		This is my third major release, having seen this type of thing in action on another roleplay server and loving it,
    / _` | '_ \		I decided to give it a shot of making a version with a few more features, allowing for more scenarios to be able to be created.
   | (_| | |_) |	All of the fonts were downloaded from Dafont, and i tried my best to check them all to make sure they are free to use.
    \__,_| .__/		If you made one of the fonts and are not okay with it being on here please contact me.
         |_|			
					As stated in the forum thread, if you have any suggestions feel free to dm me, any bugs make a issue on the github page.
					Especially if you have suggestion to make the SQL parts better, still having trouble wrapping my head around that stuff.
					
					Credits to TheFamilyRP to being the inspiration for this resource.
]]--

client_scripts {
	'Client/Functions.lua',
	'Locale/*.lua',
	'Client/Fonts.lua',
	'Client/Controls.lua',
	'Client/GUI.lua',
	'Client/Scenes.lua',
	'Client/Events.lua',
	'Client/Framework.lua'
}

shared_scripts {
	'Config.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'Server/Functions.lua',
	'Locale/*.lua',
	'Server/Database.lua',
	'Server/Sql.lua',
	'Server/Kvp.lua',
	'Server/Scenes.lua',
}