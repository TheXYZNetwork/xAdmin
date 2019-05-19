--- #
--- # KICK
--- #
xAdmin.Core.RegisterCommand("kick", "Kicks the target player", 30, function(admin, args)
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

    local reason = args[2] or "No reason given"
    if args[3] then
        for k, v in pairs(args) do
            if k < 3 then continue end
            reason = reason.." "..v
        end
    end

    if target:HasPower(admin:GetGroupPower()) then
        xAdmin.Core.Msg({target, " out powers you and thus you cannot kick them."}, admin)
        return
    end

    xAdmin.Core.Log({target, " has been kicked by ", admin, " for the reason '", Color(138,43,226), reason, Color(255, 255, 255), "'."})
    target:Kick(reason)
end)

--- #
--- # BAN
--- #
xAdmin.Core.RegisterCommand("ban", "Bans the target player", 40, function(admin, args)
	if(!IsValid(admin)) then
		admin = xAdmin.Console
	end
	if not args or not args[1] then
		xAdmin.Core.Msg({"Please provide a valid target."}, admin)
		return
	end

	local target,targetPly = xAdmin.Core.GetID64(args[1], admin)
	if not target then
        xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: ", Color(138,43,226), args[1]}, admin)
		return
	end

    -- Time is in minutes, however the database stores it as seconds.
    local time = args[2] or 0
    time = tostring(time)

    local timeArray = string.ToTable(time)
    local timeLength = #timeArray

    if not tonumber(timeArray[timeLength]) then
        time = tonumber( table.concat( timeArray , "", 1, timeLength-1 ) )
        if !time then return end
        if timeArray[timeLength] == "h" then
            time = time *60
        elseif timeArray[timeLength] == "d" then
            time = time *60 *24
        elseif timeArray[timeLength] == "w" then
            time = time *60 *24 *7
        end
    else
        time = tonumber(table.concat(timeArray))
    end

    local reason = args[3] or "No reason given"
    if args[4] then
        for k, v in pairs(args) do
            if k < 4 then continue end
            reason = reason.." "..v
        end
    end

    if IsValid(targetPly) then
        if targetPly:HasPower(admin:GetGroupPower()) then
        	xAdmin.Core.Msg({target, " out powers you and thus you cannot kick them."}, admin)
            return
        end


        targetPly:Kick(string.format(xAdmin.Config.BanFormat, admin:Name(), (time==0 and "Permanent") or string.NiceTime(time*60), reason))
    end

	if(time==0) then
    	xAdmin.Core.Log({admin, " has banned ", ((IsValid(targetPly) and targetPly:Name()) or target), Color(138,43,226), " permanently", Color(255, 255, 255), " for the reason: '", Color(138,43,226), reason, "'."})
	else
		xAdmin.Core.Log({admin, " has banned ", ((IsValid(targetPly) and targetPly:Name()) or target), " for ", Color(138,43,226), string.NiceTime(time*60), Color(255, 255, 255), " for the reason: '", Color(138,43,226), reason, "'."})
	end
    xAdmin.Database.CreateBan(target, (IsValid(targetPly) and targetPly:Name()) or "Unknown", admin:SteamID64(), admin:Name(), reason or "No reason given", time*60)
end)

hook.Add("CheckPassword", "xAdminCheckBanned", function(steamID64)
    xAdmin.Database.IsBanned(steamID64, function(data)
        if data[1] then
			local Time = tonumber(data[1]._end)
            if(Time == 0) then
                game.KickID(util.SteamIDFrom64(steamID64), string.format(xAdmin.Config.BanFormat, data[1].admin, "Permanent", data[1].reason))
            elseif (tonumber(data[1].start) + Time) > os.time() then
                game.KickID(util.SteamIDFrom64(steamID64), string.format(xAdmin.Config.BanFormat, data[1].admin, string.NiceTime((tonumber(data[1].start)+Time)-os.time()), data[1].reason))
            else
                xAdmin.Database.DestroyBan(steamID64)
            end
        end
    end)
end)

--- #
--- # UNBAN
--- #
xAdmin.Core.RegisterCommand("unban", "Unbans the target SteamID", 50, function(admin, args)
	if(!IsValid(admin)) then
		admin = xAdmin.Console
	end
	if not args or not args[1] then
		xAdmin.Core.Msg({"Please provide a valid SteamID."}, admin)
		return
	end

    local target, targetPly = xAdmin.Core.GetID64(args[1], admin)
    if not target then
        xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: ", Color(138,43,226), args[1]}, admin)
        return
    end

    xAdmin.Core.Log({admin, " has unbanned ", Color(138,43,226), target, Color(255, 255, 255), "."})
    xAdmin.Database.DestroyBan(target)
end)