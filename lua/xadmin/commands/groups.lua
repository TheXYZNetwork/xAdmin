--- #
--- # SET USERGROUP
--- #
xAdmin.Core.RegisterCommand("setgroup", "Set a user's group", 100, function(admin, args)
	if not args or not args[1] or not args[2] then return end
	if not xAdmin.Groups[args[2]] then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), args[2].." is not a valid usergroup"}, admin)
		return
	end

	local target, targetPly = xAdmin.Core.GetID64(args[1], admin)
	if not target then 
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end

	xAdmin.Database.UpdateUsersGroup(target, xAdmin.Database.Escape(args[2]))

	if IsValid(targetPly) then
		xAdmin.Core.Msg({"Your usergroup has been updated to the following: "..args[2]}, targetPly)
		xAdmin.Core.Msg({"You have updated ", targetPly:GetName(), "'s usergroup to: "..args[2]}, admin)

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
		xAdmin.Core.Msg({"You have updated "..target.."'s usergroup to: "..args[2]}, admin)
	end
end)

--- #
--- # GET USERGROUP
--- #
xAdmin.Core.RegisterCommand("getgroup", "Get a user's group", 10, function(admin, args)
	if not args or not args[1] then return end
	local targetID, target = xAdmin.Core.GetID64(args[1], admin)
	if not targetID then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end

	if target then
		xAdmin.Core.Msg({target, "'s usergroup is: "..target:GetUserGroup()}, admin)
	else
		xAdmin.Database.GetUsersGroup(targetID, function(data)
			if not data[1] then
				xAdmin.Core.Msg({"No users found with the following ID: "..targetID}, admin)
				return
			end
			xAdmin.Core.Msg({targetID.."'s usergroup is: "..data[1].rank}, admin)
		end)
	end
end)