--- #
--- # BRING
--- #
xAdmin.Core.RegisterCommand("bring", "Brings the target player", 30, function(admin, args)
	if !IsValid(admin) then
		xAdmin.Core.Msg({"You cannot perform this action."}, admin)
		return
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

	if !target:Alive() then
		xAdmin.Core.Msg({target, " is dead."}, admin)
		return
	end

	if target:InVehicle() then
		target:ExitVehicle()
	end

	target.xAdminReturnPos = target:GetPos()
	target:SetPos(admin:GetPos() + (admin:GetForward()*50) + Vector(0, 0, 20))
	target:SetLocalVelocity(Vector(0, 0, 0))

	xAdmin.Core.Log({admin, " brought ", target, " to their location."})
end)

--- #
--- # RETURN
--- #
xAdmin.Core.RegisterCommand("return", "Returns the target to their old position", 30, function(admin, args)
	if !IsValid(admin) then
		xAdmin.Core.Msg({"You cannot perform this action."}, admin)
		return
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

	if not target:Alive() then
		xAdmin.Core.Msg({target, " is dead."}, admin)
		return
	end

	if not target.xAdminReturnPos then
		xAdmin.Core.Msg({target, " has no previous locations to send them to."}, admin)
		return
	end

	if target:InVehicle() then
		target:ExitVehicle()
	end

	target:SetPos(target.xAdminReturnPos + Vector(0, 0, 20))
	target:SetLocalVelocity(Vector(0, 0, 0))
	target.xAdminReturnPos = nil

	xAdmin.Core.Log({admin, " returned ", target, " to their previous location."})
end)

--- #
--- # GOTO
--- #
xAdmin.Core.RegisterCommand("goto", "Teleports you to their position", 30, function(admin, args)
	if !IsValid(admin) then
		xAdmin.Core.Msg({"You cannot perform this action."}, admin)
		return
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

	if not target:Alive() then
		xAdmin.Core.Msg({target, " is dead."}, admin)
		return
	end

	if not admin:Alive() then
		xAdmin.Core.Msg({"You are dead."}, admin)
		return
	end

	if admin:InVehicle() then
		admin:ExitVehicle()
	end

	admin.xAdminReturnPos = admin:GetPos()
	admin:SetPos(target:GetPos() + (target:GetForward()*50) + Vector(0, 0, 20))
	admin:SetLocalVelocity(Vector(0, 0, 0))

	xAdmin.Core.Log({admin, " went to the location of ", target, "."})
end)

--- #
--- # REVIVETP
--- #
xAdmin.Core.RegisterCommand("revtp", "Revives and teleports the user", 50, function(admin, args)
	if !IsValid(admin) then
		xAdmin.Core.Msg({"You cannot perform this action."}, admin)
		return
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

	if target:Alive() then
		xAdmin.Core.Msg({target, " is already alive."}, admin)
		return
	end

	if target:InVehicle() then
		target:ExitVehicle()
	end

	target:Spawn()
	target.xAdminReturnPos = target:GetPos()
	target:SetPos(admin:GetPos() + (admin:GetForward()*50) + Vector(0, 0, 20))
	target:SetLocalVelocity(Vector(0, 0, 0))

	xAdmin.Core.Log({admin, " revived and brought ", target, " to their location."})
end)