-- =========================================================
-- RIICUY SMART AUTO KATA (RAYFIELD EDITION - MOBILE FIXED)
-- =========================================================

local DEBUG_MODE = true
local SCRIPT_VERSION = "2.2.0"

-- ================================
-- LOADING SCREEN (RIICUY IDENTITY)
-- ================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "Riicuy_Loading"
loadingGui.ResetOnSpawn = false
loadingGui.IgnoreGuiInset = true

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1,0,1,0)
textLabel.BackgroundTransparency = 1
textLabel.TextScaled = true
textLabel.TextColor3 = Color3.fromRGB(255, 170, 0)
textLabel.Font = Enum.Font.GothamBold
textLabel.Text = "Loading Riicuy Sambung-Kata..."
textLabel.Parent = loadingGui

loadingGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local function removeLoading()
    if loadingGui then
        loadingGui:Destroy()
    end
end

-- ================================
-- UTIL
-- ================================
local function trim(str)
    if not str or type(str) ~= "string" then return "" end
    return (str:gsub("^%s*(.-)%s*$", "%1"))
end

local function log(...)
    if DEBUG_MODE then
        local parts = {"[RiicuyScript]"}
        for _, v in ipairs({...}) do
            table.insert(parts, tostring(v))
        end
        print(table.concat(parts, " "))
    end
end

-- ================================
-- START
-- ================================
task.defer(function()
    if not game:IsLoaded() then game.Loaded:Wait() end
    task.wait(2)

    local RS = game:GetService("ReplicatedStorage")

    -- LOAD RAYFIELD
    local function loadRayfield()
        local urls = {"https://sirius.menu/rayfield", "https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source"}
        for _, url in ipairs(urls) do
            local success, result = pcall(function() return game:HttpGet(trim(url), true) end)
            if success and result and #result > 100 then
                local compileSuccess, chunk = pcall(loadstring, result)
                if compileSuccess and chunk then
                    local execSuccess, lib = pcall(chunk)
                    if execSuccess and type(lib) == "table" then return lib end
                end
            end
        end
        return nil
    end

    local Rayfield = loadRayfield()
    if not Rayfield then removeLoading() return end

    -- WORDLIST LOAD
    textLabel.Text = "Riicuy: Loading WordList..."
    local wordList = RS:WaitForChild("WordList", 60)
    local kataModule = require(wordList:WaitForChild("IndonesianWords", 30))

    -- REMOTES
    textLabel.Text = "Riicuy: Loading Remotes..."
    local remotes = RS:WaitForChild("Remotes", 60)
    local SubmitWord = remotes:FindFirstChild("SubmitWord")
    local BillboardUpdate = remotes:FindFirstChild("BillboardUpdate")

    -- UI WINDOW
    textLabel.Text = "Riicuy: Creating UI..."
    local Window = Rayfield:CreateWindow({
        Name = "Riicuy Sambung-Kata v"..SCRIPT_VERSION,
        LoadingTitle = "Riicuy Script",
        LoadingSubtitle = "Auto Sambung Kata",
        ConfigurationSaving = {Enabled = false}
    })

    local MainTab = Window:CreateTab("Main")
    MainTab:CreateToggle({
        Name = "Aktifkan Auto",
        CurrentValue = false,
        Callback = function(v) _G.AutoEnabled = v end
    })

    removeLoading()
    log("Riicuy Script Ready")
end)
