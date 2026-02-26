--// RIIICUY HUB ENGINE (STABLE)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "riiicuy Hub | Sambung Kata",
    LoadingTitle = "riiicuy Hub",
    LoadingSubtitle = "by rizalputraaa",
})

local autoEnabled = false
local usedWords = {}

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

task.spawn(function()
    while task.wait(0.4) do
        if autoEnabled then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("TextLabel") and v.Name == "LetterLabel" and v.Visible and v.Text ~= "" then
                    local word = solve(v.Text)
                    if word then
                        usedWords[word] = true
                        game:GetService("ReplicatedStorage").Remotes.SubmitWord:FireServer(word)
                        task.wait(1.5)
                    end
                end
            end
        end
    end
end)

local Tab = Window:CreateTab("Utama")
Tab:CreateToggle({
    Name = "Auto Answer",
    CurrentValue = false,
    Callback = function(v) autoEnabled = v end
})
