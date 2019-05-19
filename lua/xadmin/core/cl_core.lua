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
	xAdmin.Core.Print({Color(46, 170, 200), "-----[[ xAdmin ]]-----"})
	xAdmin.Core.Print({"xAdmin is a text based command system that is used by staff to manage the server. You have access to the following commands:"})
	for k, v in pairs(xAdmin.CommandCache) do
		xAdmin.Core.Print({Color(138,43,226), k, Color(255, 255, 255), " - ", v})
	end
	xAdmin.Core.Print({"To run a command, use the following format:"})
	xAdmin.Core.Print({"For console use: ", Color(138,43,226), "xadmin <command> <arguments>"})
	xAdmin.Core.Print({"	", "Example: ", Color(138,43,226), "xadmin health owain 100"})
	xAdmin.Core.Print({"For chat use: ", Color(138,43,226), "!<command> <arguments>"})
	xAdmin.Core.Print({"	", "Example: ", Color(138,43,226), "!hp owain 100"})
	xAdmin.Core.Print({"\n"})
	xAdmin.Core.Print({"Arguments are broken up by spaces, if you wish to have a multispace argument use \"\""})
	xAdmin.Core.Print({"	", "Example: ", Color(138,43,226), "!hp \"Owain Owjo\" 50"})
	xAdmin.Core.Print({"	", "This will take \"Owain Owjo\" as one argument instead of 2"})
end)

function xAdmin.Core.Msg(args)
	chat.AddText(Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), unpack(args))
end

net.Receive("xAdminChatMessage", function()
	local args = net.ReadTable()
	if not args then return end

	xAdmin.Core.Msg(args)
end)

function xAdmin.Core.AdminChat(args)
	chat.AddText(Color(46, 170, 200), "[xAdminChat] ", xAdmin.Config.AdminChatColor, unpack(args))
end

net.Receive("xAdminAChatMessage", function()
	local args = net.ReadTable()
	if(!args) then return end

	xAdmin.Core.AdminChat(args)
end)