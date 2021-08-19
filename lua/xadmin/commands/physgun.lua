if not xAdmin.Config.EnablePhysgunFeatures then return end

-- Hot Reload Support
xAdmin.hasLoadedPhysgun = xAdmin.hasLoadedPhysgun or false

--- #
--- # PLY PICKUP
--- #
hook.Add("PhysgunPickup", "xAdminPlayerPickup", function(ply, target)
	if xAdmin.Config.PhysgunEnablePeople then
		if ply:HasPower(xAdmin.Config.PhysgunPickupPlayerPowerlevel) and target:IsPlayer() and not target:HasPower(ply:GetGroupPower()) then
			target:SetMoveType(MOVETYPE_NONE)
	
			return true
		end
	end
end)

local function makeVehiclePickupHook()
	hook.Add("PhysgunPickup", "_xAdminCarPickup", function(ply, target)
		if target:IsVehicle() then
			if ply:HasPower(xAdmin.Config.PhysgunPickupVehiclePowerlevel) then
				return true
			end

			return false
		end
	end)

	xAdmin.hasLoadedPhysgun = true
end

if xAdmin.hasLoadedPhysgun then
	makeVehiclePickupHook()
end

if xAdmin.Config.PhysgunEnableVehicle then
	hook.Add("loadCustomDarkRPItems", "xAdminCarPhysgunHotfix", function()
		timer.Simple(0.1, function()
			makeVehiclePickupHook()
		end)
	end)
end

hook.Add("PhysgunDrop", "xAdminPlayerDrop", function(ply, target)
	if xAdmin.Config.PhysgunEnablePeople then
		if ply:HasPower(xAdmin.Config.PhysgunPickupPlayerPowerlevel) and target:IsPlayer() and not target:HasPower(ply:GetGroupPower()) then
			target:SetMoveType(MOVETYPE_WALK)
			target:SetLocalVelocity(Vector(0, 0, 0))
		end
	end
end)