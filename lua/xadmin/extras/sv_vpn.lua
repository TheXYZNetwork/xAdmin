if not xAdmin.VPN.Enabled then return end

xAdmin.VPN.Checked = {}
xAdmin.VPN.EnableWebhook = false -- This requires you to have CHTTP (https://github.com/timschumi/gmod-chttp)
xAdmin.VPN.WebhookURL = ""

local request = function() end

if pcall(require, "chttp") and CHTTP ~= nil then
	request = CHTTP
else
	request = HTTP
end

-- Currently Unused
function xAdmin.VPN.SendWebhook(ply, provider)
	request(
		{
			method = "post",
			url = xAdmin.VPN.WebhookURL,
			type = "application/json; charset=utf-8",
			failed = function(err)
				MsgC(Color(255, 0, 0), "[xAdmin] Failed to post to discord webhook: " .. err)
			end,
			body = util.TableToJSON({
				content = "",
				embeds = {
					{
						title = "VPN Detected",
						description = ply:Nick() .. "[" .. ply:SteamID() .. "] has been detected to be using a VPN! The provider for this VPN is thought to be " .. provider .. ".",
						color = 15417396,
					},
				},
			}),
		}
	)
end

function xAdmin.VPN.Check(ply)
	local ipData = ply:IPAddress()
	local ip = string.Explode(":", ipData)[1]

	-- Running a local server or something.
	if (ip == "loopback") or (not ip) then return end

	-- Don't trigger it for developers
	if ply:HasPower(xAdmin.VPN.PowerLevelBypass) then return end
	
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
				-- xAdmin.VPN.PowerLevel
				-- xAdmin.Prevent.Post("VPN Detected", ply, "This user has been detected as using a VPN."..(results.provider and string.format(" The VPN provider was found to be **%s**.", results.provider) or ""), "9442302", true)
				for k, v in pairs(player.GetAll()) do
					if v:HasPower(xAdmin.VPN.PowerLevel) then
						xAdmin.Core.Msg({ply, " has been detected to be using a VPN!"}, v)
					end
				end

				-- if (xAdmin.VPN.EnableWebhook) then
				-- 	xAdmin.VPN.SendWebhook(ply, (results.provider) and results.provider or "Unknown")
				-- end
			end
		end
	)
end

hook.Add("PlayerInitialSpawn", "xAdmin:VPNCheck", function(ply)
	xAdmin.VPN.Check(ply) 
end)