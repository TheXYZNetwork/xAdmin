--- #
--- # CLEARDECALS
--- #
xAdmin.Core.RegisterCommand("cleardecals", "Clears all users decals", 40, function(admin, args)
	for k, v in pairs(player.GetAll()) do
		v:ConCommand("r_cleardecals\n")
	end

	xAdmin.Core.Msg({admin, " has cleared all decals"})
end)

--- #
--- # FREEZEPROPS
--- #
xAdmin.Core.RegisterCommand("freezeprops", "Freezes all props on the map", 50, function(admin, args)
	for _, v in pairs(ents.FindByClass("prop_physics")) do
		if v:IsValid() and v:IsInWorld() then
			v:GetPhysicsObject():EnableMotion(false)
		end
	end

	xAdmin.Core.Msg({admin, " has frozen all props"})
end)

--- #
--- # STEAMID
--- #
xAdmin.Core.RegisterCommand("steamid", "Gets a user's SteamID64", 0, function(admin, args)
	if not args or not args[1] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, "[xAdmin] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	xAdmin.Core.Msg({target, "'s SteamID: " .. target:SteamID64()}, admin)
end)

xAdmin.Core.RegisterCommand("sid", "Alias of steamid", 0, function(admin, args)
	xAdmin.Commands["steamid"].func(admin, args)
end)

xAdmin.Core.RegisterCommand("id", "Alias of steamid", 0, function(admin, args)
	xAdmin.Commands["steamid"].func(admin, args)
end)
