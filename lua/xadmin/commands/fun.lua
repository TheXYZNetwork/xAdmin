--- #
--- # CLOAK
--- #
xAdmin.Core.RegisterCommand("cloak", "Cloak a user", xAdmin.Config.PowerlevelPermissions["cloak"], function(admin, args)
	if not args or not args[1] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	target:SetColor(Color(255, 255, 255, 0))
	target:SetRenderMode(RENDERMODE_TRANSALPHA)
	xAdmin.Core.Msg({admin, " has cloaked ", target})
end)

--- #
--- # UNCLOAK
--- #
xAdmin.Core.RegisterCommand("uncloak", "Cloak a user", xAdmin.Config.PowerlevelPermissions["uncloak"], function(admin, args)
	if not args or not args[1] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	target:SetColor(Color(255, 255, 255, 255))
	target:SetRenderMode(RENDERMODE_NORMAL)
	xAdmin.Core.Msg({admin, " has uncloaked ", target})
end)

--- #
--- # FREEZE
--- #
xAdmin.Core.RegisterCommand("freeze", "Freeze a user", xAdmin.Config.PowerlevelPermissions["freeze"], function(admin, args)	
	if not args or not args[1] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	target:Lock()
	xAdmin.Core.Msg({admin, " has frozen ", target})
end)

--- #
--- # UNFREEZE
--- #
xAdmin.Core.RegisterCommand("unfreeze", "Unfreeze a user", xAdmin.Config.PowerlevelPermissions["unfreeze"], function(admin, args)
	if not args or not args[1] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	target:UnLock()
	xAdmin.Core.Msg({admin, " has unfrozen ", target})
end)

--- #
--- # SETMODEL
--- #
xAdmin.Core.RegisterCommand("setmodel", "Set a user's model", xAdmin.Config.PowerlevelPermissions["setmodel"], function(admin, args)
	if not args or not args[1] or not args[2] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	target:SetModel(args[2] or "models/props_lab/blastdoor001c.mdl")
	xAdmin.Core.Msg({admin, " has set ", target, "'s model to ", Color(138, 43, 226), args[2] or "models/props_lab/blastdoor001c.mdl"})
end)