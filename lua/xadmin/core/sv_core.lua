hook.Add("PlayerInitialSpawn", "xAdminLoadPlayerRank", function(ply)
	xAdmin.Database.GetUsersGroup(ply:SteamID64(), function(data)
		if not data or not data[1] then
			xAdmin.Database.UpdateUsersGroup(ply:SteamID64(), xAdmin.Config.DefaultGroup)
			xAdmin.Users[ply:SteamID64()] = xAdmin.Config.DefaultGroup
		else
			xAdmin.Users[ply:SteamID64()] = data[1].rank
		end

		net.Start("xAdminNetworkIDRank")
			net.WriteString(ply:SteamID64())
			net.WriteString(xAdmin.Users[ply:SteamID64()])
		net.Broadcast()


		net.Start("xAdminNetworkExistingUsers")
			net.WriteTable(xAdmin.Users)
		net.Send(ply)

		if ply:HasPower(xAdmin.Config.AdminChat) then
			xAdmin.AdminChat[ply:SteamID64()] = ply
		end


		local commandCache = {}
		for k, v in pairs(xAdmin.Commands) do
			if ply:HasPower(v.power) then
				commandCache[v.command] = v.desc
			end
		end
		net.Start("xAdminNetworkCommands")
			net.WriteTable(commandCache)
		net.Send(ply)
	end)
end)

hook.Add("PlayerDisconnected", "xAdminDisconnectPlayerRank", function(ply)
	xAdmin.Users[ply:SteamID64()] = nil
	xAdmin.AdminChat[ply:SteamID64()] = nil
end)

function xAdmin.Core.GetUser(info, admin)
	if info == "" then
		return nil
	end
	
	if IsValid(admin) then
		if info == "^" then
			return admin
		end
	end

	if IsValid(admin) then
		if info == "@" then
			local target = admin:GetEyeTrace().Entity
			if target:IsPlayer() then
				return target
			end
		end
	end

	local isID
	if not (util.SteamIDFrom64(info) == "STEAM_0:0:0") then
		isID = info
	else
		isID = util.SteamIDTo64(info)
	end
	if not (isID == "0") then
		return player.GetBySteamID64(isID)
	end


	info = string.Replace(info, "\"", "")
	for k, v in pairs(player.GetAll()) do
		if string.find(string.lower(v:Name()), string.lower(info)) then
			return v
		end
	end

	return nil
end

function xAdmin.Core.GetID64(info, admin)
	if IsValid(admin) then
		if info == "^" then
			return admin:SteamID64(), admin
		end
	end

	local isID
	if not (util.SteamIDFrom64(info) == "STEAM_0:0:0") then
		isID = info
	else
		isID = util.SteamIDTo64(info)
	end
	if not (isID == "0") then
		return isID, player.GetBySteamID64(isID)
	end

	info = string.Replace(info, "\"", "")
	for k, v in pairs(player.GetAll()) do
		if string.find(string.lower(v:Name()), string.lower(info)) then
			return v:SteamID64(), v
		end
	end

	return nil
end

function xAdmin.Core.FormatArguments(args)
	local startk, endk
	for k, v in pairs(args) do
		if (v[1] == "\"") then
			startk = k
		elseif (startk and v[#v] == "\"") then
			endk = k
			break
		end
	end

	if (startk and endk) then
		args[startk] = string.sub(table.concat(args, " ", startk, endk), 2, -2)
		local num = endk - startk
		for i=1, num do
			table.remove(args, startk + 1)
		end
		
		args = xAdmin.Core.FormatArguments(args)
	end
	
	return args
end

function xAdmin.Core.Msg(args, target)
	for k, v in pairs(args) do
		if istable(v) and v.isConsole then
			args[k]= v:Name()
			table.insert(args, k, Color(0, 0, 0))
			table.insert(args, k+2, Color(215, 215, 215))
		end
	end
	net.Start("xAdminChatMessage")
		net.WriteTable(args)
	if target then
		net.Send(target)
	else
		net.Broadcast()
	end
end