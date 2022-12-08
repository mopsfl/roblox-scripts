--[[
SCP: Roleplay Rapidfire
gives ur current wepaon rapidfire yes very col
u gotta execute it after u died or respawn

u can also just edit gunsettings module and change TBS to 0 and delete ur gun identifier (in ur weapon tool). then it will keep i think 
]]

local g = getgc(true)
local t = {}

for _, v in pairs(g) do
    if typeof(v) == "table" then
        if rawget(v, "Ammo") and rawget(v, "CurrentAmmo") then
            table.insert(t,v)
        end
    end
end

for _,v in pairs(t) do
    warn()
    v.TBS = 0
end
