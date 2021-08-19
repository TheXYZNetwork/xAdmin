-- Disable this module if we aren't running DarkRP to not cunfuse people
-- Also makes sure DarkRP is running the latest version lol

--- #
--- # ADDMONEY
--- #
xAdmin.Core.RegisterCommand("addmoney", "[DarkRP] Gives the target X money", xAdmin.Config.PowerlevelPermissions["addmoney"], function(admin, args)
	if not args or not args[1] then
		return
	end

	if not DarkRP then
		return
	end

	if not args[2] or not tonumber(args[2]) or tonumber(args[2]) <= 0 then
		xAdmin.Core.Msg({"Please provid a valid amount you want to add to the target"}, admin)

		return
	end

	args[2] = tonumber(args[2])
	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	xAdmin.Core.Msg({admin, " has added ", Color(0, 255, 0), DarkRP.formatMoney(args[2]), xAdmin.Config.ColorLogText, " to ", target})
	target:addMoney(args[2])
end)

--- #
--- # REMOVEMONEY
--- #
xAdmin.Core.RegisterCommand("removemoney", "[DarkRP] Takes X money from the target", xAdmin.Config.PowerlevelPermissions["removemoney"], function(admin, args)
	if not args or not args[1] then
		return
	end

	if not DarkRP then
		return
	end

	if not args[2] or not tonumber(args[2]) or tonumber(args[2]) <= 0 then
		xAdmin.Core.Msg({"Please provid a valid amount you want to add to the target"}, admin)

		return
	end

	args[2] = tonumber(args[2])
	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	xAdmin.Core.Msg({admin, " has taken ", Color(0, 255, 0), DarkRP.formatMoney(args[2]), xAdmin.Config.ColorLogText, " from ", target})
	target:addMoney(-args[2])
end)

--- #
--- # SETMONEY
--- #
xAdmin.Core.RegisterCommand("setmoney", "[DarkRP] Sets the target's money to X", xAdmin.Config.PowerlevelPermissions["setmoney"], function(admin, args)
	if not args or not args[1] then
		return
	end

	if not DarkRP then
		return
	end

	if not args[2] or not tonumber(args[2]) or tonumber(args[2]) <= 0 then
		xAdmin.Core.Msg({"Please provid a valid amount you want to add to the target"}, admin)

		return
	end

	args[2] = tonumber(args[2])
	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	xAdmin.Core.Msg({admin, " has set ", target, "'s money to ", Color(0, 255, 0), DarkRP.formatMoney(args[2])})
	target:addMoney(-target:getDarkRPVar("money") + args[2]) -- Seems that DarkRP doesn't have a setMonet class?
end)

--- #
--- # SETJOB
--- #
xAdmin.Core.RegisterCommand("setjob", "[DarkRP] Sets the target's job", xAdmin.Config.PowerlevelPermissions["setjob"], function(admin, args)
	if not args or not args[1] then
		return
	end

	if not DarkRP then
		return
	end

	if not args[2] then
		xAdmin.Core.Msg({"Please provide a valid target"}, admin)

		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)
	local job = DarkRP.getJobByCommand(args[2])

	if not job then
		xAdmin.Core.Msg({"Please provide a valid job "}, admin)

		return
	end

	if not IsValid(target) then
		xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	xAdmin.Core.Msg({admin, " has set ", target, "'s job to ", Color(0, 255, 0), job.name})
	target:changeTeam(job.team, true, true)
end)
