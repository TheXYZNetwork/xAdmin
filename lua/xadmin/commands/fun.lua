--- #
--- # CLOAK
--- #
xAdmin.Core.RegisterCommand("cloak", "Cloak a user", 40, function(admin, args)
	if(!IsValid(admin)) then
		admin = xAdmin.Console
	end
	if not args or not args[1] then
		if(admin.isConsole) then
			xAdmin.Core.Msg({"Please provide a valid target."}, admin)
			return
		else
			args[1] = "^"
		end
	end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: ", Color(138,43,226), args[1]}, admin)
		return
	end

	target:SetColor(Color(255, 255, 255, 0))
	target:SetRenderMode(RENDERMODE_TRANSALPHA)
	xAdmin.Core.Log({admin, " has cloaked ", target})
end)

--- #
--- # UNCLOAK
--- #
xAdmin.Core.RegisterCommand("uncloak", "Uncloak a user", 40, function(admin, args)
	if(!IsValid(admin)) then
		admin = xAdmin.Console
	end
	if not args or not args[1] then
		if(admin.isConsole) then
			xAdmin.Core.Msg({"Please provide a valid target."}, admin)
			return
		else
			args[1] = "^"
		end
	end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: ", Color(138,43,226), args[1]}, admin)
		return
	end

	target:SetColor(Color(255, 255, 255, 255))
	target:SetRenderMode(RENDERMODE_NORMAL)
	xAdmin.Core.Log({admin, " has uncloaked ", target, Color(255, 255, 255), "."})
end)

--- #
--- # FREEZE
--- #
xAdmin.Core.RegisterCommand("freeze", "Freeze a user", 30, function(admin, args)
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

	target:Lock()
	xAdmin.Core.Log({admin, " has frozen ", target, Color(255, 255, 255), "."})
end)

--- #
--- # UNFREEZE
--- #
xAdmin.Core.RegisterCommand("unfreeze", "Unfreeze a user", 30, function(admin, args)
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

	target:UnLock()
	xAdmin.Core.Log({admin, " has unfrozen ", target, Color(255, 255, 255), "."})
end)

--- #
--- # SETMODEL
--- #
xAdmin.Core.RegisterCommand("setmodel", "Set a user's model", 100, function(admin, args)
	if(!IsValid(admin)) then
		admin = xAdmin.Console
	end
	if not args or not args[1] then
		xAdmin.Core.Msg({"Please provide a valid target."}, admin)
		return
	end
	if not args or not args[2] then
		xAdmin.Core.Msg({"Please provide a valid model."}, admin)
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: ", Color(138,43,226), args[1]}, admin)
		return
	end

	target:SetModel(args[2] or "models/props_lab/blastdoor001c.mdl")
	xAdmin.Core.Log({admin, " has set ", target, "'s model to ", Color(138,43,226), args[2] or "models/props_lab/blastdoor001c.mdl", Color(255, 255, 255), "."})
end)