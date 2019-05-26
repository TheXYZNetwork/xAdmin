--- #
--- # PLY PICKUP
--- #
hook.Add("PhysgunPickup", "xAdminPlayerPickup", function(ply, target)
	if ply:HasPower(30) and target:IsPlayer() and not target:HasPower(ply:GetGroupPower()) then
		target:SetMoveType(MOVETYPE_NONE)

		return true
	end
end)

hook.Add("loadCustomDarkRPItems", "xAdminCarPhysgunHotfix", function()
	timer.Simple(0.1, function()
		hook.Add("PhysgunPickup", "_xAdminCarPickup", function(ply, target)
			if target:IsVehicle() then
				if ply:IsAdmin() then
					return true
				elseif ply:Team() == TEAM_STAFF and ply:HasPower(40) then
					return true
				end

				return false
			end
		end)
	end)
end)

hook.Add("PhysgunDrop", "xAdminPlayerDrop", function(ply, target)
	if ply:HasPower(30) and target:IsPlayer() and not target:HasPower(ply:GetGroupPower()) then
		target:SetMoveType(MOVETYPE_WALK)
		target:SetLocalVelocity(Vector(0, 0, 0))
	end
end)