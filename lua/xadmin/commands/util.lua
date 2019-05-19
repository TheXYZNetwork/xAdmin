--- #
--- # NOCLIP
--- #
xAdmin.Core.RegisterCommand("noclip", "Toggle a user's noclip", 30, function(admin, args)
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

	target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) or admin.isConsole then
		xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: ", Color(138,43,226), args[1]}, admin)
		return
	end

	if target:GetMoveType() == MOVETYPE_WALK then
		target:SetMoveType(MOVETYPE_NOCLIP)
	elseif target:GetMoveType() == MOVETYPE_NOCLIP then
		target:SetMoveType(MOVETYPE_WALK)
	end

	if(admin != target) then
		xAdmin.Core.Log({admin, " toggled noclip for ", target, "."})
	end
end)

hook.Add("PlayerNoClip", "xAdminBlockNoclip", function(ply, desiredState)
	return false
end)

--- #
--- # HEALTH
--- #
xAdmin.Core.RegisterCommand("health", "Set a user's health", 40, function(admin, args)
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

	if not args or not args[2] then
		xAdmin.Core.Msg({"Please provide a valid operation/number."}, admin)
		return
	end

	local Operation = 1 -- 1 - Set, 2 - Add, 3 - Remove
	if(type(string.sub(args[2], 1, 1)) != "integer") then
		if(string.sub(args[2], 1, 1)) == "+" then
			Operation = 2
		end
		if(string.sub(args[2], 1, 1)) == "-" then
			Operation = 3
		end
	end

	if(Operation == 1) then -- Set
		if(!tonumber(args[2])) then
			xAdmin.Core.Msg({"'", Color(138,43,226), args[2], Color(255, 255, 255), "' is not a number/complete number. Please provide a valid number."}, admin)
			return
		end
		target:SetHealth(tonumber(args[2]))
		xAdmin.Core.Log({admin, " has set the health of ", target, " to ", Color(138,43,226), args[2], Color(255, 255, 255), "."})
		return
	end
	if(Operation == 2) then -- Add
		local AddHP = string.sub(args[2], 2, #args[2])
		if(!tonumber(string.sub(args[2], 2, 2))) then
			xAdmin.Core.Msg({"Unable to determine what operation to use with the value you specified."}, admin)
			return
		end
		if(!tonumber(AddHP)) then
			xAdmin.Core.Msg({"'", Color(138,43,226), AddHP, Color(255, 255, 255), "' is not a number/complete number. Please provide a valid number."}, admin)
			return
		end
		target:SetHealth(target:Health() + tonumber(AddHP))
		xAdmin.Core.Log({admin, " has added ", Color(138,43,226), AddHP, Color(255, 255, 255), " health to ", target, "."})
		return
	end
	if(Operation == 3) then -- Remove
		local RemoveHP = string.sub(args[2], 2, #args[2])
		if(!tonumber(string.sub(args[2], 2, 2))) then
			xAdmin.Core.Msg({"Unable to determine what operation to use with the value you specified."}, admin)
			return
		end
		if(!tonumber(RemoveHP)) then
			xAdmin.Core.Msg({"'", Color(138,43,226), RemoveHP, Color(255, 255, 255), "' is not a number/complete number. Please provide a valid number."}, admin)
			return
		end
		if(target:Health() - tonumber(RemoveHP) <= 0) then
			xAdmin.Core.Msg({"Unable to remove that much health, as it will result in a health value equal to or below zero."}, admin)
			return
		end
		target:SetHealth(target:Health() - tonumber(RemoveHP))
		xAdmin.Core.Log({admin, " has removed ", Color(138,43,226), RemoveHP, Color(255, 255, 255), " health from ", target, "."})
		return
	end
	xAdmin.Core.Msg({"Unable to determine what operation to use with the value you specified."}, admin)
end)
xAdmin.Core.RegisterCommand("hp", "Alias for health", 40, function(admin, args)
	xAdmin.Commands["health"].func(admin, args)
end)

--- #
--- # ARMOR
--- #
xAdmin.Core.RegisterCommand("armor", "Set a user's armor", 50, function(admin, args)
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

	if not args or not args[2] then
		xAdmin.Core.Msg({"Please provide a valid operation/number."}, admin)
		return
	end

	local Operation = 1 -- 1 - Set, 2 - Add, 3 - Remove
	if(type(string.sub(args[2], 1, 1)) != "integer") then
		if(string.sub(args[2], 1, 1)) == "+" then
			Operation = 2
		end
		if(string.sub(args[2], 1, 1)) == "-" then
			Operation = 3
		end
	end

	if(Operation == 1) then -- Set
		if(!tonumber(args[2])) then
			xAdmin.Core.Msg({"'", Color(138,43,226), args[2], Color(255, 255, 255), "' is not a number/complete number. Please provide a valid number."}, admin)
			return
		end
		target:SetArmor(tonumber(args[2]))
		xAdmin.Core.Log({admin, " has set the armor of ", target, " to ", Color(138,43,226), args[2], Color(255, 255, 255), "."})
		return
	end
	if(Operation == 2) then -- Add
		local AddArmor = string.sub(args[2], 2, #args[2])
		if(!tonumber(string.sub(args[2], 2, 2))) then
			xAdmin.Core.Msg({"Unable to determine what operation to use with the value you specified."}, admin)
			return
		end
		if(!tonumber(AddArmor)) then
			xAdmin.Core.Msg({"'", Color(138,43,226), AddArmor, Color(255, 255, 255), "' is not a number/complete number. Please provide a valid number."}, admin)
			return
		end
		target:SetArmor(target:Armor() + tonumber(AddArmor))
		xAdmin.Core.Log({admin, " has added ", Color(138,43,226), AddArmor, Color(255, 255, 255), " armor to ", target, "."})
		return
	end
	if(Operation == 3) then -- Remove
		local RemoveArmor = string.sub(args[2], 2, #args[2])
		if(!tonumber(string.sub(args[2], 2, 2))) then
			xAdmin.Core.Msg({"Unable to determine what operation to use with the value you specified."}, admin)
			return
		end
		if(!tonumber(RemoveArmor)) then
			xAdmin.Core.Msg({"'", Color(138,43,226), RemoveArmor, Color(255, 255, 255), "' is not a number/complete number. Please provide a valid number."}, admin)
			return
		end
		if(target:Armor() - tonumber(RemoveArmor) <= 0) then
			xAdmin.Core.Msg({"Unable to remove that much armor, as it will result in a health value equal to or below zero."}, admin)
			return
		end
		target:SetArmor(target:Armor() - tonumber(RemoveArmor))
		xAdmin.Core.Log({admin, " has removed ", Color(138,43,226), RemoveArmor, Color(255, 255, 255), " armor from ", target, "."})
		return
	end
	xAdmin.Core.Msg({"Unable to determine what operation to use with the value you specified."}, admin)
end)

--- #
--- # GOD
--- #
xAdmin.Core.RegisterCommand("god", "God a user", 40, function(admin, args)
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

	target:GodEnable()
	xAdmin.Core.Log({admin, " has godded ", target, "."})
end)

--- #
--- # UNGOD
--- #
xAdmin.Core.RegisterCommand("ungod", "Ungod a user", 40, function(admin, args)
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

	target:GodDisable()
	xAdmin.Core.Log({admin, " has ungodded ", target, "."})
end)

--- #
--- # SLAY
--- #
xAdmin.Core.RegisterCommand("slay", "Kill a user", 70, function(admin, args)
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

	target:Kill()
	xAdmin.Core.Log({admin, " has slayed ", target, "."})
end)
xAdmin.Core.RegisterCommand("kill", "Alias for slay", 70, function(admin, args)
	xAdmin.Commands["slay"].func(admin, args)
end)

--- #
--- # REVIVE
--- #
xAdmin.Core.RegisterCommand("revive", "Revive a user", 50, function(admin, args)
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

	if target:Alive() then
		xAdmin.Core.Msg({target, " is already alive."}, admin)
		return
	end

	local deathPos = target:GetPos()
	target:Spawn()
	target:SetPos(deathPos)

	xAdmin.Core.Log({admin, " has revived ", target, " from the dead."})
end)

--- #
--- # RESPAWN
--- #
xAdmin.Core.RegisterCommand("respawn", "Respawn a user", 70, function(admin, args)
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

	target:Spawn()
	xAdmin.Core.Log({admin, " has respawned ", target, "."})
end)

--- #
--- # STRIP
--- #
xAdmin.Core.RegisterCommand("strip", "Strip a user", 70, function(admin, args)
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

	target:StripWeapons()

	xAdmin.Core.Log({admin, " has stripped ", target, " of their weapons."})
end)

--- #
--- # GIVE
--- #
xAdmin.Core.RegisterCommand("give", "Give a user a weapon", 70, function(admin, args)
	if(!IsValid(admin)) then
		admin = xAdmin.Console
	end
	if not args or not args[1] then
		xAdmin.Core.Msg({"Please provide a valid target."}, admin)
		return
	end
	if not args or not args[2] then
		xAdmin.Core.Msg({"Please provide a valid weapon class."}, admin)
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({"Please provide a valid target. The following was not recognised: ", Color(138,43,226), args[1]}, admin)
		return
	end

	target:Give(args[2])

	xAdmin.Core.Log({admin, " has given ", target, " a ", Color(138,43,226), args[2], "."})
end)
