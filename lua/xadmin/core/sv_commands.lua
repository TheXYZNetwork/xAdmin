function xAdmin.Core.RegisterCommand(command, desc, power, func)
	if not command then
		return
	end

	if not func then
		return
	end

	xAdmin.Commands[command] = {
		command = command,
		desc = desc or "n/a",
		power = power or 0,
		func = func
	}
end

function xAdmin.Core.IsCommand(arg)
	return xAdmin.Commands[arg] or false
end

for _, files in SortedPairs(file.Find("xadmin/commands/*.lua", "LUA"), true) do
	print("Loading command file:", files)
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
	if string.sub(msg, 1, 1) == xAdmin.Config.Prefix then
		local args = xAdmin.Core.FormatArguments(string.Explode(" ", msg))
		args[1] = string.sub(args[1], 2)
		local command = xAdmin.Core.IsCommand(string.lower(args[1]))

		if command and ply:HasPower(command.power) then
			table.remove(args, 1)
				
			if hook.Run("xAdminCanRunCommand", ply, command.command, args, false) == false then
				return
			end
				
			command.func(ply, args)
		end
	end
end)
