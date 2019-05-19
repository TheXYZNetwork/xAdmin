-- Setup
if(xAdmin.Config.UseSQLoo == true) then
	require("mysqloo")
end
function xAdmin.Database.Query(q, callback)
	if(xAdmin.Config.UseSQLoo == true) then
		local query = xAdmin.Database.Connection:query(q)
		query.onSuccess = function( q, data)
			if callback then
				callback(data,q)
			end
		end
		query:start()
	else
		local Query = sql.Query(q)
		if(Query == false) then
			xAdmin.Core.Print({Color(255, 0, 0), "FATAL ERROR: ", Color(255, 255, 255), "Error while executing SQLite Query (Query returned false). SQL:"})
			xAdmin.Core.Print({q})
			xAdmin.Core.Print({"Still returning query..."})
		end
		if(callback) then
			local data = Query
			if(Query == nil) then
				data = {}
			end
			callback(data, q)
		end
	end
end

function xAdmin.Database.Connect()
	if(xAdmin.Config.UseSQLoo == true) then
		-- MySQLoo
		if xAdmin.Database.Connection then return end
		xAdmin.Database.Connection = mysqloo.connect(xAdmin.Config.SQLoo["host"], xAdmin.Config.SQLoo["username"], xAdmin.Config.SQLoo["password"], xAdmin.Config.SQLoo["database"], 3306) -- If you're running multiple servers it is suggested that xAdmin has it's own database that all the server's use for just xAdmin. That way they can share the ban_archive for things like ban walls
		xAdmin.Database.Connection.onConnected = function()
			xAdmin.Core.Print({"========================="})
			xAdmin.Core.Print({"xAdmin database connected"})
			xAdmin.Core.Print({"========================="})
			xAdmin.Core.Print({"Checking and creating the following tables:"})

			xAdmin.Core.Print({Color(188, 188, 188), xAdmin.Info.Name.."_active_bans"})
			xAdmin.Database.Query("CREATE TABLE IF NOT EXISTS "..xAdmin.Info.Name.."_active_bans(userid VARCHAR(32) NOT NULL PRIMARY KEY, user TEXT NOT NULL, adminid VARCHAR(32) NOT NULL, admin TEXT NOT NULL, reason TEXT NOT NULL, start INT(11) NOT NULL, _end INT(11) NOT NULL)")

			xAdmin.Core.Print({Color(188, 188, 188), xAdmin.Info.Name.."_users"})
			xAdmin.Database.Query("CREATE TABLE IF NOT EXISTS "..xAdmin.Info.Name.."_users(userid VARCHAR(32) NOT NULL PRIMARY KEY, rank TEXT NOT NULL)")

			xAdmin.Core.Print({Color(188, 188, 188), "xadmin_ban_archive"})
			xAdmin.Database.Query("CREATE TABLE IF NOT EXISTS xadmin_ban_archive(id INT(11) NOT NULL AUTO_INCREMENT, userid VARCHAR(32) NOT NULL, user TEXT NOT NULL, adminid VARCHAR(32) NOT NULL, admin TEXT NOT NULL, reason TEXT NOT NULL, server TEXT NOT NULL, start INT(11) NOT NULL, end INT(11) NOT NULL)")
		end
		xAdmin.Database.Connection.onConnectionFailed = function(db, sqlerror)
			xAdmin.Core.Print({"========================="})
			xAdmin.Core.Print({"xAdmin database failed:"})
			for i=1,10 do
				xAdmin.Core.Print(sqlerror)
			end
			xAdmin.Core.Print({"========================="})
		end
		xAdmin.Database.Connection:connect()
	else
		-- SQLite. No need for SQLoo or Server Names.
		xAdmin.Core.Print({"Checking/Creating the following tables:"})
		xAdmin.Core.Print({Color(188, 188, 188), "active_bans"})
		if(!sql.TableExists(xAdmin.Info.Name.."_active_bans")) then
			xAdmin.Database.Query("CREATE TABLE "..xAdmin.Info.Name.."_active_bans(userid VARCHAR(32) NOT NULL PRIMARY KEY, user TEXT NOT NULL, adminid VARCHAR(32) NOT NULL, admin TEXT NOT NULL, reason TEXT NOT NULL, start INT(11) NOT NULL, _end INT(11) NOT NULL)")
		end

		xAdmin.Core.Print({Color(188, 188, 188), "users"})
		if(!sql.TableExists(xAdmin.Info.Name.."_users")) then
			xAdmin.Database.Query("CREATE TABLE "..xAdmin.Info.Name.."_users(userid VARCHAR(32) NOT NULL PRIMARY KEY, rank TEXT NOT NULL)")
		end

		xAdmin.Core.Print({Color(188, 188, 188), "xadmin_ban_archive"})
		if(!sql.TableExists("xadmin_ban_archive")) then
			xAdmin.Database.Query("CREATE TABLE xadmin_ban_archive(id INTEGER primary key AUTOINCREMENT, userid VARCHAR(32), user TEXT, adminid VARCHAR(32), admin TEXT, reason TEXT, server TEXT, start INT, end INT)")
		end
	end
end
xAdmin.Database.Connect()

function xAdmin.Database.Escape(str)
	if(xAdmin.Config.UseSQLoo == true) then
		return xAdmin.Database.Connection:escape(str)
	else
		return sql.SQLStr(str, true)
	end
end

-- Use functions
function xAdmin.Database.UpdateUsersGroup(userid, rank)
	local Query = string.format("INSERT INTO %s_users(userid, rank) VALUES('%s', '%s') ON CONFLICT(userid) DO UPDATE SET rank = '%s';", xAdmin.Info.Name, userid, rank, rank)
	if(xAdmin.Config.UseSQLoo == true) then
		Query = string.format("INSERT INTO %s_users (userid, rank) VALUES ('%s', '%s') ON DUPLICATE KEY UPDATE rank='%s';", xAdmin.Info.Name, userid, rank, rank)
	end
	xAdmin.Database.Query(Query)
end
function xAdmin.Database.GetUsersGroup(userid, callback)
	xAdmin.Database.Query(string.format("SELECT * FROM %s_users WHERE userid='%s';", xAdmin.Info.Name, userid), callback)
end


-- Ban functions
function xAdmin.Database.CreateBan(userid, user, adminid, admin, reason, tEnd)
	local Query = string.format("INSERT INTO %s_active_bans (userid, user, adminid, admin, reason, start, _end) VALUES ('%s', '%s', '%s', '%s', '%s', %s, %s) ON CONFLICT(userid) DO UPDATE SET adminid='%s', admin='%s', reason='%s', start=%s, _end=%s;", xAdmin.Info.Name, userid, user or "Unknown", adminid, admin or "Console", reason or "No reason given", os.time(), tEnd, adminid, admin or "Console", reason or "No reason given", os.time(), tEnd)
	if(xAdmin.Config.UseSQLoo == true) then
		Query = string.format("INSERT INTO %s_active_bans (userid, user, adminid, admin, reason, start, _end) VALUES ('%s', '%s', '%s', '%s', '%s', %s, %s) ON DUPLICATE KEY UPDATE adminid='%s', admin='%s', reason='%s', start=%s, _end=%s;", xAdmin.Info.Name, userid, user or "Unknown", adminid, admin or "Console", reason or "No reason given", os.time(), tEnd, adminid, admin or "Console", reason or "No reason given", os.time(), tEnd)
	end
	xAdmin.Database.Query(Query)
	xAdmin.Database.Query(string.format("INSERT INTO xadmin_ban_archive (userid, user, adminid, admin, reason, server, start, end) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', %s, %s);", userid, xAdmin.Database.Escape(user) or "Unknown", adminid, xAdmin.Database.Escape(admin) or "Console", xAdmin.Database.Escape(reason) or "No reason given", xAdmin.Info.FullName, os.time(), tEnd))
end

function xAdmin.Database.DestroyBan(userid)
	xAdmin.Database.Query(string.format("DELETE FROM %s_active_bans WHERE userid='%s';", xAdmin.Info.Name, userid))
end

function xAdmin.Database.IsBanned(userid, callback)
	xAdmin.Database.Query(string.format("SELECT * FROM %s_active_bans WHERE userid='%s';", xAdmin.Info.Name, userid), callback)
end