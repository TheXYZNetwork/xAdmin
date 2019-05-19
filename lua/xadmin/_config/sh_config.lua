--[[--------------------------
--   XAdmin Configuration   --
]]----------------------------


--[[--------------------------
--    MySQL Configuration   --
]]----------------------------

-- If you are using a custom SQL database, enable this. If you are using multiple servers, goto lua/autorun/xadmin_init.lua and goto line 14.
xAdmin.Config.UseSQLoo = false

-- If above is true, then what credentials to use?
xAdmin.Config.SQLoo = {}
xAdmin.Config.SQLoo["host"] = "localhost" -- Host
xAdmin.Config.SQLoo["username"] = "root" -- Username
xAdmin.Config.SQLoo["pass"] = "supersecretpassword" -- Password
xAdmin.Config.SQLoo["database"] = "xadmin_master" -- Database Name



--[[--------------------------
--    Admin Configuration   --
]]----------------------------

-- To add a group, it's:
-- xAdmin.Core.RegisterGroup("GroupName", powerlevel)

-- Staff ranks.
xAdmin.Core.RegisterGroup("superadmin", 100)
xAdmin.Core.RegisterGroup("senior-admin", 90)
xAdmin.Core.RegisterGroup("admin", 80)
xAdmin.Core.RegisterGroup("jr-admin", 70)
xAdmin.Core.RegisterGroup("senior-moderator", 60)
xAdmin.Core.RegisterGroup("moderator", 50)
xAdmin.Core.RegisterGroup("jr-mod", 40)
xAdmin.Core.RegisterGroup("trial-mod", 30)
-- Paid ranks.
xAdmin.Core.RegisterGroup("VIP+", 20)
xAdmin.Core.RegisterGroup("vip", 10)
-- Base rank.
xAdmin.Core.RegisterGroup("user", 0)

-- The default group to set a player once they join.
xAdmin.Config.DefaultGroup = "user"

-- The power level needed to be superadmin/admin.
xAdmin.Config.Superadmin = 100 -- Superadmin
xAdmin.Config.Admin = 80 -- Admin

-- The power level your group needs to be above to see/use the Admin Chat.
xAdmin.Config.AdminChat = 30

-- The chat prefix for commands.
xAdmin.Config.Prefix = "!"



--[[--------------------------
--   Visual Configuration   --
]]----------------------------

-- The color of admin chat text.
xAdmin.Config.AdminChatColor = Color(46, 170, 200)

-- The ban message. %s order: Admin, Time Left, Reason.
xAdmin.Config.BanFormat = [[------------

-- Banned --
Banned by: %s
Time left: %s
Reason: %s

Feel you were false banned? Appeal it on the forums
------------]]
