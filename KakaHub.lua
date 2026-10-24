
-- KAKA HUB V2.5
-- LocalScript > StarterPlayerScripts

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("KakaHub")
if old then old:Destroy() end

local purple = Color3.fromRGB(175, 80, 255)
local dark = Color3.fromRGB(24, 18, 38)
local panel = Color3.fromRGB(43, 32, 61)
local white = Color3.fromRGB(245, 240, 255)

local gui = Instance.new("ScreenGui")
gui.Name = "KakaHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(500, 350)
main.Position = UDim2.new(0.5, -250, 0.5, -175)
main.BackgroundColor3 = dark
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local outline = Instance.new("UIStroke", main)
outline.Color = purple
outline.Thickness = 2

local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, -50, 0, 45)
header.Position = UDim2.fromOffset(14, 0)
header.BackgroundTransparency = 1
header.Text = "KAKA HUB V2.5"
header.TextColor3 = purple
header.TextSize = 21
header.Font = Enum.Font.GothamBold
header.TextXAlignment = Enum.TextXAlignment.Left
header.Parent = main

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(32, 32)
close.Position = UDim2.new(1, -40, 0, 7)
close.Text = "X"
close.TextColor3 = white
close.BackgroundColor3 = Color3.fromRGB(130, 45, 65)
close.Font = Enum.Font.GothamBold
close.Parent = main
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)
close.Activated:Connect(function() gui:Destroy() end)

local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.fromOffset(10, 50)
sidebar.Size = UDim2.new(0, 125, 1, -60)
sidebar.BackgroundColor3 = panel
sidebar.Parent = main
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 8)

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 5)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Parent = sidebar

local sidePadding = Instance.new("UIPadding")
sidePadding.PaddingTop = UDim.new(0, 8)
sidePadding.Parent = sidebar

local content = Instance.new("Frame")
content.Position = UDim2.fromOffset(145, 50)
content.Size = UDim2.new(1, -155, 1, -60)
content.BackgroundColor3 = panel
content.Parent = main
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 8)

local pageTitle = Instance.new("TextLabel")
pageTitle.Position = UDim2.fromOffset(12, 6)
pageTitle.Size = UDim2.new(1, -24, 0, 32)
pageTitle.BackgroundTransparency = 1
pageTitle.TextColor3 = purple
pageTitle.TextSize = 18
pageTitle.Font = Enum.Font.GothamBold
pageTitle.TextXAlignment = Enum.TextXAlignment.Left
pageTitle.Parent = content

local body = Instance.new("ScrollingFrame")
body.Position = UDim2.fromOffset(10, 42)
body.Size = UDim2.new(1, -20, 1, -52)
body.BackgroundTransparency = 1
body.BorderSizePixel = 0
body.ScrollBarThickness = 4
body.AutomaticCanvasSize = Enum.AutomaticSize.Y
body.CanvasSize = UDim2.new()
body.Parent = content

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 7)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = body

local padding = Instance.new("UIPadding")
padding.PaddingBottom = UDim.new(0, 8)
padding.Parent = body

local speed = 16
local rgbOn = false
local rgbConnection

local function clearBody()
    for _, item in ipairs(body:GetChildren()) do
        if not item:IsA("UIListLayout")
            and not item:IsA("UIPadding") then
            item:Destroy()
        end
    end
end

local function info(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -5, 0, 48)
    label.BackgroundColor3 = dark
    label.TextColor3 = white
    label.Text = text
    label.TextWrapped = true
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.Parent = body
    Instance.new("UICorner", label).CornerRadius = UDim.new(0, 7)
end

local function button(text, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -5, 0, 38)
    b.BackgroundColor3 = Color3.fromRGB(75, 47, 105)
    b.TextColor3 = white
    b.Text = text
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 13
    b.Parent = body
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)

    b.Activated:Connect(callback)
    return b
end

local function applySpeed(value)
    speed = math.clamp(value, 0, 100)
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = speed
    end
end

local function setRGB(enabled)
    rgbOn = enabled
    if rgbConnection then
        rgbConnection:Disconnect()
        rgbConnection = nil
    end

    if enabled then
        rgbConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local color = Color3.fromHSV((os.clock() * 0.2) % 1, 0.8, 1)
            outline.Color = color
            header.TextColor3 = color
        end)
    else
        outline.Color = purple
        header.TextColor3 = purple
    end
end

local pages = {
    "Home", "Movement", "House", "RGB",
    "Teleport", "Protection", "Settings"
}

local renderPage

renderPage = function(name)
    pageTitle.Text = string.upper(name)
    clearBody()

    if name == "Home" then
        info("Welcome, " .. player.DisplayName .. "!")
        info("Kaka Hub V2.5 | Neon Purple UI")
        info("Pilih menu di sebelah kiri.")

    elseif name == "Movement" then
        info("Movement settings")
        info("Current WalkSpeed: " .. speed)

        button("Speed + 5", function()
            applySpeed(speed + 5)
            renderPage("Movement")
        end)

        button("Speed - 5", function()
            applySpeed(speed - 5)
            renderPage("Movement")
        end)

        button("Reset Speed (16)", function()
            applySpeed(16)
            renderPage("Movement")
        end)

    elseif name == "House" then
        info("HOUSE")
        info("Menu ini perlu dihubungkan ke sistem rumah game milikmu.")
        button("House system: not configured", function()
            info("Buat sistem rumah di Roblox Studio untuk mengaktifkan fitur ini.")
        end)

    elseif name == "RGB" then
        info("RGB UI effects")
        button(rgbOn and "Turn RGB OFF" or "Turn RGB ON", function()
            setRGB(not rgbOn)
            renderPage("RGB")
        end)

    elseif name == "Teleport" then
        info("TELEPORT")
        info("Tambahkan titik tujuan yang valid di game milikmu.")
        button("Teleport points: not configured", function()
            info("Titik teleport belum dibuat.")
        end)

    elseif name == "Protection" then
        info("PROTECTION")
        info("Perlindungan game harus dibuat dan divalidasi oleh server.")
        button("Protection: not configured", function()
            info("Belum ada sistem protection yang terhubung.")
        end)

    elseif name == "Settings" then
        info("KAKA HUB SETTINGS")
        button("Toggle RGB", function()
            setRGB(not rgbOn)
            renderPage("Settings")
        end)
        button("Reset WalkSpeed", function()
            applySpeed(16)
            renderPage("Settings")
        end)
        button("Close Hub", function()
            gui:Destroy()
        end)
    end

    for _, child in ipairs(sidebar:GetChildren()) do
        if child:IsA("TextButton") then
            child.BackgroundColor3 =
                child.Name == name and purple
                or Color3.fromRGB(55, 39, 75)
        end
    end
end

for _, name in ipairs(pages) do
    local b = Instance.new("TextButton")
    b.Name = name
    b.Size = UDim2.new(1, -12, 0, 36)
    b.BackgroundColor3 = Color3.fromRGB(55, 39, 75)
    b.TextColor3 = white
    b.Text = name
    b.TextSize = 12
    b.Font = Enum.Font.GothamSemibold
    b.Parent = sidebar
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)

    b.Activated:Connect(function()
        renderPage(name)
    end)
end

player.CharacterAdded:Connect(function()
    task.wait(0.5)
    applySpeed(speed)
end)

renderPage("Home")
