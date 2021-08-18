--- #
--- # MUTE
--- #
xAdmin.Core.RegisterCommand("mute", "Mute a user", xAdmin.Config.PowerlevelPermissions.mute, function(admin, args)
	if not args or not args[1] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, xAdmin.Config.LogPrefix, xAdmin.Config.ColorLogText, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	target.xAdmin_Mute = true
	xAdmin.Core.Msg({admin, " has muted ", target})
end)

--- #
--- # UNMUTE
--- #
xAdmin.Core.RegisterCommand("unmute", "Unmute a user", xAdmin.Config.PowerlevelPermissions["unmute"], function(admin, args)
	if not args or not args[1] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, xAdmin.Config.LogPrefix, xAdmin.Config.ColorLogText, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	target.xAdmin_Mute = false
	xAdmin.Core.Msg({admin, " has unmuted ", target})
end)

--- #
--- # MUTE/UNMUTE HOOK
--- #
hook.Add("PlayerCanHearPlayersVoice", "xAdminPlayerMute", function(listener, talker)
	if talker.xAdmin_Gag then
		return false
	end
end)

--- #
--- # GAG
--- #
xAdmin.Core.RegisterCommand("gag", "Gag a user", xAdmin.Config.PowerlevelPermissions["gag"], function(admin, args)
	if not args or not args[1] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, xAdmin.Config.LogPrefix, xAdmin.Config.ColorLogText, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	target.xAdmin_Gag = true
	xAdmin.Core.Msg({admin, " has gagged ", target})
end)

--- #
--- # UNGAG
--- #
xAdmin.Core.RegisterCommand("ungag", "Ungag a user", xAdmin.Config.PowerlevelPermissions["ungag"], function(admin, args)
	if not args or not args[1] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, xAdmin.Config.LogPrefix, xAdmin.Config.ColorLogText, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	target.xAdmin_Gag = false
	xAdmin.Core.Msg({admin, " has ungagged ", target})
end)

--- #
--- # GAG/UNGAG HOOK
--- #
hook.Add("PlayerSay", "xAdminPlayerGagged", function(ply, text)
	if ply.xAdmin_Mute then
		return ""
	end
end)

--- #
--- # ADMINCHAT
--- #
hook.Add("PlayerSay", "xAdminAdminChat", function(ply, text)
	if string.sub(text, 1, 1) == "@" and ply:HasPower(xAdmin.Config.AdminChat) then
		for k, v in pairs(xAdmin.AdminChat) do
			xAdmin.Core.Msg({xAdmin.Config.ColorLog, "[xAdminChat] ", ply, xAdmin.Config.ColorLogText, ": ", xAdmin.Config.AdminChatColor, string.TrimLeft(string.sub(text, 2))}, v)
		end

		return ""
	end
end)