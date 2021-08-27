local ply = FindMetaTable("Player")

function ply:GetUserGroup()
	return xAdmin.Users[self:SteamID64()] or xAdmin.Config.DefaultGroup
end

function ply:GetGroupPower()
	return xAdmin.Groups[self:GetUserGroup()].power or 0
end

function ply:GetGroupTable()
	return xAdmin.Groups[self:GetUserGroup()] or xAdmin.Groups["user"]
end

function ply:IsAdmin()
	if self:GetGroupPower() >= xAdmin.Config.Admin then
		return true
	end

	return false
end

function ply:IsSuperAdmin()
	if self:GetGroupPower() >= xAdmin.Config.Superadmin then
		return true
	end

	return false
end

function ply:IsUserGroup(group)
	return (self:GetUserGroup() == group)
end

function ply:HasPower(power)
	return self:GetGroupPower() >= power
end

function ply:SetUserGroup(group)
	if CLIENT then return false end
	if (group == xAdmin.Config.DefaultGroup) then return end

	if CAMI then
		CAMI.SignalUserGroupChanged(self, xAdmin.Users[self:SteamID64()], group, "xAdminGithub")
	end

	xAdmin.Users[self:SteamID64()] = group

	if self:HasPower(xAdmin.Config.AdminChat) then
		xAdmin.AdminChat[self:SteamID64()] = self
	else
		xAdmin.AdminChat[self:SteamID64()] = nil
	end

	local commandCache = {}
	for k, v in pairs(xAdmin.Commands) do
		if self:HasPower(v.power) then
			commandCache[v.command] = v.desc
		end
	end

	net.Start("xAdminNetworkCommands")
	net.WriteTable(commandCache)
	net.Send(self)
	net.Start("xAdminNetworkIDRank")
	net.WriteString(self:SteamID64())
	net.WriteString(xAdmin.Users[self:SteamID64()])
	net.Broadcast()

	xAdmin.Database.UpdateUsersGroup(self:SteamID64(), xAdmin.Database.Escape(group))
end
