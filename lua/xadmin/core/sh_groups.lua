function xAdmin.Core.RegisterGroup(name, power, props)
	xAdmin.Groups[name] = {
		name = name,
		power = power,
		proplimit = props
	}
end

function xAdmin.Core.GetGroupPower(name)
	return xAdmin.Groups[name].power or 0
end

function xAdmin.Core.GetGroupsWithPower(power)
	local groups = {}

	for k, v in pairs(xAdmin.Groups) do
		if v.power >= power then
			table.insert(groups, v)
		end
	end

	return groups
end