-- Setup
require("mysqloo")


xAdmin.Database.UseMySQL = false
xAdmin.Database.Cerds = {}
xAdmin.Database.Cerds.ip = "1.1.1.1"
xAdmin.Database.Cerds.user = "user"
xAdmin.Database.Cerds.password = "Pa$$W0rd"
xAdmin.Database.Cerds.database = "xadmin_master"
xAdmin.Database.Cerds.port = 3306

function xAdmin.Database.Connect()
	if xAdmin.Database.UseMySQL then
		if xAdmin.Database.Connection then
			return
		end
	
		xAdmin.Database.Connection = mysqloo.connect(xAdmin.Database.Cerds.ip, xAdmin.Database.Cerds.user, xAdmin.Database.Cerds.password, xAdmin.Database.Cerds.database, xAdmin.Database.Cerds.port)
	
		xAdmin.Database.Connection.onConnected = function()
			print("=========================")
			print("xAdmin database connected")
			print("=========================")
			print("Checking and creating the following tables:")
			print(xAdmin.Info.Name .. "_active_bans")
			xAdmin.Database.Query("CREATE TABLE IF NOT EXISTS " .. xAdmin.Info.Name .. "_active_bans(userid VARCHAR(32) NOT NULL PRIMARY KEY, user TEXT NOT NULL, adminid VARCHAR(32) NOT NULL, admin TEXT NOT NULL, reason TEXT NOT NULL, start INT(11) NOT NULL, duration INT(11) NOT NULL)")
			print(xAdmin.Info.Name .. "_users")
			xAdmin.Database.Query("CREATE TABLE IF NOT EXISTS " .. xAdmin.Info.Name .. "_users(userid VARCHAR(32) NOT NULL PRIMARY KEY, `rank` TEXT NOT NULL)")
			print("xadmin_ban_archive")
			xAdmin.Database.Query("CREATE TABLE IF NOT EXISTS xadmin_ban_archive(id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, userid VARCHAR(32) NOT NULL, user TEXT NOT NULL, adminid VARCHAR(32) NOT NULL, admin TEXT NOT NULL, reason TEXT NOT NULL, server TEXT NOT NULL, start INT(11) NOT NULL, duration INT(11) NOT NULL)")
		end
	
		xAdmin.Database.Connection.onConnectionFailed = function(db, sqlerror)
			print("=========================")
			print("xAdmin database failed:")
	
			for i = 1, 10 do
				print(sqlerror)
			end
	
			print("=========================")
		end
	
		xAdmin.Database.Connection:connect()
	else
		print("=====================")
		print("xAdmin database setup")
		print("=====================")
		print("Checking and creating the following tables:")
		xAdmin.Info.Name = "xadmin"

		if not sql.TableExists("xadmin_active_bans") then
			print("xadmin_active_bans")
			sql.Query("CREATE TABLE IF NOT EXISTS xadmin_active_bans(userid VARCHAR(32) NOT NULL PRIMARY KEY, user TEXT NOT NULL, adminid VARCHAR(32) NOT NULL, admin TEXT NOT NULL, reason TEXT NOT NULL, start INT(11) NOT NULL, duration INT(11) NOT NULL)")
		end
		if not sql.TableExists("xadmin_users") then
			print("xadmin_users")
			sql.Query("CREATE TABLE IF NOT EXISTS xadmin_users(userid VARCHAR(32) NOT NULL PRIMARY KEY, `rank` TEXT NOT NULL)")
		end
		if not sql.TableExists("xadmin_ban_archive") then
			print("xadmin_ban_archive")
			sql.Query("CREATE TABLE IF NOT EXISTS xadmin_ban_archive(id INTEGER PRIMARY KEY AUTOINCREMENT, userid VARCHAR(32) NOT NULL, user TEXT NOT NULL, adminid VARCHAR(32) NOT NULL, admin TEXT NOT NULL, reason TEXT NOT NULL, server TEXT NOT NULL, start INT(11) NOT NULL, duration INT(11) NOT NULL)")
		end
	end
end

xAdmin.Database.Connect()

function xAdmin.Database.Query(q, callback)
	if xAdmin.Database.UseMySQL then
		local query = xAdmin.Database.Connection:query(q)
	
		query.onSuccess = function(q, data)
			if callback then
				callback(data, q)
			end
		end
	
		query:start()
	else
		local query = sql.Query(q)
		if callback then
			callback(query)
		end
	end
end

function xAdmin.Database.Escape(str)
	if xAdmin.Database.UseMySQL then
		return xAdmin.Database.Connection:escape(str)
	else
		return sql.SQLStr(str, true)
	end
end

-- Use functions
function xAdmin.Database.UpdateUsersGroup(userid, rank)
	-- 
	if xAdmin.Database.UseMySQL then
		xAdmin.Database.Query(string.format("INSERT INTO %s_users (userid, `rank`) VALUES ('%s', '%s') ON DUPLICATE KEY UPDATE `rank`='%s';", xAdmin.Info.Name, userid, xAdmin.Database.Escape(rank), xAdmin.Database.Escape(rank)))
	else
		xAdmin.Database.Query(string.format("INSERT OR REPLACE INTO xadmin_users (userid, `rank`) VALUES ('%s', '%s');", userid, xAdmin.Database.Escape(rank)))
	end
end

function xAdmin.Database.GetUsersGroup(userid, callback)
	xAdmin.Database.Query(string.format("SELECT * FROM %s_users WHERE userid='%s';", xAdmin.Info.Name, userid), callback)
end

-- Ban functions
function xAdmin.Database.CreateBan(userid, user, adminid, admin, reason, tEnd)
	if xAdmin.Database.UseMySQL then
		xAdmin.Database.Query(string.format("INSERT INTO %s_active_bans (userid, user, adminid, admin, reason, start, duration) VALUES ('%s', '%s', '%s', '%s', '%s', %s, %s) ON DUPLICATE KEY UPDATE adminid='%s', admin='%s', reason='%s', start=%s, duration=%s;", xAdmin.Info.Name, userid, xAdmin.Database.Escape(user) or "Unknown", adminid, xAdmin.Database.Escape(admin) or "Console", xAdmin.Database.Escape(reason) or "No reason given", os.time(), tEnd, adminid, xAdmin.Database.Escape(admin) or "Console", xAdmin.Database.Escape(reason) or "No reason given", os.time(), tEnd))
	else
		xAdmin.Database.Query(string.format("INSERT OR REPLACE INTO %s_active_bans (userid, user, adminid, admin, reason, start, duration) VALUES ('%s', '%s', '%s', '%s', '%s', %s, %s);", xAdmin.Info.Name, userid, xAdmin.Database.Escape(user) or "Unknown", adminid, xAdmin.Database.Escape(admin) or "Console", xAdmin.Database.Escape(reason) or "No reason given", os.time(), tEnd))
	end

	xAdmin.Database.Query(string.format("INSERT INTO xadmin_ban_archive (userid, user, adminid, admin, reason, server, start, duration) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', %s, %s);", userid, xAdmin.Database.Escape(user) or "Unknown", adminid, xAdmin.Database.Escape(admin) or "Console", xAdmin.Database.Escape(reason) or "No reason given", xAdmin.Info.FullName, os.time(), tEnd))
end

function xAdmin.Database.DestroyBan(userid)
	xAdmin.Database.Query(string.format("DELETE FROM %s_active_bans WHERE userid='%s';", xAdmin.Info.Name, userid))
end

function xAdmin.Database.IsBanned(userid, callback)
	xAdmin.Database.Query(string.format("SELECT * FROM %s_active_bans WHERE userid='%s';", xAdmin.Info.Name, userid), callback)
end
