-- ======================
-- MOVIMIENTO Y SALTO (W / S / SPACE)
-- TOGGLE POR EJECUCIÓN
-- ======================

local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- ======================
-- TOGGLE GLOBAL
-- ======================
_G.MoveGuiEnabled = not _G.MoveGuiEnabled

-- Si ya existe, destruir y salir
local oldGui = PlayerGui:FindFirstChild("MoveButtons")
if oldGui then
    oldGui:Destroy()
end

if not _G.MoveGuiEnabled then
    print("❌ Move GUI desactivado")
    return
end

print("✅ Move GUI activado")

-- ======================
-- GUI
-- ======================
local gui = Instance.new("ScreenGui")
gui.Name = "MoveButtons"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

-- ======================
-- BOTÓN ADELANTE (W)
-- ======================
local forward = Instance.new("TextButton")
forward.Size = UDim2.new(0, 80, 0, 80)
forward.Position = UDim2.new(0.75, 0, 0.6, 0)
forward.Text = "▲"
forward.TextSize = 40
forward.BackgroundColor3 = Color3.fromRGB(30,30,30)
forward.TextColor3 = Color3.new(1,1,1)
forward.Active = true
forward.Draggable = true
forward.Parent = gui

-- ======================
-- BOTÓN ATRÁS (S)
-- ======================
local back = Instance.new("TextButton")
back.Size = UDim2.new(0, 80, 0, 80)
back.Position = UDim2.new(0.75, 0, 0.75, 0)
back.Text = "▼"
back.TextSize = 40
back.BackgroundColor3 = Color3.fromRGB(30,30,30)
back.TextColor3 = Color3.new(1,1,1)
back.Active = true
back.Draggable = true
back.Parent = gui

-- ======================
-- BOTÓN SALTAR (SPACE)
-- ======================
local jump = Instance.new("TextButton")
jump.Size = UDim2.new(0, 80, 0, 80)
jump.Position = UDim2.new(0.85, 0, 0.675, 0)
jump.Text = "⮝"
jump.TextSize = 40
jump.BackgroundColor3 = Color3.fromRGB(30,30,30)
jump.TextColor3 = Color3.new(1,1,1)
jump.Active = true
jump.Draggable = true
jump.Parent = gui

-- ======================
-- FUNCIONES
-- ======================
local function pressKey(key)
    VirtualInputManager:SendKeyEvent(true, key, false, game)
end

local function releaseKey(key)
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end

-- ======================
-- CONTROLES
-- ======================
forward.MouseButton1Down:Connect(function()
    pressKey(Enum.KeyCode.W)
end)
forward.MouseButton1Up:Connect(function()
    releaseKey(Enum.KeyCode.W)
end)
forward.MouseLeave:Connect(function()
    releaseKey(Enum.KeyCode.W)
end)

back.MouseButton1Down:Connect(function()
    pressKey(Enum.KeyCode.S)
end)
back.MouseButton1Up:Connect(function()
    releaseKey(Enum.KeyCode.S)
end)
back.MouseLeave:Connect(function()
    releaseKey(Enum.KeyCode.S)
end)

jump.MouseButton1Down:Connect(function()
    pressKey(Enum.KeyCode.Space)
end)
jump.MouseButton1Up:Connect(function()
    releaseKey(Enum.KeyCode.Space)
end)
jump.MouseLeave:Connect(function()
    releaseKey(Enum.KeyCode.Space)
end)
