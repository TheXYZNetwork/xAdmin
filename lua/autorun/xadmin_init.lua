xAdmin = {}
xAdmin.Info = {}
xAdmin.Database = {}
xAdmin.Config = {}
xAdmin.Core = {}
xAdmin.Users = {}
xAdmin.Groups = {}
xAdmin.Commands = {}
xAdmin.AdminChat = {}

function xAdmin.Core.Print(args)
	if(!args) then return end
	MsgC(Color(46, 170, 200), "[xAdmin] ")
	local NextColor = Color(255, 255, 255)
	for k,v in pairs(args) do
		if(type(v) == "string") then
			MsgC(NextColor, v)
		end
		if(type(v) == "Player") then
			MsgC(Color(188, 188, 188), v:Nick())
		end
		if(type(v) == "table") then
			NextColor = v
		end
	end
	MsgC(Color(255, 255, 255), "\n")
end

xAdmin.Core.Print({"Loading ", Color(46, 170, 200), "xAdmin", Color(255, 255, 255), "."})
xAdmin.Info.Version = "1.0"

-- This is the identifier for this server. Change these to whatever you want, just as long as it's unique.
xAdmin.Info.Name = "svr1"
xAdmin.Info.FullName = "Server 1"
-- Don't touch the rest of this file.

local path = "xadmin/"
if SERVER then
	local files, folders = file.Find(path .. "*", "LUA")

	for _, folder in SortedPairs(folders, true) do
		xAdmin.Core.Print({"Loading folder: ", folder})
	    for b, File in SortedPairs(file.Find(path .. folder .. "/sh_*.lua", "LUA"), true) do
	    	xAdmin.Core.Print({"Loading file: ", File})
	        AddCSLuaFile(path .. folder .. "/" .. File)
	        include(path .. folder .. "/" .. File)
	    end

	    for b, File in SortedPairs(file.Find(path .. folder .. "/sv_*.lua", "LUA"), true) do
	    	xAdmin.Core.Print({"Loading file: ", File})
	        include(path .. folder .. "/" .. File)
	    end

	    for b, File in SortedPairs(file.Find(path .. folder .. "/cl_*.lua", "LUA"), true) do
	    	xAdmin.Core.Print({"Loading file: ", File})
	        AddCSLuaFile(path .. folder .. "/" .. File)
	    end
	end
end

if CLIENT then
	local files, folders = file.Find(path .. "*", "LUA")

	for _, folder in SortedPairs(folders, true) do
		xAdmin.Core.Print({"Loading folder: ", folder})
	    for b, File in SortedPairs(file.Find(path .. folder .. "/sh_*.lua", "LUA"), true) do
	    	xAdmin.Core.Print({"Loading file: ", File})
	        include(path .. folder .. "/" .. File)
	    end

	    for b, File in SortedPairs(file.Find(path .. folder .. "/cl_*.lua", "LUA"), true) do
	    	xAdmin.Core.Print({"Loading file: ", File})
	        include(path .. folder .. "/" .. File)
	    end
	end
end

xAdmin.Core.Print({"Loaded ", Color(46, 170, 200), "xAdmin", Color(255, 255, 255), "."})