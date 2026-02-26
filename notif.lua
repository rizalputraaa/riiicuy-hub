--// RIIICUY HUB NOTIFIER
local lp = game:GetService("Players").LocalPlayer
local sg = Instance.new("ScreenGui", lp.PlayerGui)
local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 260, 0, 80)
f.Position = UDim2.new(0.5, 0, 0.15, 0)
f.AnchorPoint = Vector2.new(0.5, 0.5)
f.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Instance.new("UICorner", f)
local s = Instance.new("UIStroke", f)
s.Color = Color3.fromRGB(0, 255, 150)
s.Thickness = 2

local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 1, 0)
t.BackgroundTransparency = 1
t.Text = "riiicuy Hub Online!\nBy rizalputraaa"
t.TextColor3 = Color3.new(1, 1, 1)
t.Font = Enum.Font.GothamBold
t.TextSize = 14

task.delay(5, function() sg:Destroy() end)
