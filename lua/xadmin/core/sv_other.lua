if xAdmin.Config.EnablePhysgunFeatures and xAdmin.Config.DisallowFrozenPropSpawning then
    hook.Add("PlayerSpawnProp", "xAdmin:Frozen:Block", function(ply)
        if not ply:IsFrozen() then return end
        
        return false
    end) 
end

-- Example
-- xAdmin.Utility.stringReplace("{USER} kinda smell lile {SMELLS_LIKE}.", {["{USER}"] = "You", ["SMELLS_LINK"] = "shit"})
-- Output would be: You kinda smell like shit.
function xAdmin.Utility.stringReplace(str, tbl)
    if (!tbl) then return str end
    if (table.IsEmpty(tbl)) then return str end
    
    for k, v in pairs(tbl) do
        str = string.Replace(str, k, v)
    end

    return str
end