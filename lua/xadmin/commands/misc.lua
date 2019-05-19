--- #
--- # CLEARDECALS
--- #
xAdmin.Core.RegisterCommand("cleardecals", "Clears all users decals", 40, function(admin, args)
	if(!IsValid(admin)) then
		admin = xAdmin.Console
	end
	
	for k, v in pairs(player.GetAll()) do
		v:ConCommand("r_cleardecals\n")
	end
	xAdmin.Core.Log({admin, " has cleared all decals."})
end)

--- #
--- # FREEZEPROPS
--- #
xAdmin.Core.RegisterCommand("freezeprops", "Freezes all props on the map", 50, function(admin, args)
	if(!IsValid(admin)) then
		admin = xAdmin.Console
	end

	for k, v in pairs(ents.FindByClass("prop_physics")) do
		if v:IsValid() and v:IsInWorld() then
			print(k, v)
			v:GetPhysicsObject():EnableMotion(false)
		end
	end
	xAdmin.Core.Log({admin, " has frozen all props on the map."})
end)

--- #
--- # STEAMID
--- #
xAdmin.Core.RegisterCommand("steamid", "Gets a user's SteamID32 and SteamID64.", 0, function(admin, args)
	if(!IsValid(admin)) then
		admin = xAdmin.Console
	end
	if not args or not args[1] then
		xAdmin.Core.Msg({"Please provide a valid target."}, admin)
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: ", Color(138,43,226), args[1]}, admin)
		return
	end

	xAdmin.Core.Msg({"The SteamID of ", target, " is ", Color(138,43,226), target:SteamID(), Color(255, 255, 255), "."}, admin)
	xAdmin.Core.Msg({"The SteamID64 of ", target, " is ", Color(138,43,226), target:SteamID64(), Color(255, 255, 255), "."}, admin)
end)
xAdmin.Core.RegisterCommand("sid", "Alias of steamid", 0, function(admin, args)
	xAdmin.Commands["steamid"].func(admin, args)
end)
xAdmin.Core.RegisterCommand("id", "Alias of steamid", 0, function(admin, args)
	xAdmin.Commands["steamid"].func(admin, args)
end)