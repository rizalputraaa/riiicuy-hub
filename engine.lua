--// RIIICUY HUB - ANTI ERROR UI (NO LIBRARY VERSION)
local player = game:GetService("Players").LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- Hapus UI lama kalau sudah ada
if pgui:FindFirstChild("riiicuyHubUI") then
    pgui.riiicuyHubUI:Destroy()
end

-- VARIABEL
local autoEnabled = false
local usedWords = {}

-- UI CONSTRUCTION (Sederhana tapi keren)
local ScreenGui = Instance.new("ScreenGui", pgui)
ScreenGui.Name = "riiicuyHubUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.Active = true
MainFrame.Draggable = true -- Bisa kamu geser-geser di layar

local Corner = Instance.new("UICorner", MainFrame)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(0, 255, 150)
Stroke.Thickness = 2

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "RIICUY HUB v2"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Instance.new("UICorner", Title)

-- TOMBOL TOGGLE
local ToggleBtn = Instance.new("TextButton", MainFrame)
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 40)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Merah (Mati)
ToggleBtn.Text = "Auto: OFF"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 14
Instance.new("UICorner", ToggleBtn)

-- TOMBOL RESET
local ResetBtn = Instance.new("TextButton", MainFrame)
ResetBtn.Size = UDim2.new(0.8, 0, 0, 30)
ResetBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
ResetBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
ResetBtn.Text = "Reset Kata"
ResetBtn.TextColor3 = Color3.new(1, 1, 1)
ResetBtn.Font = Enum.Font.Gotham
ResetBtn.TextSize = 12
Instance.new("UICorner", ResetBtn)

-- LOGIKA AUTO ANSWER
local function solve(letter)
    local rs = game:GetService("ReplicatedStorage")
    local success, dict = pcall(function() 
        return require(rs:WaitForChild("WordList"):WaitForChild("IndonesianWords"))
    end)
    if not success then return nil end
    local choices = {}
    for _, w in ipairs(dict) do
        if string.sub(string.lower(w), 1, 1) == string.lower(letter) and not usedWords[w] then
            table.insert(choices, w)
        end
    end
    return #choices > 0 and choices[math.random(1, #choices)] or nil
end

-- Fungsi Klik Toggle
ToggleBtn.MouseButton1Click:Connect(function()
    autoEnabled = not autoEnabled
    if autoEnabled then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50) -- Hijau (Nyala)
        ToggleBtn.Text = "Auto: ON"
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Merah
        ToggleBtn.Text = "Auto: OFF"
    end
end)

-- Fungsi Klik Reset
ResetBtn.MouseButton1Click:Connect(function()
    usedWords = {}
    ResetBtn.Text = "Berhasil Direset!"
    task.wait(1)
    ResetBtn.Text = "Reset Kata"
end)

-- LOOP UTAMA
task.spawn(function()
    while task.wait(0.5) do
        if autoEnabled then
            pcall(function()
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v:IsA("TextLabel") and v.Name == "LetterLabel" and v.Visible and v.Text ~= "" then
                        local word = solve(v.Text)
                        if word then
                            usedWords[word] = true
                            game:GetService("ReplicatedStorage").Remotes.SubmitWord:FireServer(word)
                            task.wait(2)
                        end
                    end
                end
            end)
        end
    end
end)

print("riiicuy Hub Engine Loaded Successfully!")
