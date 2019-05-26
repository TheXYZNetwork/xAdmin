net.Receive("xAdminNetworkIDRank", function()
	local plyID = net.ReadString()
	local rank = net.ReadString()
	xAdmin.Users[plyID] = rank
end)

net.Receive("xAdminNetworkExistingUsers", function()
	local tbl = net.ReadTable()
	xAdmin.Users = tbl
end)

xAdmin.CommandCache = xAdmin.CommandCache or {}

net.Receive("xAdminNetworkCommands", function()
	xAdmin.CommandCache = net.ReadTable()
end)

concommand.Add("xadmin_help", function()
	print("xAdmin:")
	print("xAdmin is a text based command system that is used by staff to manage the server. You have access to the following commands:")

	for k, v in pairs(xAdmin.CommandCache) do
		print(k, "-", v)
	end

	print("To run a command, use the following format:")
	print("For console use:", "xadmin <command> <arguments>")
	print("	", "Example:", "xadmin health owain 100")
	print("For chat use:", "!<command> <arguments>")
	print("	", "Example:", "!hp owain 100")
	print("\n")
	print("Arguments are broken up by spaces, if you wish to have a multispace argument use \"\"")
	print("	", "Example:", "!hp \"Owain Owjo\" 50")
	print("	", "This will take \"Owain Owjo\" as one argument instead of 2")
end)

function xAdmin.Core.Msg(args)
	chat.AddText(unpack(args))
end

net.Receive("xAdminChatMessage", function()
	local args = net.ReadTable()

	if not args then
		return
	end

	xAdmin.Core.Msg(args)
end)