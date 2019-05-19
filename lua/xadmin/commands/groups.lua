--- #
--- # SET USERGROUP
--- #
xAdmin.Core.RegisterCommand("setgroup", "Set a user's group", 100, function(admin, args)
	if(!IsValid(admin)) then
		admin = xAdmin.Console
	end
	if not args or not args[1] then
		xAdmin.Core.Msg({"Please provide a valid target."}, admin)
		return
	end
	if(!args[2]) then
		xAdmin.Core.Msg({"Please provide a valid usergroup."}, admin)
		return
	end
	if(!xAdmin.Groups[args[2]]) then
		xAdmin.Core.Msg({Color(138,43,226), args[2], Color(255, 255, 255), " is not a valid usergroup."}, admin)
		return
	end

	local target, targetPly = xAdmin.Core.GetID64(args[1], admin)
	if not target then
		xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: ", Color(138,43,226), args[1]}, admin)
		return
	end

	xAdmin.Database.UpdateUsersGroup(target, xAdmin.Database.Escape(args[2]))

	if IsValid(targetPly) then
		xAdmin.Core.Msg({"Your usergroup has been updated to ", Color(138,43,226), args[2], Color(255, 255, 255), "."}, targetPly)
		xAdmin.Core.Log({admin, " updated the usergroup of ", targetPly, " to ", Color(138,43,226), args[2], Color(255, 255, 255), "."})

		xAdmin.Users[targetPly:SteamID64()] = args[2]

		if targetPly:HasPower(xAdmin.Config.AdminChat) then
			xAdmin.AdminChat[targetPly:SteamID64()] = targetPly
		else
			xAdmin.AdminChat[targetPly:SteamID64()] = nil
		end


		local commandCache = {}
		for k, v in pairs(xAdmin.Commands) do
			if targetPly:HasPower(v.power) then
				commandCache[v.command] = v.desc
			end
		end
		net.Start("xAdminNetworkCommands")
			net.WriteTable(commandCache)
		net.Send(targetPly)


		net.Start("xAdminNetworkIDRank")
			net.WriteString(targetPly:SteamID64())
			net.WriteString(xAdmin.Users[targetPly:SteamID64()])
		net.Broadcast()
	else
		xAdmin.Core.Log({admin, " updated the usergroup of ", Color(138,43,226), target, Color(255, 255, 255), " to ", Color(138,43,226), args[2], Color(255, 255, 255), "."})
	end
end)

--- #
--- # GET USERGROUP
--- #
xAdmin.Core.RegisterCommand("getgroup", "Get a user's group", 10, function(admin, args)
	if(!IsValid(admin)) then
		admin = xAdmin.Console
	end
	if not args or not args[1] then
		xAdmin.Core.Msg({"Please provide a valid target."}, admin)
		return
	end

	local targetID, target = xAdmin.Core.GetID64(args[1], admin)
	if not targetID then
		xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: ", Color(138,43,226), args[1]}, admin)
		return
	end

	if target then
		xAdmin.Core.Msg({"The usergroup of ", target, " is ", Color(138,43,226), target:GetUserGroup(), Color(255, 255, 255), "."}, admin)
	else
		xAdmin.Database.GetUsersGroup(targetID, function(data)
			if not data[1] then
				xAdmin.Core.Msg({"No users found with the following ID: "..targetID}, admin)
				return
			end
			xAdmin.Core.Msg({"The usergroup of ", Color(138,43,226), targetID, Color(255, 255, 255), " is ", Color(138,43,226), data[1].rank, Color(255, 255, 255), "."}, admin)
		end)
	end
end)