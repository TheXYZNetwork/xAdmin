local ply = FindMetaTable("Player")

function ply:GetUserGroup()
	return xAdmin.Users[self:SteamID64()] or "user"
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

function ply:SetUserGroup()
end