/*=============
Permission Config
=============*/
-- This section of the config allows you to change what power levels
-- can access different permissions

-- Default Powerlevel for commands if one isnt provided when
-- registering the command
-- >>> ANY COMMAND FROM ANY ADDON WILL HAVE THIS POWERLEVEL UNLESS CHANGED BY THE BELOW TABLE <<<
xAdmin.Config.PowerLevelDefault = 100

-- to change what level can access Admin Chat see the option
-- 'xAdmin.Config.AdminChat' above!
-- Note: This also effects all aliases of the command
xAdmin.Config.PowerlevelPermissions = {

	-- Chat
	["mute"] 		= 50,
	["unmute"] 		= 50,
	["gag"] 		= 50,
	["ungag"] 		= 50,

	-- DarkRP
	["addmoney"] 	= 100,
	["removemoney"] = 100,
	["setmoney"] 	= 100,
	["setjob"] 		= 100,

	-- Dicipline
	["kick"] 		= 30,
	["ban"] 		= 40,
	["unban"] 		= 50,

	-- Fun
	["cloak"] 		= 40,
	["uncloak"] 	= 40,
	["freeze"] 		= 30,
	["unfreeze"] 	= 30,
	["setmodel"] 	= 100,

	-- Groups
	["setgroup"] 	= 100,
	["getgroup"] 	= 10,

	-- Misc
	["cleardecals"] = 40,
	["freezeprops"] = 50,
	["steamid"] 	= 0,

	-- Teleport
	["bring"]		= 30,
	["return"] 		= 30,
	["goto"] 		= 30,
	["revtp"] 		= 50,

	-- Util
	["noclip"] 		= 30,
	["health"] 		= 40,
	["armor"] 		= 50,
	["god"] 		= 40,
	["ungod"] 		= 40,
	["slay"] 		= 70,
	["revive"] 		= 50,
	["respawn"] 	= 70,
	["strip"] 		= 70,
	["give"] 		= 70,
	["help"]		= 0,

	-- Addon: xWarn --
	["warn"]		= 30,
	["warns"]		= 30,
	["mywarns"]		= 0,
	["deletewarn"]	= 40,

}