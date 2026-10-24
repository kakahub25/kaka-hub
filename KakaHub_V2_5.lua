-- KAKA HUB V2.5 - UI starter for Roblox Studio
-- Place this LocalScript in StarterPlayer > StarterPlayerScripts.
-- Designed for your own Roblox experience / authorized testing.
-- This is a UI starter, not a Brookhaven executor exploit.
-- Server-owned features (global RGB name/bio, house bans, teleport, etc.)
-- require supported game systems and server-side code.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local PURPLE = Color3.fromRGB(151, 82, 255)
local DARK = Color3.fromRGB(16, 14, 24)
local PANEL = Color3.fromRGB(27, 23, 39)
local TEXT = Color3.fromRGB(245, 240, 255)
local MUTED = Color3.fromRGB(170, 160, 190)

local gui = Instance.new("ScreenGui")
gui.Name = "KakaHubV25"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(620, 390)
main.Position = UDim2.new(0.5, -310, 0.5, -195)
main.BackgroundColor3 = DARK
main.BorderSizePixel = 0
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)
local stroke = Instance.new("UIStroke", main)
stroke.Color = PURPLE
stroke.Thickness = 1.5

local scale = Instance.new("UIScale")
scale.Scale = 1
scale.Parent = main

local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 54)
top.BackgroundColor3 = PANEL
top.BorderSizePixel = 0
top.Parent = main
Instance.new("UICorner", top).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(18, 0)
title.Size = UDim2.new(1, -90, 1, 0)
title.Font = Enum.Font.GothamBold
title.Text = "♛  KAKA HUB  V2.5"
title.TextColor3 = TEXT
title.TextSize = 19
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(34, 34)
close.Position = UDim2.new(1, -45, 0, 10)
close.BackgroundColor3 = Color3.fromRGB(65, 35, 85)
close.Text = "×"
close.TextColor3 = TEXT
close.TextSize = 25
close.Font = Enum.Font.GothamBold
close.Parent = top
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 9)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Drag window using the title bar.
do
    local dragging, dragStart, startPos
    top.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
end

local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.fromOffset(12, 66)
sidebar.Size = UDim2.fromOffset(150, 310)
sidebar.BackgroundColor3 = PANEL
sidebar.BorderSizePixel = 0
sidebar.Parent = main
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)

local navLayout = Instance.new("UIListLayout")
navLayout.Padding = UDim.new(0, 6)
navLayout.SortOrder = Enum.SortOrder.LayoutOrder
navLayout.Parent = sidebar
local navPadding = Instance.new("UIPadding", sidebar)
navPadding.PaddingTop = UDim.new(0, 10)
navPadding.PaddingLeft = UDim.new(0, 8)
navPadding.PaddingRight = UDim.new(0, 8)

local content = Instance.new("ScrollingFrame")
content.Position = UDim2.fromOffset(174, 66)
content.Size = UDim2.new(1, -186, 1, -78)
content.BackgroundColor3 = PANEL
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = PURPLE
content.CanvasSize = UDim2.new()
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.Parent = main
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 10)
local contentPadding = Instance.new("UIPadding", content)
contentPadding.PaddingTop = UDim.new(0, 12)
contentPadding.PaddingLeft = UDim.new(0, 12)
contentPadding.PaddingRight = UDim.new(0, 12)
contentPadding.PaddingBottom = UDim.new(0, 12)
local contentLayout = Instance.new("UIListLayout", content)
contentLayout.Padding = UDim.new(0, 9)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder

local status = Instance.new("TextLabel")
status.BackgroundTransparency = 1
status.Size = UDim2.new(1, 0, 0, 24)
status.Font = Enum.Font.Gotham
status.Text = "READY • Local UI"
status.TextColor3 = MUTED
status.TextSize = 12
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = content

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if child ~= contentPadding and child ~= contentLayout then child:Destroy() end
    end
end

local function makeLabel(text, height)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 0, height or 26)
    label.Font = Enum.Font.GothamBold
    label.Text = text
    label.TextColor3 = TEXT
    label.TextSize = 15
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = content
    return label
end

local function makeButton(text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 36)
    button.BackgroundColor3 = Color3.fromRGB(48, 36, 66)
    button.Text = text
    button.TextColor3 = TEXT
    button.TextSize = 13
    button.Font = Enum.Font.GothamSemibold
    button.AutoButtonColor = true
    button.Parent = content
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
    button.MouseButton1Click:Connect(callback or function()
        status.Text = "INFO • This feature needs game support"
    end)
    return button
end

local function makeToggle(labelText, callback)
    local enabled = false
    local button
    button = makeButton(labelText .. "  [OFF]", function()
        enabled = not enabled
        button.Text = labelText .. (enabled and "  [ON]" or "  [OFF]")
        button.BackgroundColor3 = enabled and Color3.fromRGB(78, 43, 112) or Color3.fromRGB(48, 36, 66)
        if callback then callback(enabled) end
    end)
    return button
end

local function makeSpeedSlider()
    makeLabel("WalkSpeed: 16", 24)
    local valueLabel = content:GetChildren()[#content:GetChildren()]
    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, 0, 0, 28)
    track.BackgroundColor3 = Color3.fromRGB(43, 37, 55)
    track.Parent = content
    Instance.new("UICorner", track).CornerRadius = UDim.new(0, 8)
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(15/100, 0, 1, 0)
    fill.BackgroundColor3 = PURPLE
    fill.Parent = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 8)
    local knob = Instance.new("TextButton")
    knob.Size = UDim2.fromOffset(26, 26)
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.Position = UDim2.new(15/100, 0, 0.5, 0)
    knob.Text = ""
    knob.BackgroundColor3 = TEXT
    knob.Parent = track
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local value = 16
    local dragging = false
    local function setFromX(x)
        local percent = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        value = math.floor(1 + percent * 99)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        knob.Position = UDim2.new(percent, 0, 0.5, 0)
        valueLabel.Text = "WalkSpeed: " .. value
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.WalkSpeed = value end
        status.Text = "ACTIVE • Local test WalkSpeed = " .. value
    end
    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            setFromX(input.Position.X)
        end
    end)
    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            setFromX(input.Position.X)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            setFromX(input.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
    makeButton("Reset Movement", function()
        value = 16
        fill.Size = UDim2.new(15/100, 0, 1, 0)
        knob.Position = UDim2.new(15/100, 0, 0.5, 0)
        valueLabel.Text = "WalkSpeed: 16"
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.WalkSpeed = 16 end
        status.Text = "READY • Movement reset"
    end)
end

local pages = {
    Home = function()
        makeLabel("Welcome to Kaka Hub V2.5", 30)
        makeButton("UI Status: READY", function() status.Text = "READY • UI is running" end)
        makeLabel("This starter runs in your own Roblox Studio experience.", 44)
        makeLabel("Choose a tab on the left to view the planned features.", 44)
    end,
    Movement = function()
        makeLabel("MOVEMENT")
        makeSpeedSlider()
        makeToggle("Fly (placeholder)", function(on)
            status.Text = on and "INFO • Fly requires a supported game mechanic" or "READY • Fly toggle off"
        end)
        makeToggle("Noclip Ultimate (placeholder)", function(on)
            status.Text = on and "INFO • Noclip only for authorized Studio testing" or "READY • Noclip toggle off"
        end)
    end,
    House = function()
        makeLabel("HOUSE")
        makeButton("RGB House", function() status.Text = "INFO • RGB House needs a house model you own/control" end)
        makeButton("Target House", function() status.Text = "INFO • Target selection needs a supported house system" end)
        makeButton("TP to House", function() status.Text = "INFO • Teleport needs an allowed destination in your own game" end)
        makeButton("Vault Bank House", function() status.Text = "INFO • Requires a supported game mechanic" end)
        makeButton("Troll Bell to House", function() status.Text = "INFO • Use only non-disruptive roleplay behavior" end)
        makeButton("House Ban Manager", function() status.Text = "INFO • Cannot forcibly remove another player's server-side ban" end)
    end,
    RGB = function()
        makeLabel("RGB EFFECTS")
        makeToggle("RGB Name (local preview)", function(on) status.Text = on and "ACTIVE • Local name preview only" or "READY • RGB name preview off" end)
        makeToggle("RGB Bio (local preview)", function(on) status.Text = on and "ACTIVE • Local bio preview only" or "READY • RGB bio preview off" end)
        makeToggle("Speed RGB Name", function(on) status.Text = on and "ACTIVE • Animation speed setting planned" or "READY • RGB name speed off" end)
        makeToggle("Speed RGB Bio", function(on) status.Text = on and "ACTIVE • Animation speed setting planned" or "READY • RGB bio speed off" end)
        makeToggle("RGB Skin (preview)", function(on) status.Text = on and "INFO • Skin changes need supported avatar/game systems" or "READY • RGB skin off" end)
    end,
    Teleport = function()
        makeLabel("TELEPORT")
        for _, place in ipairs({"Town Fountain", "Hospital", "Police Station", "Fire Station", "High School", "Airport", "Bank", "Beach", "Mountain", "Prison", "Motel", "Downtown", "Favorite Locations"}) do
            makeButton(place, function() status.Text = "INFO • " .. place .. " needs a valid destination in your own game" end)
        end
    end,
    Protection = function()
        makeLabel("PROTECTION")
        makeToggle("Anti-Sit (placeholder)")
        makeToggle("Anti-Lag (visual placeholder)")
        makeToggle("Anti-Troll Helicopter (placeholder)")
        makeToggle("Anti-Troll Ball (placeholder)")
        makeToggle("Anti-Troll Door (placeholder)")
        makeLabel("Protection buttons need game-specific, authorized implementation.", 44)
    end,
    Settings = function()
        makeLabel("SETTINGS")
        makeButton("Emergency Stop / Reset UI", function()
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.WalkSpeed = 16 end
            status.Text = "READY • Local movement reset"
        end)
        makeButton("Close Kaka Hub", function() gui:Destroy() end)
        makeLabel("TikTok: @abdy.putraa", 26)
        makeLabel("Some items are placeholders until supported game systems are added.", 48)
    end,
}

local function showPage(pageName)
    clearContent()
    status = Instance.new("TextLabel")
    status.BackgroundTransparency = 1
    status.Size = UDim2.new(1, 0, 0, 24)
    status.Font = Enum.Font.Gotham
    status.Text = "READY • " .. pageName
    status.TextColor3 = MUTED
    status.TextSize = 12
    status.TextXAlignment = Enum.TextXAlignment.Left
    status.Parent = content
    pages[pageName]()
end

for _, name in ipairs({"Home", "Movement", "House", "RGB", "Teleport", "Protection", "Settings"}) do
    local button = Instance.new("TextButton")
    button.Name = name .. "Tab"
    button.Size = UDim2.new(1, 0, 0, 36)
    button.BackgroundColor3 = name == "Home" and Color3.fromRGB(78, 43, 112) or PANEL
    button.Text = name
    button.TextColor3 = TEXT
    button.TextSize = 13
    button.Font = Enum.Font.GothamSemibold
    button.Parent = sidebar
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
    button.MouseButton1Click:Connect(function()
        for _, other in ipairs(sidebar:GetChildren()) do
            if other:IsA("TextButton") then other.BackgroundColor3 = PANEL end
        end
        button.BackgroundColor3 = Color3.fromRGB(78, 43, 112)
        showPage(name)
    end)
end

-- Keep the UI within screen bounds on small displays.
local function updateScale()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local viewport = camera.ViewportSize
    scale.Scale = math.min(1, viewport.X / 660, viewport.Y / 430)
end
updateScale()
if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
end

showPage("Home")
