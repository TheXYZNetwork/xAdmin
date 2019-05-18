-- Ensure you go to xadmin/core/sv_db.lua and set up your SQL credentials
-- If you're running multiple servers, I also suggest going to autorun/xadmin_init.lua and setting up unique names for each server

-- Staff ranks
xAdmin.Core.RegisterGroup("superadmin", 100)
xAdmin.Core.RegisterGroup("senior-admin", 90)
xAdmin.Core.RegisterGroup("admin", 80)
xAdmin.Core.RegisterGroup("jr-admin", 70)
xAdmin.Core.RegisterGroup("senior-moderator", 60)
xAdmin.Core.RegisterGroup("moderator", 50)
xAdmin.Core.RegisterGroup("jr-mod", 40)
xAdmin.Core.RegisterGroup("trial-mod", 30)
-- Paid ranks
xAdmin.Core.RegisterGroup("VIP+", 20)
xAdmin.Core.RegisterGroup("vip", 10)
-- Base rank
xAdmin.Core.RegisterGroup("user", 0)


-- The default group
xAdmin.Config.DefaultGroup = "user"


-- The power level needed to be superadmin/admin
xAdmin.Config.Superadmin = 100
xAdmin.Config.Admin = 80


-- What power-level can see admin chat?
xAdmin.Config.AdminChat = 30
-- The color of admin chat
xAdmin.Config.AdminChatColor = Color(0,150,255)


-- The chat prefix
xAdmin.Config.Prefix = "!"


-- The ban message
xAdmin.Config.BanFormat = [[------------

-- Banned --
Banned by: %s
Time left: %s
Reason: %s

Feel you were false banned? Appeal it on the forums 
------------]]