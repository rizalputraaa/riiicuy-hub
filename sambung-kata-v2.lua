-- =========================================================
-- RIICUY SMART AUTO KATA (COMPLETE EDITION)
-- =========================================================

local SCRIPT_VERSION = "2.2.0"
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- LOGO LOADING RIICUY
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "Riicuy_Loading"
loadingGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1,0,1,0)
textLabel.BackgroundTransparency = 1
textLabel.TextScaled = true
textLabel.TextColor3 = Color3.fromRGB(255, 170, 0) -- Warna Oranye Riicuy
textLabel.Font = Enum.Font.GothamBold
textLabel.Text = "Loading Riicuy Script..."
textLabel.Parent = loadingGui

-- FUNGSI UTAMA
task.wait(1.5)
textLabel.Text = "Riicuy: Menyambungkan ke Server..."

-- LOAD RAYFIELD (Library Menu)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Riicuy Sambung-Kata v" .. SCRIPT_VERSION,
   LoadingTitle = "Riicuy Project",
   LoadingSubtitle = "by rizalputraaa",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "RiicuyConfig" 
   }
})

local MainTab = Window:CreateTab("Utama", 4483362458)

MainTab:CreateToggle({
   Name = "Aktifkan Auto Jawab",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoRiicuy = Value
      if Value then
          Rayfield:Notify({
             Title = "Riicuy Active",
             Content = "Auto Sambung Kata telah dinyalakan!",
             Duration = 5,
             Image = 4483362458,
          })
      end
   end,
})

-- Hapus Loading
loadingGui:Destroy()

Rayfield:Notify({
   Title = "Selamat Datang!",
   Content = "Riicuy Script Berhasil Dimuat (rizalputraaa)",
   Duration = 5
})
