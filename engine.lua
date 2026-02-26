--// RIIICUY HUB ENGINE (ULTRA LIGHT VERSION)
-- Kita pakai library yang lebih ringan supaya pasti muncul di Delta

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "riiicuy Hub | Sambung Kata",
    LoadingTitle = "Memuat riiicuy Hub...",
    LoadingSubtitle = "by rizalputraaa",
    ConfigurationSaving = {Enabled = false},
    KeySystem = false
})

-- Variabel Kontrol
local autoEnabled = false
local usedWords = {}

-- Fungsi Logika Jawab
local function solve(letter)
    local rs = game:GetService("ReplicatedStorage")
    local success, dictModule = pcall(function() 
        return require(rs:WaitForChild("WordList"):WaitForChild("IndonesianWords"))
    end)
    
    if not success then return nil end
    
    local choices = {}
    for _, w in ipairs(dictModule) do
        if string.sub(string.lower(w), 1, 1) == string.lower(letter) and not usedWords[w] then
            table.insert(choices, w)
        end
    end
    return #choices > 0 and choices[math.random(1, #choices)] or nil
end

-- // TAB LANGSUNG DIBUAT DISINI
local Tab = Window:CreateTab("Main", 4483362458) 

-- Tombol On/Off
Tab:CreateToggle({
    Name = "Auto Answer (AKTIFKAN DISINI)",
    CurrentValue = false,
    Flag = "Toggle1", 
    Callback = function(Value)
        autoEnabled = Value
    end,
})

-- Tombol Reset
Tab:CreateButton({
    Name = "Reset Kata",
    Callback = function()
        usedWords = {}
    end,
})

-- Loop Deteksi (Diperbaiki agar tidak bikin lag)
task.spawn(function()
    while true do
        task.wait(0.5)
        if autoEnabled then
            pcall(function()
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v:IsA("TextLabel") and v.Name == "LetterLabel" and v.Visible and v.Text ~= "" then
                        local word = solve(v.Text)
                        if word then
                            usedWords[word] = true
                            game:GetService("ReplicatedStorage").Remotes.SubmitWord:FireServer(word)
                            task.wait(2) -- Jeda aman
                        end
                    end
                end
            end)
        end
    end
end)

Rayfield:Notify({
    Title = "riiicuy Hub",
    Content = "Menu Berhasil Muncul!",
    Duration = 5
})
