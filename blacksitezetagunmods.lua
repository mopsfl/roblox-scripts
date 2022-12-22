--[[
Blacksite Zeta OP Gun Mods | 12/22/2022
This will be patched soon (probably)
]]


local gunstatsbackup = nil
local game_client = {}
local gungarbageforbypassthebadexploitfix = {}

--get client stuff
function loadClientStuff()
	local garbage = getgc(true)
	local loaded_modules = getloadedmodules()
	
	for i = 1, #garbage do
		local v = garbage[i]
		if typeof(v) == "table" then
			if rawget(v, "SetWalkspeed")  then
				game_client.character = v
			elseif rawget(v, "AddWeapon") then
				game_client.main_weapon = v
			elseif rawget(v, "RemoveCatagory") then
				game_client.key_control = v
			end
		end
	end
end; loadClientStuff()

--func to reset guns so all gun mods will be applied correctly
local function resetguns()
    if not game_client.main_weapon.CurrentWeapons then return warn("no guns found") end
    local currentWeapons = {}
	for _,weapon in pairs(game_client.main_weapon.CurrentWeapons) do
		table.insert(currentWeapons, weapon)
	end
	for _,v in pairs(currentWeapons) do
		if gunstatsbackup:FindFirstChild(v.Tool.Name) then
			local module = require(gunstatsbackup:FindFirstChild(v.Tool.Name))
			if module then
				if not game_client.main_weapon then
    			    loadClientStuff()
    	    	end
        		pcall(function()
        			game_client.main_weapon.Reset()
        		end)
			end
		end
	end
end

--this is a part of the patch fix a dev made wich is very bad
function loadGunGarbageForPoopBypassOfTheGunModsExploitPatchBySoftware()
	for _, v in pairs(getgc(true)) do
		if typeof(v) == "table" and rawget(v, "FireDelay") then
			table.insert(gungarbageforbypassthebadexploitfix, v)
		end
	end
end

--search backup folder, he wants to troll me and renamed it lol this noob
for _,v in pairs(game:GetService("ReplicatedStorage").Assets:GetChildren()) do
	if v.Name ~= "WeaponModules" and v:FindFirstChild("M9 Beretta") then
		gunstatsbackup = v
	end
end

--function to edit gun data
function modifyGunData(data, value, modulevalue)
	if not game_client.main_weapon then
		loadClientStuff()
	end
	if not game_client.main_weapon then
		return
	end
	local currentWeapons = {}
	for _,weapon in pairs(game_client.main_weapon.CurrentWeapons) do
		table.insert(currentWeapons, weapon)
	end
	
	for _, weaponData in pairs(currentWeapons) do
		local s,e = pcall(function()
			if not modulevalue and weaponData[data] and typeof(weaponData[data]) == typeof(value) then
				weaponData[data] = value
			elseif modulevalue and game:GetService("ReplicatedStorage").Assets.WeaponModules:FindFirstChild(weaponData.Tool.Name) then
				--bypass for the new 'gun mods exploit patch'
				if #gungarbageforbypassthebadexploitfix < 1 then
					loadGunGarbageForPoopBypassOfTheGunModsExploitPatchBySoftware()
				end
				if #gungarbageforbypassthebadexploitfix < 1 then
					return
				end
				for _, v in pairs(gungarbageforbypassthebadexploitfix) do
					if v[data] and typeof(v[data]) == typeof(value) then
						v[data] = value
					end
				end
				--edit gun values
				local module = require(game:GetService("ReplicatedStorage").Assets.WeaponModules:FindFirstChild(weaponData.Tool.Name))
				if module[data] and typeof(module[data]) == typeof(value) then
					module[data] = value
				end
			end
		end)
	end
end;

--no recoil
modifyGunData("CamRecoilMin", Vector3.new(0,0,0), true)
modifyGunData("CamRecoilMax", Vector3.new(0,0,0), true)
--no spread
modifyGunData("AccuracyMin", Vector3.new(-0,-0,0), true)
modifyGunData("AccuracyMax", Vector3.new(0,0,0), true)

--rapidfire
modifyGunData("firedelay", 0.05)
modifyGunData("FireDelay", 0.05, true)
modifyGunData("FireMode", "Auto", true)
modifyGunData("firemode", "Auto")

--inf ammo
modifyGunData("clipsize", 9999999999)
modifyGunData("ClipSize", 9999999999, true)
modifyGunData("ammo", 9999999999)

--reset gun
task.spawn(resetguns)


--made by mopsfl
