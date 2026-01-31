function xAdmin.Core.RegisterCommandInternal(cmd, dsc, pwr, fnc)
	xAdmin.Commands[cmd] = {
		command = cmd,
		desc = dsc or "n/a",
		power = xAdmin.Config.PowerlevelPermissions[cmd] or xAdmin.Config.PowerLevelDefault,
		func = fnc
	}
end

function xAdmin.Core.RegisterCommand(command, desc, power, func, alias)
	if not command then
		return
	end

	if not func then
		return
	end

	// xAdmin.Commands[command] = {
	// 	command = command,
	// 	desc = desc or "n/a",
	// 	power = xAdmin.Config.PowerlevelPermissions[command] or xAdmin.Config.PowerLevelDefault,
	// 	func = func
	// }
	print("[xAdmin] Loading command " .. command .. ".")
	xAdmin.Core.RegisterCommandInternal(command, desc, power, func)

	if alias then
		if not istable(alias) then return end
		for k, v in pairs(alias) do
			xAdmin.Core.RegisterCommandInternal(v, desc, power, func)
			print("", "Alias Registered: " .. v)
		end
	end
end
function xAdmin.Core.IsCommand(arg)
	return xAdmin.Commands[arg] or false
end

for _, files in SortedPairs(file.Find("xadmin/commands/*.lua", "LUA"), true) do
	print("[xAdmin] Loading commands located in: " .. files)
	include("xadmin/commands/" .. files)
end

concommand.Add("xadmin", function(ply, cmd, args, argStr)
	if not args[1] then
		return
	end

	if ply == NULL then
		ply = xAdmin.Console
	end

	local comTbl = xAdmin.Commands[string.lower(args[1])]

	if not comTbl then
		return
	end

	if not ply:HasPower(comTbl.power) then
		return
	end
		
	local formattedArgs = xAdmin.Core.FormatArguments(string.Explode(" ", argStr))

	table.remove(formattedArgs, 1)
	
	if hook.Run("xAdminCanRunCommand", ply, string.lower(args[1]), formattedArgs, true) == false then
		return
	end
		
	comTbl.func(ply, formattedArgs)
end)

hook.Add("PlayerSay", "xAdminChatCommands", function(ply, msg)
	if string.sub(msg, 1, #xAdmin.Config.Prefix) == xAdmin.Config.Prefix then
		local args = xAdmin.Core.FormatArguments(string.Explode(" ", msg))
		args[1] = string.sub(args[1], #xAdmin.Config.Prefix + 1)
		local command = xAdmin.Core.IsCommand(string.lower(args[1]))

		if command and ply:HasPower(command.power) then
			local cmdName = args[1]
			table.remove(args, 1)
				
			if hook.Run("xAdminCanRunCommand", ply, command.command, args, false) == false then
				return
			end
				
			command.func(ply, args)

			--print("[xAdmin] " .. ply:Nick() .. " [" .. ply:SteamID() .. "] ran command " .. args[1] .. ": " .. msg)

			return ""
		end
	end
end)
