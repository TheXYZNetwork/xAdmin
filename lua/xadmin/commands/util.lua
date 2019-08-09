--- #
--- # NOCLIP
--- #
xAdmin.Core.RegisterCommand("noclip", "Toggle a user's noclip", 30, function(admin, args)
	local target = admin

	if args and args[1] then
		target = xAdmin.Core.GetUser(args[1], admin)

		if not IsValid(target) or admin.isConsole then
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

			return
		end
	end

	if target:GetMoveType() == MOVETYPE_WALK then
		target:SetMoveType(MOVETYPE_NOCLIP)
	elseif target:GetMoveType() == MOVETYPE_NOCLIP then
		target:SetMoveType(MOVETYPE_WALK)
	end
end)

hook.Add("PlayerNoClip", "xAdminBlockNoclip", function(ply, desiredState)
	return false
end)

--- #
--- # HEALTH
--- #
xAdmin.Core.RegisterCommand("health", "Set a user's health", 40, function(admin, args)
	if not args or not args[1] or not args[2] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	local Operation = 1 -- 1 - Set, 2 - Add, 3 - Remove

	if (type(string.sub(args[2], 1, 1)) ~= "integer") then
		if (string.sub(args[2], 1, 1)) == "+" then
			Operation = 2
		end

		if (string.sub(args[2], 1, 1)) == "-" then
			Operation = 3
		end
	end

	if (Operation == 1) then
		if (not tonumber(args[2])) then
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "'" .. args[2] .. "' is not a number/complete number. Please provide a valid number."}, admin)

			return
		end

		target:SetHealth(tonumber(args[2]))
		xAdmin.Core.Msg({admin, " has set ", target, "'s health to ", Color(255, 0, 0), args[2]})

		return
	end -- Set

	if (Operation == 2) then
		local AddHP = string.sub(args[2], 2, #args[2])

		if (not tonumber(string.sub(args[2], 2, 2))) then
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Unable to determine what operation to use with the value you specified."}, admin)

			return
		end

		if (not tonumber(AddHP)) then
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "'" .. AddHP .. "' is not a number/complete number. Please provide a valid number."}, admin)

			return
		end

		target:SetHealth(target:Health() + tonumber(AddHP))
		xAdmin.Core.Msg({admin, " has added ", Color(255, 0, 0), AddHP, color_white, " health to ", target, "."})

		return
	end -- Add

	if (Operation == 3) then
		local RemoveHP = string.sub(args[2], 2, #args[2])

		if (not tonumber(string.sub(args[2], 2, 2))) then
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Unable to determine what operation to use with the value you specified."}, admin)

			return
		end

		if (not tonumber(RemoveHP)) then
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "'" .. RemoveHP .. "' is not a number/complete number. Please provide a valid number."}, admin)

			return
		end

		if (target:Health() - tonumber(RemoveHP) <= 0) then
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Unable to remove that much health, as it will result in a health value below zero."}, admin)

			return
		end

		target:SetHealth(target:Health() - tonumber(RemoveHP))
		xAdmin.Core.Msg({admin, " has removed ", Color(255, 0, 0), RemoveHP, color_white, " health from ", target, "."})

		return
	end -- Remove

	xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Unable to determine what operation to use with the value you specified."}, admin)
end)

xAdmin.Core.RegisterCommand("hp", "Alias for health", 40, function(admin, args)
	xAdmin.Commands["health"].func(admin, args)
end)

--- #
--- # ARMOR
--- #
xAdmin.Core.RegisterCommand("armor", "Set a user's armor", 50, function(admin, args)
	if not args or not args[1] or not args[2] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	local Operation = 1 -- 1 - Set, 2 - Add, 3 - Remove

	if (type(string.sub(args[2], 1, 1)) ~= "integer") then
		if (string.sub(args[2], 1, 1)) == "+" then
			Operation = 2
		end

		if (string.sub(args[2], 1, 1)) == "-" then
			Operation = 3
		end
	end

	if (Operation == 1) then
		if (not tonumber(args[2])) then
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "'" .. args[2] .. "' is not a number/complete number. Please provide a valid number."}, admin)

			return
		end

		target:SetArmor(tonumber(args[2]))
		xAdmin.Core.Msg({admin, " has set ", target, "'s armor to ", Color(255, 0, 0), args[2]})

		return
	end -- Set

	if (Operation == 2) then
		local AddArmor = string.sub(args[2], 2, #args[2])

		if (not tonumber(string.sub(args[2], 2, 2))) then
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Unable to determine what operation to use with the value you specified."}, admin)

			return
		end

		if (not tonumber(AddArmor)) then
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "'" .. AddArmor .. "' is not a number/complete number. Please provide a valid number."}, admin)

			return
		end

		target:SetArmor(target:Armor() + tonumber(AddArmor))
		xAdmin.Core.Msg({admin, " has added ", Color(255, 0, 0), AddArmor, color_white, " armor to ", target, "."})

		return
	end -- Add

	if (Operation == 3) then
		local RemoveArmor = string.sub(args[2], 2, #args[2])

		if (not tonumber(string.sub(args[2], 2, 2))) then
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Unable to determine what operation to use with the value you specified."}, admin)

			return
		end

		if (not tonumber(RemoveArmor)) then
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "'" .. RemoveArmor .. "' is not a number/complete number. Please provide a valid number."}, admin)

			return
		end

		if (target:Armor() - tonumber(RemoveArmor) <= 0) then
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Unable to remove that much armor, as it will result in a armor value below zero."}, admin)

			return
		end

		target:SetArmor(target:Armor() - tonumber(RemoveArmor))
		xAdmin.Core.Msg({admin, " has removed ", Color(255, 0, 0), RemoveArmor, color_white, " armor from ", target, "."})

		return
	end -- Remove

	xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Unable to determine what operation to use with the value you specified."}, admin)
end)

--- #
--- # GOD
--- # 
xAdmin.Core.RegisterCommand("god", "God a user", 40, function(admin, args)
	if not args or not args[1] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	target:GodEnable()
	xAdmin.Core.Msg({admin, " has godded ", target})
end)

--- #
--- # UNGOD
--- # 
xAdmin.Core.RegisterCommand("ungod", "Ungod a user", 40, function(admin, args)
	if not args or not args[1] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	target:GodDisable()
	xAdmin.Core.Msg({admin, " has ungodded ", target})
end)

--- #
--- # SLAY
--- # 
xAdmin.Core.RegisterCommand("slay", "Kill a user", 70, function(admin, args)
	if not args or not args[1] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	target:Kill()
	xAdmin.Core.Msg({admin, " has slayed ", target})
end)

--- #
--- # REVIVE
--- # 
xAdmin.Core.RegisterCommand("revive", "Revive a user", 50, function(admin, args)
	if not args or not args[1] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	if target:Alive() then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, target, " is already alive."}, admin)

		return
	end

	local deathPos = target:GetPos()
	target:Spawn()
	target:SetPos(deathPos)
	xAdmin.Core.Msg({admin, " has revived ", target})
end)

--- #
--- # RESPAWN
--- # 
xAdmin.Core.RegisterCommand("respawn", "Respawn a user", 70, function(admin, args)
	if not args or not args[1] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	target:Spawn()
	xAdmin.Core.Msg({admin, " has respawned ", target})
end)

--- #
--- # STRIP
--- # 
xAdmin.Core.RegisterCommand("strip", "Strip a user", 70, function(admin, args)
	if not args or not args[1] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	target:StripWeapons()
	xAdmin.Core.Msg({admin, " has stripped ", target})
end)

--- #
--- # GIVE
--- # 
xAdmin.Core.RegisterCommand("give", "Give a user a weapon", 70, function(admin, args)
	if not args or not args[1] or not args[2] then
		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)

	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	target:Give(args[2] or "weapon_357")
	xAdmin.Core.Msg({admin, " has given ", target, " a ", Color(138, 43, 226), args[2] or "weapon_357"})
end)
