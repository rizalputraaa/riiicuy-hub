--// RIIICUY HUB ENGINE (STABLE & FIXED UI)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "riiicuy Hub | Sambung Kata",
    LoadingTitle = "riiicuy Hub",
    LoadingSubtitle = "by rizalputraaa",
    ConfigurationSaving = {
        Enabled = false
    },
    KeySystem = false -- Kita matikan key system agar langsung masuk
})

local autoEnabled = false
local usedWords = {}

-- Fungsi Logika Pencari Kata
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

-- Monitor Giliran secara Otomatis
task.spawn(function()
    while task.wait(0.4) do
        if autoEnabled then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("TextLabel") and v.Name == "LetterLabel" and v.Visible and v.Text ~= "" then
                    local word = solve(v.Text)
                    if word then
                        usedWords[word] = true
                        game:GetService("ReplicatedStorage").Remotes.SubmitWord:FireServer(word)
                        task.wait(1.5) -- Jeda agar tidak dianggap spam bot
                    end
                end
            end
        end
    end
end)

-- // TAB UTAMA
local MainTab = Window:CreateTab("Utama", 4483362458) -- Menambahkan Icon

local MainSection = MainTab:CreateSection("Main Automation")

MainTab:CreateToggle({
    Name = "Auto Answer riiicuy",
    CurrentValue = false,
    Flag = "AutoAnswerToggle", 
    Callback = function(Value)
        autoEnabled = Value
        if Value then
            Rayfield:Notify({
                Title = "riiicuy Hub",
                Content = "Auto Answer AKTIF!",
                Duration = 3,
                Image = 4483362458,
            })
        else
            Rayfield:Notify({
                Title = "riiicuy Hub",
                Content = "Auto Answer MATI!",
                Duration = 3,
                Image = 4483362458,
            })
        end
    end,
})

MainTab:CreateButton({
    Name = "Reset Daftar Kata",
    Callback = function()
        usedWords = {}
        Rayfield:Notify({
            Title = "Selesai",
            Content = "Daftar kata yang sudah dipakai telah direset.",
            Duration = 2,
            Image = 4483362458,
        })
    end,
})

-- // TAB INFO
local InfoTab = Window:CreateTab("Credits", 4483362458)
InfoTab:CreateParagraph({Title = "Owner", Content = "rizalputraaa"})
InfoTab:CreateParagraph({Title = "Support", Content = "Terima kasih telah menggunakan riiicuy Hub!"})

Rayfield:LoadConfiguration()
