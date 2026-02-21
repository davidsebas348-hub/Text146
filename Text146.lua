-- =========================
-- TOGGLE AUTO SHOOT
-- =========================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

if _G.AUTO_SHOOT_LOOP then
	_G.AUTO_SHOOT_LOOP = false
	print("AutoShoot Murderer: OFF")
	return
end

_G.AUTO_SHOOT_LOOP = true
print("AutoShoot Murderer: ON")

local SHOOT_INTERVAL = 0.1
local MAX_DISTANCE = 1000

-- =========================
-- Función para verificar visibilidad
-- =========================
local function isVisible(origin, target)
	local direction = (target.Position - origin.Position).Unit * MAX_DISTANCE
	local rayParams = RaycastParams.new()
	rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
	rayParams.FilterType = Enum.RaycastFilterType.Blacklist
	local result = Workspace:Raycast(origin.Position, direction, rayParams)

	return not result or result.Instance:IsDescendantOf(target.Parent)
end

-- =========================
-- Función principal
-- =========================
local function autoShoot(character)

	while _G.AUTO_SHOOT_LOOP and character and character.Parent do

		local hrp = character:FindFirstChild("HumanoidRootPart")
		if hrp then
			local gun = character:FindFirstChild("Gun")

			for _, plr in pairs(Players:GetPlayers()) do
				if not _G.AUTO_SHOOT_LOOP then break end

				if plr ~= LocalPlayer and plr.Character then
					local targetHRP = plr.Character:FindFirstChild("HumanoidRootPart")
					local knife = plr.Character:FindFirstChild("Knife")
						or (plr:FindFirstChild("Backpack") and plr.Backpack:FindFirstChild("Knife"))

					if knife and targetHRP and isVisible(hrp, targetHRP) then

						-- Equipar Gun si está en Backpack
						if not gun then
							local backpack = LocalPlayer:FindFirstChild("Backpack")
							if backpack then
								local toolGun = backpack:FindFirstChild("Gun")
								if toolGun then
									toolGun.Parent = character
									gun = toolGun
								end
							end
						end

						-- Disparar si ya tenemos Gun equipada
						if gun then
							local shootRemote = gun:FindFirstChild("Shoot")
							if shootRemote then
								shootRemote:FireServer(
									CFrame.new(hrp.Position, targetHRP.Position),
									CFrame.new(targetHRP.Position)
								)
							end
						end
					end
				end
			end
		end

		task.wait(SHOOT_INTERVAL)
	end
end

-- =========================
-- Ejecutar
-- =========================

task.spawn(function()
	autoShoot(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait())
end)

LocalPlayer.CharacterAdded:Connect(function(char)
	if _G.AUTO_SHOOT_LOOP then
		task.spawn(function()
			autoShoot(char)
		end)
	end
end)
