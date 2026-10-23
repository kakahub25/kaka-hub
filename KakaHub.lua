
-- Kaka Hub | Neon Purple UI
-- Untuk LocalScript di Roblox Studio

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "KakaHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 320, 0, 230)
main.Position = UDim2.new(0.5, -160, 0.5, -115)
main.BackgroundColor3 = Color3.fromRGB(25, 16, 42)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(170, 70, 255)
stroke.Thickness = 2
stroke.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 48)
title.BackgroundColor3 = Color3.fromRGB(65, 30, 105)
title.Text = "KAKA HUB V2.5"
title.TextColor3 = Color3.fromRGB(235, 210, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = main

local function addButton(text, y)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -24, 0, 38)
    button.Position = UDim2.new(0, 12, 0, y)
    button.BackgroundColor3 = Color3.fromRGB(75, 40, 115)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = text
    button.Font = Enum.Font.GothamMedium
    button.TextSize = 14
    button.Parent = main

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = button

    return button
end

addButton("TARGET PLAYER", 62)
addButton("MOVEMENT SETTINGS", 108)
addButton("PROTECTION OPTIONS", 154)

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 28, 0, 28)
close.Position = UDim2.new(1, -34, 0, 8)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.BackgroundColor3 = Color3.fromRGB(120, 35, 150)
close.Parent = main

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

