--// RIICUY UPDATE GUI PRO
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

if player:WaitForChild("PlayerGui"):FindFirstChild("RiicuyUpdateGUI") then
    player.PlayerGui.RiicuyUpdateGUI:Destroy()
end

local AUTO_CLOSE_TIME = 8 

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RiicuyUpdateGUI"
ScreenGui.Parent = player.PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 400, 0, 150)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Parent = ScreenGui

local UIStroke = Instance.new("UIStroke", Frame)
UIStroke.Color = Color3.fromRGB(255, 170, 0)
UIStroke.Thickness = 2

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.Text = "⚠ Riicuy Script Sedang Di Update ⚠"
TextLabel.TextColor3 = Color3.fromRGB(255, 170, 0)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextScaled = true
TextLabel.BackgroundTransparency = 1
TextLabel.Parent = Frame

-- (Logika Drag & Close tetap sama namun dengan identitas Riicuy)
