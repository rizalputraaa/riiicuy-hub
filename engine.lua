--// RIICUY HUB - ALL IN ONE STABLE (FIXED FOR DELTA)
--// Merged & Fixed version of Sazarax's Script

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")

--// 1. NOTIFIKASI AWAL (RIICUY STYLE)
local function notify(title, text)
    local sg = Instance.new("ScreenGui", lp.PlayerGui)
    local f = Instance.new("Frame", sg)
    f.Size = UDim2.new(0, 250, 0, 80)
    f.Position = UDim2.new(0.5, 0, 0.1, 0)
    f.AnchorPoint = Vector2.new(0.5, 0.5)
    f.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    Instance.new("UICorner", f)
    local s = Instance.new("UIStroke", f)
    s.Color = Color3.fromRGB(0, 255, 150)
    
    local t = Instance.new("TextLabel", f)
    t.Size = UDim2.new(1, 0, 1, 0)
    t.BackgroundTransparency = 1
    t.Text = title .. "\n" .. text
    t.TextColor3 = Color3.new(1, 1, 1)
    t.Font = Enum.Font.GothamBold
    t.TextSize = 14
    task.delay(4, function() sg:Destroy() end)
end

notify("RIICUY HUB", "Sistem Siap Diaktifkan!")

--// 2. UI PANEL SEDERHANA (Agar Pasti Muncul)
local ScreenGui = Instance.new("ScreenGui", lp.PlayerGui)
ScreenGui.Name = "RiicuyMainUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 180, 0, 100)
Frame.Position = UDim2.new(0.5, -90, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Frame.Active = true
Frame.Draggable = true -- Bisa digeser di Delta
Instance.new("UICorner", Frame)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Text = "RIICUY AUTO KATA"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Instance.new("UICorner", Title)

local Toggle = Instance.new("TextButton", Frame)
Toggle.Size = UDim2.new(0.8, 0, 0, 35)
Toggle.Position = UDim2.new(0.1, 0, 0.4, 0)
Toggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Toggle.Text = "AUTO: OFF"
Toggle.TextColor3 = Color3.new(1, 1, 1)
Toggle.Font = Enum.Font.GothamBold
Instance.new("UICorner", Toggle)

--// 3. LOGIKA AUTO ANSWER
local autoEnabled = false
local usedWords = {}

local function getWord(letter)
    local success, wordModule = pcall(function()
        return require(rs:WaitForChild("WordList"):WaitForChild("IndonesianWords"))
    end)
    if not success then return nil end
    
    local possible = {}
    for _, w in ipairs(wordModule) do
        if string.sub(string.lower(w), 1, 1) == string.lower(letter) and not usedWords[w] then
            table.insert(possible, w)
        end
    end
    return #possible > 0 and possible[math.random(1, #possible)] or nil
end

-- Toggle Click
Toggle.MouseButton1Click:Connect(function()
    autoEnabled = not autoEnabled
    if autoEnabled then
        Toggle.Text = "AUTO: ON"
        Toggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        notify("RIICUY HUB", "Auto Answer Aktif")
    else
        Toggle.Text = "AUTO: OFF"
        Toggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

--// 4. MAIN LOOP (Monitoring Game)
task.spawn(function()
    while task.wait(0.5) do
        if autoEnabled then
            pcall(function()
                -- Mencari LetterLabel seperti di script asli sazaraax
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("TextLabel") and v.Name == "LetterLabel" and v.Visible and v.Text ~= "" then
                        local char = v.Text
                        task.wait(1) -- Jeda biar gak kick
                        local word = getWord(char)
                        if word then
                            usedWords[word] = true
                            rs.Remotes.SubmitWord:FireServer(word)
                        end
                    end
                end
            end)
        end
    end
end)

print("RIICUY HUB LOADED SUCCESSFULLY")                    end
                end
            end)
        end
    end
end)

print("riiicuy Hub Engine Loaded Successfully!")
