--[[
Blacksite Zeta Local Anticheat Bypass for Fly & Noclip | working as of 12/24/2022
]]

RunService.Stepped:Connect(function()
	local char = game.Players.LocalPlayer.Character
	if not char then return end
	local upt = char:FindFirstChild("UpperTorso")
	if not upt then return end

	--fly
	for _,v in pairs(getconnections(game.Players.LocalPlayer.Character.DescendantAdded)) do
		v:Disable()
	end
	--noclip
	for _,v in pairs(getconnections(upt:GetPropertyChangedSignal("CanCollide"))) do
		v:Disable()
	end
end)

--made by mopsfl
