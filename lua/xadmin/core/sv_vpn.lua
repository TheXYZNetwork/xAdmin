if not xAdmin.VPN.Enabled then return end

xAdmin.VPN.Checked = {}

function xAdmin.VPN.Check(ply)
	local ipData = ply:IPAddress()
	local ip = string.Explode(":", ipData)[1]

	-- Running a local server or something.
	if (ip == "loopback") or (not ip) then return end

	-- Don't trigger it for developers
	if ply:HasPower(95) then return end
	
	-- Checked if used
	if xAdmin.VPN.Checked[ip] then return end
	xAdmin.VPN.Checked[ip] = true
 
	http.Fetch(string.format("https://proxycheck.io/v2/%s?key=%s&vpn=1", ip, xAdmin.VPN.Key),
		function(body)
			if not IsValid(ply) then return end

			local data = util.JSONToTable(body)
			local results = data[ip]

			if not results then return end
			if results.proxy == "yes" then
				xAdmin.Prevent.Post("VPN Detected", ply, "This user has been detected as using a VPN."..(results.provider and string.format(" The VPN provider was found to be **%s**.", results.provider) or ""), "9442302", true)
			end
		end
	)
end

hook.Add("PlayerInitialSpawn", "xAdmin:VPNCheck", function(ply)
	xAdmin.VPN.Check(ply) 
end)