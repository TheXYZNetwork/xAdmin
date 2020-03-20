-- We've resorted to using the source "xAdminGithub" to prevent conflict from gmodstore xAdmin
hook.Add("PostGamemodeLoaded", "xAdminLoadCAMISupport", function()
	-- Register already existing groups
	for k, v in pairs(CAMI.GetUsergroups()) do
		if xAdmin.Groups[v.Name] then return end
		xAdmin.Core.RegisterGroup(v.Name, xAdmin.Core.GetGroupPower(v.Inherits), 0)
	end

	-- Register groups
	for k, v in pairs(xAdmin.Groups) do
		CAMI.RegisterUsergroup({Name = v.name, Inherits = xAdmin.Config.DefaultGroup}, "xAdminGithub")
	end
end)

hook.Add("CAMI.OnUsergroupRegistered", "xAdminCAMIOnUsergroupRegistered", function(usergroup, source)
	if source == "xAdminGithub" then return end -- Don't need to do this for our own addon
	if xAdmin.Groups[usergroup.Name] then return end -- Group already registered

	xAdmin.Core.RegisterGroup(usergroup.Name, 0, xAdmin.Config.DefaultPropLimit)
end)

-- xAdmin doesn't really do "group removal" like this, so I can't promise this will work very well
hook.Add("CAMI.OnUsergroupUnregistered", "xAdminCAMIOnUsergroupUnregistered", function(usergroup, source)
	if source == "xAdminGithub" then return end -- Don't need to do this for our own addon
	if not xAdmin.Groups[usergroup.Name] then return end -- Check the group actually exists

	xAdmin.Groups[usergroup.Name] = nil -- Yuck
end)

hook.Add("CAMI.PlayerUsergroupChanged", "xAdminCAMIPlayerUsergroupChanged", function(ply, old, new, source)
	if source == "xAdminGithub" then return end -- Don't need to do this for our own addon
	if not IsValid(ply) then return end -- Validate the player is still in the server

	ply:SetUserGroup(new)
end)