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
		if string.find(string.lower(v:Name()), string.lower(info), nil, true) then
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

-- I stole this from somewhere but I honestly can't find where. If you were the original creator of this snippet OR know where it's from, please contact me in any way possible <3
function xAdmin.Core.FormatArguments(args)
	local Start, End = nil, nil

	for k, v in pairs(args) do
		if (string.sub(v, 1, 1) == "\"") then
			Start = k
		elseif Start and (string.sub(v, string.len(v), string.len(v)) == "\"") then
			End = k
			break
		end
	end

	if Start and End then
		args[Start] = string.Trim(table.concat(args, " ", Start, End), "\"")

		for i = 1, (End - Start) do
			table.remove(args, Start + 1)
		end

		args = xAdmin.Core.FormatArguments(args)
	end

	return args
end

function xAdmin.Core.Msg(args, target)
	for k, v in pairs(args) do
		if istable(v) and v.isConsole then
			args[k] = v:Name()
			table.insert(args, k, xAdmin.Config.ColorConsole)
			table.insert(args, k + 2, Color(215, 215, 215))
		end
	end

	table.insert(args, 1, xAdmin.Config.ColorLogText)
	net.Start("xAdminChatMessage")
	net.WriteTable(args)

	if target then
		net.Send(target)
	else
		net.Broadcast()
	end

	if IsValid(target) and not target.isConsole then
		return
	end

	local nextColor = color_white

	for k, v in pairs(args) do
		if (type(v) == "table") then
			nextColor = v
		elseif type(v) == "Player" then
			MsgC(team.GetColor(v:Team()), v:Name())
		else
			MsgC(nextColor, v)
		end
	end

	MsgC("\n")
end

--
-- Prop Limit
--
if xAdmin.Config.PropLimit then
	hook.Add("PlayerSpawnProp", "xAdminPropLimit", function(ply, model)
		local count = ply:GetCount("props") + 1
		local limit = ply:GetGroupTable().proplimit or xAdmin.Config.DefaultPropLimit

		if limit == -1 then
			return true
		end

		if count > limit then xAdmin.Core.Msg({string.format("You have reached your prop limit of %s/%s", limit, limit)}, ply) return false end
	end)

	hook.Add("PlayerSpawnedProp", "xAdminPropLimitNotify", function(ply, model)
		local count = ply:GetCount("props") + 1
		local limit = ply:GetGroupTable().proplimit or xAdmin.Config.DefaultPropLimit
		if not xAdmin.Config.PropLimitNotify then return end

		if limit == -1 then
			limit = xAdmin.Config.PropLimitInfinText
		end

		xAdmin.Core.Msg({string.format("You have spawned a prop. You're now at %s/%s", count, limit )}, ply)
	end)
end
