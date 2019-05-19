--- #
--- # MUTE
--- #
xAdmin.Core.RegisterCommand("mute", "Mute a user", 50, function(admin, args)
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

	target.xAdmin_Mute = true
	xAdmin.Core.Log({admin, " has muted ", target, " for the reason '", Color(138,43,226), reason, Color(255, 255, 255), "'."})
end)

--- #
--- # UNMUTE
--- #
xAdmin.Core.RegisterCommand("unmute", "Unmute a user", 50, function(admin, args)
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

	target.xAdmin_Mute = false
	xAdmin.Core.Log({admin, " has unmuted ", target, Color(255, 255, 255), "."})
end)

--- #
--- # MUTE/UNMUTE HOOK
--- #
hook.Add("PlayerSay", "xAdminPlayerGagged", function(ply, text)
	if ply.xAdmin_Mute then
		return ""
	end
end)

--- #
--- # GAG
--- #
xAdmin.Core.RegisterCommand("gag", "Gag a user", 50, function(admin, args)
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

	target.xAdmin_Gag = true
	xAdmin.Core.Log({admin, " has gagged ", target, " for the reason ", Color(138,43,226), reason, Color(255, 255, 255), "."})
end)

--- #
--- # UNGAG
--- #
xAdmin.Core.RegisterCommand("ungag", "Ungag a user", 50, function(admin, args)
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

	target.xAdmin_Gag = false
	xAdmin.Core.Log({admin, " has ungagged ", target, Color(255, 255, 255), "."})
end)

--- #
--- # GAG/UNGAG HOOK
--- #
hook.Add("PlayerCanHearPlayersVoice", "xAdminPlayerMute", function(listener, talker)
	if talker.xAdmin_Gag then
		return false
	end
end)

--- #
--- # ADMINCHAT
--- #
hook.Add("PlayerSay", "xAdminAdminChat", function(ply, text)
	if(string.sub(text, 1, 1) == "@" and ply:HasPower(xAdmin.Config.AdminChat)) then
		xAdmin.Core.AdminChat(text, ply)
		return ""
	end
end)