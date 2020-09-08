xAdmin.Console = {}
xAdmin.Console.isConsole = true

function xAdmin.Console:GetUserGroup()
	return "Console"
end

function xAdmin.Console:GetGroupPower()
	return 9999
end

function xAdmin.Console:GetGroupTable()
	return {
		name = "Console",
		power = 9999
	}
end

function xAdmin.Console:IsAdmin()
	return true
end

function xAdmin.Console:IsSuperAdmin()
	return true
end

function xAdmin.Console:IsUserGroup(group)
	return true
end

function xAdmin.Console:HasPower(power)
	return true
end

function xAdmin.Console:Name()
	return "_Console"
end

function xAdmin.Console:Nick()
	return xAdmin.Console:Name()
end

function xAdmin.Console:SteamID()
	return "STEAM_0:0:00000000"
end

function xAdmin.Console:SteamID64()
	return "76561197960000000"
end
