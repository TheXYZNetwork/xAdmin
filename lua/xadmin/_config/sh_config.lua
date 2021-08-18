/*=============
xAdmin Config
=============*/
-- Here is the config for xAdmin. You can create ranks, set needed power levels and even edit the ban message.
-- Ensure you go to xadmin/core/sv_db.lua and set up your SQL credentials. (This is only if you're using MYSQLoo)
	-- If you're running multiple servers, I also suggest going to autorun/xadmin_init.lua and setting up unique names for each server. Else they will share info.
-- You can find a "Getting Started" guide here: https://github.com/OwjoTheGreat/xadmin/wiki/Getting-Started
-- If you want to change the needed power level of the command you can find that in the xadmin/commands folder. See the above guide (Getting Started) for a detailed guide on how that works.


/*===========
Ranks Config
=============*/
-- These are the ranks that users can be. The first argument is the rank name, the 2nd is the power level and the 3rd is the prop limit set to nil for default value.

-- Staff ranks
xAdmin.Core.RegisterGroup("superadmin", 100, 100)
xAdmin.Core.RegisterGroup("admin", 80, 40)
xAdmin.Core.RegisterGroup("moderator", 50, 40)
-- Paid ranks
xAdmin.Core.RegisterGroup("vip+", 20, 35)
xAdmin.Core.RegisterGroup("vip", 10, 30)
-- Base rank
xAdmin.Core.RegisterGroup("user", 0, nil)

-- The default group that a user is given on first join.
xAdmin.Config.DefaultGroup = "user"

-- The power levels needed to be superadmin/admin
xAdmin.Config.Superadmin = 100 -- Superadmin
xAdmin.Config.Admin = 80 -- Admin

-- The power level that can see admin chat
xAdmin.Config.AdminChat = 30
-- The color of admin chat
xAdmin.Config.AdminChatColor = Color(0,150,255)
-- Color of the logs prefix
xAdmin.Config.ColorLog = Color(46, 170, 200)
-- Color of the logs (not the prefix)
xAdmin.Config.ColorLogText = Color(255, 255, 255)
-- Logs Prefix
xAdmin.Config.LogPrefix = "[xAdmin] "
-- Prop limit function
xAdmin.Config.PropLimit = true
xAdmin.Config.DefaultPropLimit = 25

-- The table prefix used when making the unique tables. If you're running multiple servers this should be unique else they will share data
xAdmin.Config.Name = "svr1"
-- The unique name of this server. This will be used as a unique identifier in the bans archive
xAdmin.Config.FullName = "Server 1"

/*=============
Physgun Config
=============*/
-- Master switch to disable / enable everything with Physgun in xAdmin
-- You are required to have this true even if you only have one of the
-- two features enabled!
xAdmin.Config.EnablePhysgunFeatures = true

-- Allow xAdmin to control staff picking people up with their physgun
xAdmin.Config.PhysgunEnablePeople = true
-- Power level that is allowed to pick people up with their physgun
xAdmin.Config.PhysgunPickupPlayerPowerlevel = 30

-- Allow xAdmin to control staff picking vehicles up with their physgun
xAdmin.Config.PhysgunEnableVehicle = true
xAdmin.Config.PhysgunPickupVehiclePowerlevel = 40

-- Dont allow people who are frozen to spawn props
xAdmin.Config.DisallowFrozenPropSpawning = true

-- Require people to be a certain staff job to pick people up
xAdmin.Config.PhysgunRequireJobToPickup = false
xAdmin.Config.PhysgunJobsRequired = {
	[TEAM_HOBO] = true,
}

/*=============
Notes Config
=============*/
-- Enable or disable the Note Features
xAdmin.Config.EnableNotesFeatures = true



/*=============
Permission Config
=============*/
-- This section of the config allows you to change what power levels
-- can access different permissions from the base xAdmin addon

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

}

/*===============
Formatting Config
=================*/

-- The chat prefix
xAdmin.Config.Prefix = "!"

-- PermaBan Length
xAdmin.Config.StrForPermBan = "Forever"

-- The ban message
-- Valid Variables:
-- {BANNED_BY} - Who banned you
-- {TIME_LEFT} - Time left in your ban
-- {REASON} - Reason
xAdmin.Config.BanFormat = [[--------------------------
--- You're Banned! ---
Banned by: {BANNED_BY}
Time left: {TIME_LEFT}
Reason: {REASON}

Appeal this punishment on our forums
--------------------------]]
